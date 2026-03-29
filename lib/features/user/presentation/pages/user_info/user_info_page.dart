// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/domain/blocs/register/register_bloc.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/select_variants_widget.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/profession_sheet.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/region_sheet.dart';
import 'package:mpd_client/features/user/data/models/user_info_model.dart';
import 'package:mpd_client/features/user/presentation/pages/user_info/components/select_gender_user.dart';
import 'package:mpd_client/features/user/presentation/pages/user_info/components/update_selected_date_widget.dart';
import 'package:mpd_client/features/user/presentation/widgets/disabled_account_sheet.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/tools/formatters.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:mpd_client/src/widgets/label_input_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

class UserInfo extends StatefulWidget {
  final UserInfoModel userLocalModel;

  const UserInfo({super.key, required this.userLocalModel});

  @override
  State<UserInfo> createState() => _UserInfoState();

  static _UserInfoState of(BuildContext context) =>
      context.findAncestorStateOfType<_UserInfoState>()!;
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController firsNameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController diplomController = TextEditingController();
  TextEditingController pinflController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController currentPlaceController = TextEditingController();
  late Gender gender = Gender.male;
  String region = "";
  String specialist = "";

  File? _diplomFile;
  File? _courseFile;
  String? _selectedEducationKey;

  Map<String, String> get _educationOptions => {
    'high': context.l10n.education_high,
    'middle': context.l10n.education_medium_special,
    'low': context.l10n.education_medium,
    'not_finish': context.l10n.education_unfinished_high,
    'no': context.l10n.education_none,
  };

  bool _isPickingFile = false;
  Future<void> _pickFile(bool isDiplom) async {
    if (_isPickingFile) return;
    _isPickingFile = true;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          if (isDiplom) {
            _diplomFile = File(result.files.single.path!);
            diplomController.text = result.files.single.name;
          } else {
            _courseFile = File(result.files.single.path!);
            courseController.text = result.files.single.name;
          }
        });
        if (mounted) {
          context.read<UserInfoBloc>().add(const HasChangesEvent());
        }
      }
    } finally {
      if (mounted) {
        _isPickingFile = false;
      }
    }
  }

  // void _showEducationSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: context.color.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
  //     ),
  //     builder: (ctx) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: _educationOptions.entries.map((entry) {
  //             return ListTile(
  //               title: Text(
  //                 entry.value,
  //                 style: Styles.headline6.copyWith(color: context.color.black),
  //               ),
  //               onTap: () {
  //                 setState(() {
  //                   _selectedEducationKey = entry.key;
  //                   educationController.text = entry.value;
  //                 });
  //                 context.read<UserInfoBloc>().add(const HasChangesEvent());
  //                 Navigator.pop(ctx);
  //               },
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildFileAttachWidget({
    required String title,
    required File? selectedFile,
    required String? remoteUrl,
    required VoidCallback onPick,
    required bool isReadOnly,
  }) {
    bool hasFile =
        selectedFile != null || (remoteUrl != null && remoteUrl.isNotEmpty);
    String fileName = context.l10n.profile_upload_document;
    if (selectedFile != null) {
      fileName = selectedFile.path.split('/').last;
    } else if (remoteUrl != null && remoteUrl.isNotEmpty) {
      fileName = remoteUrl.split('/').last;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            title,
            style: Styles.boldTopHint.copyWith(color: context.color.black),
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: context.color.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.color.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.attach_file,
                color: hasFile ? context.color.mainBlue : context.color.grey,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  fileName,
                  style: Styles.headline7.copyWith(color: context.color.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (remoteUrl != null &&
                  remoteUrl.isNotEmpty &&
                  selectedFile == null)
                IconButton(
                  icon: Icon(Icons.visibility, color: context.color.mainBlue),
                  onPressed: () async {
                    final uri = Uri.parse(
                      remoteUrl.startsWith('http')
                          ? remoteUrl
                          : 'https://api.mpdinfo.uz$remoteUrl',
                    );
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                ),
              if (!isReadOnly)
                IconButton(
                  icon: Icon(Icons.upload_file, color: context.color.grey),
                  onPressed: onPick,
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // context.read<RegionBloc>().add(GetRegionsEvent());
    // context.read<ProfessionBloc>().add(GetProfessionEvent());
    firsNameController.text = widget.userLocalModel.name ?? "--";
    surnameController.text = widget.userLocalModel.surname ?? "--";
    userLastNameController.text = widget.userLocalModel.lastname ?? "--";
    bioController.text = widget.userLocalModel.bio ?? "--";
    diplomController.text = widget.userLocalModel.diplom != null
        ? widget.userLocalModel.diplom!.split('/').last
        : "--";
    pinflController.text = widget.userLocalModel.pinfl ?? "--";
    courseController.text = widget.userLocalModel.course != null
        ? widget.userLocalModel.course!.split('/').last
        : "--";

    _selectedEducationKey = widget.userLocalModel.education;
    if (_selectedEducationKey != null &&
        _educationOptions.containsKey(_selectedEducationKey!)) {
      educationController.text = _educationOptions[_selectedEducationKey!]!;
    } else {
      educationController.text = _selectedEducationKey ?? "--";
    }

    currentPlaceController.text = widget.userLocalModel.currentPlace ?? "--";

    birthController.text = Utils.formatDateTime(
      widget.userLocalModel.birthday ?? DateTime.now(),
    );
    gender = widget.userLocalModel.gender == "female"
        ? Gender.female
        : Gender.male;
    debugPrint(
      "ppgender : ${context.read<UserInfoBloc>().state.userInfo?.gender}",
    );
    // context.read<UserInfoBloc>().add(const GetDocumentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Text(context.l10n.profile_personal_info),
            if (context.read<UserInfoBloc>().state.userInfo?.status == 2)
              AppIcons.verify.svg(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => BlocProvider.value(
                  value: AuthBloc(
                    locator.get<AuthRepository>(),
                    GlobalKey<FormState>(),
                    TextEditingController(),
                    TextEditingController(),
                    FocusNode(),
                  ),
                  child: DisabledAccount(
                    onPress: () {
                      context.read<RegisterBloc>().add(
                        AccountDisabled(
                          onSucces: () {
                            context.read<UserInfoBloc>().add(DeleteUserInfo());
                            context.read<AuthBloc>().add(DeleteToken());
                            context.read<UserSubscriptionsBloc>().add(
                              CloseSubscriptionBloc(),
                            );
                          },
                          onError: () {},
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.delete_outline, color: context.color.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(height: 250.h),
                BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                    if (state.isBackChanged && state.userBackImage != null) {
                      return Image.file(
                        state.userBackImage!,
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: double.maxFinite,
                      );
                    }
                    return CachedNetworkImage(
                      imageUrl: state.userInfo?.backgroundImage ?? "",
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(32),
                        child: Image.asset(AppImages.logo, color: mainBlue),
                      ),
                      fit: BoxFit.cover,
                      height: 200.h,
                      width: double.maxFinite,
                    );
                  },
                ),
                Positioned(
                  top: 150.h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: BlocBuilder<UserInfoBloc, UserInfoState>(
                      builder: (context, state) {
                        return Hero(
                          tag: 'image',
                          child: _setImage(
                            state.userImage,
                            widget.userLocalModel.avatar,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 88.h,
                  left: 300.h,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<UserInfoBloc>().add(SelectUserBackImage());
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: context.color.mainBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: AppIcons.edit.svg(
                            color: context.color.white,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(enableFeedback: false),
              onPressed: () {
                context.read<UserInfoBloc>().add(SelectUserImage());
              },
              child: Text(
                context.l10n.profile_edit_photo,
                style: Styles.headline7.copyWith(
                  fontSize: 14.sp,
                  color: context.color.mainBlue,
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(24.h),
            LabelInputWidget(
              validator: (value) => Validators.empty(value, context),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              topHint: context.l10n.profile_firstname,
              inputHint: context.l10n.profile_firstname,
              controller: firsNameController,
              // require: '*',
              readOnly:
                  context.read<UserInfoBloc>().state.userInfo?.status == 2,
              onChanged: (value) {
                context.read<UserInfoBloc>().add(const HasChangesEvent());
              },
            ),
            ScreenUtil().setVerticalSpacing(20.h),
            LabelInputWidget(
              validator: (value) => Validators.empty(value, context),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              topHint: context.l10n.profile_lastname,
              inputHint: context.l10n.profile_lastname,
              controller: surnameController,
              readOnly:
                  context.read<UserInfoBloc>().state.userInfo?.status == 2,
              onChanged: (value) {
                context.read<UserInfoBloc>().add(const HasChangesEvent());
              },
            ),
            ScreenUtil().setVerticalSpacing(20.h),
            LabelInputWidget(
              validator: (value) => Validators.empty(value, context),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              topHint: context.l10n.profile_patronymic,
              inputHint: context.l10n.profile_patronymic,
              controller: userLastNameController,
              // require: '*',
              readOnly:
                  context.read<UserInfoBloc>().state.userInfo?.status == 2,
              onChanged: (value) {
                context.read<UserInfoBloc>().add(const HasChangesEvent());
              },
            ),
            ScreenUtil().setVerticalSpacing(20.h),
            SelectGenderUser(
              isDisable:
                  context.read<UserInfoBloc>().state.userInfo?.status == 2,
            ),
            ScreenUtil().setVerticalSpacing(20.h),
            UpdateSelectDateWidget(
              onChanged: (value) {
                context.read<UserInfoBloc>().add(const HasChangesEvent());
              },
              birthController: birthController,
              isDisable:
                  context.read<UserInfoBloc>().state.userInfo?.status == 2,
            ),
            ScreenUtil().setVerticalSpacing(20.h),

            if (context.read<UserInfoBloc>().state.userInfo?.phone !=
                '998909098108') ...[
              LabelInputWidget(
                textInputAction: TextInputAction.next,
                inputformater: [Formatters.pnflFormat2],
                textInputType: TextInputType.number,
                topHint: context.l10n.profile_pinfl,
                inputHint: context.l10n.profile_pinfl,
                controller: pinflController,
                readOnly:
                    context.read<UserInfoBloc>().state.userInfo?.status == 2,
                onChanged: (value) {
                  context.read<UserInfoBloc>().add(const HasChangesEvent());
                },
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              // LabelInputWidget(
              //   textInputAction: TextInputAction.next,
              //   topHint: context.l10n.profile_residence_address,
              //   inputHint: context.l10n.profile_residence_address,
              //   controller: currentPlaceController,
              //   readOnly:
              //       context.read<UserInfoBloc>().state.userInfo?.status == 2,
              //   onChanged: (value) {
              //     context.read<UserInfoBloc>().add(const HasChangesEvent());
              //   },
              // ),
              // ScreenUtil().setVerticalSpacing(20.h),
              LabelInputWidget(
                textInputAction: TextInputAction.next,
                topHint: context.l10n.profile_bio,
                inputHint: context.l10n.profile_bio,
                controller: bioController,
                readOnly:
                    context.read<UserInfoBloc>().state.userInfo?.status == 2,
                onChanged: (value) {
                  context.read<UserInfoBloc>().add(const HasChangesEvent());
                },
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              // GestureDetector(
              //   onTap: context.read<UserInfoBloc>().state.userInfo?.status == 2
              //       ? null
              //       : _showEducationSheet,
              //   child: AbsorbPointer(
              //     child: LabelInputWidget(
              //       topHint: "Маълумоти",
              //       inputHint: "Ma'lumoti",
              //       controller: educationController,
              //       readOnly: true,
              //       suffixIcon: Icon(
              //         Icons.keyboard_arrow_down,
              //         color: context.color.grey,
              //       ),
              //     ),
              //   ),
              // ),
              // ScreenUtil().setVerticalSpacing(20.h),
              BlocSelector<ProfessionBloc, ProfessionState, Profession?>(
                selector: (state) => state.chosenProfession,
                builder: (context, chosenProfession) {
                  Profession? selected = chosenProfession;
                  return BlocSelector<
                    SubProfessionsBloc,
                    SubProfessionsState,
                    Profession?
                  >(
                    selector: (state) => state.selectedSubProfession,
                    builder: (context, selectedSubProfession) {
                      selected = chosenProfession ?? selectedSubProfession;
                      if (selected != null) {
                        context.read<UserInfoBloc>().add(
                          SelectedCategoryIdEvent(
                            MainCat(id: selected!.id, name: selected!.name),
                            localCatName: "",
                          ),
                        );
                      }
                      return SelectVariantsWidget(
                        topHint: context.l10n.profile_profession,
                        hint: selected != null
                            ? selected!.name!
                            : widget.userLocalModel.mainCat?.name ?? "--",
                        onPressed: () {
                          context.read<ProfessionBloc>().add(
                            GetProfessionEvent(),
                          );
                          showModalBottomSheet(
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: BlocProvider.of<ProfessionBloc>(
                                    context,
                                  ),
                                ),
                                BlocProvider.value(
                                  value: BlocProvider.of<SubProfessionsBloc>(
                                    context,
                                  ),
                                ),
                              ],
                              child: const ProfessionSheet(),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              BlocSelector<DistrictBloc, DistrictState, Region?>(
                selector: (state) => state.selectedDistict,
                builder: (context, selectedDistict) {
                  if (selectedDistict != null) {
                    context.read<UserInfoBloc>().add(
                      SelectedRegionIdEvent(
                        MainCat(
                          id: selectedDistict.id,
                          name: selectedDistict.name,
                        ),
                        localRegion: "",
                      ),
                    );
                  }
                  return SelectVariantsWidget(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<RegionBloc>().add(GetRegionsEvent());
                      showModalBottomSheet(
                        useSafeArea: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: BlocProvider.of<RegionBloc>(context),
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<DistrictBloc>(context),
                            ),
                          ],
                          child: const RegionSheet(),
                        ),
                      );
                    },
                    topHint: context.l10n.profile_region,
                    hint: selectedDistict != null
                        ? selectedDistict.name
                        : widget.userLocalModel.region?.name ?? "--",
                  );
                },
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              _buildFileAttachWidget(
                title: context.l10n.profile_diploma,
                selectedFile: _diplomFile,
                remoteUrl: widget.userLocalModel.diplom,
                onPick: () => _pickFile(true),
                isReadOnly:
                    context.read<UserInfoBloc>().state.userInfo?.status == 2,
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              _buildFileAttachWidget(
                title: context.l10n.profile_course_certificate,
                selectedFile: _courseFile,
                remoteUrl: widget.userLocalModel.course,
                onPick: () => _pickFile(false),
                isReadOnly:
                    context.read<UserInfoBloc>().state.userInfo?.status == 2,
              ),
              ScreenUtil().setVerticalSpacing(30.h),
              /*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.l10n.profile_my_documents,
                      style: Styles.headline7.copyWith(
                        color: context.color.black,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(16.h),
                  BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      if (state.statusDocs ==
                          FormzSubmissionStatus.inProgress) {
                        return const CircularProgressIndicator();
                      }
                      if (state.documents.isEmpty) {
                        return Text(context.l10n.profile_no_documents);
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.documents.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final doc = state.documents[index];
                          return Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: context.color.background,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: context.color.grey.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: context.color.mainBlue,
                                  size: 24.h,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc.file?.split('/').last ?? context.l10n.profile_upload_document,
                                        style: Styles.headline6.copyWith(
                                          color: context.color.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (doc.description != null &&
                                          doc.description!.isNotEmpty)
                                        Text(
                                          doc.description!,
                                          style: Styles.headline7.copyWith(
                                            color: context.color.grey,
                                            fontSize: 12.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ScreenUtil().setVerticalSpacing(16.h),
                  LongButton(
                    buttonName: context.l10n.profile_upload_new_document,
                    border: Border.all(color: context.color.mainBlue),
                    onPress: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<UserInfoBloc>(),
                          child: const CreateDocumentSheet(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            */
            ],
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomSheet: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
            child: AnimatedCrossFade(
              firstChild: const SizedBox(width: double.maxFinite),
              secondChild: PinnedSheet(
                widget: LongButton(
                  loading: state.showLoading,
                  buttonName: context.l10n.profile_save_changes,
                  onPress: () {
                    if (state.userInfo?.status != 2) {
                      context.read<UserInfoBloc>().add(
                        UpdateUserProfessionEvent(
                          lastname: userLastNameController.text.trim(),
                          surname: surnameController.text.trim(),
                          name: firsNameController.text.trim(),
                          birthday: birthController.text.trim(),
                          gender: gender,
                          bio: bioController.text.trim(),
                          diplom:
                              _diplomFile?.path ?? widget.userLocalModel.diplom,
                          pinfl: pinflController.text.trim(),
                          course:
                              _courseFile?.path ?? widget.userLocalModel.course,
                          education:
                              _selectedEducationKey ??
                              widget.userLocalModel.education,
                          currentPlace: currentPlaceController.text.trim(),
                          onSuccess: () {
                            Navigator.of(context).pop(true);
                            context.read<UserInfoBloc>().add(
                              UpdateUserInfoLocal(),
                            );
                          },
                          onError: () {
                            CustomSnackbar.show(
                              context,
                              "Ma'lumot yangilanmadi",
                            );
                          },
                        ),
                      );
                    } else {
                      context.read<UserInfoBloc>().add(UpdateUserVerifyEvent());
                    }
                    context.read<UserInfoBloc>().add(UpdateUserImage());
                  },
                ),
              ),
              crossFadeState: state.isChanged || state.isImageChanged
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 400),
            ),
          );
        },
      ),
    );
  }

  Widget _setImage(File? fileImage, String? memoryImage) {
    if (fileImage != null) {
      return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          border: Border.all(color: context.color.white, width: 4),
          borderRadius: BorderRadius.circular(48.r),
          image: DecorationImage(
            image: FileImage(fileImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (memoryImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(48.r),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: mainBlue, width: 4),
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            imageUrl: memoryImage,
            height: 100.h,
            width: 100.h,
            errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(AppImages.mapProfileDefault, color: mainBlue),
            ),
          ),
        ),
      );
    } else {
      return const DefaultAvatar(containerSize: 96, imageSize: 72);
    }
  }
}

//no access
/*  ScreenUtil().setVerticalSpacing(20.h),
                  LabelInputWidget(
                    topHint: 'Username',
                    inputHint: 'Username',
                    controller: TextEditingController(
                        text: state.userLocalInfo!.username),
                  ),
                  ScreenUtil().setVerticalSpacing(20.h),
                  LabelInputWidget(
                    readOnly: true,
                    topHint: 'Phone number',
                    inputHint: 'Phone number',
                    controller: TextEditingController(
                        text: '+${state.userLocalInfo!.userNumber}'),
                    background: context.color.background,
                    suffixIcon: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.r),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 15.w, top: 15.5.h, left: 15.w),
                          child: Text(
                            'Change phone',
                            style: Styles.headline7
                                .copyWith(color: context.color.mainBlue),
                          ),
                        ),
                      ),
                    ),
                  ), */

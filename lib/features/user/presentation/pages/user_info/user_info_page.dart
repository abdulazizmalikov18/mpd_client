// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
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
import 'package:mpd_client/features/user/presentation/widgets/disabled_account_sheet.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:mpd_client/src/widgets/label_input_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

import 'components/update_selected_date_widget.dart';

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
  TextEditingController bioController = TextEditingController();
  TextEditingController firsNameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  late Gender gender = Gender.male;
  String region = "";
  String specialist = "";

  @override
  void initState() {
    context.read<RegionBloc>().add(GetRegionsEvent());
    context.read<ProfessionBloc>().add(GetProfessionEvent());
    firsNameController.text = widget.userLocalModel.name ?? "--";
    userLastNameController.text = widget.userLocalModel.lastname ?? "--";
    bioController.text = widget.userLocalModel.bio ?? "--";
    birthController.text =
        Utils.formatDateTime(widget.userLocalModel.birthday ?? DateTime.now());
    gender =
        widget.userLocalModel.gender == "female" ? Gender.female : Gender.male;
    debugPrint(
        "ppgender : ${context.read<UserInfoBloc>().state.userInfo?.gender}");
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
              AppIcons.verify.svg()
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
                      context.read<RegisterBloc>().add(AccountDisabled(
                          onSucces: () {
                            context.read<UserInfoBloc>().add(DeleteUserInfo());
                            context.read<AuthBloc>().add(DeleteToken());
                            context
                                .read<UserSubscriptionsBloc>()
                                .add(CloseSubscriptionBloc());
                          },
                          onError: () {}));
                    },
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.delete_outline,
              color: context.color.red,
            ),
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
                     imageUrl: state.userInfo?.backgroundImage ??
                          "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13",
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
                          context
                              .read<UserInfoBloc>()
                              .add(SelectUserBackImage());
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
                    )),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(enableFeedback: false),
              onPressed: () {
                context.read<UserInfoBloc>().add(SelectUserImage());
              },
              child: Text(
                context.l10n.profile_edit_photo,
                style: Styles.headline7
                    .copyWith(fontSize: 14.sp, color: context.color.mainBlue),
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
              require: '*',
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
              controller: userLastNameController,
              require: '*',
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
            BlocSelector<ProfessionBloc, ProfessionState, Profession?>(
              selector: (state) => state.chosenProfession,
              builder: (context, chosenProfession) {
                Profession? selected = chosenProfession;
                return BlocSelector<SubProfessionsBloc, SubProfessionsState,
                    Profession?>(
                  selector: (state) => state.selectedSubProfession,
                  builder: (context, selectedSubProfession) {
                    selected = chosenProfession ?? selectedSubProfession;
                    if (selected != null) {
                      context.read<UserInfoBloc>().add(SelectedCategoryIdEvent(
                          MainCat(id: selected!.id, name: selected!.name),
                          localCatName: ""));
                    }
                    return SelectVariantsWidget(
                      topHint: context.l10n.profile_profession,
                      hint: selected != null
                          ? selected!.name!
                          : widget.userLocalModel.mainCat?.name ?? "--",
                      onPressed: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                  value:
                                      BlocProvider.of<ProfessionBloc>(context)),
                              BlocProvider.value(
                                  value: BlocProvider.of<SubProfessionsBloc>(
                                      context)),
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
                  context.read<UserInfoBloc>().add(SelectedRegionIdEvent(
                      MainCat(
                          id: selectedDistict.id, name: selectedDistict.name),
                      localRegion: ""));
                }
                return SelectVariantsWidget(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    showModalBottomSheet(
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                              value: BlocProvider.of<RegionBloc>(context)),
                          BlocProvider.value(
                              value: BlocProvider.of<DistrictBloc>(context)),
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
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomSheet: BlocConsumer<UserInfoBloc, UserInfoState>(
        listener: (context, state) async {
          if (!state.showLoading && state.error == 'No') {
            context.read<UserInfoBloc>().add(UpdateUserInfoLocal());
            Navigator.of(context).maybePop();
          }
        },
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
                      context
                          .read<UserInfoBloc>()
                          .add((UpdateUserProfessionEvent(
                            lastname: userLastNameController.text.trim(),
                            name: firsNameController.text.trim(),
                            birthday: birthController.text.trim(),
                            gender: gender,
                            bio: bioController.text.trim(),
                          )));
                    } else {
                      context
                          .read<UserInfoBloc>()
                          .add((UpdateUserVerifyEvent()));
                    }
                    context.read<UserInfoBloc>().add((UpdateUserImage()));
                    Navigator.of(context).pop();
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
      return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          border: Border.all(color: context.color.white, width: 4),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(memoryImage),
            onError: (exception, stackTrace) =>
                const DefaultAvatar(containerSize: 96, imageSize: 72),
            fit: BoxFit.cover,
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

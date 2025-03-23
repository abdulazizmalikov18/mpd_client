import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/select_variants_widget.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_position_model.dart';
import 'package:mpd_client/features/user/presentation/widgets/category_sheet.dart';
import 'package:mpd_client/features/user/presentation/widgets/custom_text_field.dart';
import 'package:mpd_client/features/user/presentation/widgets/position_sheet.dart';
import 'package:mpd_client/features/user/presentation/widgets/spec_cat_sheet.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class SpecialistRegisterPage extends StatefulWidget {
  const SpecialistRegisterPage({super.key});

  @override
  State<SpecialistRegisterPage> createState() => _SpecialistRegisterPageState();
}

class _SpecialistRegisterPageState extends State<SpecialistRegisterPage> {
  TextEditingController bioController = TextEditingController();
  SpecialistCategoryModel? specialistCategoryModel;
  SpecialistCatModel? specialistCatModel;
  SpecialistPositionModel? specialistPositionModel;
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _extension;

  int status = -10;

  void onError(String text) {}

  void _pickFiles() async {
    if ((_paths?.length ?? 0) >= 1) {
      onError("1 tadan oshiq ma'lumotlar yuklanmaydu");
      return;
    }
    _resetState();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.any,
        // allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  void _logException(String message) {
    print(message);
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _fileName = null;
      _paths = null;
    });
  }

  @override
  void initState() {
    context.read<UserInfoBloc>().add(IsAddedSpecialist(
          onSucces: (int newStatus) {
            setState(() {
              status = newStatus;
            });
          },
          onError: () {},
        ));
    context.read<UserInfoBloc>().add(GetSpecialistPosition());
    context.read<UserInfoBloc>().add(GetSpecialistCat());
    context.read<UserInfoBloc>().add(GetSpecCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "About you"),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: status != -1
            ? null
            : AnimatedContainer(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                margin: const EdgeInsets.only(bottom: 24),
                duration: const Duration(milliseconds: 300),
                child: BlocSelector<UserInfoBloc, UserInfoState,
                    FormzSubmissionStatus>(
                  selector: (state) => state.statusCreate,
                  builder: (context, state) {
                    return LongButton(
                      onPress: () {
                        if (_paths?.isEmpty ?? false) {
                          onError("Iltimos ma'lumotlaringizni yuklang");
                          return;
                        }
                        context.read<UserInfoBloc>().add(PostSpecialist(
                              idCat: specialistCatModel!.id,
                              idPos: specialistPositionModel!.id,
                              idJob: specialistCategoryModel!.id,
                              file: _paths?.first.path,
                              onSucces: () {
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                              },
                              onError: () {
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                              },
                            ));
                      },
                      loading: state.isInProgress,
                      isDisable: specialistCategoryModel == null ||
                          specialistCatModel == null ||
                          specialistPositionModel == null,
                      buttonName: "Register",
                    );
                  },
                ),
              ),
        body: switch (status) {
          0 => Center(
              child: Lottie.asset(
                'assets/anim/waiting.json',
                width: 200,
                height: 200,
              ),
            ),
          1 => Center(
              child: Lottie.asset(
                'assets/anim/success.json',
                width: 200,
                height: 200,
              ),
            ),
          -2 => Center(
              child: Lottie.asset(
                'assets/anim/error.json',
                width: 200,
                height: 200,
              ),
            ),
          -1 => BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      SelectVariantsWidget(
                        topHint: "Specialist Category",
                        hint: specialistCatModel?.name ?? "",
                        onPressed: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => SpecCatSheet(
                              specialistCat: state.specialistCat,
                              selection: specialistCatModel,
                              onPress: (value) {
                                specialistCatModel = value;
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      SelectVariantsWidget(
                        topHint: "Specialist Position",
                        hint: specialistPositionModel?.name ?? "",
                        onPressed: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => PositionSheet(
                              specialistPosition: state.specialistPosition,
                              selection: specialistPositionModel,
                              onPress: (SpecialistPositionModel value) {
                                specialistPositionModel = value;
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      SelectVariantsWidget(
                        topHint: "Specialist Job",
                        hint: specialistCategoryModel?.name ?? "",
                        onPressed: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => CategorySheet(
                              specialistCategory: state.specialistCategory,
                              selection: specialistCategoryModel,
                              onPress: (SpecialistCategoryModel value) {
                                specialistCategoryModel = value;
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                      ScreenUtil().setVerticalSpacing(16.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: bioController,
                              title: "About you",
                              hintText: "Write here ",
                              onChanged: (value) {},
                              minLines: 5,
                              maxLines: 8,
                              noHeight: true,
                              expands: false,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Education & certifications (1)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                )
                              ],
                            ),
                            CustomTextField(
                              hintText: "Write here ",
                              onChanged: (value) {},
                              minLines: 1,
                              maxLines: 6,
                              noHeight: true,
                              expands: false,
                            ),
                            SizedBox(height: 16.h),
                            Builder(
                              builder: (context) => _paths != null &&
                                      _paths!.isNotEmpty
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      itemCount:
                                          _paths != null && _paths!.isNotEmpty
                                              ? _paths!.length
                                              : 1,
                                      itemBuilder: (context, index) {
                                        final bool isMultiPath =
                                            _paths != null &&
                                                _paths!.isNotEmpty;
                                        final String name = isMultiPath
                                            ? _paths!
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...';

                                        return Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: context.color.white,
                                            border: Border.all(
                                                color: context.color.border),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: context.color.grey,
                                                  border: Border.all(
                                                      color:
                                                          context.color.border),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: AppIcons.files.svg(),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: context.color.black,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  if (_paths!.length > 1) {
                                                    _paths!.removeAt(index);
                                                  } else {
                                                    _paths!.clear();
                                                  }
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  color: context.color.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                    )
                                  : const SizedBox(),
                            ),
                            InkWell(
                              onTap: () {
                                _pickFiles();
                              },
                              child: DottedBorder(
                                color: context.color.border,
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(8),
                                child: SizedBox(
                                  height: 106.h,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 48.h,
                                        width: 48.h,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: context.color.border
                                              .withValues(alpha: .5),
                                        ),
                                        child: AppIcons.files.svg(),
                                      ),
                                      SizedBox(height: 4.h),
                                      const Text(
                                        "Add File",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF677294),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(100.h)
                    ],
                  ),
                );
              },
            ),
          _ => const Center(
              child: Text('Kutilmoqda ...'),
            ),
        });
  }
}

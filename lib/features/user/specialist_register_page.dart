import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/select_variants_widget.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/features/user/presentation/widgets/category_sheet.dart';
import 'package:mpd_client/features/user/presentation/widgets/custom_text_field.dart';
import 'package:mpd_client/features/user/presentation/widgets/spec_cat_sheet.dart';
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
  // SpecialistPositionModel? specialistPositionModel;

  List<PlatformFile>? _paths;
  String? _base64Image;

  int status = -10;

  void onError(String text) {}

  Future<void> _pickFiles() async {
    if ((_paths?.length ?? 0) >= 1) {
      onError(context.l10n.specialist_register_error_max_files);
      return;
    }
    _resetState();

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        _base64Image = base64Encode(bytes);

        // Create a temporary file to store the image
        final tempFile = File(image.path);
        final fileSize = await tempFile.length();

        if (!mounted) return;

        setState(() {
          _paths = [
            PlatformFile(
              name: image.name,
              path: tempFile.path,
              size: fileSize,
              bytes: bytes,
            ),
          ];
        });
      }
    } on PlatformException catch (e) {
      Log.e('Image picker error: $e');
      onError('Failed to pick image: ${e.message}');
    } catch (e) {
      Log.e('Error picking image: $e');
      onError('Failed to process image');
    }
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _paths = null;
      _base64Image = null;
    });
  }

  Future<void> _pickOrReplaceImage() async {
    if (_paths?.isNotEmpty == true) {
      // If image is already selected, show option to remove or replace
      final result = await showModalBottomSheet<bool>(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('O\'chirish'),
              onTap: () => Navigator.pop(context, true),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Boshqa rasm tanlash'),
              onTap: () => Navigator.pop(context, false),
            ),
          ],
        ),
      );

      if (result == null) return;

      if (result == true) {
        // Remove image
        _resetState();
        return;
      }
      // Continue to pick new image
    }

    // If no image or user wants to replace, pick a new one
    await _pickFiles();
  }

  @override
  void initState() {
    context.read<UserInfoBloc>().add(
      IsAddedSpecialist(
        onSucces: (int newStatus) {
          setState(() {
            status = newStatus;
          });
        },
        onError: () {},
      ),
    );
    context.read<UserInfoBloc>().add(GetSpecialistPosition());
    context.read<UserInfoBloc>().add(GetSpecialistCat());
    context.read<UserInfoBloc>().add(GetSpecCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.aboutYou)),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AnimatedContainer(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        margin: const EdgeInsets.only(bottom: 24),
        duration: const Duration(milliseconds: 300),
        child: BlocSelector<UserInfoBloc, UserInfoState, FormzSubmissionStatus>(
          selector: (state) => state.statusCreate,
          builder: (context, statusCreate) {
            return LongButton(
              onPress: () {
                if (_paths?.isEmpty ?? false) {
                  onError(
                    context.l10n.specialist_register_error_upload_required,
                  );
                  return;
                }
                context.read<UserInfoBloc>().add(
                  PostSpecialist(
                    idCat: specialistCatModel!.id,
                    // idPos: specialistPositionModel!.id,
                    idJob: specialistCategoryModel!.id,
                    file: _base64Image,
                    bio: bioController.text,
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
                  ),
                );
              },
              loading: statusCreate.isInProgress,
              isDisable:
                  specialistCategoryModel == null || specialistCatModel == null,
              buttonName: context.l10n.specialist_register_register_button,
            );
          },
        ),
      ),
      body: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.r),
                    onTap: () {
                      _pickOrReplaceImage();
                    },
                    child: _paths?.isNotEmpty == true
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 108.r,
                                height: 108.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.file(
                                    File(_paths!.first.path!),
                                    width: 108.r,
                                    height: 108.r,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _resetState();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              radius: Radius.circular(54.r),
                              strokeWidth: 2,
                              color: Colors.grey,
                              dashPattern: const [10, 10],
                            ),
                            child: SizedBox(
                              height: 108.h,
                              width: 108.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 24.sp,
                                    color: Colors.grey.shade500,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Rasm yuklash",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 16.h),
                SelectVariantsWidget(
                  topHint: context.l10n.specialist_register_category_hint,
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
                // SelectVariantsWidget(
                //   topHint: context.l10n.specialist_register_position_hint,
                //   hint: specialistPositionModel?.name ?? "",
                //   onPressed: () {
                //     showModalBottomSheet(
                //       useSafeArea: true,
                //       backgroundColor: Colors.transparent,
                //       isScrollControlled: true,
                //       context: context,
                //       builder: (ctx) => PositionSheet(
                //         specialistPosition: state.specialistPosition,
                //         selection: specialistPositionModel,
                //         onPress: (SpecialistPositionModel value) {
                //           specialistPositionModel = value;
                //           setState(() {});
                //         },
                //       ),
                //     );
                //   },
                // ),
                // SizedBox(height: 16.h),
                SelectVariantsWidget(
                  topHint: context.l10n.specialist_register_job_hint,
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
                        title: context.l10n.aboutYou,
                        hintText:
                            "${context.l10n.specialist_register_write_here} ",
                        onChanged: (value) {},
                        minLines: 5,
                        maxLines: 8,
                        noHeight: true,
                        expands: false,
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       context.l10n.specialist_register_education_title,
                      //       style: Theme.of(
                      //         context,
                      //       ).textTheme.titleSmall!.copyWith(),
                      //     ),
                      //     const Spacer(),
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(Icons.add),
                      //     ),
                      //   ],
                      // ),
                      // CustomTextField(
                      //   hintText:
                      //       "${context.l10n.specialist_register_write_here} ",
                      //   onChanged: (value) {},
                      //   minLines: 1,
                      //   maxLines: 6,
                      //   noHeight: true,
                      //   expands: false,
                      // ),
                      // SizedBox(height: 16.h),
                      // Builder(
                      //   builder: (context) =>
                      //       _paths != null && _paths!.isNotEmpty
                      //       ? ListView.separated(
                      //           shrinkWrap: true,
                      //           padding: EdgeInsets.only(bottom: 16.h),
                      //           itemCount: _paths != null && _paths!.isNotEmpty
                      //               ? _paths!.length
                      //               : 1,
                      //           itemBuilder: (context, index) {
                      //             final bool isMultiPath =
                      //                 _paths != null && _paths!.isNotEmpty;
                      //             final String name = isMultiPath
                      //                 ? _paths!
                      //                       .map((e) => e.name)
                      //                       .toList()[index]
                      //                 : _fileName ?? '...';

                      //             return Container(
                      //               padding: const EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: context.color.white,
                      //                 border: Border.all(
                      //                   color: context.color.border,
                      //                 ),
                      //                 borderRadius: BorderRadius.circular(8),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(8),
                      //                     decoration: BoxDecoration(
                      //                       color: context.color.grey,
                      //                       border: Border.all(
                      //                         color: context.color.border,
                      //                       ),
                      //                       borderRadius: BorderRadius.circular(
                      //                         8,
                      //                       ),
                      //                     ),
                      //                     child: AppIcons.files.svg(),
                      //                   ),
                      //                   const SizedBox(width: 12),
                      //                   Expanded(
                      //                     child: Text(
                      //                       name,
                      //                       maxLines: 1,
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: TextStyle(
                      //                         fontSize: 17,
                      //                         fontWeight: FontWeight.w600,
                      //                         color: context.color.black,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   IconButton(
                      //                     onPressed: () {
                      //                       if (_paths!.length > 1) {
                      //                         _paths!.removeAt(index);
                      //                       } else {
                      //                         _paths!.clear();
                      //                       }
                      //                       setState(() {});
                      //                     },
                      //                     icon: Icon(
                      //                       Icons.delete_outline,
                      //                       color: context.color.red,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           },
                      //           separatorBuilder: (context, index) =>
                      //               const Divider(),
                      //         )
                      //       : const SizedBox(),
                      // ),

                      // InkWell(
                      //   onTap: () {
                      //     _pickFiles();
                      //   },
                      //   child: DottedBorder(
                      //     options: RoundedRectDottedBorderOptions(
                      //       radius: Radius.circular(20.r),
                      //       strokeWidth: 2,
                      //       color: Colors.grey,
                      //       dashPattern: const [10, 10],
                      //     ),
                      //     child: SizedBox(
                      //       height: 106.h,
                      //       width: double.infinity,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             height: 48.h,
                      //             width: 48.h,
                      //             padding: const EdgeInsets.all(12),
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(12),
                      //               color: context.color.border.withValues(
                      //                 alpha: .5,
                      //               ),
                      //             ),
                      //             child: AppIcons.files.svg(),
                      //           ),
                      //           SizedBox(height: 4.h),
                      //           Text(
                      //             context.l10n.specialist_register_add_file,
                      //             style: const TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF677294),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                ScreenUtil().setVerticalSpacing(100.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

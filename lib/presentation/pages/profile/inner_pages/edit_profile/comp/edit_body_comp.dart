import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/custom_textformfield_comp.dart';
import 'package:orient_motors/presentation/component/main_button_component.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class EditBodyComp extends StatefulWidget {
  const EditBodyComp({
    super.key,
  });

  @override
  State<EditBodyComp> createState() => _EditBodyCompState();
}

class _EditBodyCompState extends State<EditBodyComp> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _regionController;
  int? provinceId;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _regionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocConsumer<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) =>
              previous.proceedToProfile != current.proceedToProfile &&
              current.proceedToProfile,
          listener: (context, state) {
            if (state.proceedToProfile) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final param = state.profileParam;
            if (state.statusProfile == FormzSubmissionStatus.success &&
                _nameController.text.isEmpty) {
              provinceId = param?.region;

              final result = mapProvince.entries.firstWhere(
                (element) => element.value == provinceId,
                orElse: () => const MapEntry("", 0),
              );

              _regionController.text = result.key;
              _nameController.text = param?.fullName ?? "";
            }
            _phoneController.text = InternationalPhoneFormatter()
                .internationalPhoneFormat(param?.username ?? "");
            return Container(
              margin: EdgeInsets.only(top: 18.h),
              decoration: ShapeDecoration(
                color: colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Stack(
                children: [
                  const Column(),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        8.verticalSpace,
                        CustomTextFieldComp(
                          label: "first_and_last_name".tr(),
                          type: TextInputType.text,
                          controller: _nameController,
                        ),
                        CustomTextFieldComp(
                          label: "phone".tr(),
                          readOnly: true,
                          controller: _phoneController,
                          type: TextInputType.phone,
                          trailingIcon: true,
                          onTapTrailingIcon: () {
                            if (state.profileParam != null) {
                              Navigator.push(
                                  context,
                                  AppRoutes.getChangeNumber(
                                      profile: state.profileParam!));
                            }
                          },
                        ),
                        CustomTextFieldComp(
                            label: "region".tr(),
                            type: TextInputType.text,
                            controller: _regionController,
                            readOnly: true,
                            onTap: () {
                              Navigator.push(
                                      context, AppRoutes.getSelectRegion())
                                  .then(
                                (value) {
                                  if (value != null) {
                                    _regionController.text = value;
                                    provinceId = mapProvince[value];
                                  }
                                },
                              );
                            }),
                        // CustomTextFieldComp(
                        //     label: "date_of_birth".tr(),
                        //     type: TextInputType.text,
                        //     readOnly: true,
                        //     controller: _dateController,
                        //     onTap: () {
                        //       _selectDate(context);
                        //     }),
                        // CustomTextFieldComp(
                        //   label: "email".tr(),
                        //   type: TextInputType.emailAddress,
                        // ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            context
                                .read<BottomNavBarController>()
                                .changeNavBar(true);
                            Navigator.push(context,
                                    AppRoutes.getChangePasswordProfile())
                                .then((value) {
                              context
                                  .read<BottomNavBarController>()
                                  .changeNavBar(false);
                            });
                          },
                          title: Text(
                            'change_password'.tr(),
                            textAlign: TextAlign.start,
                            style: fonts.headline1
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                        24.verticalSpace,
                        MainButtonComponent(
                          text: "save".tr(),
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                                  ProfileEvent.updateProfile(
                                    request: ProfileModel(
                                      (param) => param
                                        ..fullName = _nameController.text
                                        ..region = provinceId,
                                    ),
                                  ),
                                );
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => CustomDialogComponent(
                            //     title: 'are_you_sure_you_want_save_your_profile'.tr(),
                            //     leftButtonTitle: "cancel".tr(),
                            //     rightButtonTitle: "save".tr(),
                            //     onRightButtonPressed: () {
                            //       if (_nameController.text.isNotEmpty) {
                            //         context.read<ProfileBloc>().add(ProfileEvent.updateProfile(
                            //               request: ProfileModel(
                            //                 (param) => param
                            //                   ..fullName = _nameController.text
                            //                   ..region = provinceId,
                            //               ),
                            //             ),);
                            //       }
                            //     },
                            //   ),
                            // );
                          },
                          backgroundColor: colors.text,
                          // child: SvgPicture.asset(icons.checkRed),
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

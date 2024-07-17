import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/component/main_button_component.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ProfileOtherComp extends StatelessWidget {
  const ProfileOtherComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Container(
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.profileParam != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.verticalSpace,
                    Divider(
                        thickness: 1,
                        color: colors.customGreyC3,
                        indent: 16.w,
                        endIndent: 20.w,
                        height: 6.h),
                    _listTileItem(
                      title: 'my_announcements'.tr(),
                      colors: colors,
                      fonts: fonts,
                      onTap: () {
                        Navigator.push(context, AppRoutes.getMyAds(context));
                      },
                      icons: icons,
                    ),
                    _listTileItem(
                      title: 'my_cards'.tr(),
                      colors: colors,
                      fonts: fonts,
                      onTap: () {
                        Navigator.push(context, AppRoutes.getMyCards());
                      },
                      icons: icons,
                    ),
                    _listTileItem(
                      title: 'payment_history'.tr(),
                      colors: colors,
                      fonts: fonts,
                      onTap: () {
                        Navigator.push(context, AppRoutes.getPaymentHistory());
                      },
                      icons: icons,
                    ),
                    8.verticalSpace,
                  ],
                ),
              const OtherProfileWidget(),
              if (state.profileParam != null)
                Column(
                  children: [
                    MainButtonComponent(
                      text: "log_out".tr(),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => CustomDialogComponent(
                            title: "log_out".tr(),
                            content: 'are_you_sure_you_want_log_out'.tr(),
                            leftButtonTitle: "cancel".tr(),
                            rightButtonTitle: "log_out".tr(),
                            onRightButtonPressed: () {
                              context.read<DBService>().signOut().then(
                                (value) {
                                  Navigator.pop(ctx);
                                  Navigator.of(context, rootNavigator: true)
                                      .pushAndRemoveUntil(
                                          AppRoutes.singUp(), (_) => false);
                                },
                              );
                            },
                          ),
                        );
                      },
                      backgroundColor: colors.text,
                      child: icons.exit.svg(color: colors.white, height: 18),
                    ),
                    16.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return CustomDialogComponent(
                                  title:
                                      "do_you_really_want_delete_profile".tr(),
                                  leftButtonTitle: "cancel".tr(),
                                  rightButtonTitle: "delete".tr(),
                                  onRightButtonPressed: () {
                                    context.read<ProfileBloc>().add(
                                        const ProfileEvent.deleteProfile());
                                    Navigator.pop(ctx);
                                    context
                                        .read<DBService>()
                                        .signOut()
                                        .then((value) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushAndRemoveUntil(
                                              AppRoutes.singUp(), (_) => false);
                                    });
                                  },
                                );
                              });
                        },
                        child: Text(
                          'delete_account'.tr(),
                          style:
                              fonts.headline1.copyWith(color: colors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              80.h.verticalSpace,
            ],
          ),
        );
      });
    });
  }

  Widget _listTileItem({
    required String title,
    required CustomColorSet colors,
    required FontSet fonts,
    required VoidCallback onTap,
    required IconSet icons,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Text(
            title,
            style: fonts.headline1,
          ),
          trailing: icons.forward.svg(
            color: colors.text,
            height: 14.sp,
          ),
        ),
        Divider(
            thickness: 1,
            color: colors.customGreyC3,
            indent: 16.w,
            endIndent: 20.w,
            height: 6.h),
      ],
    );
  }
}

class OtherProfileWidget extends StatelessWidget {
  const OtherProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Container(
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(title: "other".tr(), fonts: fonts),
              _listTileItem(
                  title: "feedback".tr(),
                  colors: colors,
                  fonts: fonts,
                  onTap: () {},
                  icons: icons),
              _listTileItem(
                  title: "posting_rules".tr(),
                  colors: colors,
                  fonts: fonts,
                  onTap: () {},
                  icons: icons),
              _listTileItem(
                  title: "privacy_policy2".tr(),
                  colors: colors,
                  fonts: fonts,
                  onTap: () {},
                  icons: icons),
              _listTileItem(
                title: "about_the_app".tr(),
                colors: colors,
                fonts: fonts,
                onTap: () {
                  Navigator.push(context, AppRoutes.getAbout());
                },
                icons: icons,
              ),
              if (state.profileParam == null)
                MainButtonComponent(
                  text: "login".tr(),
                  margin: EdgeInsets.all(16.w),
                  onPressed: () {
                    showAuthModalSheet(context, () {
                      context
                          .read<ProfileBloc>()
                          .add(const ProfileEvent.getProfile());
                    });
                  },
                  backgroundColor: colors.text,
                  child: icons.login.svg(color: colors.white),
                ),
              14.verticalSpace,
            ],
          ),
        );
      });
    });
  }

  Widget _title({required String title, required FontSet fonts}) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 16.w),
      child: Text(
        title,
        style: fonts.subtitle2.copyWith(fontSize: 18.sp),
      ),
    );
  }

  Widget _listTileItem({
    required String title,
    required CustomColorSet colors,
    required FontSet fonts,
    required VoidCallback onTap,
    required IconSet icons,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          onTap: onTap,
          title: Text(
            title,
            style: fonts.headline1,
          ),
          trailing: icons.forward.svg(
            color: colors.text,
            height: 14.sp,
          ),
        ),
        Divider(
            thickness: 1.h,
            height: 1.h,
            color: colors.customGreyC3,
            indent: 16.w,
            endIndent: 20.w),
      ],
    );
  }
}

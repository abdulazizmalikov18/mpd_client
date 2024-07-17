import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class PolicyComp extends StatelessWidget {
  const PolicyComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return SizedBox(
        child: Column(
          children: [
            Container(
              height: 46.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.white,
                border: Border.symmetric(
                  horizontal: BorderSide(color: colors.grey1, width: 1.w),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      return AnimationButtonEffect(
                        onTap: () {
                          if (state.profileParam == null) {
                            showAuthModalSheet(context, () {
                              context
                                  .read<ProfileBloc>()
                                  .add(const ProfileEvent.getProfile());
                            });
                          } else {
                            Navigator.push(
                                context, AppRoutes.getProfile(context));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 4.w, top: 4.h, bottom: 4.h),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                            return AutoSizeText(
                              state.profileParam != null
                                  ? "profile".tr()
                                  : 'registration'.tr(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: fonts.headline1,
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: colors.grey1,
                    indent: 8.w,
                    endIndent: 8.w,
                  ),
                  Expanded(
                    child: AnimationButtonEffect(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.only(
                            left: 4.w, right: 4.w, top: 4.h, bottom: 4.h),
                        child: AutoSizeText(
                          'orient_website'.tr(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: fonts.headline1,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: colors.grey1,
                    indent: 8.w,
                    endIndent: 8.w,
                  ),
                  Expanded(
                    child: AnimationButtonEffect(
                      onTap: () {
                        context
                            .read<MainBloc>()
                            .add(const MainEvent.getBranchList(id: 4));
                        Navigator.push(context, AppRoutes.getBranches(context));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.only(
                            left: 4.w, right: 16.w, top: 4.h, bottom: 4.h),
                        child: AutoSizeText(
                          'branches'.tr(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: fonts.headline1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            Text(
              'privacy_policy2'.tr(),
              style: TextStyle(
                color: colors.text,
                fontSize: 14.sp,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
            16.verticalSpace,
            SizedBox(
              width: 350.w,
              child: Opacity(
                opacity: 0.50,
                child: Text(
                  'orient_is_not_direct_mail_broker'.tr(),
                  textAlign: TextAlign.center,
                  style: Style.medium14(size: 12.sp),
                ),
              ),
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcons(icons, icons.telegram, colors),
                12.horizontalSpace,
                _socialIcons(icons, icons.instagram, colors),
                12.horizontalSpace,
                _socialIcons(icons, icons.facebook, colors),
              ],
            ),
            24.verticalSpace,
          ],
        ),
      );
    });
  }

  Widget _socialIcons(IconSet icons, String iconName, CustomColorSet colors) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.grey1,
        ),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(child: SvgPicture.asset(iconName)),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class LoginComp extends StatelessWidget {
  final bool isProfile;

  const LoginComp({super.key, required this.onTap, required this.isProfile});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 16, vertical: isProfile ? 4.h : 8.h),
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              side: isProfile
                  ? BorderSide.none
                  : BorderSide(width: 1.w, color: colors.customGreyC3),
              borderRadius: isProfile
                  ? BorderRadius.vertical(bottom: Radius.circular(12.r))
                  : BorderRadius.circular(12.r),
            ),
          ),
          child: Column(
            children: [
              Text(
                "profile".tr(),
                style: Style.bold16(size: 18),
              ),
              16.verticalSpace,
              CircleAvatar(
                radius: 35.r,
                backgroundColor: colors.grey1,
                backgroundImage: AssetImage(icons.user),
              ),
              16.verticalSpace,
              Text(
                'hello'.tr(),
                style: Style.semiBold16(size: 18.sp),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LoggedInComp extends StatelessWidget {
  const LoggedInComp({super.key, required this.onTap, required this.isProfile});

  final VoidCallback onTap;
  final bool isProfile;
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.profileParam == null) {
              return LoginComp(
                isProfile: isProfile,
                onTap: () {
                  showAuthModalSheet(
                    context,
                    () {
                      context
                          .read<ProfileBloc>()
                          .add(const ProfileEvent.getProfile());
                    },
                  );
                },
              );
            } else {
              return InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        "profile".tr(),
                        style: Style.bold16(size: 18),
                      ),
                      12.verticalSpace,
                      Center(
                        child: state.profileParam?.profilePic != null
                            ? CircleAvatar(
                                radius: 35.r,
                                backgroundColor: colors.customGreyC3,
                                backgroundImage: CachedNetworkImageProvider(
                                    state.profileParam!.profilePic!),
                              )
                            : CircleAvatar(
                                radius: 35.r,
                                backgroundColor: colors.grey1,
                                backgroundImage: AssetImage(icons.user),
                              ),
                      ),
                      12.verticalSpace,
                      Text(
                        state.profileParam == null
                            ? "hello".tr()
                            : "${"hello".tr()}, ${state.profileParam?.fullName ?? state.profileParam?.username ?? ""}",
                        style: Style.semiBold16(size: 18.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(text: "ID: ", style: Style.medium16(color: colors.text)),
                      //       TextSpan(text: "${state.profileParam.}", style: Style.bold16(color: colors.black)),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class LoggedInMenuComp extends StatelessWidget {
  const LoggedInMenuComp({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return InkWell(
          onTap: onTap,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: colors.colorF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                final item = state.profileParam ?? ProfileRes();
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  leading: item.profilePic == null
                      ? CircleAvatar(
                          radius: 26.r,
                          backgroundImage: AssetImage(icons.user),
                        )
                      : CircleAvatar(
                          radius: 26.r,
                          backgroundImage:
                              CachedNetworkImageProvider(item.profilePic!),
                        ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.profileParam != null
                          ? DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: colors.customRed,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                child: Text(
                                  "Частное лицо",
                                  style: Style.bold16(
                                      size: 12, color: colors.white),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      4.verticalSpace,
                      Text(
                        state.profileParam == null
                            ? "hello".tr()
                            : "${"hello".tr()}, ${item.fullName ?? item.username ?? ""}",
                        style: Style.semiBold14(size: 16),
                      ),
                    ],
                  ),
                  trailing: icons.forward.svg(
                    color: colors.black,
                    height: 16,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class UserInfoComp extends StatelessWidget {
  const UserInfoComp({
    super.key,
    required this.onTap,
    required this.owner,
    this.asAppBar = false,
  });

  final VoidCallback onTap;
  final Owner owner;
  final bool asAppBar;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return InkWell(
          onTap: onTap,
          child: DecoratedBox(
            decoration: asAppBar
                ? const BoxDecoration()
                : ShapeDecoration(
                    color: colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: colors.colorF5F5F5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
            child: Row(
              children: [
                if (asAppBar) ...[
                  6.horizontalSpace,
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: icons.back.svg()),
                ],
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 8.h, horizontal: asAppBar ? 10.w : 16.w),
                    leading: owner.profilePic == null
                        ? CircleAvatar(
                            radius: 26.r,
                            backgroundImage: AssetImage(icons.user),
                          )
                        : CircleAvatar(
                            radius: 26.r,
                            backgroundImage:
                                CachedNetworkImageProvider(owner.profilePic!),
                          ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: colors.colorF5F5F5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            child: Text(
                              "Частное лицо",
                              style: Style.bold16(
                                  size: 12, color: colors.customRed),
                            ),
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          owner.username ?? "",
                          style: Style.semiBold14(size: 16),
                        ),
                      ],
                    ),
                    subtitle: owner.fullName != null
                        ? Text(owner.fullName!,
                            style:
                                Style.medium14(size: 12.sp, color: colors.text))
                        : null,
                    trailing: asAppBar
                        ? null
                        : icons.forward.svg(
                            color: colors.black,
                            height: 16,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserInfoWithIconsComp extends StatelessWidget {
  const UserInfoWithIconsComp({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: 140.h,
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: icons.back.svg(color: colors.text),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.w),
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundImage: AssetImage(icons.user),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 24.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: ShapeDecoration(
                      color: colors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r)),
                    ),
                    child: Center(
                      child: Text(
                        'Частное лицо',
                        style: Style.semiBold14(color: colors.white),
                      ),
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    'Нодир',
                    style: Style.semiBold16(size: 18.sp),
                  ),
                  Text(
                    'Онлайн в 19:07',
                    style:
                        Style.semiBold14(color: colors.text.withOpacity(0.5)),
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: onTap,
                  icon: SvgPicture.asset(icons.horizontalDotRollBlack)),
              8.horizontalSpace
            ],
          ));
    });
  }
}

//
class UserInfoCompShimmer extends StatelessWidget {
  const UserInfoCompShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: colors.colorF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: ShimmerView(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundImage: AssetImage(icons.user),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerContainer(height: 24, width: 100),
                  4.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const ShimmerContainer(height: 20, width: 100),
                      4.horizontalSpace,
                      const ShimmerContainer(height: 20, width: 100)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              icons.forward.svg(
                color: colors.black,
                height: 30,
              ),
              8.horizontalSpace
            ]),
          ));
    });
  }
}

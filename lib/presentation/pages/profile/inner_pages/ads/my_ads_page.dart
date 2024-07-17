import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/presentation/component/custom_tabbar_component.dart';
import 'package:orient_motors/presentation/component/main_button_component.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/widget/archive_widget.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/widget/current_widget.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/widget/draft_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.putArchive) {
              context.read<ProfileBloc>()
                ..add(const ProfileEvent.getOwnActualCars(isActive: "1"))
                ..add(const ProfileEvent.getOwnActualCars(isActive: "0"));
            }
          },
          listenWhen: (previous, current) =>
              previous.putArchive != current.putArchive && current.putArchive,
          child: Scaffold(
            backgroundColor: colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    "my_announcements".tr(),
                    style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                  ),
                  floating: true,
                  pinned: true,
                  surfaceTintColor: colors.white,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50.h),
                    child: CustomTabbarBlack(
                      index: 0,
                      leftTab: 'current'.tr(),
                      middleTab: 'draft'.tr(),
                      rightTab: 'archive'.tr(),
                    ),
                  ),
                )
              ],
              body: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CurrentWidget(),
                  DraftWidget(),
                  ArchiveWidget(),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 56.h),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                return MainButtonComponent(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  text: "add_a_car".tr(),
                  onPressed: () {
                    checkTokenDialog(context, () {
                      if (state.profileParam?.username != null) {
                        Navigator.push(
                                context,
                                AppRoutes.getCreateCar(
                                    phoneNumber: state.profileParam!.username!,
                                    regionId: state.profileParam?.region))
                            .then((value) {
                          context.read<ProfileBloc>()
                            ..add(const ProfileEvent.getOwnActualCars(
                                isActive: "1"))
                            ..add(const ProfileEvent.getDrafts());
                          context
                              .read<BottomNavBarController>()
                              .changeNavBar(false);
                        });
                      }
                    });
                  },
                  childAfter: SvgPicture.asset(icons.adsCarWhite),
                  backgroundColor: colors.primary,
                );
              }),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      }),
    );
  }
}

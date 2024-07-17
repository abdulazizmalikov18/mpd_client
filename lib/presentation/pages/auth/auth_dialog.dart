import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

void checkTokenDialog(BuildContext context, Function onSuccess) {
  if (context.read<DBService>().token.accessToken != null) {
    onSuccess();
  } else {
    showDialog(
        context: context,
        builder: (BuildContext ctx) => CustomDialogComponent(
            isRightPop: true,
            title: "you_are_not_registred".tr(),
            content:
                'register_to_post_ads_and_gain_access_to_all_features'.tr(),
            leftButtonTitle: "later".tr(),
            rightButtonTitle: "registration".tr(),
            onRightButtonPressed: () {
              showAuthModalSheet(context, onSuccess);
            }));
  }
}

void showAuthModalSheet(BuildContext context, Function onSuccess) {
  context.read<BottomNavBarController>().changeNavBar(true);
  showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: 1.sh - MediaQuery.of(context).padding.top - 80.h,
          minHeight: 1.sh - MediaQuery.of(context).padding.top - 80.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) => ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.r),
            ),
            child: Container(
              color: Style.colorF5F5F5,
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    height: 6.h,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: Style.customGreyC3,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  Expanded(
                    child: Scaffold(
                      backgroundColor: Colors.red,
                      body: Navigator(
                        onGenerateRoute: (_) => AppRoutes.singUp(onClose: () {
                          Navigator.pop(ctx);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )).then((value) {
    context.read<BottomNavBarController>().changeNavBar(false);
    if (context.read<DBService>().token.accessToken != null) {
      context.read<ProfileBloc>()
        ..add(const ProfileEvent.getProfile())
        ..add(const ProfileEvent.getOwnActualCars(isActive: "1"))
        ..add(const ProfileEvent.getOwnActualCars(isActive: "0"))
        ..add(const ProfileEvent.getDrafts())
        ..add(const ProfileEvent.getLikedList())
        ..add(const ProfileEvent.getSeenList());

      context.read<MainBloc>()
        ..add(const MainEvent.getCurrency())
        ..add(const MainEvent.getNotificationsUnread());
      onSuccess();
    }
  });
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient_motors/presentation/component/easy_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

import '../../../infrastructure/services/connectivity.dart';
import '../../../infrastructure/services/local_database/db_service.dart';
import '../../component/custom_button.dart';
import '../../routes/routes.dart';
import '../../styles/theme_wrapper.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({super.key});

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  Future<void> retry() async {
    // Navigator.push(context, MaterialPageRoute(builder: (_) => ErrorPage()));
    await EasyLoading.show();
    final result = await ConnectivityX().create();
    if (result) {
      DBService.create.then((value) => Navigator.pushAndRemoveUntil(
          context, AppRoutes.getAppWidget(value, result), (route) => false));
      EasyLoading.dismiss();
      return;
    } else {
      return EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, c) {
      return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: icons.noInternet.svg(width: 200.w, height: 144.h),
              ),
              16.verticalSpace,
              Text('connection_is_afk'.tr(),
                  style: fonts.subtitle2.copyWith(fontSize: 18.sp)),
              10.verticalSpace,
              Text(
                'no_connection_body'.tr(),
                textAlign: TextAlign.center,
                style: fonts.subtitle1,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: retry,
                backgroundColor: colors.primary,
                titleColor: colors.white,
                verticalPadding: 10.h,
                title: 'retry'.tr(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

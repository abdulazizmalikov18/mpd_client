import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient_motors/presentation/component/easy_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../infrastructure/services/connectivity.dart';
import '../../../infrastructure/services/local_database/db_service.dart';
import '../../component/custom_button.dart';
import '../../routes/routes.dart';
import '../../styles/theme_wrapper.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  Future<void> retry() async {
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
                child: Image.asset(icons.errorPageImage,
                    width: 200.w, height: 144.h),
              ),
              16.verticalSpace,
              Text('something_went_wrong'.tr(),
                  style: fonts.subtitle2.copyWith(fontSize: 18.sp)),
              10.verticalSpace,
              Text(
                'try_again_in_a_few_minutes'.tr(),
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

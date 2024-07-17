import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_checkbox.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      bool isCheckUz = context.locale == const Locale('uz', 'UZ');
      return Scaffold(
        backgroundColor: colors.white,
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 72.w),
              child: Image.asset(
                icons.splashLogo,
                height: 80,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: MediaQuery.of(context).padding.bottom + 8.h),
              child: Column(
                children: [
                  Text("Tilni tanlang / Выберите язык",
                      style: fonts.subtitle2.copyWith(fontSize: 18.sp)),
                  12.verticalSpace,
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: colors.customGreyC3,
                          ),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: ListTile(
                        onTap: () {
                          EasyLocalization.of(context)!.setLocale(
                            const Locale('ru', 'RU'),
                          );
                        },
                        leading: SvgPicture.asset(icons.flagRu),
                        title: Text("Русский", style: fonts.headline1),
                        trailing: CustomCheckBoxComponent(
                            horizontalMargin: 0,
                            isCheck: !isCheckUz,
                            onChanged: () {
                              EasyLocalization.of(context)!.setLocale(
                                const Locale('ru', 'RU'),
                              );
                            }),
                      )),
                  12.verticalSpace,
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: colors.customGreyC3,
                          ),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: ListTile(
                        onTap: () {
                          EasyLocalization.of(context)!.setLocale(
                            const Locale('uz', 'UZ'),
                          );
                        },
                        leading: SvgPicture.asset(icons.flagUz),
                        title: Text("O’zbek tili", style: fonts.headline1),
                        trailing: CustomCheckBoxComponent(
                            horizontalMargin: 0,
                            isCheck: isCheckUz,
                            onChanged: () {
                              EasyLocalization.of(context)!.setLocale(
                                const Locale('uz', 'UZ'),
                              );
                            }),
                      )),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      context.read<DBService>().setLang(isSaved: true);

                      bool? isIntroDone = context.read<DBService>().getIntro;

                      if (isIntroDone != null && isIntroDone) {
                        Navigator.pushAndRemoveUntil(
                            context, AppRoutes.main(), (_) => false);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context, AppRoutes.getIntro(), (_) => false);
                        return;
                      }
                    },
                    backgroundColor: colors.primary,
                    title: "continue".tr(),
                    verticalPadding: 13.h,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

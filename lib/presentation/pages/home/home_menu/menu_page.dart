import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/bottom_sheet_comp.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/home_menu_appbar_comp.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/login_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext contextB) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.white,
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                        HomeMenuAppBarComp(
                            icons: icons,
                            colors: colors,
                            fonts: fonts,
                            onTap: () {
                              Navigator.push(
                                  context, AppRoutes.getNotification(context));
                            })
                      ],
              body: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: LoggedInMenuComp(
                      onTap: () {
                        checkTokenDialog(
                          context,
                          () {
                            Navigator.push(
                                context, AppRoutes.getEditProfile(context));
                          },
                        );
                      },
                    ),
                  ),
                  8.verticalSpace,
                  _listTile(icons.service4, "diagnostics".tr(), () {
                    Navigator.push(contextB, AppRoutes.getUsedCars());
                  }),
                  _listTile(icons.service3, "service".tr(), () {
                    Navigator.push(contextB, AppRoutes.getPremiumDiagnostic());
                  }),
                  _listTile(icons.service1, "spare_parts".tr(), () {
                    Navigator.push(
                        contextB, AppRoutes.getSignupForDiagnostic());
                  }),
                  _listTile(icons.news, "news".tr(), () {
                    context.read<MainBloc>()
                      ..add(const MainEvent.getNewsFamousList())
                      ..add(const MainEvent.getNewsRecentlyList());
                    Navigator.push(contextB, AppRoutes.getNews(context));
                  }),
                  _listTile(icons.locationHome, "branch".tr(), () {
                    context
                        .read<MainBloc>()
                        .add(const MainEvent.getBranchList(id: 4));
                    Navigator.push(contextB, AppRoutes.getBranches(context));
                  }),
                  _listTile(icons.faq, "faqs".tr(), () {
                    Navigator.push(contextB, AppRoutes.getFAQ());
                  }),
                  _listTile(icons.exchange, "currency".tr(), () async {
                    context.read<BottomNavBarController>().changeNavBar(true);
                    await showModalBottomSheet(
                        backgroundColor: colors.transparent,
                        context: context,
                        builder: (contextDialog) {
                          return BottomSheetComp(
                            firstItem: "conventional_unit"
                                .tr(args: [listCurrency.first.tr()]),
                            onTapFirst: () {
                              context
                                  .read<DBService>()
                                  .setCurrencySymbol(listCurrency.first);
                              Navigator.pop(contextDialog);
                            },
                            secondItem: "uzbek_currency"
                                .tr(args: [listCurrency.last.tr()]),
                            onTapSecond: () {
                              context
                                  .read<DBService>()
                                  .setCurrencySymbol(listCurrency.last);
                              Navigator.pop(contextDialog);
                            },
                          );
                        }).then((value) {
                      setState(() {});
                      context
                          .read<BottomNavBarController>()
                          .changeNavBar(false);
                    });
                  },
                      trailing: context.read<DBService>().getCurrencySymbol ==
                              listCurrency.last
                          ? "uzbek_currency".tr(args: [listCurrency.last.tr()])
                          : "conventional_unit"
                              .tr(args: [listCurrency.first.tr()])),
                  _listTileLanguage(
                    icon: icons.globe,
                    title: "language".tr(),
                    onTapUz: () async {
                      setState(() {
                        EasyLocalization.of(context)!.setLocale(
                          const Locale('uz', 'UZ'),
                        );
                      });
                    },
                    onTapRu: () async {
                      setState(() {
                        EasyLocalization.of(context)!.setLocale(
                          const Locale('ru', 'RU'),
                        );
                      });
                    },
                    colors: colors,
                    isUZ: context.locale == const Locale('uz', 'UZ'),
                    fonts: fonts,
                  ),
                  120.verticalSpace
                ],
              )),
        );
      },
    );
  }

  Widget _listTile(String icon, String title, VoidCallback onTap,
      {String? trailing}) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              onTap: onTap,
              leading: icon.svg(color: colors.customRed),
              title: Text(
                title,
                style: fonts.headline1,
              ),
              trailing: trailing != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          trailing,
                          style: fonts.caption.copyWith(
                              color: colors.customGreyC3,
                              fontWeight: FontWeight.w500),
                        ),
                        4.horizontalSpace,
                        icons.forward.svg(
                          color: colors.customGreyC3,
                          height: 12,
                        ),
                      ],
                    )
                  : null,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                height: 1.h,
                width: 1.sw,
                color: colors.customGreyC3)
          ],
        );
      },
    );
  }

  ListTile _listTileLanguage({
    required String icon,
    required String title,
    required VoidCallback onTapUz,
    required VoidCallback onTapRu,
    required CustomColorSet colors,
    required bool isUZ,
    required FontSet fonts,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(
        title,
        style: fonts.headline1,
      ),
      trailing: SizedBox(
        height: 48.h,
        width: 160.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: onTapRu,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: isUZ == false
                    ? ShapeDecoration(
                        color: colors.colorF5F5F5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: colors.customGreyC3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      )
                    : null,
                child: Text(
                  'РУ',
                  style: fonts.headline3.copyWith(
                      color: isUZ == false ? colors.primary : colors.black,
                      fontSize: 18.sp),
                ),
              ),
            ),
            4.horizontalSpace,
            InkWell(
              onTap: onTapUz,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: isUZ == true
                    ? ShapeDecoration(
                        color: colors.colorF5F5F5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: colors.customGreyC3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      )
                    : null,
                child: Text(
                  'UZ',
                  style: fonts.headline3.copyWith(
                      color: isUZ == true ? colors.primary : colors.black,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/home_menu_appbar_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class GuaranteePage extends StatelessWidget {
  const GuaranteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (contextT, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.backgroundScaffold,
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            HomeSliverAppBarComp(
                icons: icons,
                colors: colors,
                fonts: fonts,
                onTapNotification: () {
                  Navigator.push(context, AppRoutes.getNotification(context));
                },
                onTap: () {
                  Navigator.push(context, AppRoutes.getMenu());
                }),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: icons.back.svg(),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Гарантия ',
                            style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                          ),
                          TextSpan(
                            text: 'Orient Motors\n',
                            style: fonts.subtitle2.copyWith(
                                fontSize: 18.sp, color: colors.primary),
                          ),
                          TextSpan(
                            text: 'для отечественных и\nимпортных автомобилей',
                            style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCard(
                    onTap: () {
                      Navigator.push(context, AppRoutes.getGuaranteeDetail());
                    },
                    title: "Гарантия Orient на отечественные автомобили",
                    subtitle:
                        'Даже после покупки Enka напрямую берет на себя ответственность за 100%',
                    image: icons.guarantee1,
                    colors: colors,
                    fonts: fonts,
                    icons: icons),
                16.verticalSpace,
                _buildCard(
                    onTap: () {},
                    title: "Гарантия Orient на импортные автомобили",
                    subtitle:
                        'Техническое обслуживание обременительных автомобилей импортного производства,',
                    image: icons.guarantee2,
                    colors: colors,
                    fonts: fonts,
                    icons: icons),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required String image,
    required VoidCallback onTap,
    required CustomColorSet colors,
    required FontSet fonts,
    required IconSet icons,
  }) {
    return Container(
      width: double.infinity,
      height: 220.w,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        color: colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style:
                fonts.headline1.copyWith(color: Colors.white, fontSize: 18.sp),
          ),
          Text(
            subtitle,
            style: fonts.subtitle1.copyWith(color: Colors.white),
          ),
          AnimationButtonEffect(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  'more_details'.tr(),
                  style: fonts.subtitle1.copyWith(color: Colors.white),
                ),
                2.horizontalSpace,
                icons.forward.svg(color: Colors.white, height: 15.sp),
              ],
            ),
          )
        ],
      ),
    );
  }
}

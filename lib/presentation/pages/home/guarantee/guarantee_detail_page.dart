import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/home_menu_appbar_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/guarantee/comp/benefits_comp.dart';
import 'package:orient_motors/presentation/pages/home/guarantee/comp/car_guarantee_type_comp.dart';
import 'package:orient_motors/presentation/pages/home/guarantee/comp/month_km_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/top_image_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class GearanteeDetailPage extends StatelessWidget {
  const GearanteeDetailPage({super.key});

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
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// image
                Stack(
                  children: [
                    TopImageComp(
                      title: "Orient с вами даже после покупки".tr(),
                      subtitle: "",
                      image: icons.guarantee1,
                    ),
                    Positioned(
                      top: 10.w,
                      left: 10.w,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: icons.back.svg(color: colors.white),
                      ),
                    )
                  ],
                ),

                //text
                const MonthKmComp(),
                // benefits
                const BenefitsComp(),
                const CarGuaranteeTypeComp(),
                const PolicyComp(),
                16.verticalSpace,
              ],
            ),
          ),
        ),
      );
    });
  }
}

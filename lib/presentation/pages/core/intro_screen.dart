import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Material(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimationButtonEffect(
                      onTap: () {
                        context.read<DBService>().setIntro(isSaved: true);

                        Navigator.pushAndRemoveUntil(
                            context, AppRoutes.main(), (_) => false);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: colors.customGreyC3),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Text(
                          "skip".tr(),
                          style: Style.medium14(size: 12),
                        ),
                      ),
                    ),
                  ),
                  42.verticalSpace,
                  Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        currentIndex = value;
                        setState(() {});
                      },
                      controller: pageController,
                      children: _screenList(colors, icons),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Row(
                          children: List.generate(
                            _screenList(colors, icons).length,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 6.w),
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: index == currentIndex
                                    ? colors.customRed
                                    : colors.customGreyC3,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        AnimationButtonEffect(
                          onTap: () {
                            if (currentIndex == 2) {
                              context.read<DBService>().setIntro(isSaved: true);

                              Navigator.pushAndRemoveUntil(
                                  context, AppRoutes.main(), (_) => false);
                              return;
                            }

                            currentIndex++;
                            pageController.animateToPage(
                              currentIndex,
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              color: colors.text,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              currentIndex == 2
                                  ? "lets_get_started".tr()
                                  : "next".tr(),
                              style: Style.medium14(
                                size: 12,
                                color: colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _screenList(CustomColorSet colors, IconSet icons) {
    return [
      _buildScreen(
        title: "welcome_to_ORIENT_MOTORS".tr(),
        subtitle:
            "your_reliable_solution_for_convenient_and_safe_purchase_and_sale_of_cars"
                .tr(),
        image: icons.introPic,
      ),
      _buildScreen(
        title: "directly_at_your_desired_price".tr(),
        subtitle: "sell_your_car_at_your_desired_price_with_our_listing".tr(),
        image: icons.introPicSecond,
      ),
      _buildScreen(
        title: "sale_via_auction".tr(),
        subtitle:
            "sell_your_car_at_auction_and_give_buyers_the_chance_to_compete"
                .tr(),
        image: icons.introPicThird,
      ),
    ];
  }

  _buildScreen(
      {required String title,
      required String subtitle,
      required String image}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                title,
                style: Style.bold20(size: 18),
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,
              Text(
                subtitle,
                style: Style.medium16(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        20.verticalSpace,
        Expanded(
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        20.verticalSpace,
      ],
    );
  }
}

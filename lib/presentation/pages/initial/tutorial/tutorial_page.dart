import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/domain/models/tutorial_model.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

import 'components/tutorial_page_view_widget.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final _pageController = PageController();
  ValueNotifier<int> activeIndex = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageViewPages = [
      PageViewWidget(
        tutorial: TutorialModel(
          AppIcons.tutorial_1,
          context.l10n.presentation_first_page,
          context.l10n.presentation_first_page_description,
        ),
      ),
      PageViewWidget(
        tutorial: TutorialModel(
          AppIcons.tutorial_2,
          context.l10n.presentation_second_page,
          context.l10n.presentation_second_description,
        ),
      ),
      PageViewWidget(
        tutorial: TutorialModel(
          AppIcons.tutorial_3,
          context.l10n.presentation_third_page,
          context.l10n.presentation_third_description,
        ),
      ),
      PageViewWidget(
        tutorial: TutorialModel(
          AppIcons.tutorial_4,
          context.l10n.presentation_four_page,
          context.l10n.presentation_four_page_description,
        ),
      ),
    ];
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenUtil().setVerticalSpacing(MediaQuery.of(context).viewPadding.top + 40),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                activeIndex.value = value;
              },
              itemCount: pageViewPages.length,
              itemBuilder: (context, index) => pageViewPages[index],
            ),
          ),
          ScreenUtil().setVerticalSpacing(20.h),
          ValueListenableBuilder(
            valueListenable: activeIndex,
            builder: (BuildContext context, int value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List<Widget>.generate(
                  pageViewPages.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: background,
                        gradient: value == index
                            ? const LinearGradient(colors: [
                                gradientBlueOpacity,
                                gradientBlue,
                              ])
                            : null,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          ScreenUtil().setVerticalSpacing(30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ValueListenableBuilder(
              valueListenable: activeIndex,
              builder: (BuildContext context, int value, Widget? child) {
                return LongButton(
                  buttonName: value == 3 ? context.l10n.presentation_next : context.l10n.presentation_get_start,
                  onPress: () {
                    if (value == 3) {
                      context.goNamed(AppRouteNames.login);
                    } else {
                      _pageController.animateToPage(
                        value += 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                );
              },
            ),
          ),
          ScreenUtil().setVerticalSpacing(20.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: 3 == 3
                ? Container(
                    height: 50.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, AppRoutes.auth);
                      },
                      style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                      child: Text(
                        context.l10n.presentation_skip,
                        textAlign: TextAlign.center,
                        style: AppTheme.headlineSmall.copyWith(color: black),
                      ),
                    ),
                  )
                : SizedBox(height: 50.h),
          ),
          ScreenUtil().setVerticalSpacing(40.h)
        ],
      ),
    );
  }
}

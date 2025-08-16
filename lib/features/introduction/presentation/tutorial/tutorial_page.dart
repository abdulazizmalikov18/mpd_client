import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/features/introduction/data/models/tutorial_model.dart';
import 'package:mpd_client/features/introduction/domain/inhereted/inherited_notifier.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

import 'components/tutorial_page_view_widget.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final _pageController = PageController();

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
    final notifier = TutorialInheritedNotifier.of(context).notifier!;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenUtil().setVerticalSpacing(
            MediaQuery.of(context).viewPadding.top,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) => notifier.pageIndex = value,
              itemCount: pageViewPages.length,
              itemBuilder: (context, index) => pageViewPages[index],
            ),
          ),
          ScreenUtil().setVerticalSpacing(20.h),
          Row(
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
                    color: context.color.background,
                    gradient: notifier.pageIndex == index
                        ? LinearGradient(
                            colors: [
                              context.color.gradientBlueOpacity,
                              context.color.gradientBlue,
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
          ScreenUtil().setVerticalSpacing(100.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: LongButton(
              buttonName: notifier.pageIndex != 3
                  ? context.l10n.presentation_next
                  : context.l10n.presentation_get_started,
              onPress: () {
                if (notifier.pageIndex == 3) {
                  Navigator.pushNamed(context, AppRoutes.auth);
                } else {
                  _pageController.animateToPage(
                    notifier.pageIndex += 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
            ),
          ),
          ScreenUtil().setVerticalSpacing(20.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: notifier.pageIndex != 3
                ? Container(
                    height: 50.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.auth);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        context.l10n.presentation_skip,
                        textAlign: TextAlign.center,
                        style: Styles.headline6.copyWith(
                          color: context.color.black,
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: 50.h),
          ),
          ScreenUtil().setVerticalSpacing(40.h),
        ],
      ),
    );
  }
}

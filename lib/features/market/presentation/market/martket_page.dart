import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/features/home/presentation/widgets/category_widget.dart';
import 'package:mpd_client/src/widgets/search_field_widget.dart';

import '../../../../app/app_colors.dart';
import '../../../../src/themes/styles.dart';
import 'components/market_card_widget.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: .0,
        toolbarHeight: 64,
        leadingWidth: 0,
        title: SearchFieldWidget(
          searchHint: 'Search',
          controller: TextEditingController(),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: MaterialButton(
              highlightElevation: 0,
              minWidth: 44.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              elevation: 0,
              color: context.color.background,
              onPressed: () {},
              enableFeedback: false,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
              child: SvgPicture.asset(
                AppIcons.settings,
                colorFilter:  ColorFilter.mode(context.color.black, BlendMode.srcIn),
                height: 16.h,
                width: 16.h,
              ),
            ),
          ),
          ScreenUtil().setHorizontalSpacing(16.w)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Styles.boldTopHint.copyWith(fontSize: 18.sp, color: context.color.black),
                  ),
                  TextButton(
                    onPressed: () {
                      // showModalBottomSheet(
                      //   backgroundColor: Colors.transparent,
                      //   isScrollControlled: true,
                      //   context: context,
                      //   builder: (ctx) => _buildCategorySheet(context),
                      // );
                    },
                    style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h))),
                    child: Text(
                      'See all',
                      style: Styles.boldTopHint.copyWith(fontSize: 16.sp, color: context.color.mainBlue),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) =>
                      const CategoryWidget(categoryName: 'Skin Care', categoryImagePath: AppImages.marketCategory),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New products',
                    style: Styles.boldTopHint.copyWith(fontSize: 18.sp, color: context.color.black),
                  ),
                  TextButton(
                    onPressed: () {
                      // showModalBottomSheet(
                      //   backgroundColor: Colors.transparent,
                      //   isScrollControlled: true,
                      //   context: context,
                      //   builder: (ctx) => _buildCategorySheet(context),
                      // );
                    },
                    style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h))),
                    child: Text(
                      'See all',
                      style: Styles.boldTopHint.copyWith(fontSize: 16.sp, color: context.color.mainBlue),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Wrap(
                  spacing: 12.w, runSpacing: 12.h, children: List.generate(3, (index) => const MarketCardWidget())),
            ),
            ScreenUtil().setVerticalSpacing(12.h)
          ],
        ),
      ),
    );
  }
}

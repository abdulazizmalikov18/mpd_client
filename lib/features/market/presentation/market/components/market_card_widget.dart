import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/src/widgets/transparent_long_button.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../src/themes/styles.dart';

class MarketCardWidget extends StatelessWidget {
  const MarketCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          height: 276.h,
          width: 173.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: context.color.white,
              boxShadow:  [BoxShadow(color: context.color.cardShadow, blurRadius: 20)]),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 140.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: const DecorationImage(image: AssetImage(AppImages.marketCategory), fit: BoxFit.fill)),
              ),
              ScreenUtil().setVerticalSpacing(8.h),
              Text(
                'FarmStay All in One Collagen and...',
                style: Styles.postSubtitle,
              ),
              const Spacer(),
              Text(
                '159 900 UZS',
                style: Styles.boldHeadline6.copyWith(fontWeight: FontWeight.w600),
              ),
              ScreenUtil().setVerticalSpacing(8.h),
              TransparentLongButton(
                textColor: context.color.mainBlue,
                borderColor: context.color.mainBlue,
                buttonName: 'Add cart',
                onPress: () {},
                height: 32.h,
                fontsize: 12.sp,
              )
            ],
          ),
        ),
        Positioned(
            top: 16,
            left: 16,
            child: Container(
              width: 28.w,
              height: 15.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: context.color.gradientRedOpacity),
              child: Text(
                '15%',
                style: Styles.headline6.copyWith(color: context.color.white, fontSize: 10.sp),
              ),
            ))
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/home/presentation/widgets/swipe_indicator.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/app_export.dart';
import '../../domain/inherited/adverticement_inherited.dart';

class Adverticements extends StatelessWidget {
  final AdverticementState state;
  const Adverticements({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.adverts.isNotEmpty) {
      return _buildBannerList(context);
    } else {
      return _buildLoadingBanner(context);
    }
  }

  Shimmer _buildLoadingBanner(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.color.baseColor,
      highlightColor: context.color.highlightColor,
      child: Container(
        height: 175.h,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.color.white)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenUtil().setVerticalSpacing(24.h),
            Container(
              height: 24.h,
              width: 135.w,
              decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
            ScreenUtil().setVerticalSpacing(8.h),
            Container(
              height: 34.h,
              width: 236.w,
              decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
            const Spacer(),
            Container(
              height: 34.h,
              width: 110.w,
              decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
            ScreenUtil().setVerticalSpacing(26.h)
          ],
        ),
      ),
    );
  }

  Container _buildBannerList(BuildContext context) {
    return Container(
      height: 175.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: CarouselSlider.builder(
                itemCount: state.adverts.length,
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    AdverticementInheritedNotifier.of(context)
                        .notifier!
                        .advertChanged(index);
                  },
                ),
                itemBuilder: (context, index, realIndex) => SizedBox(
                  width: double.maxFinite,
                  child: CachedNetworkImage(
                    imageUrl: state.adverts[0].post!.media![0].image ??
                        'https://resources.comphealth.com/wp-content/uploads/2019/05/post-residency-career-tips.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.h,
              right: 0,
              left: 0,
              child: SwipeIndicator(
                  current: AdverticementInheritedNotifier.of(context)
                      .notifier!
                      .currentAdvertIndex,
                  length: state.adverts.length),
            ),
            Positioned(
              left: 16.w,
              bottom: 14.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.color.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r)),
                    elevation: 0,
                    minimumSize: Size(110.w, 34.h)),
                onPressed: () {},
                child: Text(
                  'Check now',
                  style: Styles.expTitle.copyWith(fontSize: 14.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

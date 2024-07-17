import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ReviewCarsComp extends StatefulWidget {
  const ReviewCarsComp({super.key, this.hasTrailing = false});

  final bool hasTrailing;

  @override
  State<ReviewCarsComp> createState() => _ReviewCarsCompState();
}

class _ReviewCarsCompState extends State<ReviewCarsComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (_, colors, fonts, icons, controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: widget.hasTrailing == true
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'review_of_cars_from'.tr(),
                                style: Style.medium14(size: 16.sp),
                              ),
                              TextSpan(
                                text: 'Orient Motors',
                                style: Style.medium14(
                                    size: 18.sp, color: colors.primary),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        AnimationButtonEffect(
                          onTap: () {
                            context
                                .read<ReviewBloc>()
                                .add(const ReviewEvent.getBodyType());
                            Navigator.push(
                                context, AppRoutes.getReviewCars(context));
                          },
                          child: SizedBox(
                            child: Row(
                              children: [
                                Opacity(
                                  opacity: 0.50,
                                  child: Text(
                                    'see_all'.tr(),
                                    style: Style.medium14(),
                                  ),
                                ),
                                8.horizontalSpace,
                                icons.forward.svg(
                                  color: colors.grey,
                                  height: 14,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Text(
                      'similar_models'.tr(),
                      style: Style.medium16(size: 18.sp),
                    ),
            ),
            8.verticalSpace,
            SizedBox(
              height: 140.h,
              child: BlocBuilder<ReviewBloc, ReviewState>(
                builder: (_, state) {
                  final list = state.listModel?.result?.toList() ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    itemCount: list.length < 6 ? list.length : 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext _, int index) {
                      final item = list[index];
                      return _carCard(
                          item: item,
                          colors: colors,
                          icons: icons,
                          context: context);
                    },
                  );
                },
              ),
            ),
            24.verticalSpace,
          ],
        );
      },
    );
  }

  Widget _carCard({
    required ReviewListModel item,
    required CustomColorSet colors,
    required IconSet icons,
    required BuildContext context,
  }) {
    final title = "${item.carModel?.brand?.name} ${item.carModel?.name}";
    return AnimationButtonEffect(
      onTap: () {
        Navigator.push(context,
            AppRoutes.getReviewCarDetail(context, item, ReviewController()));
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: colors.white,
              border: Border.all(
                color: colors.borderColor,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.verticalSpace,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Style.medium14(),
                ),
                Opacity(
                  opacity: 0.50,
                  child: Text(
                    item.advantage?.title ?? "",
                    textAlign: TextAlign.center,
                    style: Style.medium14(size: 12.sp),
                  ),
                ),
                4.verticalSpace,
                StarsComp(starCount: item.orientMotorsOverallRating ?? 0),
                12.verticalSpace,
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 16.w,
            left: 16.w,
            child: CachedNetworkImage(imageUrl: item.photo ?? "", height: 64.h),
          ),
        ],
      ),
    );
  }
}

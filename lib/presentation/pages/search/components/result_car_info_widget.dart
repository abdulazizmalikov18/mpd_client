import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/gallery_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';

class ResultCarInfoWidget extends StatefulWidget {
  const ResultCarInfoWidget({
    super.key,
    this.onTap,
    required this.resultsModel,
    this.isLikePage = false,
    required this.likes,
  });

  final List<CarModel> likes;
  final Function()? onTap;
  final CarModel resultsModel;
  final bool isLikePage;

  @override
  State<ResultCarInfoWidget> createState() => _ResultCarInfoWidgetState();
}

class _ResultCarInfoWidgetState extends State<ResultCarInfoWidget> {
  bool liked = true;

  bool get isFav => widget.isLikePage
      ? true
      : widget.likes.map((e) => e.id).contains(widget.resultsModel.id);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AnimatedOpacity(
        opacity: liked ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInQuart,
        child: AnimationButtonEffect(
          onTap: widget.onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// image
                Container(
                  height: 200.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  alignment: Alignment.topRight,
                  child: Stack(
                    children: [
                      GalleryComp(
                        bottomGap: 0,
                        height: 200,
                        borderRadius: 10.r,
                        images: widget.resultsModel.photos?.toList() ?? [],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AnimationButtonEffect(
                          onTap: () {
                            context.read<ProfileBloc>().add(
                                ProfileEvent.patchLike(
                                    id: widget.resultsModel.id ?? 0));
                            final dbService = context.read<DBService>();

                            if (widget.isLikePage) {
                              liked = false;
                              setState(() {});

                              Future.delayed(const Duration(milliseconds: 250),
                                  () {
                                dbService.removeLike(widget.resultsModel);
                                liked = true;
                                setState(() {});
                              });
                              return;
                            }
                            if (!isFav) {
                              dbService.addLike(widget.resultsModel);
                            } else {
                              dbService.removeLike(widget.resultsModel);
                            }

                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            margin: EdgeInsets.all(8.sp),
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: colors.text,
                            ),
                            child: widget.likes
                                    .map((e) => e.id)
                                    .contains(widget.resultsModel.id)
                                ? icons.favoriteFill
                                    .svg(color: colors.white, height: 20.w)
                                : icons.favorite
                                    .svg(color: colors.white, height: 20.w),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.resultsModel.brand?.name ?? ''} ${widget.resultsModel.carModel?.name ?? ''}",
                              style: fonts.subtitle2,
                            ),
                          ),
                          8.horizontalSpace,
                          Text(
                            widget.resultsModel.price.toFormattedCurrency(
                                dbService: context.read<DBService>(),
                                currencyS: widget.resultsModel.currency),
                            style: fonts.headline2.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      SizedBox(
                        height: 18.h,
                        child: Row(
                          children: [
                            Text(
                              "${widget.resultsModel.year ?? ''}г",
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 13.sp, color: colors.customGrey9A),
                            ),
                            VerticalDivider(
                                indent: 4.h,
                                endIndent: 4.h,
                                color: colors.customGreyE1),
                            Text(
                              // '0км',
                              "${widget.resultsModel.mileage ?? ''}${"km".tr()}",
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 13.sp, color: colors.customGrey9A),
                            ),
                            VerticalDivider(
                                indent: 4.h,
                                endIndent: 4.h,
                                color: colors.customGreyE1),
                            Text(
                              widget.resultsModel.fuelType?.name ?? '',
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 13.sp, color: colors.customGrey9A),
                            ),
                          ],
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        "${widget.resultsModel.region?.name ?? ''} - ${dateFormatValue(widget.resultsModel.postedAt ?? "")}",
                        style: fonts.subtitle1.copyWith(
                            fontSize: 10.sp, color: colors.customGrey9A),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

//min size detail widget
class ResultCarInfoMinWidget extends StatefulWidget {
  const ResultCarInfoMinWidget({
    super.key,
    this.onTap,
    this.isLikePage = false,
    required this.likes,
    required this.resultsModel,
  });

  final Function()? onTap;
  final bool isLikePage;
  final List<CarModel> likes;
  final CarModel resultsModel;

  @override
  State<ResultCarInfoMinWidget> createState() => _ResultCarInfoMinWidgetState();
}

class _ResultCarInfoMinWidgetState extends State<ResultCarInfoMinWidget> {
  bool liked = true;

  bool get isFav => widget.isLikePage
      ? true
      : widget.likes.map((e) => e.id).contains(widget.resultsModel.id);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AnimatedOpacity(
        opacity: liked ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInQuart,
        child: AnimationButtonEffect(
          onTap: widget.onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// image
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  alignment: Alignment.topRight,
                  child: Stack(
                    children: [
                      GalleryComp(
                        bottomGap: 0,
                        height: 120,
                        borderRadius: 10.r,
                        dotBottomPadding: 8.h,
                        images: widget.resultsModel.photos?.toList() ?? [],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AnimationButtonEffect(
                          onTap: () {
                            context.read<ProfileBloc>().add(
                                ProfileEvent.patchLike(
                                    id: widget.resultsModel.id ?? 0));
                            final dbService = context.read<DBService>();

                            if (widget.isLikePage) {
                              liked = false;
                              setState(() {});

                              Future.delayed(const Duration(milliseconds: 250),
                                  () {
                                dbService.removeLike(widget.resultsModel);
                                liked = true;
                                setState(() {});
                              });
                              return;
                            }

                            if (!isFav) {
                              dbService.addLike(widget.resultsModel);
                            } else {
                              dbService.removeLike(widget.resultsModel);
                            }

                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            margin: EdgeInsets.all(8.sp),
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: colors.text,
                            ),
                            child: widget.likes
                                    .map((e) => e.id)
                                    .contains(widget.resultsModel.id)
                                ? icons.favoriteFill.svg(
                                    color: colors.white,
                                    height: 20.w,
                                  )
                                : icons.favorite.svg(
                                    color: colors.white,
                                    height: 20.w,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.resultsModel.brand?.name ?? ''} ${widget.resultsModel.carModel?.name ?? ''}",
                        style: fonts.subtitle2.copyWith(fontSize: 12.sp),
                        maxLines: 1,
                      ),
                      8.verticalSpace,
                      SizedBox(
                        height: 18.h,
                        child: Row(
                          children: [
                            Text(
                              "${widget.resultsModel.year ?? ''}г",
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 10.sp, color: colors.customGrey9A),
                            ),
                            VerticalDivider(
                                indent: 4.h,
                                endIndent: 4.h,
                                color: colors.customGreyE1),
                            Text(
                              // '0км',
                              "${widget.resultsModel.mileage ?? ''}${"km".tr()}",
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 10.sp, color: colors.customGrey9A),
                            ),
                            VerticalDivider(
                                indent: 4.h,
                                endIndent: 4.h,
                                color: colors.customGreyE1),
                            Text(
                              widget.resultsModel.fuelType?.name ?? '',
                              style: fonts.subtitle1.copyWith(
                                  fontSize: 10.sp, color: colors.customGrey9A),
                            ),
                          ],
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        widget.resultsModel.price.toFormattedCurrency(
                            dbService: context.read<DBService>(),
                            currencyS: widget.resultsModel.currency),
                        style: fonts.headline2.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        "${widget.resultsModel.region?.name ?? ''} - ${dateFormatValue(widget.resultsModel.postedAt ?? "")}",
                        style: fonts.subtitle1.copyWith(
                            fontSize: 10.sp, color: colors.customGrey9A),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

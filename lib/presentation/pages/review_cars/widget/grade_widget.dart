import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/faq_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/learn_more_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/share_button_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/comment_list_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/write_comment_widget.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class GradeWidget extends StatelessWidget {
  final ReviewController vmController;
  final TabController tabController;
  const GradeWidget(
      {super.key, required this.vmController, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          final item = state.systhesisModel;
          if (state.statusSysthesis == FormzSubmissionStatus.inProgress ||
              state.statusSysthesis == FormzSubmissionStatus.initial) {
            return const ReviewShimmerComp();
          }
          return ListView(
            shrinkWrap: true,
            children: [
              _imageSharePart(colors, item?.photo ?? ""),
              16.verticalSpace,
              _listTilePart(colors, icons),
              16.verticalSpace,
              _recomendedCarPart(colors, icons, item),
              16.verticalSpace,
              FAQComp(
                titles: state.faqModel
                    .map((e) =>
                        (childText: e.answer ?? "", title: e.question ?? ""))
                    .toList(),
              ),
              16.verticalSpace,
              _designPart(colors, icons, state.designModel),
              16.verticalSpace,
              _sizePart(colors, icons, state.sizeSpaceModel),
              16.verticalSpace,
              // _safetyPart(colors, icons, state.safetyConvenienceModel),
              // 16.verticalSpace,
              _performancePart(colors, icons, "specification".tr(), "",
                  state.maintenanceModel?.ratedByOrientMotors, 3),
              // 16.verticalSpace,
              // _performancePart(colors, icons, "defects_and_problems".tr(), "Запланированное обновление"),
              16.verticalSpace,
              _performancePart(colors, icons, "price".tr(), "",
                  state.maintenanceModel?.ratedByOrientMotors, 4),
              16.verticalSpace,
              _performancePart(colors, icons, "link".tr(), "",
                  state.maintenanceModel?.ratedByOrientMotors, 5),
              _commentPart(
                  colors,
                  icons,
                  "comments".tr(),
                  state.safetyConvenienceModel?.id ?? 0,
                  state.commentsList ?? [],
                  state.maintenanceModel?.ratedByOrientMotors,
                  6),
              const ReviewCarsComp(),
              const PolicyComp(),
              36.verticalSpace,
            ],
          );
        },
      );
    });
  }

  Widget _imageSharePart(CustomColorSet colors, String img) {
    return ColoredBox(
      color: colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 230,
            child: ColoredBox(
                color: colors.backgroundColor,
                child: CachedNetworkImage(imageUrl: img, fit: BoxFit.cover)),
          ),
          const ShareButtonComp(),
        ],
      ),
    );
  }

  Widget _listTilePart(CustomColorSet colors, IconSet icons) {
    return ColoredBox(
      color: colors.white,
      child: Column(children: [
        ListTile(
          leading: Container(
            width: 30.w,
            height: 30.w,
            decoration: ShapeDecoration(
              color: colors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.r)),
            ),
            padding: const EdgeInsets.all(4),
            child: icons.minus.svg(color: colors.white),
          ),
          title: Text(
            'compact_car_with_all_modern_organs'.tr(),
            style: Style.medium14(),
          ),
        ),
        ListTile(
          leading: Container(
            width: 30.w,
            height: 30.w,
            decoration: ShapeDecoration(
              color: colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.r)),
            ),
            padding: const EdgeInsets.all(4),
            child: icons.plus.svg(color: colors.white),
          ),
          title: Text(
            'are_you_not_going_buy_full_version'.tr(),
            style: Style.medium14(),
          ),
        ),
      ]),
    );
  }

  Widget _recomendedCarPart(
      CustomColorSet colors, IconSet icons, ReviewSysthesisModel? item) {
    return ColoredBox(
      color: colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'grade'.tr(),
            textAlign: TextAlign.center,
            style: Style.medium16(size: 18.sp),
          ),
          // 16.verticalSpace,
          // Opacity(
          //   opacity: 0.5,
          //   child: Text(
          //     '${"rating".tr()} ${model.orientMotorsOverallRating?.toStringAsFixed(1)} | ${"customer_rating".tr()} ${model.usersRating?.toStringAsFixed(1)}',
          //     textAlign: TextAlign.center,
          //     style: Style.medium14(),
          //   ),
          // ),
          // 8.verticalSpace,
          // StarsComp(starCount: ((model.orientMotorsOverallRating ?? 0) + (model.usersRating ?? 0)) / 2),
          8.verticalSpace,
          Divider(color: colors.customGreyC3),
          8.verticalSpace,
          SizedBox(
            width: 350,
            child: Opacity(
              opacity: 0.90,
              child: Text(
                item?.text ?? "",
                style: Style.regular14(),
              ),
            ),
          ),
          8.verticalSpace,
          // Divider(color: colors.customGreyC3),
          // 8.verticalSpace,
          // Center(child: Icon(Icons.keyboard_arrow_down_rounded, color: colors.black))
        ]),
      ),
    );
  }

  Widget _designPart(
      CustomColorSet colors, IconSet icons, ReviewDesignModel? item) {
    return ColoredBox(
      color: colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LearnMoreComp(
              title: "design".tr(),
              onTap: () {
                vmController.selectedIndex.value = 1;
                tabController.animateTo(vmController.selectedIndex.value);
              },
              rating: item?.ratedByOrientMotors ?? 0,
            ),
          ),
          SizedBox(
            height: 190.h,
            width: double.infinity,
            child: ListView.builder(
                itemCount: item?.externalPhotos?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  final img = item?.externalPhotos?[index] ?? "";
                  return Container(
                    width: 330.w,
                    height: 188.h,
                    padding: EdgeInsets.all(12.sp),
                    margin: EdgeInsets.only(
                      left: index == 0 ? 16.0.w : 8.w,
                      right: index == 4 ? 16.0.w : 0,
                    ),
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(img),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  );
                }),
          ),
          36.verticalSpace,
        ],
      ),
    );
  }

  Widget _performancePart(
      CustomColorSet colors, IconSet icons, String title, String content,
      [double? stars, int? page]) {
    return ColoredBox(
      color: colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: LearnMoreComp(
            title: title,
            onTap: () {
              vmController.selectedIndex.value = page ?? 0;
              tabController.animateTo(vmController.selectedIndex.value);
            },
            rating: stars ?? 0,
          ),
        ),
        content.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  content,
                  style: Style.medium14(color: colors.text.withOpacity(.5)),
                  maxLines: 3,
                ),
              ),
        content.isEmpty ? const SizedBox.shrink() : 36.verticalSpace,
      ]),
    );
  }

  Widget _commentPart(CustomColorSet colors, IconSet icons, String title,
      int id, List<CommentsModel> list,
      [double? stars, int? page]) {
    return ColoredBox(
      color: colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: LearnMoreComp(
            title: title,
            onTap: () {
              vmController.selectedIndex.value = page ?? 0;
              tabController.animateTo(vmController.selectedIndex.value);
            },
            rating: stars ?? 0,
          ),
        ),
        WriteCommentWidget(vmCtr: vmController, id: id),
        CommentListWidget(list: list, limited: true),
        36.verticalSpace,
      ]),
    );
  }

  // Widget _safetyPart(CustomColorSet colors, IconSet icons, ReviewSafetyConvenienceModel? item) {
  //   return Visibility(
  //     visible: item != null,
  //     child: ColoredBox(
  //       color: colors.white,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: LearnMoreComp(
  //               title: "grade".tr(),
  //               onTap: () {
  //                 vmController.selectedIndex.value = 3;
  //               },
  //               rating: item?.ratedByOrientMotors ?? 0,
  //             ),
  //           ),
  //           Column(
  //             children: item?.advantages?.map((param) => DotTitleComp(title: param.title ?? "")).toList() ?? [],
  //           ),
  //           24.verticalSpace,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _sizePart(
      CustomColorSet colors, IconSet icons, ReviewSizeSpaceModel? model) {
    return ColoredBox(
      color: colors.white,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LearnMoreComp(
            rating: model?.ratedByOrientMotors ?? 0,
            title: "size".tr(),
            onTap: () {
              vmController.selectedIndex.value = 2;
              tabController.animateTo(vmController.selectedIndex.value);
            },
          ),
        ),
        SizedBox(
          height: 190.h,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return index == 0
                  ? Container(
                      width: 350.w,
                      height: 178.h,
                      padding: EdgeInsets.all(12.sp),
                      margin: EdgeInsets.only(
                        left: index == 0 ? 16.0.w : 8.w,
                        right: index == 1 ? 16.0.w : 0,
                      ),
                      decoration: ShapeDecoration(
                        color: colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: const Color(0x4CC3C3C3)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 5,
                            offset: Offset(0, 0),
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 56),
                              Image.network(
                                model?.heightWidthPhoto ?? "",
                                fit: BoxFit.contain,
                                height: 124.h,
                                width: 158.w,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 24.h,
                                      width: 1.w,
                                      color: colors.black,
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      'height2'.tr(),
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      "${model?.dimension?.height?.toInt() ?? 0}mm",
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                    4.verticalSpace,
                                    Container(
                                      height: 24.h,
                                      width: 1.w,
                                      color: colors.black,
                                    ),
                                  ])
                            ],
                          ),
                          24.verticalSpace,
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 2.w,
                                  width: 12.w,
                                  color: colors.black,
                                ),
                                4.horizontalSpace,
                                Text(
                                  "width2".tr(),
                                  style: Style.medium14(size: 10.sp),
                                ),
                                4.horizontalSpace,
                                Text(
                                  "${model?.dimension?.width?.toInt() ?? 0}mm",
                                  style: Style.medium14(size: 10.sp),
                                ),
                                4.horizontalSpace,
                                Container(
                                  height: 2.w,
                                  width: 12.w,
                                  color: colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  : Container(
                      width: 350.w,
                      height: 178.h,
                      padding: EdgeInsets.all(12.sp),
                      margin: EdgeInsets.only(
                        left: index == 0 ? 16.0.w : 8.w,
                        right: index == 1 ? 16.0.w : 0,
                      ),
                      decoration: ShapeDecoration(
                        color: colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: const Color(0x4CC3C3C3)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 5,
                            offset: Offset(0, 0),
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            icons.carLength,
                            width: 240.w,
                            height: 80.h,
                            fit: BoxFit.contain,
                          ),
                          24.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12.h,
                                width: 1.w,
                                color: colors.customGreyC3,
                              ),
                              4.horizontalSpace,
                              Text(
                                "${"wheelbase2".tr()} ${model?.dimension?.weight?.toInt() ?? 0}",
                                style: Style.medium14(size: 10.sp),
                              ),
                              4.horizontalSpace,
                              Container(
                                height: 12.h,
                                width: 1.w,
                                color: colors.customGreyC3,
                              ),
                            ],
                          ),
                          4.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 1.h,
                                width: 50.w,
                                color: colors.customGreyC3,
                              ),
                              4.horizontalSpace,
                              Text(
                                "${"length2".tr()} ${model?.dimension?.length?.toInt()} mm",
                                style: Style.medium14(size: 10.sp),
                              ),
                              4.horizontalSpace,
                              Container(
                                height: 1.h,
                                width: 50.w,
                                color: colors.customGreyC3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
        36.verticalSpace,
      ]),
    );
  }
}

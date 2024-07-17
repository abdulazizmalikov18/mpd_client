import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/home/news/comp/popular_shimmer_list.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class PopularComp extends StatelessWidget {
  const PopularComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ColoredBox(
          color: colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  'popular'.tr(),
                  textAlign: TextAlign.left,
                  style: Style.medium20(size: 18.sp),
                ),
              ),
              8.verticalSpace,
              SizedBox(
                height: 180.h,
                child: BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state.statusNewsFamous.isInitial ||
                        state.statusNewsFamous.isInProgress) {
                      return const PopularShimmerList();
                    }
                    final list = state.newsFamousList;

                    if (list.isEmpty) {
                      return Center(
                        child: Text(
                          "no_result_found".tr(),
                          style: Style.semiBold14(),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final item = list[index];
                        return AnimationButtonEffect(
                          onTap: () {
                            Navigator.push(
                                context, AppRoutes.getNewsDetail(param: item));
                          },
                          child: Container(
                            width: 160.w,
                            height: 180.h,
                            margin: EdgeInsets.only(
                              left: index == 0 ? 16.0.w : 8.w,
                              right: index == 4 ? 16.0.w : 0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: colors.white,
                              border: Border.all(color: colors.borderColor),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// image
                                Container(
                                  width: 162.w,
                                  height: 94.h,
                                  decoration: ShapeDecoration(
                                    image: (item.photos?.toList() ?? [])
                                            .isNotEmpty
                                        ? DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                item.photos?.first ?? ""),
                                            fit: BoxFit.fill,
                                          )
                                        : null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.r),
                                        topLeft: Radius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                ),
                                8.verticalSpace,
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'news2'.tr(),
                                              style: Style.medium14(
                                                  size: 10.sp,
                                                  color: colors.primary),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          4.horizontalSpace,
                                          Opacity(
                                            opacity: .5,
                                            child: Text(
                                              item.createdAt
                                                      ?.substring(0, 10)
                                                      .replaceAll("-", "/") ??
                                                  "",
                                              style: Style.medium14(
                                                  size: 10.sp,
                                                  color: colors.text),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                          color: colors.customGreyC3,
                                          thickness: .4),
                                      Text(
                                        item.title ?? "",
                                        style: Style.medium14(
                                            size: 12.sp, color: colors.text),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

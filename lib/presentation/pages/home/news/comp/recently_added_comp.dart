import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/home/news/comp/recently_shimmer_list.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class RecentlyAddedComp extends StatefulWidget {
  const RecentlyAddedComp({super.key});

  @override
  State<RecentlyAddedComp> createState() => _RecentlyAddedCompState();
}

class _RecentlyAddedCompState extends State<RecentlyAddedComp> {
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
                  'recently_added'.tr(),
                  textAlign: TextAlign.left,
                  style: Style.medium20(size: 18.sp),
                ),
              ),
              8.verticalSpace,
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state.statusNewsRecently.isInitial ||
                      state.statusNewsRecently.isInProgress) {
                    return const RecentlyShimmerList();
                  }
                  final list = state.newsRecentlyList;

                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        "no_result_found".tr(),
                        style: Style.semiBold14(),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = list[index];
                      return AnimationButtonEffect(
                        onTap: () {
                          Navigator.push(
                              context, AppRoutes.getNewsDetail(param: item));
                        },
                        child: Container(
                          height: 110.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: colors.white,
                            border: Border.all(color: colors.borderColor),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 120.w,
                                  height: 110.h,
                                  decoration: ShapeDecoration(
                                    image: (item.photos?.toList() ?? [])
                                            .isNotEmpty
                                        ? DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                item.photos?.first ?? ""),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'news2'.tr(),
                                              style: Style.medium14(
                                                  size: 10,
                                                  color: colors.primary),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          16.horizontalSpace,
                                          Opacity(
                                            opacity: .5,
                                            child: Text(
                                              item.createdAt
                                                      ?.substring(0, 10)
                                                      .replaceAll("-", "/") ??
                                                  "",
                                              style: Style.medium14(size: 10),
                                            ),
                                          )
                                        ],
                                      ),
                                      4.verticalSpace,
                                      Divider(
                                        color: colors.customGreyC3,
                                        height: 0,
                                        thickness: .4,
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        item.title ?? "",
                                        style: Style.medium14(size: 12),
                                      ),
                                      6.verticalSpace,
                                      Text(
                                        item.description ?? "",
                                        style: Style.medium14(
                                            size: 12, color: colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      )
                                    ],
                                  ),
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
              46.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/component/custom_pagination.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendedComp extends StatefulWidget {
  final bool hideNavBar;
  const RecommendedComp(
      {super.key, required this.genId, required this.hideNavBar});

  final int genId;

  @override
  State<RecommendedComp> createState() => _RecommendedCompState();
}

class _RecommendedCompState extends State<RecommendedComp> {
  bool liked = true;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _pageNumber = 1;

  void _onRefresh() async {
    _pageNumber = 1;
    _refreshController.footerMode?.value = LoadStatus.canLoading;
    try {
      context.read<CarDetailBloc>().add(CarDetailEvent.getRecommendation(
            genId: widget.genId,
            page: _pageNumber,
            pageSize: 20,
          ));
    } catch (e) {
      _refreshController.footerMode?.value = LoadStatus.failed;
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      _pageNumber = _pageNumber + 1;
      context.read<CarDetailBloc>().add(CarDetailEvent.getRecommendation(
            genId: widget.genId,
            page: _pageNumber,
            pageSize: 20,
          ));
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'we_recommend'.tr(),
                style: Style.semiBold16(size: 20.sp),
              ),
            ),
            _recommendedList(colors, icons, controller),
          ],
        ),
      );
    });
  }

  Widget _recommendedList(
    CustomColorSet colors,
    IconSet icons,
    GlobalController controller,
  ) {
    return BlocConsumer<CarDetailBloc, CarDetailState>(
      listenWhen: (previous, current) =>
          (previous.paginationError != current.paginationError &&
              current.paginationError) ||
          (previous.paginationNoMore != current.paginationNoMore &&
              current.paginationNoMore),
      listener: (context, state) {
        if (state.paginationNoMore) {
          _refreshController.loadNoData();
        }
        if (state.paginationError) {
          _refreshController.loadNoData();
        }
      },
      builder: (context, state) {
        final data = state.recommendationList;
        if (state.loading && data == null) {
          return SizedBox(
            height: 180.h,
            width: 1.sw,
            child: ListView.builder(
                itemCount: 8,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: ShimmerView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerContainer(
                          height: 80.h,
                          width: 164.w,
                        ),
                        8.verticalSpace,
                        ShimmerContainer(
                          height: 16.h,
                          width: 124.w,
                        ),
                        8.verticalSpace,
                        ShimmerContainer(
                          height: 16.h,
                          width: 144.w,
                        ),
                        8.verticalSpace,
                        ShimmerContainer(
                          height: 16.h,
                          width: 64.w,
                        ),
                      ],
                    )),
                  );
                }),
          );
        }

        return SizedBox(
          height: 180.h,
          width: 1.sw,
          child: CustomPagination(
            enablePullUp: true,
            enablePullDown: false,
            onRetry: () {},
            scrollDirection: Axis.horizontal,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ValueListenableBuilder(
              valueListenable: DBService.listenable(),
              builder: (context, box, child) {
                final likes = DBService.likesListGlobal(box);
                return ListView.builder(
                  itemCount: data?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    bool isFav() =>
                        likes.map((e) => e.id).contains(data?[index].id);
                    return AnimationButtonEffect(
                      onTap: () {
                        Navigator.push(
                            context,
                            AppRoutes.getProductCard(
                              model: data?[index] ?? CarModel(),
                            )).then((value) {
                          context
                              .read<BottomNavBarController>()
                              .changeNavBar(widget.hideNavBar);
                        });
                      },
                      child: Container(
                        width: 164.w,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 16.0.w : 8.w,
                          right: index == 14 ? 16.0.w : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// image
                            Container(
                              height: 90.h,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              alignment: Alignment.topRight,
                              child: Stack(
                                children: [
                                  CachedImageComponent(
                                    fit: BoxFit.cover,
                                    height: 90.h,
                                    borderRadius: 10.r,
                                    width: double.infinity,
                                    imageUrl: (data?[index].photos?.isEmpty ??
                                            false)
                                        ? ""
                                        : data?[index].photos?.first.url ?? "",
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: AnimationButtonEffect(
                                      onTap: () {
                                        context.read<ProfileBloc>().add(
                                            ProfileEvent.patchLike(
                                                id: data![index].id ?? 0));
                                        final dbService =
                                            context.read<DBService>();

                                        if (!isFav()) {
                                          dbService.addLike(data[index]);
                                        } else {
                                          dbService.removeLike(data[index]);
                                        }

                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        margin: EdgeInsets.all(8.sp),
                                        width: 24.w,
                                        height: 24.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          color: colors.text,
                                        ),
                                        child: likes
                                                .map((e) => e.id)
                                                .contains(data?[index].id)
                                            ? icons.favoriteFill.svg(
                                                color: colors.white, height: 16)
                                            : icons.favorite.svg(
                                                color: colors.white,
                                                height: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                12.verticalSpace,
                                Text(
                                  "${data?[index].brand?.name ?? ''} ${data?[index].carModel?.name ?? ''}",
                                  style: Style.medium16(size: 12.sp),
                                ),
                                4.verticalSpace,
                                Opacity(
                                  opacity: 0.5,
                                  child: IntrinsicHeight(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "${data?[index].year ?? ''}${"y".tr()}",
                                            style: Style.medium14(size: 10.sp),
                                          ),
                                          VerticalDivider(color: colors.text),
                                          Text(
                                            "${data?[index].mileage ?? ''}${"km".tr()}",
                                            style: Style.medium14(size: 10.sp),
                                          ),
                                          VerticalDivider(color: colors.text),
                                          Text(
                                            data?[index].fuelType?.name ?? '',
                                            style: Style.medium14(size: 10.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  "${data?[index].price?.toFormattedCurrency(dbService: context.read<DBService>(), currencyS: data[index].currency)}",
                                  style: Style.bold16(size: 14.sp),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

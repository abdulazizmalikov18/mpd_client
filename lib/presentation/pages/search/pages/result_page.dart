import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/util/filter_item_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_float_action_button.dart';
import 'package:orient_motors/presentation/component/custom_pagination.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/pages/search/components/result_car_info_widget.dart';
import 'package:orient_motors/presentation/pages/search/components/sort_bottom_sheet.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/set_value_range_dialog.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with SingleTickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late ScrollController scrollController;
  int _pageNumber = 1;
  late String currency;

  void _onRefresh() async {
    _pageNumber = 1;

    _refreshController.footerMode?.value = LoadStatus.canLoading;
    try {
      context.read<SearchBloc>().add(SearchEvent.makeReqToFilter(
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
      context.read<SearchBloc>().add(SearchEvent.makeReqToFilter(
            page: _pageNumber,
            pageSize: 20,
          ));
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    scrollController = ScrollController();
    currency = listCurrency.last;
    Future.delayed(Duration.zero, () {
      context.read<BottomNavBarController>().changeNavBar(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocConsumer<SearchBloc, SearchState>(
          listenWhen: (previous, current) =>
              (previous.paginationFilterResultError != current.paginationFilterResultError && current.paginationFilterResultError) ||
              (previous.paginationFilterResultNoMore != current.paginationFilterResultNoMore && current.paginationFilterResultNoMore) ||
              (previous.scrollToTop != current.scrollToTop && current.scrollToTop),
          listener: (context, state) {
            if (state.paginationFilterResultNoMore) {
              _refreshController.loadNoData();
            }
            if (state.paginationFilterResultError) {
              _refreshController.loadNoData();
            }
            if (state.scrollToTop) {
              scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            }
          },
          builder: (context, state) {
            List<FilterItemModel> listRegion = state.filterRegionValue ?? [];
            List<String?> listFromState = [
              state.yearOfIssueValue,
              state.mileageValue,
              state.priceValue == null ? null : "${state.priceValue} $currency",
              listRegion.isEmpty
                  ? null
                  : listRegion.length == 1
                      ? listRegion.first.value
                      : "${listRegion.first.value}${"and_again".tr(namedArgs: {"count": "${listRegion.length - 1}"})}",
              state.filterFuelValue?.map((e) => e.value).toList().join(", "),
            ];
            return Scaffold(
              backgroundColor: colors.white,
              body: NotificationListener(
                onNotification: (t) {
                  final ScrollDirection direction = scrollController.position.userScrollDirection;

                  if (direction == ScrollDirection.reverse) {
                    Future.delayed(Duration.zero, () {
                      context.read<BottomNavBarController>().changeNavBar(true);
                    });
                  } else if (direction == ScrollDirection.forward) {
                    Future.delayed(Duration.zero, () {
                      context.read<BottomNavBarController>().changeNavBar(false);
                    });
                  }

                  return true;
                },
                child: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        centerTitle: true,
                        surfaceTintColor: colors.white,
                        title: Text(
                          "announcements".tr(args: [(state.filterRes?.cars?.count ?? 0).toString()]),
                          style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                        ),
                        floating: true,
                        pinned: true,
                        snap: true,
                        actions: [
                          IconButton(
                            onPressed: () {
                              context.read<BottomNavBarController>().changeNavBar(true);
                              showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    return BlocProvider.value(value: context.read<SearchBloc>(), child: const SortBottomSheet());
                                  }).then((value) {
                                context.read<BottomNavBarController>().changeNavBar(false);
                              });
                            },
                            icon: Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: SvgPicture.asset(
                                icons.sort,
                                colorFilter: ColorFilter.mode(colors.icon, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(44.h),
                          child: Container(
                            height: 36.h,
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 56.w,
                                  height: 32.h,
                                  child: Stack(
                                    children: [
                                      AnimationButtonEffect(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20.w),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.r),
                                            border: Border.all(color: colors.customGreyC3, width: 1.sp),
                                          ),
                                          child: SvgPicture.asset(
                                            icons.filterIc,
                                            height: 15.h,
                                            width: 15.h,
                                            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 4.w),
                                          height: 6.r,
                                          width: 6.r,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: colors.primary),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                4.horizontalSpace,
                                Expanded(
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: listFilter.length + 1,
                                    padding: EdgeInsets.only(left: 8.w, right: 20.w),
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AnimationButtonEffect(
                                              onTap: () {
                                                context.read<DBService>().setCurrencySymbol(listCurrency.first);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 35.w,
                                                height: 28.h,
                                                decoration: context.read<DBService>().getCurrencySymbol == listCurrency.first
                                                    ? BoxDecoration(
                                                        color: colors.primary,
                                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(16.r)),
                                                      )
                                                    : BoxDecoration(
                                                        color: colors.transparent,
                                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(16.r)),
                                                        border: Border.all(color: colors.customGreyC3, width: 1.sp),
                                                      ),
                                                child: Center(
                                                  child: Text(
                                                    listCurrency.first.tr(),
                                                    style: fonts.subtitle1.copyWith(
                                                      color: context.read<DBService>().getCurrencySymbol == listCurrency.first
                                                          ? colors.white
                                                          : colors.customGreyC3,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            AnimationButtonEffect(
                                              onTap: () {
                                                context.read<DBService>().setCurrencySymbol(listCurrency.last);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 28.h,
                                                width: 35.w,
                                                decoration: context.read<DBService>().getCurrencySymbol == listCurrency.last
                                                    ? BoxDecoration(
                                                        color: colors.primary,
                                                        borderRadius: BorderRadius.horizontal(right: Radius.circular(16.r)),
                                                      )
                                                    : BoxDecoration(
                                                        color: colors.transparent,
                                                        borderRadius: BorderRadius.horizontal(right: Radius.circular(16.r)),
                                                        border: Border.all(color: colors.customGreyC3, width: 1.sp),
                                                      ),
                                                child: Center(
                                                  child: Text(
                                                    listCurrency.last.tr(),
                                                    style: fonts.subtitle1.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color: context.read<DBService>().getCurrencySymbol == listCurrency.last
                                                            ? colors.white
                                                            : colors.customGreyC3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return AnimationButtonEffect(
                                        onTap: () {
                                          switch (index) {
                                            case 1:
                                              int? startYear = state.generationsList?.first.yearStart;
                                              int? endYear = state.generationsList?.first.yearStop;
                                              state.generationsList?.forEach((element) {
                                                if (element.yearStart != null && (element.yearStart ?? 0) < (startYear ?? 0)) {
                                                  startYear = element.yearStart;
                                                }
                                                if ((element.yearStop ?? 0) >= (endYear ?? 0)) {
                                                  endYear = element.yearStop ?? DateTime.now().year;
                                                }
                                              });
                                              Navigator.of(context)
                                                  .push(AppRoutes.setYearOfIssue(context, state.yearOfIssueValue ?? "", startYear, endYear))
                                                  .then((value) {
                                                context.read<BottomNavBarController>().changeNavBar(false);
                                              });
                                              break;
                                            case 2:
                                              showDialog<void>(
                                                context: context,
                                                builder: (BuildContext cntxt) {
                                                  return SetValueRangeDialog(
                                                    division: 20,
                                                    title: 'mileage'.tr(),
                                                    unit: 'km'.tr(),
                                                    start: null,
                                                    end: null,
                                                    onSelect: (value) {
                                                      context
                                                          .read<SearchBloc>()
                                                          .add(SearchEvent.setFilterValue(value: value, filtrType: FilterType.mileage));
                                                      Navigator.of(cntxt).pop();
                                                    },
                                                  );
                                                },
                                              );
                                              break;
                                            case 3:
                                              showDialog<void>(
                                                context: context,
                                                builder: (BuildContext cntxt) {
                                                  return SetPriceValueRangeDialog(
                                                    division: 200,
                                                    title: 'price'.tr(),
                                                    start: null,
                                                    end: null,
                                                    onSelect: (String value, String currency) {
                                                      context
                                                          .read<SearchBloc>()
                                                          .add(SearchEvent.setFilterValue(value: value, filtrType: FilterType.price));
                                                      Navigator.of(cntxt).pop();
                                                    },
                                                  );
                                                },
                                              );
                                              break;
                                            case 4:
                                              Future.delayed(Duration.zero, () {
                                                context.read<BottomNavBarController>().changeNavBar(true);
                                              });
                                              Navigator.of(context).push(AppRoutes.setRegion(context)).then((value) {
                                                context.read<BottomNavBarController>().changeNavBar(false);
                                              });
                                              break;
                                            case 5:
                                              Future.delayed(Duration.zero, () {
                                                context.read<BottomNavBarController>().changeNavBar(true);
                                              });
                                              Navigator.of(context).push(AppRoutes.setFuel(context)).then((value) {
                                                context.read<BottomNavBarController>().changeNavBar(false);
                                              });
                                              break;
                                          }
                                        },
                                        child: Container(
                                          height: 28.h,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.r),
                                            border: Border.all(color: colors.customGreyC3, width: 1.sp),
                                          ),
                                          child: Text(
                                            listFromState[index - 1] ?? listFilter[index - 1],
                                            style: fonts.subtitle1.copyWith(fontSize: 12.sp),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => 10.horizontalSpace,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: state.loading
                      ? SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16.h),
                          child: Column(
                            children: List.generate(
                                12,
                                (index) => Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                      child: ShimmerView(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ShimmerContainer(
                                            height: 160.h,
                                            width: 1.sw - 16.w,
                                          ),
                                          8.verticalSpace,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ShimmerContainer(height: 16.h, width: 0.3.sw),
                                              ShimmerContainer(height: 16.h, width: 0.2.sw),
                                            ],
                                          ),
                                          8.verticalSpace,
                                          ShimmerContainer(
                                            height: 16.h,
                                            width: 0.5.sw,
                                          ),
                                          8.verticalSpace,
                                          ShimmerContainer(
                                            height: 16.h,
                                            width: 0.4.sw,
                                          ),
                                        ],
                                      )),
                                    )),
                          ),
                        )
                      : CustomPagination(
                          enablePullUp: true,
                          onRetry: () {},
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: SingleChildScrollView(
                            child: (state.filterRes?.cars?.results?.isEmpty ?? true)
                                ? Column(
                                    children: [
                                      44.verticalSpace,
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                                        child: Image.asset(icons.favImage),
                                      ),
                                      ContentComp(spacing: 0, title: "ads".tr(), subTitle: "here_you_can_save_the_ads_you_like".tr())
                                    ],
                                  )
                                : ValueListenableBuilder(
                                    valueListenable: DBService.listenable(),
                                    builder: (context, box, child) {
                                      return ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.filterCarResultList?.length ?? 0,
                                        padding: EdgeInsets.only(
                                          right: 20.w,
                                          left: 20.w,
                                          bottom: 16.h,
                                        ),
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) => ResultCarInfoWidget(
                                          resultsModel: state.filterCarResultList?[index] ?? CarModel(),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                AppRoutes.getProductCard(
                                                  model: state.filterCarResultList?[index] ?? CarModel(),
                                                )).then((value) {
                                              context.read<BottomNavBarController>().changeNavBar(false);
                                            });
                                          },
                                          likes: DBService.likesListGlobal(box),
                                          isLikePage: false,
                                        ),
                                        separatorBuilder: (BuildContext context, int index) => 20.verticalSpace,
                                      );
                                    },
                                  ),
                          ),
                        ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: Consumer<BottomNavBarController>(
                builder: (context, theme, _) {
                  return theme.hiddenNavBar
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(bottom: 48.h),
                          child: CustomFloatActionButton(
                            function: () {
                              scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
                            },
                            icon: icons.up.svg(color: colors.black),
                          ),
                        );
                },
              ),
            );
          },
        );
      },
    );
  }
}

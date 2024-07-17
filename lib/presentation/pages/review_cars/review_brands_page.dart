import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_pagination.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ReviewBrandsPage extends StatefulWidget {
  final ReviewController vmController;
  const ReviewBrandsPage({super.key, required this.vmController});

  @override
  State<ReviewBrandsPage> createState() => _ReviewBrandsPageState();
}

class _ReviewBrandsPageState extends State<ReviewBrandsPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _pageNumber = 1;

  void _onRefresh() async {
    _pageNumber = 1;

    _refreshController.footerMode?.value = LoadStatus.canLoading;
    try {
      context.read<SearchBloc>().add(SearchEvent.getListBrands(
          page: _pageNumber, pageSize: 20, isUsed: 1));
    } catch (e) {
      _refreshController.footerMode?.value = LoadStatus.failed;
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      _pageNumber = _pageNumber + 1;
      context.read<SearchBloc>().add(SearchEvent.getListBrands(
          page: _pageNumber, pageSize: 20, isUsed: 1));
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
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocConsumer<SearchBloc, SearchState>(
          listenWhen: (previous, current) =>
              previous.next != current.next && current.next ||
              previous.paginationError != current.paginationError ||
              previous.paginationNoMore != current.paginationNoMore,
          listener: (context, state) {
            if (state.next) {
              Navigator.pop(context);
            }
            if (state.paginationNoMore) {
              _refreshController.loadNoData();
            }
            if (state.paginationError) {
              _refreshController.loadNoData();
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: colors.white,
              appBar: AppBarComponent(
                color: colors.white,
                title: "brands".tr(),
              ),
              body: CustomPagination(
                enablePullUp: true,
                onRetry: () {},
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView(
                  children: [
                    StickyHeader(
                      header: Container(
                        width: 1.sw,
                        color: colors.colorF5F5F5,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.h),
                        child: Text("popular".tr(), style: fonts.subtitle1),
                      ),
                      content: ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.brandTopList?.length ?? 0,
                          itemBuilder: (context, index) {
                            if (state.brandTopList?[index].top ?? false) {
                              return ModelListItem(
                                isSelected: state.brandValueId ==
                                    state.brandTopList?[index].id,
                                colors: colors,
                                fonts: fonts,
                                imageUrl: state.brandTopList?[index].icon ?? "",
                                title: state.brandTopList?[index].name ?? "",
                                count:
                                    "${state.brandTopList?[index].countOfCars ?? 0}",
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(SearchEvent.setFilterValue(
                                        value:
                                            state.brandTopList?[index].name ??
                                                "",
                                        valueId:
                                            state.brandTopList?[index].id ?? 0,
                                        filtrType: FilterType.brand,
                                      ));
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) {
                            if (state.brandTopList?[index].top ?? false) {
                              return Divider(
                                color: colors.customGreyC3.withOpacity(0.3),
                                height: 1.h,
                                indent: 16.w,
                                endIndent: 16.w,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                    ),
                    16.verticalSpace,
                    StickyHeader(
                      header: Container(
                        width: 1.sw,
                        color: colors.colorF5F5F5,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.h),
                        child: Text("all_brands".tr(), style: fonts.subtitle1),
                      ),
                      content: ListView.separated(
                          padding: EdgeInsets.only(bottom: 40.h),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.brandList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ModelListItem(
                              isSelected: state.brandValueId ==
                                  state.brandList?[index].id,
                              colors: colors,
                              fonts: fonts,
                              imageUrl: state.brandList?[index].icon ?? "",
                              title: state.brandList?[index].name ?? "",
                              count:
                                  "${state.brandList?[index].countOfCars ?? 0}",
                              onTap: () {
                                context.read<SearchBloc>().add(
                                    SearchEvent.setFilterValue(
                                        value:
                                            state.brandList?[index].name ?? "",
                                        valueId:
                                            state.brandList?[index].id ?? 0,
                                        filtrType: FilterType.brand));
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                                color: colors.customGreyC3.withOpacity(0.3),
                                height: 1.h,
                                indent: 16.w,
                                endIndent: 16.w,
                              )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

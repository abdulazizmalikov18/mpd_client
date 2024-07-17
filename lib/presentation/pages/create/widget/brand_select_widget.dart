import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/custom_pagination.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

class BrandSelectWidget extends StatefulWidget {
  const BrandSelectWidget({super.key});

  @override
  State<BrandSelectWidget> createState() => _BrandSelectWidgetState();
}

class _BrandSelectWidgetState extends State<BrandSelectWidget> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _pageNumber = 1;

  void _onRefresh() async {
    _pageNumber = 1;

    _refreshController.footerMode?.value = LoadStatus.canLoading;
    try {
      context.read<AddCarBloc>().add(AddCarEvent.getListBrands(
          page: _pageNumber, pageSize: 20, isUsed: 0));
    } catch (e) {
      _refreshController.footerMode?.value = LoadStatus.failed;
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      _pageNumber = _pageNumber + 1;
      context.read<AddCarBloc>().add(AddCarEvent.getListBrands(
          page: _pageNumber, pageSize: 20, isUsed: 0));
    }
    _refreshController.loadComplete();
  }

  void selectItem({CreateCarReq? createCarReq, int? id}) {
    CreateCarReq req = (createCarReq ?? CreateCarReq()).rebuild((p0) => p0
      ..brand = id
      ..carModel = null
      ..generation = null
      ..modification = null);
    context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
        createCarReq: req, filterType: FilterType.model));
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
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocConsumer<AddCarBloc, AddCarState>(
          listenWhen: (previous, current) =>
              previous.paginationError != current.paginationError ||
              previous.paginationNoMore != current.paginationNoMore,
          listener: (context, state) {
            if (state.paginationNoMore) {
              _refreshController.loadNoData();
            }
            if (state.paginationError) {
              _refreshController.loadNoData();
            }
          },
          builder: (ctx, state) {
            return CustomPagination(
              enablePullUp: true,
              onRetry: () {},
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                padding: EdgeInsets.only(
                    bottom: 16.h + MediaQuery.of(context).padding.bottom,
                    top: 8.h),
                children: [
                  if ((state.brandTopList?.length ?? 0) != 0)
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
                            return ModelListItem(
                              isSelected: state.createCarReq?.brand ==
                                  state.brandTopList?[index].id,
                              colors: colors,
                              fonts: fonts,
                              imageUrl: state.brandTopList?[index].icon ?? "",
                              title: state.brandTopList?[index].name ?? "",
                              count: "",
                              onTap: () {
                                selectItem(
                                    createCarReq: state.createCarReq,
                                    id: state.brandTopList?[index].id);
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
                  8.verticalSpace,
                  if ((state.brandList?.length ?? 0) != 0)
                    StickyHeader(
                      header: Container(
                        width: 1.sw,
                        color: colors.colorF5F5F5,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.h),
                        child: Text("all_brands".tr(), style: fonts.subtitle1),
                      ),
                      content: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: colors.customGreyC3.withOpacity(0.3),
                            height: 1.h,
                            indent: 16.w,
                            endIndent: 16.w,
                          );
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ModelListItem(
                            isSelected: state.createCarReq?.brand ==
                                state.brandList?[index].id,
                            imageUrl: state.brandList?[index].icon ?? "",
                            title: state.brandList?[index].name ?? "",
                            onTap: () {
                              selectItem(
                                  createCarReq: state.createCarReq,
                                  id: state.brandList?[index].id);
                            },
                            fonts: fonts,
                            colors: colors,
                            count: ""),
                        itemCount: state.brandList?.length ?? 0,
                      ),
                    ),
                ],
              ),
            );
          });
    });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_pagination.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FilteredSearchesComp extends StatefulWidget {
  final List<FilterSearchRes> params;
  final bool isLocal;
  const FilteredSearchesComp(
      {super.key, required this.params, required this.isLocal});

  @override
  State<FilteredSearchesComp> createState() => _FilteredSearchesCompState();
}

class _FilteredSearchesCompState extends State<FilteredSearchesComp> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool star = true;

  void _onRefresh() async {
    _refreshController.footerMode?.value = LoadStatus.canLoading;
    try {
      context.read<SearchBloc>().add(const SearchEvent.getSearchesList());
    } catch (e) {
      _refreshController.footerMode?.value = LoadStatus.failed;
    }
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // _refreshController.twoLevelComplete();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  bool isStar(FilterSearchRes param) {
    return widget.isLocal
        ? true
        : context
            .read<DBService>()
            .starsList
            .map((e) => e.id)
            .contains(param.id);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLocal
        ? _buildItems(params: widget.params)
        : CustomPagination(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onRetry: () {},
            child: _buildItems(params: widget.params),
          );
  }

  Widget _buildItems({required List<FilterSearchRes> params}) {
    return ThemeWrapper(
      builder: (context, CustomColorSet colors, FontSet fonts, IconSet icons,
          GlobalController controller) {
        return widget.params.isEmpty
            ? _empty(icons)
            : ListView.builder(
                itemCount: widget.params.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 56),
                itemBuilder: (BuildContext context, int index) {
                  final param = widget.params[index];
                  return AnimatedOpacity(
                    opacity: star ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInQuart,
                    child: AnimationButtonEffect(
                      onTap: () {
                        Navigator.of(context)
                            .push(AppRoutes.goToResult(context, index: index))
                            .then((value) => context
                                .read<BottomNavBarController>()
                                .changeNavBar(false));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: colors.white,
                          border: Border.all(color: colors.borderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimationButtonEffect(
                              onTap: () {
                                final dbService = context.read<DBService>();

                                if (widget.isLocal) {
                                  star = false;
                                  setState(() {});

                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    dbService.removeStar(param);
                                    star = true;
                                    setState(() {});
                                  });
                                  return;
                                }

                                if (!isStar(param)) {
                                  dbService.addStar(param);
                                } else {
                                  dbService.removeStar(param);
                                }
                                setState(() {});
                              },
                              child: isStar(param)
                                  ? icons.starFill.svg()
                                  : icons.star.svg(),
                            ),
                            12.horizontalSpace,
                            Container(
                              width: 70.w,
                              height: 60.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      param.brand.icon ?? ""),
                                  fit: BoxFit.fill,
                                ),
                                color: colors.customGreyE1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r)),
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    param.brand.name ?? "no_messages".tr(),
                                    style: Style.bold16(size: 18.sp),
                                  ),
                                  Opacity(
                                    opacity: 0.50,
                                    child: Text(
                                      param.carModel?.name ??
                                          "no_messages".tr(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Style.medium14(),
                                    ),
                                  ),
                                  Text(
                                    (param.fuel?.toList() ?? []).isNotEmpty
                                        ? param.fuel?.first.name ??
                                            "no_messages".tr()
                                        : "no_messages".tr(),
                                    style: Style.medium14(
                                        size: 12.sp, color: colors.primary),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            AnimationButtonEffect(
                              onTap: () {
                                final dbService = context.read<DBService>();

                                star = false;
                                setState(() {});

                                Future.delayed(
                                    const Duration(milliseconds: 200), () {
                                  dbService.removeStar(param);
                                  star = true;
                                  if (!widget.isLocal) {
                                    context.read<SearchBloc>().add(
                                        SearchEvent.deleteSearches(
                                            id: param.id ?? 0));
                                  }
                                  setState(() {});
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  width: 25.w,
                                  height: 25.w,
                                  decoration: BoxDecoration(
                                    color: colors.text.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                  child: Center(
                                    child: icons.clear.svg(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  Widget _empty(IconSet icons) {
    return Column(
      children: [
        24.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0.w),
          child: Image.asset(icons.searchCarImage),
        ),
        ContentComp(
            spacing: 0,
            title: "search".tr(),
            subTitle: "here_you_can_save_the_ads_you_like".tr())
      ],
    );
  }
}

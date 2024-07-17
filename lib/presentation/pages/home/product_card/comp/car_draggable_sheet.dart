import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/custom_pagination.dart';
import 'package:orient_motors/presentation/pages/home/news/comp/popular_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/home/news/comp/recently_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/home/notification/comp/notifications_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/comment_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_list.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum CarListType { all, useds, news }

class CarDraggbleSheet extends StatefulWidget {
  final DraggableScrollableController draggableScrollableController;
  const CarDraggbleSheet({super.key, required this.draggableScrollableController});

  @override
  State<CarDraggbleSheet> createState() => _CarDraggbleSheetState();
}

class _CarDraggbleSheetState extends State<CarDraggbleSheet> {
  CarListType _selectedSegment = CarListType.useds;

  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  late ScrollController scrollController;
  int _pageNumber = 1;
  late String currency;

  void _onRefresh() async {
    _pageNumber = 1;

    _refreshController.footerMode?.value = LoadStatus.canLoading;
    try {
      context.read<SearchBloc>().add(SearchEvent.makeReqToFilterOnHome(
            page: _pageNumber,
            pageSize: 20,
            isUsed: null,
          ));
    } catch (e) {
      _refreshController.footerMode?.value = LoadStatus.failed;
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      _pageNumber = _pageNumber + 1;
      context.read<SearchBloc>().add(SearchEvent.makeReqToFilterOnHome(
            page: _pageNumber,
            pageSize: 20,
            isUsed: null,
          ));
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();

    widget.draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return DraggableScrollableSheet(
          initialChildSize: (1.sh - (332.h + 120.w)) / 1.sh,
          minChildSize: (1.sh - (332.h + 120.w)) / 1.sh,
          maxChildSize: (1.sh - (154.h + MediaQuery.of(context).padding.top)) / 1.sh,
          snap: true,
          expand: false,
          controller: widget.draggableScrollableController,
          builder: (context, scrollController) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: const [
                  BoxShadow(blurRadius: 20, color: Color.fromRGBO(20, 20, 21, 0.1)),
                ],
              ),
              child: Column(
                children: [
                  12.h.verticalSpace,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                      color: colors.grey1,
                    ),
                    child: SizedBox(height: 2.h, width: 32.w),
                  ),
                  12.h.verticalSpace,
                  CupertinoSlidingSegmentedControl<CarListType>(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    groupValue: _selectedSegment,
                    backgroundColor: CupertinoColors.quaternarySystemFill,
                    onValueChanged: (CarListType? value) {
                      if (value != null) {
                        _selectedSegment = value;
                        setState(() {});
                      }
                    },
                    children: <CarListType, Widget>{
                      CarListType.all: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                        child: Text(
                          'Все',
                          style: Style.semiBold16(),
                        ),
                      ),
                      CarListType.useds: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                        child: Text(
                          'С пробегом',
                          style: Style.semiBold16(),
                        ),
                      ),
                      CarListType.news: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                        child: Text(
                          'Новые',
                          style: Style.semiBold16(),
                        ),
                      ),
                    },
                  ),
                  16.h.verticalSpace,
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state.statusCars.isInitial || state.statusCars.isInProgress) {
                          return const NotificationsShimmerList();
                        }
                        return CustomPagination(
                          primary: false,
                          enablePullUp: false,
                          onRefresh: null,
                          onRetry: () {},
                          controller: _refreshController,
                          onLoading: _onLoading,
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            controller: scrollController,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .9,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 12,
                            ),
                            itemCount: state.carsList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: colors.redText,
                                          image: const DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              "https://hips.hearstapps.com/hmg-prod/images/honda-prelude-concept-front-three-quarters-653927960f1f4.jpg?crop=1.00xw:0.920xh;0,0.0801xh&resize=980:*",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  4.h.verticalSpace,
                                  Text(
                                    "Porsche Taycan 4S",
                                    style: Style.bold16(),
                                  ),
                                  2.h.verticalSpace,
                                  Text(
                                    "120 000 у.е",
                                    style: Style.semiBold14(),
                                  ),
                                  4.h.verticalSpace,
                                  Row(
                                    children: [
                                      _buildChip(colors, "2023"),
                                      4.w.horizontalSpace,
                                      _buildChip(colors, "4 000 км"),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChip(CustomColorSet colors, String title) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colors.backgroundScaffold,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Text(
          title,
          style: Style.regular12(size: 10, color: colors.grey1),
        ),
      ),
    );
  }
}

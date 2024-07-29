import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/yandex/filter_category/filter_category_bloc.dart';
import 'package:mpd_client/domain/models/yandex/popular_categories_model.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/presentation/pages/yandex_doctor/widgets/filter_buttons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/presentation/widgets/w_search_text_field.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class FilterCategorySheet extends StatefulWidget {
  const FilterCategorySheet({super.key});

  @override
  State<FilterCategorySheet> createState() => _FilterCategorySheetState();
}

class _FilterCategorySheetState extends State<FilterCategorySheet> {
  final scrollController = ScrollController();

  final int listItemCount = 20;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        maxChildSize: .97,
        initialChildSize: .7,
        builder: (context, controller) {
          return Stack(
            children: [
              BottomSheetWidget(children: [
                Expanded(
                  child: NotificationListener(
                    onNotification: (ScrollNotification notification) => _handleScrollNotification(notification, context, controller),
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        SliverAppBar(
                          titleSpacing: 0,
                          leadingWidth: 0,
                          pinned: true,
                          toolbarHeight: 112,
                          backgroundColor: white,
                          leading: const SizedBox(),
                          title: Column(
                            children: [
                              ScreenUtil().setVerticalSpacing(24.h),
                              Center(
                                child: Text(
                                  context.l10n.search_filter,
                                  style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                              ),
                              ScreenUtil().setVerticalSpacing(12.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: SearchFieldWidget(
                                  controller: context.read<FilterCategoryBloc>().searchController,
                                  searchHint: context.l10n.search_category,
                                  onChanged: (query) {
                                    if (query.isEmpty || query.length % 3 == 0) {
                                      setState(() {});
                                    }
                                    context.read<FilterCategoryBloc>().add(SearchCategoryEvent(query, Localizations.localeOf(context).languageCode));
                                  },
                                ),
                              ),
                              ScreenUtil().setVerticalSpacing(10.h),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Text(
                                  context.l10n.search_filter_select_category,
                                  style: AppTheme.bodyLarge.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                BlocBuilder<FilterCategoryBloc, FilterCategoryState>(
                                  builder: (context, state) {
                                    if (state is FilterCategorySuccess) {
                                      return Text(
                                        '~${context.read<FilterCategoryBloc>().categoriesCount}',
                                        style: AppTheme.bodyLarge.copyWith(
                                          fontSize: 18,
                                          color: grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    }
                                    return Shimmer.fromColors(
                                      baseColor: baseColor,
                                      highlightColor: highlightColor,
                                      child: Text(
                                        context.l10n.search_filter_count,
                                        style: AppTheme.bodyLarge.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<FilterCategoryBloc, FilterCategoryState>(
                          builder: (context, state) {
                            if (state is FilterCategorySuccess) {
                              return SliverPadding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                sliver: SliverGrid.builder(
                                  itemCount: state.categories.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 12.h,
                                    mainAxisExtent: 42.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    Log.w(index.toString());
                                    if (index >= state.categories.length) {
                                      return _buildShimmerItem(context, index);
                                    }
                                    return buildAnimatedItem(
                                      context,
                                      state.categories[index],
                                      state.selectedCategoryId,
                                    );
                                  },
                                ),
                              );

                              // return SliverPadding(
                              //   padding: EdgeInsets.only(
                              //       left: 16.w, right: 16.w, bottom: 90.h),
                              //   sliver: SliverToBoxAdapter(
                              //     child: GridView.builder(
                              //       shrinkWrap: true,
                              //       controller: scrollController,
                              //       itemCount: state.hasReachedMax
                              //           ? state.categories.length
                              //           : state.categories.length + 2,
                              //       itemBuilder: (context, index) {
                              //         if (index >= state.categories.length) {
                              //           return _buildShimmerItem(
                              //               context, index);
                              //         }
                              //         return buildAnimatedItem(
                              //           context,
                              //           state.categories[index],
                              //           state.selectedCategoryId,
                              //         );
                              //       },
                              //       gridDelegate:
                              //           SliverGridDelegateWithFixedCrossAxisCount(
                              //         crossAxisCount: 2,
                              //         crossAxisSpacing: 16.w,
                              //         mainAxisSpacing: 12.h,
                              //         mainAxisExtent: 42.h,
                              //       ),
                              //     ),
                              //   ),
                              // );
                            }
                            return SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              sliver: SliverGrid.builder(
                                itemCount: 20,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 12.h,
                                  mainAxisExtent: 42.h,
                                ),
                                itemBuilder: _buildShimmerItem,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: FilterButtons(),
              )
            ],
          );
        });
  }

  Widget buildAnimatedItem(
    BuildContext context,
    PopularCategories category,
    int selectedCategoryId,
  ) =>
      // For example wrap with fade transition
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ]),
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<FilterCategoryBloc>().add(SelectedCategoryEvent(category.id!, category.name!));
          },
          color: category.id == selectedCategoryId ? mainBlue : white,
          shape: const StadiumBorder(),
          elevation: 0,
          child: Text(
            category.name ?? "--",
            style: AppTheme.headlineSmall.copyWith(
              fontSize: 14,
              color: category.id == selectedCategoryId ? white : black,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _buildShimmerItem(BuildContext context, int index) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Card(
        color: white,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification, BuildContext context, ScrollController controller) {
    if (notification is ScrollEndNotification && controller.position.extentAfter == 0) {
      context.read<FilterCategoryBloc>().add(GetFilterCategories(Localizations.localeOf(context).languageCode));
    }
    return false;
  }
}

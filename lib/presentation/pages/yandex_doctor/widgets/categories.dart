import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/yandex/popular_categories/popular_categories_bloc.dart';
import 'package:mpd_client/application/yandex/search_by_category/search_by_category_bloc.dart';
import 'package:mpd_client/application/yandex/yandex_doctor/yandex_doctor_bloc.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  final bool showDoctorInfo;
  final PopularCategoriesState state;
  const Categories({super.key, required this.showDoctorInfo, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCirc,
      left: 0,
      right: 0,
      bottom: showDoctorInfo ? -100.h : 12.h,
      child: SizedBox(
        height: 47.h,
        child: CategoriesComponent(
            scrollController: ScrollController(),
            onScrollEnd: () {
              context.read<PopularCategoriesBloc>().add(GetPopularCategoriesEvent(Localizations.localeOf(context).languageCode));
            },
            state: state),
      ),
    );
  }
}

class CategoriesComponent extends StatelessWidget {
  final PopularCategoriesState state;
  final VoidCallback onScrollEnd;
  final ScrollController scrollController;
  const CategoriesComponent({super.key, required this.state, required this.onScrollEnd, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    if (state.popularCategories.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: state is PopularCategoriesLoading ? state.popularCategories.length + 20 : state.popularCategories.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            if (index >= state.popularCategories.length) {
              if (state.isEnd) return const SizedBox();
              return Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w, bottom: 5.h),
                  child: Card(
                    color: white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    child: SizedBox(width: 123.w),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(right: 8.w, bottom: 5.h),
              child: BlocConsumer<SearchByCategoryBloc, SearchByCategoryState>(
                listener: (_, state) {
                  if (!state.isLoading && state is SearchByCategorySuccess && state.specialists.isNotEmpty) {
                    context.read<YandexDoctorBloc>().add(ClusterPlaceMarkEvent(specialists: state.specialists, context: context));
                  }
                },
                builder: (context, selectedState) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<SearchByCategoryBloc>().add(SelectCategoryEvent(state.popularCategories[index].id!));
                      context.read<SearchByCategoryBloc>().add(GetSearchedByCategory(state.popularCategories[index].id!, state.popularCategories[index].name!));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: state.popularCategories[index].id == selectedState.selectedId ? mainBlue.withOpacity(0.8) : white,
                        foregroundColor: state.popularCategories[index].id == selectedState.selectedId ? white : black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                    child: Text(
                      state.popularCategories[index].name!,
                      style: AppTheme.headlineSmall.copyWith(
                        // fontFamily: Styles.gilroyMedium,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }
    return _buildLoadingList();
  }

  ListView _buildLoadingList() {
    return ListView.builder(
      itemCount: 20,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Padding(
            padding: EdgeInsets.only(right: 8.w, bottom: 5.h),
            child: Card(
              color: white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              child: SizedBox(width: 123.w),
            ),
          ),
        );
      },
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && scrollController.position.extentAfter == 0) {
      onScrollEnd();
    }
    return false;
  }
}

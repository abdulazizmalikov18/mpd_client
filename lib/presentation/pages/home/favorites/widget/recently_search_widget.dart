import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/pages/search/components/filtered_search_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/search/components/filtered_searches_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class RecentlySearchWidget extends StatelessWidget {
  const RecentlySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.statusFilterSearch.isInProgress ||
              state.statusFilterSearch.isInitial) {
            return const FilteredSearchSimmerList();
          }
          if (state.filterSearchList.isEmpty) return _empty(icons);

          return NestedTabBar(params: state.filterSearchList);
        },
      );
    });
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

class NestedTabBar extends StatefulWidget {
  final List<FilterSearchRes> params;
  const NestedTabBar({super.key, required this.params});

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        children: <Widget>[
          TabBar.secondary(
            // isScrollable: true,
            indicatorWeight: 0,
            labelStyle: fonts.subtitle1,
            dividerColor: colors.customGreyC3,
            labelColor: colors.primary,
            // tabAlignment: TabAlignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            // labelPadding: EdgeInsets.only(right: 15.w),
            unselectedLabelColor: colors.customBlack.withOpacity(0.5),
            controller: _tabController,
            indicator: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.sp, color: colors.customRed)),
            ),
            tabs: <Widget>[
              Tab(text: 'recent_searches'.tr()),
              Tab(text: 'favorite_searches'.tr()),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                FilteredSearchesComp(params: widget.params, isLocal: false),
                ValueListenableBuilder(
                  valueListenable: DBService.listenable(),
                  builder: (context, box, child) {
                    return FilteredSearchesComp(
                        params: DBService.starsListGlobal(box), isLocal: true);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

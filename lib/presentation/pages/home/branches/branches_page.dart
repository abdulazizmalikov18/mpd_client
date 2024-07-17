import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/search/components/filtered_search_shimmer_list.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({super.key});

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: listProvince.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 56.h,
                    child: AppBarComponent(
                      title: "${"branches".tr()} ",
                      color: colors.white,
                      titleRich: "Orient Motors",
                      isBorder: true,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildTabBar(colors),
                )
              ];
            },
            body: _buildListView(),
          ),
        ),
      );
    });
  }

  Widget _buildTabBar(CustomColorSet colors) {
    return TabBar(
      controller: tabController,
      tabAlignment: TabAlignment.start,
      onTap: (index) {
        context.read<MainBloc>().add(
            MainEvent.getBranchList(id: mapProvince[listProvince[index]] ?? 0));
      },
      tabs: listProvince.map((e) => Tab(text: e)).toList(),
      isScrollable: true,
      padding: EdgeInsets.zero,
      labelColor: colors.customRed,
      indicatorColor: colors.customRed,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  Widget _buildListView() {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state.statusBranch.isInitial ||
                state.statusBranch.isInProgress) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100.h,
                    child: const FilteredSearchSimmerList(),
                  );
                },
              );
            }
            if (state.branchList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(icons.adsCar,
                        height: 130.h, fit: BoxFit.contain),
                    16.verticalSpace,
                    Text(
                      "no_result_found".tr(),
                      style: Style.medium16(color: colors.grey1),
                    )
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: state.branchList.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final item = state.branchList[index];
                return AnimationButtonEffect(
                  onTap: () {
                    Navigator.push(
                      context,
                      AppRoutes.getBranchDetail(param: item),
                    );
                  },
                  child: SizedBox(
                    height: 110.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: icons.location
                                  .svg(color: colors.customRed, height: 24)),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? "",
                                  style:
                                      fonts.headline1.copyWith(fontSize: 18.sp),
                                ),
                                Opacity(
                                  opacity: 0.50,
                                  child: Text(
                                    item.address ?? "",
                                    style: Style.medium14(),
                                  ),
                                ),
                                Text(
                                  item.contact ?? "",
                                  style:
                                      Style.semiBold14(color: colors.primary),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child:
                                icons.forward.svg(color: colors.customGreyC3),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 1, color: colors.customGreyC3);
              },
            );
          },
        );
      },
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/custom_text_field.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/search/components/save_and_other_buttons.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

import '../../styles/theme_wrapper.dart';
import 'pages/filtertype_models/domestic_models.dart';

class SearchPage extends StatefulWidget {
  final int count;
  const SearchPage({super.key, required this.count});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController tab1Controller;
  late PageController pageController;

  @override
  void initState() {
    tab1Controller = TabController(length: 2, vsync: this);
    pageController = PageController(initialPage: 0);
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<BottomNavBarController>().changeNavBar(true);
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocConsumer<SearchBloc, SearchState>(
            listenWhen: (previous, current) =>
                previous.brandValueId != current.brandValueId ||
                previous.modelValueId != current.modelValueId ||
                previous.filterGenerationValue !=
                    current.filterGenerationValue ||
                previous.yearOfIssueValue != current.yearOfIssueValue ||
                previous.mileageValue != current.mileageValue ||
                previous.priceValue != current.priceValue ||
                previous.filterColorValue != current.filterColorValue ||
                previous.filterFuelValue != current.filterFuelValue ||
                previous.filterTransmissionValue !=
                    current.filterTransmissionValue ||
                previous.filterRegionValue != current.filterRegionValue ||
                previous.filterBodyValue != current.filterBodyValue ||
                previous.status != current.status,
            listener: (context, state) {
              context.read<SearchBloc>().add(
                  const SearchEvent.makeReqToFilter(page: 1, pageSize: 20));
            },
            builder: (context, state) {
              return OnUnFocusTap(
                child: Scaffold(
                  backgroundColor: colors.white,
                  appBar: AppBar(
                    backgroundColor: colors.white,
                    titleSpacing: 0,
                    title: CustomTextField(
                      readOnly: true,
                      onPressed: () {
                        Navigator.push(
                                context, AppRoutes.getSearchList(context))
                            .then(
                          (value) => context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.generation)),
                        );
                      },
                      hintText: "ex: Cobalt",
                      padding: EdgeInsets.only(top: 4.h, right: 16.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide:
                            BorderSide(color: colors.transparent, width: 0.8),
                      ),
                      enableBorderColor: colors.primary,
                      fillColor: colors.searchTextfieldColor,
                    ),
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(54.h),
                        child: Column(
                          children: [
                            TabBar(
                              dividerColor:
                                  colors.customGreyC3.withOpacity(0.3),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              indicatorWeight: 0,
                              labelStyle: fonts.subtitle1,
                              controller: tab1Controller,
                              labelColor: colors.primary,
                              indicatorSize: TabBarIndicatorSize.tab,
                              // tabAlignment: TabAlignment.start,
                              unselectedLabelColor:
                                  colors.customBlack.withOpacity(0.5),
                              onTap: (value) => pageController.animateToPage(
                                  value,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn),
                              indicator: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.sp, color: colors.customRed)),
                              ),
                              tabs: [
                                Tab(
                                  child: AutoSizeText(
                                    'domestic'.tr(),
                                    maxLines: 1,
                                  ),
                                ),
                                Tab(
                                  child: AutoSizeText(
                                    'electrical'.tr(),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            itemCount: 2,
                            controller: pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => [
                              const DomesticFilterModelWidget(),
                              const DomesticFilterModelWidget(),
                            ][index],
                            onPageChanged: (value) => tab1Controller.animateTo(
                              value,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: EdgeInsets.only(
                      // bottom: 80.h,
                      right: 16.w,
                      left: 16.w,
                    ),
                    child: SaveAndOtherButtonsComponent(
                      colors: colors,
                      fonts: fonts,
                      isDisabled: false,
                      isSave: state.isFilterSaved,
                      totalCars: state.filterRes?.cars?.count ?? widget.count,
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

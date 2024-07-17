import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/util/filter_item_model.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/checkbox_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class SetSalesmanPage extends StatefulWidget {
  const SetSalesmanPage({super.key});

  @override
  State<SetSalesmanPage> createState() => _SetSalesmanPageState();
}

class _SetSalesmanPageState extends State<SetSalesmanPage> {
  List<String> salesmanTypes = [
    "Индивидуальный",
    "Дилер",
    "Лицензированный (Orient  Motors)"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: colors.white,
            appBar: AppBarComponent(
              title: "seller_classification".tr(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: salesmanTypes.length,
                        padding: EdgeInsets.only(bottom: 120.h),
                        itemBuilder: (context, index) {
                          return CheckboxListItem(
                            colors: colors,
                            fonts: fonts,
                            icons: icons,
                            isSelected: state.salesmanValue
                                    ?.map((e) => e.value)
                                    .contains(salesmanTypes[index]) ??
                                false,
                            title: salesmanTypes[index],
                            count: "",
                            onTap: () {
                              List<FilterItemModel> filterModel =
                                  List.from(state.salesmanValue ?? []);
                              int lastIndex = filterModel.lastIndexWhere(
                                  (element) =>
                                      element.value == salesmanTypes[index]);
                              if (lastIndex != -1) {
                                filterModel.removeAt(lastIndex);
                              } else {
                                filterModel.add(FilterItemModel(
                                    (p0) => p0..value = salesmanTypes[index]));
                              }
                              context.read<SearchBloc>().add(
                                  SearchEvent.setFilterValueList(
                                      values: filterModel,
                                      filtrType: FilterType.numberOfOwners));
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Divider(
                              color: colors.customGreyC3.withOpacity(0.3),
                              height: 1.h,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomButton(
                haveBorder: false,
                backgroundColor: colors.customRed,
                titleStyle: fonts.subtitle1.copyWith(color: colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
                titleWidget: SizedBox(
                  height: 24.h,
                  child: AnimatedFlipCounter(
                    duration: const Duration(seconds: 1),
                    value: state.filterRes?.cars?.count ?? 2500,
                    suffix: "advertisements_are_waiting".tr(),
                    textStyle: fonts.subtitle1.copyWith(color: colors.white),
                  ),
                ),
                title: "",
              ),
            ),
          );
        });
      },
    );
  }
}

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

class SetRegionPage extends StatelessWidget {
  const SetRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: colors.white,
            appBar: AppBarComponent(
              title: "region".tr(),
            ),
            body: ListView.separated(
                shrinkWrap: true,
                itemCount: state.regionList?.length ?? 0,
                padding: EdgeInsets.only(bottom: 120.h),
                itemBuilder: (context, index) {
                  int lastIndexWhere = state.filterRegionValue?.lastIndexWhere(
                          (element) =>
                              element.valueId == state.regionList?[index].id) ??
                      -1;
                  return CheckboxListItem(
                    disabled: (state.regionList?[index].countOfCars ?? 0) == 0,
                    colors: colors,
                    fonts: fonts,
                    icons: icons,
                    isSelected: lastIndexWhere != -1,
                    title: state.regionList?[index].name ?? "",
                    count:
                        (state.regionList?[index].countOfCars ?? 0).toString(),
                    onTap: () {
                      List<FilterItemModel> selected =
                          state.filterRegionValue?.toList() ?? [];
                      if (lastIndexWhere != -1) {
                        selected.removeAt(lastIndexWhere);
                      } else {
                        selected.add(FilterItemModel((p0) => p0
                          ..value = state.regionList?[index].name
                          ..valueId = state.regionList?[index].id));
                      }
                      context.read<SearchBloc>().add(
                          SearchEvent.setFilterValueList(
                              values: selected, filtrType: FilterType.region));
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

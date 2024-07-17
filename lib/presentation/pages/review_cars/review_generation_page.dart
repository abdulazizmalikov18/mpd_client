import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/util/filter_item_model.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/checkbox_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class ReviewGenerationPage extends StatelessWidget {
  final ReviewController vmController;
  const ReviewGenerationPage({super.key, required this.vmController});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (contextT, colors, fonts, icons, controller) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (contextC, state) {
            return Scaffold(
              backgroundColor: colors.white,
              appBar: AppBarComponent(
                title: "${state.brandValue} ${state.modelValue}",
              ),
              body: ListView.separated(
                shrinkWrap: true,
                itemCount: state.generationsList?.length ?? 0,
                padding: EdgeInsets.only(bottom: 120.h),
                itemBuilder: (context, index) {
                  final data = state.generationsList?[index];
                  int lastIndexWhere = state.filterGenerationValue
                          ?.lastIndexWhere((element) =>
                              element.valueId ==
                              state.generationsList?[index].id) ??
                      -1;
                  return CheckboxListItem(
                    disabled: (data?.countOfCars ?? 0) == 0,
                    colors: colors,
                    fonts: fonts,
                    icons: icons,
                    isSelected: lastIndexWhere != -1,
                    title: data?.name == null || data?.name == ""
                        ? "${data?.yearStart ?? "1980"} - ${data?.yearStop ?? "${DateTime.now().year}"}"
                        : "${data?.name}",
                    count: (data?.countOfCars ?? 0).toString(),
                    onTap: () {
                      List<FilterItemModel> selected = [];
                      if (lastIndexWhere != -1) {
                        selected.removeAt(lastIndexWhere);
                      } else {
                        selected.add(FilterItemModel((p0) => p0
                          ..value = (data?.name ?? "").isEmpty
                              ? "${data?.yearStart ?? DateTime.now().year} - ${data?.yearStop ?? DateTime.now().year}"
                              : data!.name
                          ..valueId = data?.id));
                      }
                      context.read<SearchBloc>().add(
                          SearchEvent.setFilterValueList(
                              values: selected,
                              filtrType: FilterType.generation));

                      Navigator.pop(context);
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
                },
              ),
            );
          },
        );
      },
    );
  }
}

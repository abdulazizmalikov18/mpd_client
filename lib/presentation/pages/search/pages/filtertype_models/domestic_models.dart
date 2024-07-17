import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/pages/search/components/filtr_item_component.dart';
import 'package:orient_motors/presentation/pages/search/components/save_filter_component.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/set_status_dialog.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/set_value_range_dialog.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class DomesticFilterModelWidget extends StatefulWidget {
  const DomesticFilterModelWidget({super.key});

  @override
  State<DomesticFilterModelWidget> createState() =>
      _DomesticFilterModelWidgetState();
}

class _DomesticFilterModelWidgetState extends State<DomesticFilterModelWidget> {
  late bool showOtherFilters;

  @override
  void initState() {
    showOtherFilters = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                20.verticalSpace,
                SaveFilterComponent(
                  colors: colors,
                  fonts: fonts,
                  icons: icons,
                  value: state.isFilterSaved,
                ),
                20.verticalSpace,
                FitrItemComponent(
                  title: "brand".tr(),
                  selectedFiltr: [state.brandValue],
                  onRemove: () {
                    context.read<SearchBloc>().add(
                        const SearchEvent.deleteFilterValue(
                            filtrType: FilterType.brand));
                  },
                  onTap: () {
                    Navigator.of(context).push(AppRoutes.setBrand(context));
                  },
                ),
                if (state.brandValueId != null)
                  FitrItemComponent(
                    title: "model".tr(),
                    selectedFiltr: [state.modelValue],
                    onRemove: () {
                      context.read<SearchBloc>().add(
                          const SearchEvent.deleteFilterValue(
                              filtrType: FilterType.model));
                    },
                    onTap: () {
                      Navigator.of(context).push(AppRoutes.setModel(
                          context, state.brandValueId.toString()));
                    },
                  ),
                if (state.modelValueId != null && state.brandValueId != null)
                  FitrItemComponent(
                    title: "generation".tr(),
                    selectedFiltr: state.filterGenerationValue
                        ?.map((e) => e.value)
                        .toList(),
                    onRemove: () {
                      context.read<SearchBloc>().add(
                          const SearchEvent.deleteFilterValue(
                              filtrType: FilterType.generation));
                    },
                    onTap: () {
                      Navigator.of(context).push(AppRoutes.setGeneration(
                          context, state.modelValueId.toString()));
                    },
                  ),
                FitrItemComponent(
                  title: "year_of_manufacture".tr(),
                  onRemove: () {
                    context.read<SearchBloc>().add(
                        const SearchEvent.deleteFilterValue(
                            filtrType: FilterType.year));
                  },
                  selectedFiltr: [state.yearOfIssueValue],
                  onTap: () {
                    List<int> ids = state.filterGenerationValue
                            ?.map((e) => e.valueId ?? 0)
                            .toList() ??
                        [];
                    int? startYear = ids.isEmpty
                        ? null
                        : state.generationsList?.first.yearStart;
                    int? endYear = ids.isEmpty
                        ? null
                        : state.generationsList?.first.yearStop;
                    state.generationsList?.forEach((element) {
                      if (ids.contains(element.id)) {
                        if (element.yearStart != null &&
                            (element.yearStart ?? 0) < (startYear ?? 0)) {
                          startYear = element.yearStart;
                        }
                        if ((element.yearStop ?? 0) >= (endYear ?? 0)) {
                          endYear = element.yearStop ?? DateTime.now().year;
                        }
                      }
                    });
                    Navigator.of(context).push(AppRoutes.setYearOfIssue(context,
                        state.yearOfIssueValue ?? "", startYear, endYear));
                  },
                ),
                FitrItemComponent(
                    title: "mileage".tr(),
                    selectedFiltr: [state.mileageValue],
                    onRemove: () {
                      context.read<SearchBloc>().add(
                          const SearchEvent.deleteFilterValue(
                              filtrType: FilterType.mileage));
                    },
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext cntxt) {
                          return SetValueRangeDialog(
                            division: 20,
                            title: 'mileage'.tr(),
                            unit: 'km'.tr(),
                            start: null,
                            end: null,
                            onSelect: (value) {
                              context.read<SearchBloc>().add(
                                  SearchEvent.setFilterValue(
                                      value: value,
                                      filtrType: FilterType.mileage));
                              Navigator.of(cntxt).pop();
                            },
                          );
                        },
                      );
                    }),
                FitrItemComponent(
                  isRemove: true,
                  title: "price".tr(),
                  selectedFiltr: [state.priceValue, state.currencyValue],
                  onRemove: () {
                    context.read<SearchBloc>()
                      ..add(const SearchEvent.deleteFilterValue(
                          filtrType: FilterType.price))
                      ..add(const SearchEvent.deleteFilterValue(
                          filtrType: FilterType.currency));
                  },
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext cntxt) {
                        return SetPriceValueRangeDialog(
                          division: 200,
                          title: 'price'.tr(),
                          start: null,
                          end: null,
                          onSelect: (String value, String currency) {
                            context.read<SearchBloc>().add(
                                SearchEvent.setFilterValue(
                                    value: currency,
                                    filtrType: FilterType.currency));
                            context.read<SearchBloc>().add(
                                SearchEvent.setFilterValue(
                                    value: value, filtrType: FilterType.price));
                            Navigator.of(cntxt).pop();
                          },
                        );
                      },
                    );
                  },
                ),
                FitrItemComponent(
                  title: "body_type".tr(),
                  onRemove: () {
                    context.read<SearchBloc>().add(
                        const SearchEvent.deleteFilterValue(
                            filtrType: FilterType.bodyType));
                  },
                  selectedFiltr:
                      state.filterBodyValue?.map((e) => e.value).toList(),
                  onTap: () {
                    Navigator.of(context).push(AppRoutes.setBodyType(context));
                  },
                ),
                FitrItemComponent(
                  title: "service".tr(),
                  selectedFiltr:
                      state.filterServicesValue?.map((e) => e.value).toList(),
                  isHaveInfoButton: true,
                  onRemove: () {
                    context.read<SearchBloc>().add(
                        const SearchEvent.deleteFilterValue(
                            filtrType: FilterType.service));
                  },
                  onTap: () {
                    Navigator.of(context).push(AppRoutes.setService(context));
                  },
                  onTapInfoButton: () {
                    Navigator.of(context).push(AppRoutes.serviceInfo(context));
                  },
                ),
                if (showOtherFilters)
                  Column(
                    children: [
                      FitrItemComponent(
                        title: "region".tr(),
                        selectedFiltr: state.filterRegionValue
                            ?.map((e) => e.value)
                            .toList(),
                        onRemove: () {
                          context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.region));
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(AppRoutes.setRegion(context));
                        },
                      ).animate(),
                      FitrItemComponent(
                        title: "fuel".tr(),
                        selectedFiltr:
                            state.filterFuelValue?.map((e) => e.value).toList(),
                        onRemove: () {
                          context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.fuel));
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(AppRoutes.setFuel(context));
                        },
                      ).animate(),
                      FitrItemComponent(
                        title: "transmission".tr(),
                        selectedFiltr: state.filterTransmissionValue
                            ?.map((e) => e.value)
                            .toList(),
                        onRemove: () {
                          context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.transmission));
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(AppRoutes.setTransmisson(context));
                        },
                      ),
                      FitrItemComponent(
                        title: "color".tr(),
                        selectedFiltr: state.filterColorValue
                            ?.map((e) => e.value)
                            .toList(),
                        onRemove: () {
                          context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.color));
                        },
                        onTap: () {
                          Navigator.of(context).push(AppRoutes.setColor(
                              context, state.filterColorValue));
                        },
                      ),
                      FitrItemComponent(
                        title: "status".tr(),
                        selectedFiltr: (state.status == "1")
                            ? ["new".tr()]
                            : state.status == "0"
                                ? ["used".tr()]
                                : null,
                        onRemove: () {
                          context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.status));
                        },
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext cntxt) {
                              return SetStatusDialog(
                                isNew: state.status == null
                                    ? null
                                    : state.status == "1",
                                onChanged: (bool value) {
                                  context.read<SearchBloc>().add(
                                      SearchEvent.setFilterValue(
                                          value: value ? "1" : "0",
                                          filtrType: FilterType.status));
                                  Navigator.of(cntxt).pop();
                                },
                              );
                            },
                          );
                        },
                      ),
                      FitrItemComponent(
                        title: "seller_classification".tr(),
                        selectedFiltr:
                            state.salesmanValue?.map((e) => e.value).toList(),
                        onRemove: () {
                          context.read<SearchBloc>().add(
                              const SearchEvent.deleteFilterValue(
                                  filtrType: FilterType.numberOfOwners));
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(AppRoutes.setSalesman(context));
                        },
                      ),
                    ],
                  ),
                if (!showOtherFilters)
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          showOtherFilters = true;
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(colors.customRed),
                        textStyle: MaterialStateProperty.all(
                            fonts.subtitle1.copyWith(fontSize: 14.sp)),
                      ),
                      child: Text("additional_filter".tr()),
                    ),
                  ),
                160.verticalSpace,
              ],
            ),
          );
        });
      },
    );
  }
}

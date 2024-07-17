import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/year_or_month_component.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class SetYearOfIssuePage extends StatefulWidget {
  const SetYearOfIssuePage(
      {super.key, required this.selectedDate, this.startYear, this.endYear});

  final String selectedDate;
  final int? startYear;
  final int? endYear;

  @override
  State<SetYearOfIssuePage> createState() => _SetYearOfIssuePageState();
}

class _SetYearOfIssuePageState extends State<SetYearOfIssuePage>
    with SingleTickerProviderStateMixin {
  String minYear = '';
  String maxYear = '';
  String minMonth = '';
  String maxMonth = '';
  late bool showMonth;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<BottomNavBarController>().changeNavBar(true);
    });
    List<List<String>> date = List.generate(
        widget.selectedDate.trim().split('-').length,
        (index) =>
            widget.selectedDate.trim().split('-')[index].trim().split("/"));
    showMonth = date.isNotEmpty && date[0].length > 1;
    if (date.isNotEmpty && date[0][0].isNotEmpty) minYear = date[0][0].trim();
    if (date.isNotEmpty && date[0].length > 1) minMonth = date[0][1].trim();
    if (date.length > 1 && date[1].isNotEmpty) maxYear = date[1][0].trim();
    if (date.length > 1 && date[1].length > 1) maxMonth = date[1][1].trim();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBarComponent(
            title: "year_of_manufacture".tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  YearSelecInfoComponent(
                      minYear: minYear,
                      minMonth: minMonth,
                      maxYear: maxYear,
                      maxMonth: maxMonth,
                      colors: colors,
                      fonts: fonts,
                      showMonth: showMonth),
                  8.verticalSpace,
                  Divider(
                    height: 1,
                    color: colors.customGreyC3.withOpacity(0.7),
                  ),
                  SizedBox(
                    height: 460.h,
                    width: double.infinity,
                    child: Row(
                      children: [
                        20.horizontalSpace,
                        Expanded(
                          child: Row(
                            children: [
                              YearOrMontPickerComponent(
                                colors: colors,
                                fonts: fonts,
                                selYear: minYear,
                                isYear: true,
                                startYear: widget.startYear,
                                endYear: widget.endYear,
                                onTap: (value) {
                                  if (maxYear.isNotEmpty) {
                                    if (DateTime(int.parse(maxYear))
                                        .difference(DateTime(int.parse(value)))
                                        .inDays
                                        .isNegative) {
                                    } else {
                                      setState(() {
                                        minYear = value;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      minYear = value;
                                    });
                                  }
                                  String value2 = minYear +
                                      (showMonth && minMonth.isNotEmpty
                                          ? " / $minMonth"
                                          : "") +
                                      (maxYear.isNotEmpty
                                          ? " - $maxYear"
                                          : "") +
                                      (showMonth && maxMonth.isNotEmpty
                                          ? " / $maxMonth"
                                          : "");
                                  context.read<SearchBloc>().add(
                                      SearchEvent.setFilterValue(
                                          value: value2,
                                          filtrType: FilterType.year));
                                },
                              ),
                              if (showMonth)
                                YearOrMontPickerComponent(
                                  colors: colors,
                                  fonts: fonts,
                                  selYear: minMonth,
                                  onTap: (value) {
                                    setState(() {
                                      minMonth = value;
                                    });
                                  },
                                )
                            ],
                          ),
                        ),
                        40.horizontalSpace,
                        Expanded(
                          child: Row(
                            children: [
                              YearOrMontPickerComponent(
                                colors: colors,
                                fonts: fonts,
                                selYear: maxYear,
                                startYear: widget.startYear,
                                endYear: widget.endYear,
                                isYear: true,
                                onTap: (value) {
                                  if (minYear.isNotEmpty) {
                                    if (DateTime(int.parse(value))
                                        .difference(
                                            DateTime(int.parse(minYear)))
                                        .inDays
                                        .isNegative) {
                                    } else {
                                      setState(() {
                                        maxYear = value;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      maxYear = value;
                                    });
                                  }
                                  String value2 = minYear +
                                      (showMonth && minMonth.isNotEmpty
                                          ? " / $minMonth"
                                          : "") +
                                      (maxYear.isNotEmpty
                                          ? " - $maxYear"
                                          : "") +
                                      (showMonth && maxMonth.isNotEmpty
                                          ? " / $maxMonth"
                                          : "");
                                  context.read<SearchBloc>().add(
                                      SearchEvent.setFilterValue(
                                          value: value2,
                                          filtrType: FilterType.year));
                                },
                              ),
                              if (showMonth)
                                YearOrMontPickerComponent(
                                  colors: colors,
                                  fonts: fonts,
                                  selYear: maxMonth,
                                  onTap: (value) {
                                    setState(() {
                                      maxMonth = value;
                                    });
                                  },
                                )
                            ],
                          ),
                        ),
                        20.horizontalSpace,
                      ],
                    ),
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: BlocBuilder<SearchBloc, SearchState>(
                builder: (contextC, state) {
              return CustomButton(
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
              );
            }),
          ),
        );
      },
    );
  }
}

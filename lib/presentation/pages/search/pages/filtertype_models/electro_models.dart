// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:orient_motors/application/search/search_bloc.dart';
// import 'package:orient_motors/presentation/pages/search/components/filtr_item_component.dart';
// import 'package:orient_motors/presentation/pages/search/components/save_filter_component.dart';
// import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/set_value_range_dialog.dart';
// import 'package:orient_motors/presentation/routes/routes.dart';
// import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
// import 'package:orient_motors/utils/enum_filtr.dart';
//
// class ElectroFilterModelWidget extends StatefulWidget {
//   const ElectroFilterModelWidget({super.key});
//
//   @override
//   State<ElectroFilterModelWidget> createState() =>
//       _ElectroFilterModelWidgetState();
// }
//
// class _ElectroFilterModelWidgetState extends State<ElectroFilterModelWidget> {
//   late bool showOtherFilters;
//
//   @override
//   void initState() {
//     showOtherFilters = false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
//       return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               20.verticalSpace,
//               SaveFilterComponent(
//                 colors: colors,
//                 fonts: fonts,
//                 icons: icons,
//                 value: state.isFilterSaved,
//               ),
//               20.verticalSpace,
//               FitrItemComponent(
//                 title: "brand".tr(),
//                 selectedFiltr: state.brandValue,
//                 onRemove: () {
//                   context.read<SearchBloc>().add(
//                       const SearchEvent.deleteFilterValue(
//                           filtrType: FilterType.brand));
//                 },
//                 onTap: () {
//                   Navigator.of(context).push(AppRoutes.setBrand(context));
//                 },
//               ),
//               if (state.brandValueId != null)
//                 FitrItemComponent(
//                   title: "model".tr(),
//                   selectedFiltr: state.modelValue,
//                   onRemove: () {
//                     context.read<SearchBloc>().add(
//                         const SearchEvent.deleteFilterValue(
//                             filtrType: FilterType.model));
//                   },
//                   onTap: () {
//                     Navigator.of(context).push(AppRoutes.setModel(
//                         context, state.brandValueId.toString()));
//                   },
//                 ),
//               if (state.modelValueId != null && state.brandValueId != null)
//                 FitrItemComponent(
//                   title: "generation".tr(),
//                   selectedFiltr: state.filterGenerationValue
//                       ?.map((e) => e.value)
//                       .toList()
//                       .join(", "),
//                   onRemove: () {
//                     context.read<SearchBloc>().add(
//                         const SearchEvent.deleteFilterValue(
//                             filtrType: FilterType.generation));
//                   },
//                   onTap: () {
//                     Navigator.of(context).push(AppRoutes.setGeneration(
//                         context, state.modelValueId.toString()));
//                   },
//                 ),
//               // FitrItemComponent(
//               //   title: "Класс",
//               //   onRemove: () {
//               //     context.read<SearchBloc>().add(
//               //         const SearchEvent.deleteFilterValue(
//               //             filtrType: FilterType.modification));
//               //   },
//               //   selectedFiltr: state.classValue,
//               //   onTap: () {
//               //     // context.read<SearchBloc>().add(
//               //     //     const SearchEvent.setFilterValue(
//               //     //         value: "Midsize Car",
//               //     //         filtrType: FilterType.modification));
//               //     Navigator.of(context).push(AppRoutes.setClass(context));
//               //   },
//               // ),
//               FitrItemComponent(
//                 title: "year_of_manufacture".tr(),
//                 onRemove: () {
//                   context.read<SearchBloc>().add(
//                       const SearchEvent.deleteFilterValue(
//                           filtrType: FilterType.year));
//                 },
//                 selectedFiltr: state.yearOfIssueValue,
//                 onTap: () {
//                   int? startYear = state.generationsList?.first.yearStart;
//                   int? endYear = state.generationsList?.first.yearStop;
//                   state.generationsList?.forEach((element) {
//                     if (element.yearStart != null &&
//                         (element.yearStart ?? 0) < (startYear ?? 0)) {
//                       startYear = element.yearStart;
//                     }
//                     if ((element.yearStop ?? 0) >= (endYear ?? 0)) {
//                       endYear = element.yearStop ?? DateTime.now().year;
//                     }
//                   });
//                   Navigator.of(context).push(AppRoutes.setYearOfIssue(context,
//                       state.yearOfIssueValue ?? "", startYear, endYear));
//                 },
//               ),
//               FitrItemComponent(
//                   title: "mileage".tr(),
//                   selectedFiltr: state.mileageValue,
//                   onRemove: () {
//                     context.read<SearchBloc>().add(
//                         const SearchEvent.deleteFilterValue(
//                             filtrType: FilterType.milleage));
//                   },
//                   onTap: () {
//                     showDialog<void>(
//                       context: context,
//                       builder: (BuildContext cntxt) {
//                         return SetValueRangeDialog(
//                           division: 20,
//                           title: 'mileage'.tr(),
//                           unit: 'km'.tr(),
//                           start: null,
//                           end: null,
//                           onSelect: (value) {
//                             context.read<SearchBloc>().add(
//                                 SearchEvent.setFilterValue(
//                                     value: value,
//                                     filtrType: FilterType.milleage));
//                             Navigator.of(context).pop();
//                           },
//                         );
//                       },
//                     );
//                   }),
//               // FitrItemComponentWithButton(
//               //   title: "currency".tr(),
//               //   value: state.currencyValue ?? listCurrency.last,
//               //   filtrItems: listCurrency,
//               //   onSelectedItem: (value) {
//               //     context.read<SearchBloc>().add(SearchEvent.setFilterValue(
//               //         value: value, filtrType: FilterType.currency));
//               //   },
//               // ),
//               FitrItemComponent(
//                 title: "price".tr(),
//                 selectedFiltr: state.priceValue,
//                 onRemove: () {
//                   context.read<SearchBloc>().add(
//                       const SearchEvent.deleteFilterValue(
//                           filtrType: FilterType.price));
//                 },
//                 onTap: () {
//                   showDialog<void>(
//                     context: context,
//                     builder: (BuildContext cntxt) {
//                       return SetPriceValueRangeDialog(
//                         division: 200,
//                         title: 'price'.tr(),
//                         start: null,
//                         end: null,
//                         onSelect: (String value, String currency) {
//                           context.read<SearchBloc>().add(
//                               SearchEvent.setFilterValue(
//                                   value: value, filtrType: FilterType.price));
//                           Navigator.of(context).pop();
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//               FitrItemComponent(
//                 title: "body_type".tr(),
//                 onRemove: () {
//                   context.read<SearchBloc>().add(
//                       const SearchEvent.deleteFilterValue(
//                           filtrType: FilterType.bodyType));
//                 },
//                 selectedFiltr: state.filterBodyValue
//                     ?.map((e) => e.value)
//                     .toList()
//                     .join(", "),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       AppRoutes.setBodyType(context, state.filterBodyValue));
//                 },
//               ),
//               FitrItemComponent(
//                 title: "service".tr(),
//                 selectedFiltr: state.filterServicesValue?.map((e) => e.value)
//                     .toList()
//                     .join(", "),
//                 isHaveInfoButton: true,
//                 onRemove: () {
//                   context.read<SearchBloc>().add(
//                       const SearchEvent.deleteFilterValue(
//                           filtrType: FilterType.service));
//                 },
//                 onTap: () {
//                   // Navigator.of(context).push(
//                   //     AppRoutes.setService(context, state.servicesValue));
//                 },
//                 onTapInfoButton: () {
//                   Navigator.of(context).push(AppRoutes.serviceInfo(context));
//                 },
//               ),
//               if (showOtherFilters)
//                 Column(
//                   children: [
//                     FitrItemComponent(
//                       title: "region".tr(),
//                       selectedFiltr: state.filterRegionValue
//                           ?.map((e) => e.value)
//                           .toList()
//                           .join(", "),
//                       onRemove: () {
//                         context.read<SearchBloc>().add(
//                             const SearchEvent.deleteFilterValue(
//                                 filtrType: FilterType.region));
//                       },
//                       onTap: () {
//                         Navigator.of(context).push(AppRoutes.setRegion(
//                             context, state.filterRegionValue));
//                       },
//                     ).animate(),
//                     FitrItemComponent(
//                       title: "fuel".tr(),
//                       selectedFiltr: state.filterFuelValue
//                           ?.map((e) => e.value)
//                           .toList()
//                           .join(", "),
//                       onRemove: () {
//                         context.read<SearchBloc>().add(
//                             const SearchEvent.deleteFilterValue(
//                                 filtrType: FilterType.fuel));
//                       },
//                       onTap: () {
//                         Navigator.of(context).push(AppRoutes.setFuel(
//                             context, state.filterFuelValue));
//                       },
//                     ).animate(),
//                     FitrItemComponent(
//                       title: "transmission".tr(),
//                       selectedFiltr: state.filterTransmissionValue
//                           ?.map((e) => e.value)
//                           .toList()
//                           .join(", "),
//                       onRemove: () {
//                         context.read<SearchBloc>().add(
//                             const SearchEvent.deleteFilterValue(
//                                 filtrType: FilterType.transmission));
//                       },
//                       onTap: () {
//                         Navigator.of(context).push(AppRoutes.setTransmisson(
//                             context, state.filterTransmissionValue));
//                       },
//                     ),
//                     FitrItemComponent(
//                       title: "color".tr(),
//                       selectedFiltr: state.filterColorValue
//                           ?.map((e) => e.value)
//                           .toList()
//                           .join(", "),
//                       onRemove: () {
//                         context.read<SearchBloc>().add(
//                             const SearchEvent.deleteFilterValue(
//                                 filtrType: FilterType.color));
//                       },
//                       onTap: () {
//                         Navigator.of(context).push(AppRoutes.setColor(
//                             context, state.filterColorValue));
//                       },
//                     ),
//                     FitrItemComponent(
//                       title: "seller_classification".tr(),
//                       selectedFiltr: state.salesmanValue?.map((e) => e.value)
//                           .toList()
//                           .join(", "),
//                       onRemove: () {
//                         context.read<SearchBloc>().add(
//                             const SearchEvent.deleteFilterValue(
//                                 filtrType: FilterType.numberOfOwners));
//                       },
//                       onTap: () {
//                         Navigator.of(context).push(AppRoutes.setSalesman(context));
//                       },
//                     ),
//                   ],
//                 ),
//               Align(
//                 alignment: Alignment.center,
//                 child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       showOtherFilters = true;
//                     });
//                   },
//                   style: ButtonStyle(
//                     foregroundColor:
//                     MaterialStateProperty.all(colors.customRed),
//                     textStyle: MaterialStateProperty.all(
//                         fonts.subtitle1.copyWith(fontSize: 14.sp)),
//                   ),
//                   child: Text("additional_filter".tr()),
//                 ),
//               ),
//               160.verticalSpace,
//             ],
//           ),
//         );
//       });
//     });
//   }
// }

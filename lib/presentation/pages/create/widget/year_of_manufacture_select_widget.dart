import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class YearOfManufactureSelectWidget extends StatefulWidget {
  const YearOfManufactureSelectWidget({super.key});

  @override
  State<YearOfManufactureSelectWidget> createState() =>
      YearOfManufactureSelectWidgetState();
}

class YearOfManufactureSelectWidgetState
    extends State<YearOfManufactureSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  if (state.createCarReq?.generation != null) {
                    int lastIndex = state.generationsList?.lastIndexWhere(
                            (element) =>
                                element.id == state.createCarReq!.generation) ??
                        -1;
                    if (lastIndex != -1) {
                      return ModelListItemYear(
                        selectedYear: state.createCarReq?.year,
                        colors: colors,
                        fonts: fonts,
                        title: "",
                        count: "",
                        onTap: (int year) {
                          CreateCarReq req =
                              (state.createCarReq ?? CreateCarReq())
                                  .rebuild((p0) => p0..year = year);
                          context.read<AddCarBloc>().add(
                              AddCarEvent.setFilterValue(
                                  createCarReq: req,
                                  filterType: FilterType.bodyType));
                        },
                        model: state.generationsList![lastIndex],
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
          );
        },
      );
    });
  }
}

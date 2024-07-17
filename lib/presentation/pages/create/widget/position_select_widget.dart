import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class PositionSelectWidget extends StatelessWidget {
  const PositionSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(
        builder: (ctx, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.generationsList?.length ?? 0,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ModelListItem(
                        isSelected: state.createCarReq?.generation ==
                            state.generationsList?[index].id,
                        colors: colors,
                        fonts: fonts,
                        title: state.generationsList?[index].name != null &&
                                state.generationsList![index].name!.isNotEmpty
                            ? state.generationsList![index].name!
                            : "${state.generationsList?[index].yearStart ?? ""}/${state.generationsList?[index].yearStop ?? DateTime.now().year}",
                        count: "",
                        onTap: () {
                          CreateCarReq req = (state.createCarReq ??
                                  CreateCarReq())
                              .rebuild((p0) => p0
                                ..generation = state.generationsList?[index].id
                                ..modification = null);
                          context.read<AddCarBloc>().add(
                              AddCarEvent.setFilterValue(
                                  createCarReq: req,
                                  filterType: FilterType.modification));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Divider(
                          color: colors.customGreyC3.withOpacity(0.5),
                          height: 1.h,
                        ),
                      );
                    }),
              ],
            ),
          );
        },
      );
    });
  }
}

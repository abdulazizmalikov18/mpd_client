import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class ModificationSelectWidget extends StatelessWidget {
  const ModificationSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocConsumer<AddCarBloc, AddCarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.generationsConfigurationsList?.isNotEmpty ?? false)
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.generationsConfigurationsList?.first
                              .modification?.length ??
                          0,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ModelListItem(
                          isSelected: state.createCarReq?.modification ==
                              state.generationsConfigurationsList?.first
                                  .modification?[index].id,
                          colors: colors,
                          fonts: fonts,
                          title:
                              "${state.generationsConfigurationsList?.first.modification?[index].groupName ?? ""} ${state.generationsConfigurationsList?.first.modification?[index].specifications?.first.volumeLitres ?? ""} ${state.generationsConfigurationsList?.first.modification?[index].specifications?.first.transmission ?? ""} (${state.generationsConfigurationsList?.first.modification?[index].specifications?.first.horsePower?.toInt() ?? ""}) ${state.generationsConfigurationsList?.first.modification?[index].specifications?.first.drive}",
                          count: "",
                          onTap: () {
                            CreateCarReq req =
                                (state.createCarReq ?? CreateCarReq()).rebuild(
                                    (p0) => p0
                                      ..modification = state
                                          .generationsConfigurationsList
                                          ?.first
                                          .modification?[index]
                                          .id
                                      ..configuration = state
                                          .generationsConfigurationsList
                                          ?.first
                                          .id);
                            context.read<AddCarBloc>().add(
                                AddCarEvent.setFilterValue(
                                    createCarReq: req,
                                    filterType: FilterType.year));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(
                            color: colors.customGreyC3.withOpacity(0.3),
                            height: 1.h,
                          ),
                        );
                      }),
                16.verticalSpace
              ],
            ),
          );
        },
      );
    });
  }
}

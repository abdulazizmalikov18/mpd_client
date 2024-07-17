import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class BodyTypeSelectWidget extends StatefulWidget {
  const BodyTypeSelectWidget({super.key});

  @override
  State<BodyTypeSelectWidget> createState() => BodyTypeSelectWidgetState();
}

class BodyTypeSelectWidgetState extends State<BodyTypeSelectWidget> {
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
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.bodyTypeList?.length ?? 0,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ModelListItem(
                        isSelected: state.createCarReq?.bodyType ==
                            state.bodyTypeList?[index].id,
                        colors: colors,
                        fonts: fonts,
                        title: state.bodyTypeList?[index].name ?? '',
                        count: "",
                        onTap: () {
                          CreateCarReq req = (state.createCarReq ??
                                  CreateCarReq())
                              .rebuild((p0) =>
                                  p0..bodyType = state.bodyTypeList?[index].id);
                          context.read<AddCarBloc>().add(
                              AddCarEvent.setFilterValue(
                                  createCarReq: req,
                                  filterType: FilterType.carOptions));
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
                100.verticalSpace
              ],
            ),
          );
        },
      );
    });
  }
}

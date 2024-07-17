import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ModelSelectWidget extends StatelessWidget {
  const ModelSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (ctx, state) {
        return ListView(
          padding: EdgeInsets.only(
              bottom: 16.h + MediaQuery.of(context).padding.bottom, top: 8.h),
          children: [
            if ((state.topModelList?.length ?? 0) != 0)
              StickyHeader(
                header: Container(
                  width: 1.sw,
                  color: colors.colorF5F5F5,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                  child: Text("popular".tr(), style: fonts.subtitle1),
                ),
                content: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.topModelList?.length ?? 0,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ModelListItem(
                        isSelected: state.createCarReq?.carModel ==
                            state.topModelList?[index].id,
                        colors: colors,
                        fonts: fonts,
                        title: state.topModelList?[index].name ?? "",
                        count: "",
                        onTap: () {
                          CreateCarReq req =
                              (state.createCarReq ?? CreateCarReq())
                                  .rebuild((p0) => p0
                                    ..carModel = state.topModelList?[index].id
                                    ..generation = null
                                    ..modification = null);
                          context.read<AddCarBloc>().add(
                              AddCarEvent.setFilterValue(
                                  createCarReq: req,
                                  filterType: FilterType.generation));
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
              ),
            8.verticalSpace,
            if ((state.modelList?.length ?? 0) != 0)
              StickyHeader(
                header: Container(
                  width: 1.sw,
                  color: colors.colorF5F5F5,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                  child: Text("all_models".tr(), style: fonts.subtitle1),
                ),
                content: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.modelList?.length ?? 0,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ModelListItem(
                        isSelected: state.createCarReq?.carModel ==
                            state.modelList?[index].id,
                        colors: colors,
                        fonts: fonts,
                        title: state.modelList?[index].name ?? "",
                        count: "",
                        onTap: () {
                          CreateCarReq req =
                              (state.createCarReq ?? CreateCarReq())
                                  .rebuild((p0) => p0
                                    ..carModel = state.modelList?[index].id
                                    ..generation = null
                                    ..modification = null);
                          context.read<AddCarBloc>().add(
                              AddCarEvent.setFilterValue(
                                  createCarReq: req,
                                  filterType: FilterType.generation));
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
              ),
          ],
        );
      });
    });
  }
}

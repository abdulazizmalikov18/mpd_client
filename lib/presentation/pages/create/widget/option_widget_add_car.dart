import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class OptionAddCarWidget extends StatelessWidget {
  const OptionAddCarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        CreateCarReq? createCarReq = state.createCarReq;
        return Scaffold(
          backgroundColor: colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomButton(
              onPressed: () {
                context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                    createCarReq: state.createCarReq ?? CreateCarReq(),
                    filterType: FilterType.configurations));
              },
              backgroundColor: colors.primary,
              title: "continue".tr(),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              children: [
                _OptionsItem(
                  createCarReq: createCarReq,
                  list: state.options?.externalBodyKit?.toList() ?? [],
                  filterType: FilterType.externalBodyKit,
                  title: 'appearance'.tr(
                      args: ["${state.options?.externalBodyKit?.length ?? 0}"]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(
                    color: colors.customGreyC3,
                  ),
                ),
                _OptionsItem(
                  createCarReq: createCarReq,
                  list: state.options?.optics?.toList() ?? [],
                  filterType: FilterType.optics,
                  title: 'optics2'
                      .tr(args: ["${state.options?.optics?.length ?? 0}"]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(
                    color: colors.customGreyC3,
                  ),
                ),
                _OptionsItem(
                  createCarReq: createCarReq,
                  list: state.options?.mediaTools?.toList() ?? [],
                  filterType: FilterType.media,
                  title: 'multimedia'
                      .tr(args: ["${state.options?.mediaTools?.length ?? 0}"]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(
                    color: colors.customGreyC3,
                  ),
                ),
                _OptionsItem(
                  createCarReq: createCarReq,
                  list: state.options?.salon?.toList() ?? [],
                  filterType: FilterType.salon,
                  title: 'salon2'
                      .tr(args: ["${state.options?.salon?.length ?? 0}"]),
                ),
                SizedBox(
                  height: 80.h,
                )
              ],
            ),
          ),
        );
      });
    });
  }
}

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({
    required this.createCarReq,
    required this.list,
    required this.filterType,
    required this.title,
  });

  final CreateCarReq? createCarReq;
  final List<DriveUnitModel> list;
  final FilterType filterType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: filterType == FilterType.externalBodyKit,
          title: Text(
            title,
            style: fonts.subtitle1,
          ),
          children: [
            for (var index = 0; index < (list.length); index++)
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                value: filterType == FilterType.externalBodyKit
                    ? createCarReq?.externalBodyKit?.contains(list[index].id) ??
                        false
                    : filterType == FilterType.optics
                        ? createCarReq?.optics?.contains(list[index].id) ??
                            false
                        : filterType == FilterType.media
                            ? createCarReq?.mediaTools
                                    ?.contains(list[index].id) ??
                                false
                            : createCarReq?.salon?.contains(list[index].id) ??
                                false,
                onChanged: (bool? val) {
                  if (val != null) {
                    CreateCarReq req = (createCarReq ?? CreateCarReq());
                    if (filterType == FilterType.externalBodyKit) {
                      List<int> externalList =
                          req.externalBodyKit?.toList() ?? [];
                      if (val) {
                        externalList.add(list[index].id!);
                      } else {
                        externalList.remove(list[index].id!);
                      }
                      req = req.rebuild((p0) => p0
                        ..externalBodyKit =
                            externalList.toBuiltList().toBuilder());
                    }
                    if (filterType == FilterType.optics) {
                      List<int> opticsList = req.optics?.toList() ?? [];
                      if (val) {
                        opticsList.add(list[index].id!);
                      } else {
                        opticsList.remove(list[index].id!);
                      }
                      req = req.rebuild((p0) =>
                          p0..optics = opticsList.toBuiltList().toBuilder());
                    }
                    if (filterType == FilterType.media) {
                      List<int> mediaList = req.mediaTools?.toList() ?? [];
                      if (val) {
                        mediaList.add(list[index].id!);
                      } else {
                        mediaList.remove(list[index].id);
                      }
                      req = req.rebuild((p0) =>
                          p0..mediaTools = mediaList.toBuiltList().toBuilder());
                    }
                    if (filterType == FilterType.salon) {
                      List<int> salonList = req.salon?.toList() ?? [];
                      if (val) {
                        salonList.add(list[index].id!);
                      } else {
                        salonList.remove(list[index].id);
                      }
                      req = req.rebuild((p0) =>
                          p0..salon = salonList.toBuiltList().toBuilder());
                    }
                    context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                        createCarReq: req, filterType: FilterType.none));
                  }
                },
                activeColor: colors.primary,
                checkColor: colors.white,
                side: BorderSide(width: 1.w, color: colors.grey),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
                title: Text(
                  list[index].name ?? "",
                  style: fonts.subtitle1.copyWith(fontSize: 12.sp),
                ),
              )
          ],
        ),
      );
    });
  }
}

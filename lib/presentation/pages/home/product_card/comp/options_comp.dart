import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class OptionsComp extends StatefulWidget {
  const OptionsComp({super.key});

  @override
  State<OptionsComp> createState() => _OptionsCompState();
}

class _OptionsCompState extends State<OptionsComp> {
  late bool isShimmer;
  late bool allShow;

  @override
  void initState() {
    isShimmer = true;
    allShow = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OptionsRes? optionsRes = context.read<DBService>().optionsList;
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        if (state.carDetailRes != null) {
          isShimmer = false;
        }

        /// car detail list
        List<DriveUnitModel> externalCarList = [];
        if (state.carDetailRes?.externalBodyKit != null) {
          state.carDetailRes?.externalBodyKit?.forEach((p0) {
            externalCarList.add(p0);
          });
        }

        if (state.carDetailRes?.optics != null) {
          state.carDetailRes?.optics?.forEach((p0) {
            // opticsCarList.add(p0);
            externalCarList.add(p0);
          });
        }

        if (state.carDetailRes?.mediaTools != null) {
          state.carDetailRes?.mediaTools?.forEach((p0) {
            // mediaCarList.add(p0);
            externalCarList.add(p0);
          });
        }

        if (state.carDetailRes?.salon != null) {
          for (var p0 in state.carDetailRes!.salon!) {
            // salonCarList.add(p0);
            externalCarList.add(p0);
          }
        }

        /// all lists from server
        List<DriveUnitModel> externalList = [];
        // List<DriveUnitModel> opticsList = [];
        // List<DriveUnitModel> mediaList = [];
        // List<DriveUnitModel> salonList = [];
        if (optionsRes?.externalBodyKit != null) {
          for (var p0 in optionsRes!.externalBodyKit!) {
            externalList.add(p0);
          }
        }

        if (optionsRes?.optics != null) {
          for (var p0 in optionsRes!.optics!) {
            // opticsList.add(p0);
            externalList.add(p0);
          }
        }

        if (optionsRes?.mediaTools != null) {
          for (var p0 in optionsRes!.mediaTools!) {
            // mediaList.add(p0);
            externalList.add(p0);
          }
        }

        if (optionsRes?.salon != null) {
          for (var p0 in optionsRes!.salon!) {
            // salonList.add(p0);
            externalList.add(p0);
          }
        }
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GridView.builder(
                padding: EdgeInsets.only(top: 12.h),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return _listOptions(
                      colors, index, externalList, externalCarList);
                },
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allShow
                    ? externalList.length
                    : externalList.isEmpty
                        ? 0
                        : 8,
                shrinkWrap: true,
              ),
              8.verticalSpace,
              IconButton(
                onPressed: () {
                  setState(() {
                    allShow = !allShow;
                  });
                },
                icon: allShow
                    ? icons.up.svg(color: colors.customGreyC3)
                    : icons.down.svg(
                        color: colors.customGreyC3,
                      ),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget _listOptions(CustomColorSet colors, int index,
      List<DriveUnitModel> list, List<DriveUnitModel> listCar) {
    final item = list[index].name;
    Color color = listCar.any((element) => element.name == item)
        ? colors.text
        : colors.customGreyC3;
    return isShimmer
        ? ShimmerView(
            child: Column(children: [
              const ShimmerContainer(width: 30, height: 30),
              4.verticalSpace,
              const ShimmerContainer(width: 60, height: 20)
            ]),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.h,
                width: 32.w,
                child: CachedImageComponent(
                  imageUrl: list[index].icon ?? "",
                  color: color,
                  height: 32.h,
                  width: 32.w,
                ),
              ),
              4.verticalSpace,
              Text(
                list[index].name ?? "",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Style.medium14(size: 10.sp, color: color),
              )
            ],
          );
  }
}

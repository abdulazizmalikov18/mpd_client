import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class BargainingComp extends StatefulWidget {
  final CreateCarReq? createCarReq;

  const BargainingComp({super.key, required this.createCarReq});

  @override
  State<BargainingComp> createState() => _BargainingCompState();
}

class _BargainingCompState extends State<BargainingComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return Row(children: [
        Text(
          "bargaining".tr(),
          style: fonts.subtitle1,
        ),
        const Spacer(),
        Row(children: [
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              CreateCarReq req = (widget.createCarReq ?? CreateCarReq())
                  .rebuild((p0) => p0..isCheaper = true);
              context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                  createCarReq: req,
                  filterType: FilterType.none,
                  isCheck: false));
            },
            child: Container(
              width: 80.w,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: (widget.createCarReq?.isCheaper ?? false)
                        ? colors.primary
                        : colors.customGreyC3,
                  )),
              child: Text(
                "yes".tr(),
                textAlign: TextAlign.center,
                style: fonts.subtitle1.copyWith(
                    color: (widget.createCarReq?.isCheaper ?? false)
                        ? colors.primary
                        : colors.customGreyC3),
              ),
            ),
          ),
          8.horizontalSpace,
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              CreateCarReq req = (widget.createCarReq ?? CreateCarReq())
                  .rebuild((p0) => p0..isCheaper = false);
              context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                  createCarReq: req,
                  filterType: FilterType.none,
                  isCheck: false));
            },
            child: Container(
              width: 80.w,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: (widget.createCarReq?.isCheaper ?? false)
                          ? colors.customGreyC3
                          : colors.primary)),
              child: Text(
                "no".tr(),
                textAlign: TextAlign.center,
                style: fonts.subtitle1.copyWith(
                    color: (widget.createCarReq?.isCheaper ?? false)
                        ? colors.customGreyC3
                        : colors.primary),
              ),
            ),
          ),
        ])
      ]);
    });
  }
}

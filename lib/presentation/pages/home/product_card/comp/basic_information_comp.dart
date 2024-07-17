import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BasicInformationComp extends StatelessWidget {
  const BasicInformationComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<CarDetailBloc, CarDetailState>(
          builder: (context, state) {
        var data = state.carDetailRes;
        return Column(
          children: [
            _buildRow(["year".tr(), "${data?.year ?? ""}"], colors),
            _buildRow(
                ["mileage".tr(), "${data?.mileage?.toInt() ?? 0}"], colors),
            _buildRow(
                ["engine_volume".tr(), "${data?.engineSize ?? ""} л"], colors),
            _buildRow(["fuel".tr(), (data?.fuelType?.name ?? "")], colors),
            _buildRow(["transmission".tr(), (data?.transmission?.name ?? "")],
                colors),
            _buildRow(["body_type".tr(), (data?.bodyType?.name ?? "")], colors),
            _buildRow(["color".tr(), (data?.color?.name ?? "")], colors),
            _buildRow(["region".tr(), (data?.region?.name ?? "")], colors),
            _buildRow(
                ["number_of_owners".tr(), "${data?.numberOfOwners ?? ""}"],
                colors),
          ],
        );
      });
    });
  }

  Row _buildRow(List<String> data, CustomColorSet colors) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            data[i],
            textAlign: i == 0 ? TextAlign.start : TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Style.medium14(
                color: i == 0 ? colors.text.withOpacity(0.7) : colors.text),
          ),
        ),
      ));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list);
  }
}

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class DescriptionTextFieldComp extends StatefulWidget {
  const DescriptionTextFieldComp({super.key});

  @override
  State<DescriptionTextFieldComp> createState() =>
      _DescriptionTextFieldCompState();
}

class _DescriptionTextFieldCompState extends State<DescriptionTextFieldComp> {
  Timer? _timer;
  @override
  void initState() {
    _timer?.cancel();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, _) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'description'.tr(),
            style: fonts.headline1,
          ),
          16.verticalSpace,
          if (state.createCarReq != null)
            SizedBox(
              height: 200.h,
              child: TextFormField(
                initialValue: state.createCarReq!.description,
                onChanged: (val) {
                  if (_timer != null) _timer?.cancel();
                  _timer = Timer(const Duration(seconds: 1), () {
                    CreateCarReq req = (state.createCarReq ?? CreateCarReq())
                        .rebuild((p0) => p0..description = val.trim());
                    context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                        createCarReq: req,
                        filterType: FilterType.none,
                        isCheck: false));
                  });
                },
                expands: true,
                maxLines: null,
                maxLength: 9000,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0.r),
                      ),
                      borderSide: BorderSide(
                        color: colors.customGreyC3,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0.r),
                      ),
                      borderSide: BorderSide(
                        color: colors.customGreyC3,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0.r),
                      ),
                      borderSide: BorderSide(
                        color: colors.customGreyC3,
                      )),
                  filled: true,
                  fillColor: colors.white,
                  hintText: 'enter_description'.tr(),
                  hintStyle: fonts.headline1
                      .copyWith(color: colors.text.withOpacity(0.5)),
                ),
              ),
            ),
          8.verticalSpace,
        ]);
      });
    });
  }
}

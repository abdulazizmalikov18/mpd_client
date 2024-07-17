import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/dialog_components.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class MileageOneSliderComp extends StatefulWidget {
  const MileageOneSliderComp({
    super.key,
    required this.start,
    this.maxValue = 1000000,
    required this.title,
    this.unit,
    required this.onSelect,
    required this.division,
  });

  final double? start;
  final double maxValue;
  final String title;
  final String? unit;
  final int division;
  final Function(int) onSelect;

  @override
  State<MileageOneSliderComp> createState() => _MileageOneSliderCompState();
}

class _MileageOneSliderCompState extends State<MileageOneSliderComp> {
  late bool _isDirectInput;
  late TextEditingController _minController;
  final _formKey = GlobalKey<FormState>();
  late String uintWihtSpace;
  late double startVal;
  Timer? _timer;

  @override
  void initState() {
    _minController =
        TextEditingController(text: widget.start?.toInt().toString() ?? "");
    _timer?.cancel();
    _isDirectInput = true;
    startVal = widget.start ?? 0;
    uintWihtSpace = widget.unit == null ? "" : " ${widget.unit}";
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _minController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Row(
            children: [
              Text(widget.title,
                  textAlign: TextAlign.center,
                  style: fonts.subtitle2.copyWith(fontSize: 14.sp)),
            ],
          ),
          backgroundColor: colors.white,
          surfaceTintColor: colors.white,
          content: SizedBox(
            height: 56.h,
            width: 350.w,
            child: _isDirectInput
                ? Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: MilleageTextFormField(
                            controller: _minController,
                            fonts: fonts,
                            colors: colors,
                            hintText: "0",
                            suffixText: widget.unit,
                            onChanged: (val) {
                              if (_isDirectInput &&
                                  _formKey.currentState!.validate()) {
                                String text = _minController.text
                                    .toString()
                                    .trim()
                                    .replaceAll(RegExp(r"\s+"), "");
                                double? value = double.tryParse(text);
                                if (value != null) {
                                  startVal = value;
                                  widget.onSelect(startVal.round());
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SliderTheme(
                        data: customSliserThemeData(colors),
                        child: Slider(
                          value: startVal,
                          min: widget.start ?? 0,
                          max: widget.maxValue,
                          divisions: widget.division,
                          onChanged: (val) {
                            setState(() {
                              startVal = val;
                              _minController.clear();
                              if (_timer != null) _timer?.cancel();
                              _timer = Timer(const Duration(seconds: 2), () {
                                widget.onSelect(startVal.round());
                              });
                            });
                          },
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        "${startVal.round()}$uintWihtSpace",
                        style: fonts.subtitle1.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
          ),
          actionsPadding: EdgeInsets.all(20.w),
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/dialog_components.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class SetValueRangeDialog extends StatefulWidget {
  const SetValueRangeDialog({
    super.key,
    required this.start,
    required this.end,
    this.maxValue = 1000000,
    required this.title,
    this.unit,
    required this.onSelect,
    required this.division,
  });

  final double? start;
  final double? end;
  final double maxValue;
  final String title;
  final String? unit;
  final int division;
  final Function(String) onSelect;

  @override
  State<SetValueRangeDialog> createState() => _SetValueRangeDialogState();
}

class _SetValueRangeDialogState extends State<SetValueRangeDialog>
    with SingleTickerProviderStateMixin {
  late RangeValues _currentRangeValues;
  late bool _isDirectInput;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String uintWihtSpace;

  @override
  void initState() {
    _currentRangeValues =
        RangeValues(widget.start ?? 0, widget.end ?? widget.maxValue);
    _minController.text = widget.start?.toString() ?? "";
    _maxController.text = widget.end?.toString() ?? "";
    _isDirectInput = false;
    uintWihtSpace = widget.unit == null ? "" : " ${widget.unit}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AlertDialog(
          title: Text(widget.title,
              textAlign: TextAlign.center,
              style: fonts.subtitle1.copyWith(fontSize: 15.sp)),
          backgroundColor: colors.white,
          surfaceTintColor: colors.white,
          content: SizedBox(
            height: 66.h,
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
                            hintText: "minimum".tr(),
                            suffixText: widget.unit,
                          ),
                        ),
                        20.w.horizontalSpace,
                        Expanded(
                          child: MilleageTextFormField(
                            controller: _maxController,
                            fonts: fonts,
                            colors: colors,
                            hintText: "maximum".tr(),
                            suffixText: widget.unit,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        "${_currentRangeValues.start.round()}$uintWihtSpace - ${_currentRangeValues.end.round()}$uintWihtSpace",
                        style: fonts.subtitle1.copyWith(fontSize: 15.sp),
                      ),
                      10.verticalSpace,
                      SliderTheme(
                        data: customSliserThemeData(colors),
                        child: RangeSlider(
                          values: _currentRangeValues,
                          divisions: widget.division,
                          max: widget.maxValue,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          actionsPadding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 7.h, bottom: 25.h),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 25.h,
              bottom: _isDirectInput ? 0 : 0.h),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      // if (_isDirectInput) {
                      //   _currentRangeValues = RangeValues(
                      //     double.parse(_minController.text),
                      //     double.parse(_maxController.text),
                      //   );
                      // } else {
                      //   _minController.text =
                      //       _currentRangeValues.start.round().toString();
                      //   _maxController.text =
                      //       _currentRangeValues.end.round().toString();
                      // }
                      _isDirectInput = !_isDirectInput;
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    foregroundColor: MaterialStateProperty.all(
                        colors.black.withOpacity(0.5)),
                    textStyle: MaterialStateProperty.all(
                        fonts.subtitle1.copyWith(fontSize: 14.sp)),
                  ),
                  child: Text(_isDirectInput
                      ? "input_slider".tr()
                      : "direct_input".tr()),
                ),
                15.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          verticalPadding: 8.h,
                          backgroundColor: colors.white,
                          borderColor: colors.customGreyC3,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          title: "cancel".tr(),
                          titleStyle: fonts.subtitle1
                              .copyWith(color: colors.customBlack),
                        ),
                      ),
                      10.w.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                            verticalPadding: 8.h,
                            haveBorder: false,
                            backgroundColor: colors.customRed,
                            onPressed: () {
                              if (_isDirectInput &&
                                  _formKey.currentState!.validate()) {
                                String textMin = _minController.text
                                    .toString()
                                    .trim()
                                    .replaceAll(RegExp(r"\s+"), "");
                                String textMax = _maxController.text
                                    .toString()
                                    .trim()
                                    .replaceAll(RegExp(r"\s+"), "");

                                widget.onSelect(
                                    "$textMin$uintWihtSpace - $textMax$uintWihtSpace");
                              } else {
                                widget.onSelect(
                                    "${_isDirectInput ? _minController.text : _currentRangeValues.start.round()}$uintWihtSpace - ${_isDirectInput ? _maxController.text : _currentRangeValues.end.round()}$uintWihtSpace");
                              }
                            },
                            title: "choose".tr(),
                            titleStyle:
                                fonts.subtitle1.copyWith(color: colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

//
class SetPriceValueRangeDialog extends StatefulWidget {
  const SetPriceValueRangeDialog({
    super.key,
    required this.start,
    required this.end,
    this.maxValue = 200000,
    required this.title,
    required this.onSelect,
    required this.division,
  });

  final double? start;
  final double? end;
  final double maxValue;
  final String title;
  final int division;
  final Function(String value, String currency) onSelect;

  @override
  State<SetPriceValueRangeDialog> createState() =>
      _SetPriceValueRangeDialogState();
}

class _SetPriceValueRangeDialogState extends State<SetPriceValueRangeDialog>
    with SingleTickerProviderStateMixin {
  late RangeValues _currentRangeValues;
  late bool _isDirectInput;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String currency;

  @override
  void initState() {
    _currentRangeValues =
        RangeValues(widget.start ?? 0, widget.end ?? widget.maxValue);
    _minController.text = widget.start?.toString() ?? "";
    _maxController.text = widget.end?.toString() ?? "";
    _isDirectInput = true;
    currency = listCurrency.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  textAlign: TextAlign.center,
                  style: fonts.subtitle1.copyWith(fontSize: 15.sp)),
              //currency selector
              Container(
                height: 25.h,
                width: 72.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: colors.customGreyC3,
                    )),
                child: Row(
                  children: [
                    Expanded(
                        child: AnimationButtonEffect(
                      onTap: () {
                        setState(() {
                          currency = listCurrency.first;
                        });
                      },
                      child: Container(
                        height: 44.h,
                        decoration: currency == listCurrency.first
                            ? BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(16.r)),
                              )
                            : null,
                        child: Center(
                          child: Text(
                            listCurrency.first.tr(),
                            style: fonts.subtitle1.copyWith(
                              color: currency == listCurrency.first
                                  ? colors.white
                                  : colors.customGreyC3,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: AnimationButtonEffect(
                      onTap: () {
                        setState(() {
                          currency = listCurrency.last;
                        });
                      },
                      child: Container(
                        height: 44.h,
                        decoration: currency == listCurrency.last
                            ? BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(16.r)),
                              )
                            : null,
                        child: Center(
                          child: Text(
                            listCurrency.last.tr(),
                            style: fonts.subtitle1.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: currency == listCurrency.last
                                    ? colors.white
                                    : colors.customGreyC3),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: colors.white,
          surfaceTintColor: colors.white,
          content: SizedBox(
            height: 64.h,
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
                            hintText: "minimum".tr(),
                            suffixText: currency.tr(),
                          ),
                        ),
                        20.w.horizontalSpace,
                        Expanded(
                          child: MilleageTextFormField(
                            controller: _maxController,
                            fonts: fonts,
                            colors: colors,
                            hintText: "maximum".tr(),
                            suffixText: currency.tr(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        "${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()} ${currency.tr()}",
                        style: fonts.subtitle1.copyWith(fontSize: 15.sp),
                      ),
                      10.verticalSpace,
                      SliderTheme(
                        data: customSliserThemeData(colors),
                        child: RangeSlider(
                          values: _currentRangeValues,
                          divisions: widget.division,
                          max: widget.maxValue,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          actionsPadding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 7.h, bottom: 25.h),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 25.h,
              bottom: _isDirectInput ? 0 : 0.h),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isDirectInput = !_isDirectInput;
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    foregroundColor: MaterialStateProperty.all(
                        colors.black.withOpacity(0.5)),
                    textStyle: MaterialStateProperty.all(
                        fonts.subtitle1.copyWith(fontSize: 14.sp)),
                  ),
                  child: Text(_isDirectInput
                      ? "input_slider".tr()
                      : "direct_input".tr()),
                ),
                15.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          verticalPadding: 8.h,
                          backgroundColor: colors.white,
                          borderColor: colors.customGreyC3,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          title: "cancel".tr(),
                          titleStyle: fonts.subtitle1
                              .copyWith(color: colors.customBlack),
                        ),
                      ),
                      10.w.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                            verticalPadding: 8.h,
                            haveBorder: false,
                            backgroundColor: colors.customRed,
                            onPressed: () {
                              if (_isDirectInput) {
                                if (_formKey.currentState!.validate()) {
                                  widget.onSelect(
                                      "${_isDirectInput ? _minController.text : _currentRangeValues.start.round()} - ${_isDirectInput ? _maxController.text : _currentRangeValues.end.round()}",
                                      currency);
                                }
                              } else {
                                widget.onSelect(
                                    "${_isDirectInput ? _minController.text : _currentRangeValues.start.round()} - ${_isDirectInput ? _maxController.text : _currentRangeValues.end.round()}",
                                    currency);
                              }
                            },
                            title: "choose".tr(),
                            titleStyle:
                                fonts.subtitle1.copyWith(color: colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

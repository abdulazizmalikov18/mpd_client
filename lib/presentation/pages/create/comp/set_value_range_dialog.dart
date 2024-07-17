import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/dialog_components.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SetValueBottomSheet extends StatefulWidget {
  const SetValueBottomSheet({
    super.key,
    required this.value,
    required this.title,
    this.unit,
    required this.onSelect,
    this.unitsList,
    this.onChangeValue,
  });

  final String value;
  final String title;
  final String? unit;
  final List<String>? unitsList;
  final Function(String?) onSelect;
  final Function(String?)? onChangeValue;

  @override
  State<SetValueBottomSheet> createState() => _SetValueBottomSheetState();
}

class _SetValueBottomSheetState extends State<SetValueBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _valueController = TextEditingController();
  late List<String>? filtrItems;
  late String? unitValue;

  @override
  void initState() {
    filtrItems = widget.unitsList;
    unitValue = widget.unit;
    _valueController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Padding(
          padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 20.h,
              bottom: 40.h + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          foregroundColor:
                              MaterialStateProperty.all(colors.black),
                          textStyle: MaterialStateProperty.all(
                              fonts.subtitle1.copyWith(fontSize: 18.sp)),
                        ),
                        child: Text('cancel'.tr()),
                      ),
                    ),
                  ),
                  Text(widget.title,
                      textAlign: TextAlign.center,
                      style: fonts.subtitle2.copyWith(fontSize: 18.sp)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (widget.onChangeValue != null &&
                              widget.unitsList != null) {
                            widget.onChangeValue!(unitValue);
                          }
                          widget.onSelect(_valueController.text);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          foregroundColor:
                              MaterialStateProperty.all(colors.customRed),
                          textStyle: MaterialStateProperty.all(
                              fonts.subtitle2.copyWith(fontSize: 18.sp)),
                        ),
                        child: Text(
                          'ready'.tr(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: 145.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MilleageTextFormField(
                      controller: _valueController,
                      fonts: fonts,
                      colors: colors,
                      hintText: "0.0",
                      textAlign: TextAlign.center,
                    ),
                    10.verticalSpace,
                    (widget.unitsList?.isNotEmpty ?? false)
                        ? Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10.w,
                            children: [
                                for (int i = 0;
                                    i < (filtrItems?.length ?? 0);
                                    i++)
                                  CustomButton(
                                    onPressed: () {
                                      setState(() {
                                        unitValue = filtrItems?[i] ?? "";
                                      });
                                    },
                                    title: filtrItems?[i] ?? "",
                                    isInfinityWidth: false,
                                    haveBorder:
                                        filtrItems?.indexOf(unitValue ?? "") ==
                                                i
                                            ? false
                                            : true,
                                    backgroundColor:
                                        filtrItems?.indexOf(unitValue ?? "") ==
                                                i
                                            ? colors.customRed
                                            : colors.white,
                                    titleStyle: fonts.subtitle1.copyWith(
                                        fontSize: 14.sp,
                                        color: filtrItems?.indexOf(
                                                    unitValue ?? "") ==
                                                i
                                            ? colors.white
                                            : colors.customGreyC3),
                                    borderColor: colors.customGreyC3,
                                    borderWidth: 1.sp,
                                    horizontalPadding: 10.w,
                                    verticalPadding: 5.h,
                                  )
                              ])
                        : Text(
                            "($unitValue)",
                            style: fonts.subtitle1.copyWith(
                                fontSize: 15.sp,
                                color: colors.customBlack.withOpacity(0.5)),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

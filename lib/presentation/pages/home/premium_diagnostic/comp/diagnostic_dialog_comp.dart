import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_dropdown_menu_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class DiagnosticDialogComp extends StatefulWidget {
  const DiagnosticDialogComp({super.key, required this.isPremium});

  final bool isPremium;

  @override
  State<DiagnosticDialogComp> createState() => _DiagnosticDialogCompState();
}

class _DiagnosticDialogCompState extends State<DiagnosticDialogComp> {
  late String marka;

  DateTime? fromDate;
  DateTime? toDate;

  // late TextEditingController _dateController;
  late bool isDate;

  @override
  void initState() {
    marka = listMarka.first;
    isDate = false;
    fromDate = DateTime.now();
    toDate = DateTime.now();
    // _dateController =
    //     TextEditingController(text: DateFormat("MMM").format(DateTime.now()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AlertDialog(
        backgroundColor: colors.white,
        surfaceTintColor: colors.transparent,
        title: Text(
          widget.isPremium
              ? 'fill_for_premium_diagnostics'.tr()
              : "fill_out_the_form_to_sign_up_for_diagnostics".tr(),
          textAlign: TextAlign.center,
          style: Style.medium14(size: 18.sp),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          16.verticalSpace,
          const CustomDropDownMenuComp(list: listMarka),
          16.verticalSpace,
          const CustomDropDownMenuComp(list: listMarka),
          16.verticalSpace,
          const CustomDropDownMenuComp(list: listMarka),
          16.verticalSpace,
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              height: 42.h,
              decoration: ShapeDecoration(
                color: colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.w, color: colors.customGreyC3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  16.horizontalSpace,
                  Text(
                    'дд / мм / гггг',
                    style: Style.medium14(),
                  ),
                  const Spacer(),
                  icons.calendarIc.svg(color: colors.customGreyC3),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  title: "edit".tr(),
                  backgroundColor: colors.customGreyC3,
                  titleColor: colors.black,
                  verticalPadding: 10.h,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  title: "send".tr(),
                  backgroundColor: colors.primary,
                  titleColor: colors.white,
                  verticalPadding: 10.h,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Opacity(
            opacity: 0.5,
            child: Text(
              'our_specialists_will_call_you'.tr(),
              textAlign: TextAlign.center,
              style: Style.medium14(),
            ),
          )
        ]),
      );
    });
  }

  /// table calendar
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if (picked != null && picked != fromDate) {
      setState(() {});
    }
  }
}

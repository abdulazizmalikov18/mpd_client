import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerComponent {
  static void timePicker({
    required BuildContext context,
    required Function(String) onSaveButtonPressed,
  }) {
    if (Platform.isAndroid) {
      _androidTimePicker(
          context: context, onSaveButtonPressed: onSaveButtonPressed);
    } else {
      _iosTimePicker(
          context: context, onSaveButtonPressed: onSaveButtonPressed);
    }
  }

  static void _androidTimePicker({
    required BuildContext context,
    required Function(String) onSaveButtonPressed,
  }) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    await showTimePicker(
        context: context,
        confirmText: 'save'.tr(),
        cancelText: 'cancel'.tr(),
        initialTime: selectedTime,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? const SizedBox(),
          );
        }).then((pickedTime) {
      if (pickedTime != null && pickedTime != selectedTime) {
        final String result = pickedTime.format(context);
        onSaveButtonPressed(result);
      }
    });
  }

  static void _iosTimePicker({
    required BuildContext context,
    required Function(String) onSaveButtonPressed,
  }) {
    String date = '';

    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              color: Colors.white,
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSaveButtonPressed(date);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'save'.tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250.h,
                      child: CupertinoDatePicker(
                        // initialDateTime: controller.date,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        onDateTimeChanged: (newDate) {
                          date = newDate.toString().substring(11, 16);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

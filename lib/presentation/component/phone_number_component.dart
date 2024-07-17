import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class InternationalPhoneFormatter extends TextInputFormatter {
  String internationalPhoneFormat(String value) {
    final String nums = value.replaceAll(RegExp(r'[\D]'), '');
    final String internationalPhoneFormatted = nums.isNotEmpty
        //${nums.substring(0, nums.isNotEmpty ? 1 : null)}${nums.substring(1, nums.length >= 3 ? 3 : null)}
        ? nums.length <= 1
            ? '+998 $nums'
            : '+998${nums.length > 3 ? ' ' : ''}${nums.length > 3 ? nums.substring(3, nums.length >= 5 ? 5 : null) + (nums.length > 5 ? ' ${nums.substring(5, nums.length >= 8 ? 8 : null)}' : '') + (nums.length > 8 ? ' ${nums.substring(8, nums.length >= 10 ? 10 : null)}' : '') + (nums.length > 10 ? ' ${nums.substring(10, nums.length >= 12 ? 12 : null)}' : '') : ''}'
        : nums;
    return internationalPhoneFormatted;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    return newValue.copyWith(
        text: internationalPhoneFormat(text),
        selection: TextSelection.collapsed(
            offset: internationalPhoneFormat(text).length));
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 6;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, ' /');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class CurruncyInputFormatter extends TextInputFormatter {
  String numberDigetFormat(String value) {
    final oCcy = NumberFormat.decimalPatternDigits(locale: 'uz_UZ');
    final String nums =
        value.replaceAll(",", ".").replaceAll(RegExp(r'[^0-9.]'), '');

    final String numberFormatted =
        oCcy.format(num.tryParse(nums.split('.')[0]) ?? 0);
    return numberFormatted +
        (nums.split('.').length > 1 ? '.${nums.split('.')[1]}' : '');
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    return newValue.copyWith(
        text: numberDigetFormat(text),
        selection:
            TextSelection.collapsed(offset: numberDigetFormat(text).length));
  }
}

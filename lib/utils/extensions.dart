import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension EnumToString on Enum {
  String getName() {
    return toString().split('.')[1];
  }
}

extension StringCasingExtension on String {
  String toCapitalized() {
    if (isNotEmpty) {
      return '${this[0].toUpperCase()}${substring(1, length)}';
    } else {
      return this;
    }
  }

  String cleanNumbers() {
    var s = "";
    for (int i = 0; i < length; i++) {
      if (!RegExp(r'^[0-9]').hasMatch(this[i])) {
        s += this[i];
      }
    }
    return s;
  }
}

extension TextAnimation on Text {
  Widget animateText() {
    return Animate(
      effects: [
        const FadeEffect(),
        SlideEffect(duration: 0.6.seconds),
        FadeEffect(
          begin: 0.0,
          end: 1.0,
          duration: 0.5.seconds,
        )
      ],
      child: this,
      // .animate().fade().slideX(duration: 0.5.seconds)
    );
  }
}

//remove spaces
String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAll(" ", '');
}

// add spaces
String formatPhoneNumberAddSpaces(String phoneNumber) {
  String separatedNumber = phoneNumber.replaceFirstMapped(
      RegExp(r'^(\+\d{3})(\d{2})(\d{3})(\d{2})(\d{2})$'),
      (match) =>
          '${match.group(1)} ${match.group(2)} ${match.group(3)} ${match.group(4)} ${match.group(5)}');
  return separatedNumber;
}

String? priceValue(String? value, {bool isStart = true}) {
  if (value == null || value.isEmpty) {
    return null;
  } else {
    List<String> parts = value.replaceAll(RegExp(r"\s+"), "").split("-");

    return isStart ? parts[0].trim() : parts[1].trim();
  }
}

String? mileageValue(String? value, {bool isStart = true}) {
  if (value == null || value.isEmpty) {
    return null;
  } else {
    List<String> parts = value.split("-");
    return isStart
        ? parts[0].trim().split(" ")[0]
        : parts[1].trim().split(" ")[0];
  }
}

String? yearValue(String? value, {bool isStart = true}) {
  if (value == null || value.isEmpty) {
    return null;
  } else {
    if (value.contains("-")) {
      List<String> parts = value.split("-");
      return isStart
          ? parts[0].trim().split("/")[0].trim()
          : parts[1].trim().split("/")[0].trim();
    } else {
      return value.trim().split("/")[0].trim();
    }
  }
}

Color colorValue(String? value) {
  if (value == null || value.isEmpty) {
    return Colors.transparent;
  } else {
    int colorValue = int.parse("0xFF${value.replaceAll('#', '')}");
    return Color(colorValue);
  }
}

String dateFormatValue(String? value) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      String date = "";
      int day = dateTime.difference(DateTime.now()).inDays;
      dateTime = dateTime.toLocal();
      if (day == 0) {
        date = "${"today".tr()} ${DateFormat("HH:mm").format(dateTime)}";
      } else if (day == -11) {
        date = "${"yesterday".tr()} ${DateFormat("HH:mm").format(dateTime)}";
      } else {
        date = DateFormat("dd.MM.yyyy HH:mm").format(dateTime);
      }
      return date;
    }
  }
}

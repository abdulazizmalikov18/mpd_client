import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class Utils {
  static String commentDateFormat(DateTime date, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    final formattedDate = DateFormat('d MMM yyyy', locale).format(date);
    return formattedDate;
  }

  static String appointMentDateFormat(String dateTime, BuildContext context) {
    final date = DateTime.parse(dateTime).toLocal();
    String? formattedDate;
    final inDayDifference = DateTime.now().difference(date).inDays;
    if (inDayDifference == 0) {
      formattedDate = 'Today';
    } else if (inDayDifference == 1) {
      formattedDate = 'Tomorrow';
    } else if (inDayDifference == -1) {
      formattedDate = 'Yesterday';
    } else {
      formattedDate = commentDateFormat(date, context);
    }
    final formattedTime = DateFormat.Hm().format(date);
    return '$formattedDate at $formattedTime';
  }

  static String formatDateTime(DateTime dateTime) {
    final formatted = DateFormat("dd-MM-yyyy").format(dateTime);
    return formatted.replaceAll('-', '.');
  }

  static String priceFormat(double? price) {
    if (price == null) return 'Free';
    final formatted = NumberFormat.simpleCurrency(locale: 'uz').format(price).split(',').first;
    return formatted;
  }

  static String dateReviewFormat(DateTime dateTime, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return DateFormat.MMMMd(locale).format(dateTime);
  }

  static String shortMonthName(DateTime dateTime, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return DateFormat.LLL(locale).format(dateTime);
  }

  static String dateCheckByNow(DateTime dateTime, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

    if (dateTime.day == DateTime.now().day) {
      return 'T';
    } else if (dateTime.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return 'Tomorrow';
    } else {
      return DateFormat.EEEE(locale).format(dateTime).capitalize();
    }
  }

  static String errorFormat(String error) {
    final formated = error.replaceAll('[', '').replaceAll(']', '').replaceAll('\'', '');
    return formated;
  }

  static DateTime toDateTimeFormat(DateTime date, String time) {
    final hour = int.tryParse(time.split('-').first.split(':').first);
    final minute = int.tryParse(time.split('-').first.split(':').last);

    final datetime = DateTime(date.year, date.month, date.day, hour!, minute!);
    return datetime;
  }

  static String timeFormat(DateTime time) {
    final formatted = time.toString().split(' ').last.substring(0, 5);
    return formatted;
  }

  static String todayTimeFormat(String time) {
    return time.substring(0, 5);
  }

  static String weekDayFormat(DateTime datetime) {
    final DateFormat format = DateFormat('yyyy-MM-dd');
    return format.format(datetime).toLowerCase();
  }

  static String currencyFormat(String? currency) {
    if (currency == null) return '';

    return currency.toUpperCase();
  }

  // static String weekDayFormatObrevation(String dayObrevation) {
  //   final fullWeekDayString =
  //       Constants.weekDays.where((element) => element.toLowerCase().startsWith(dayObrevation)).first;
  //   return fullWeekDayString;
  // }

  static String formatPostDate(DateTime dateTime, BuildContext context) {
    if (DateTime.now().difference(dateTime).inSeconds == 0 || DateTime.now().difference(dateTime).inSeconds == 1) {
      return context.l10n.lenth_now_ago;
    } else if (DateTime.now().difference(dateTime).inSeconds < 60) {
      return context.l10n.lenth_now_ago;
    } else if (DateTime.now().difference(dateTime).inMinutes < 60) {
      return '${(DateTime.now().difference(dateTime).inMinutes)} ${context.l10n.lenth_minutes_ago}';
    } else if (DateTime.now().difference(dateTime).inHours < 24) {
      return '${(DateTime.now().difference(dateTime).inHours)} ${context.l10n.lenth_hours_ago}';
    } else if (DateTime.now().difference(dateTime).inDays < 30) {
      return '${DateTime.now().difference(dateTime).inDays} ${context.l10n.lenth_days_ago}';
    } else if (DateTime.now().difference(dateTime).inDays > 365) {
      return '${(DateTime.now().difference(dateTime).inDays / 365).round()} ${context.l10n.lenth_years_ago}';
    } else if (DateTime.now().difference(dateTime).inDays > 30) {
      return '${(DateTime.now().difference(dateTime).inDays / 30).round()} ${context.l10n.lenth_months_ago}';
    } else if (DateTime.now().difference(dateTime).inDays == 30 || DateTime.now().difference(dateTime).inDays == 31) {
      return context.l10n.lenth_month_ago;
    } else if (DateTime.now().difference(dateTime).inDays == 1) {
      return context.l10n.lenth_day_ago;
    } else if (DateTime.now().difference(dateTime).inDays > 365) {
      return context.l10n.lenth_year_ago;
    }
    return '';
  }
}

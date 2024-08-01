import 'package:flutter/cupertino.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class AppoinmentInfo {
  DrCardInfo? drCardInfo;

  Color? color;
  String? status;
  String? statusIcon;
  AppoinmentInfo({this.drCardInfo, this.color, this.status, this.statusIcon});

  static List<AppoinmentInfo> infos(BuildContext context) => [
        AppoinmentInfo(statusIcon: AppIcons.clock, drCardInfo: DrCardInfo.pending, status: 'Pending', color: orange),
        AppoinmentInfo(statusIcon: AppIcons.circleTick, drCardInfo: DrCardInfo.completed, status: 'Completed', color: green),
        AppoinmentInfo(statusIcon: AppIcons.circleCancel, drCardInfo: DrCardInfo.cancelled, status: 'Canceled', color: gradientRed),
        AppoinmentInfo(statusIcon: AppIcons.circleCancel, drCardInfo: DrCardInfo.following, status: 'Nothing', color: gradientRed),
      ];
}

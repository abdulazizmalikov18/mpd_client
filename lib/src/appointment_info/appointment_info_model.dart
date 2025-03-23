import 'package:flutter/cupertino.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';

class AppoinmentInfo {
  DrCardInfo? drCardInfo;

  Color? color;
  String? status;
  String? statusIcon;
  AppoinmentInfo({this.drCardInfo, this.color, this.status, this.statusIcon});

  static List<AppoinmentInfo> infos(BuildContext context) => [
    AppoinmentInfo(
        statusIcon: AppIcons.clock, drCardInfo: DrCardInfo.pending, status: 'Pending', color: context.color.orange),
    AppoinmentInfo(
        statusIcon: AppIcons.circleTick, drCardInfo: DrCardInfo.completed, status: 'Completed', color: context.color.green),
    AppoinmentInfo(
        statusIcon: AppIcons.circleCancel,
        drCardInfo: DrCardInfo.cancelled,
        status: 'Canceled',
        color: context.color.gradientRed),
    AppoinmentInfo(
        statusIcon: AppIcons.circleCancel,
        drCardInfo: DrCardInfo.following,
        status: 'Nothing',
        color: context.color.gradientRed),
  ];
}

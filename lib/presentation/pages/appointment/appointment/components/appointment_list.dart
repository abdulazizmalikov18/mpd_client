import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/appointment_arg_model.dart';
import 'package:mpd_client/domain/models/appointment/appointment_info_models.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/loading_platform.dart';
import 'package:mpd_client/utils/appointment_tools.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/ui_tools.dart';
import 'appointment_bottom_info.dart';
import 'appointment_item.dart';

class AppointmentList extends StatelessWidget {
  final int infoIndex;
  final List<Appointment> appointments;

  final ScrollController scrollController;
  final VoidCallback scrollEndFunction;
  final bool hasReachedMax;
  final Future<void> Function() onRefresh;

  const AppointmentList({
    super.key,
    required this.onRefresh,
    required this.hasReachedMax,
    required this.scrollEndFunction,
    required this.scrollController,
    required this.infoIndex,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    List<AppoinmentInfo> infos = [
      AppoinmentInfo(
        statusIcon: AppIcons.clock,
        drCardInfo: DrCardInfo.pending,
        status: context.l10n.appointment_upcoming,
        color: orange,
      ),
      AppoinmentInfo(
        statusIcon: AppIcons.circleTick,
        drCardInfo: DrCardInfo.completed,
        status: context.l10n.appointment_complited,
        color: green,
      ),
      AppoinmentInfo(
        statusIcon: AppIcons.circleCancel,
        drCardInfo: DrCardInfo.cancelled,
        status: context.l10n.appointment_canceled,
        color: gradientRed,
      ),
    ];
    return RefreshIndicator(
      onRefresh: onRefresh,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: NotificationListener(
        onNotification: _handleScrollNotification,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          controller: scrollController,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: hasReachedMax ? appointments.length : appointments.length + 1,
          itemBuilder: (context, index) {
            if (index >= appointments.length) {
              return const Center(child: LoadingPlatform());
            }
            final appointment = appointments[index];
            return AppointmentItem(
              specialist: SpecialistInfoModel(
                appointmentName: appointment.name,
                avatar: appointment.currentWorkState?.specialist.avatar ?? appointment.responsible?.avatar,
                fullname: appointment.currentWorkState != null
                    ? '${appointment.currentWorkState?.specialist.name ?? '-'} ${appointment.currentWorkState?.specialist.lastname ?? '-'}'
                    : '${appointment.responsible?.name ?? '-'} ${appointment.responsible?.lastname ?? '-'}',
                job: appointment.currentWorkState?.specialist.job ?? appointment.responsible?.job,
                id: appointment.currentWorkState?.specialist.id ?? appointment.responsible?.id ?? 0,
              ),
              appoinmentInfo: infos[infoIndex],
              bottomInfo: getBottomWidget(appointments[index], infos, context),
            );
          },
        ),
      ),
    );
  }

  Widget getBottomWidget(Appointment appointment, List<AppoinmentInfo> infos, BuildContext context) {
    switch (infos[infoIndex].drCardInfo) {
      case DrCardInfo.pending:
        return AppointmentBottomInfo(
          isPending: true,
          meetDate: appointment.meetDate ?? "",
          onDetailPressed: () {
            context.pushNamed(AppRouteNames.appointment, extra: {
              'appoinmentInfo': infos[infoIndex],
              'appointment': appointment,
            });
            // FIXME: PushTo Navigatge
            // Navigator.pushNamed(
            //   context,
            //   AppRoutes.appointment,
            //   arguments: AppointmentArgModel(appoinmentInfo: , ),
            // );
          },
          onLocationPressed: () => UiTools.openMapsSheet(
            context,
            appointment.responsible?.job ?? "--",
            Coords(
              appointment.responsible?.location?.latitude ?? 41.311015,
              appointment.responsible?.location?.longitude ?? 69.279760,
            ),
          ),
        );
      case DrCardInfo.completed:
        return AppointmentBottomInfo(
          price: appointment.cost!,
          meetDate: appointment.meetDate ?? "",
          onDetailPressed: () {
            context.pushNamed(AppRouteNames.appointment, extra: {
              'appoinmentInfo': infos[infoIndex],
              'appointment': appointment,
            });
            // // FIXME: PushTo Navigate
            //   Navigator.pushNamed(
            //   context,
            //   AppRoutes.appointment,
            //   arguments: AppointmentArgModel(),
            // );
          },
          onLocationPressed: () => UiTools.openMapsSheet(
            context,
            appointment.responsible?.job ?? "--",
            Coords(
              appointment.responsible?.location?.latitude ?? 41.311015,
              appointment.responsible?.location?.longitude ?? 69.279760,
            ),
          ),
        );
      default:
        return AppointmentBottomInfo(
          price: appointment.cost!,
          meetDate: appointment.meetDate ?? "",
          onDetailPressed: () {
            context.pushNamed(
              AppRouteNames.appointment,
              extra: {
                'appoinmentInfo': infos[infoIndex],
                'appointment': appointment,
              },
            );
            // FIXME: Push To Navigate
            // Navigator.pushNamed(
            //   context,
            //   AppRoutes.appointment,
            //   arguments: AppointmentArgModel(appoinmentInfo: infos[infoIndex], appointment: appointment),
            // );
          },
          onLocationPressed: () => UiTools.openMapsSheet(
            context,
            appointment.responsible?.job ?? "--",
            Coords(
              appointment.responsible?.location?.latitude ?? 41.311015,
              appointment.responsible?.location?.longitude ?? 69.279760,
            ),
          ),
        );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && scrollController.position.extentAfter == 0) {
      scrollEndFunction();
    }
    return false;
  }
}

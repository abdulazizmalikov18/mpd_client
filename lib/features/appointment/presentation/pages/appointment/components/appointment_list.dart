import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/presentation/paginator_list.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/features/user/data/models/specialist_info_model.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/appointment_info/appointment_info_model.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import '../../../../data/models/appointment_arg_model.dart';
import 'appointment_bottom_info.dart';
import 'appointment_item.dart';

class AppointmentList extends StatelessWidget {
  final int infoIndex;
  final List<Appointment> appointments;

  final VoidCallback scrollEndFunction;
  final bool hasReachedMax;
  final Future<void> Function() onRefresh;
  final FormzSubmissionStatus paginatorStatus;

  const AppointmentList({
    super.key,
    required this.onRefresh,
    required this.hasReachedMax,
    required this.scrollEndFunction,
    required this.infoIndex,
    required this.appointments,
    required this.paginatorStatus,
  });

  @override
  Widget build(BuildContext context) {
    List<AppoinmentInfo> infos = [
      AppoinmentInfo(
        statusIcon: AppIcons.clock,
        drCardInfo: DrCardInfo.pending,
        status: context.l10n.appointment_upcoming,
        color: context.color.orange,
      ),
      AppoinmentInfo(
        statusIcon: AppIcons.circleTick,
        drCardInfo: DrCardInfo.completed,
        status: context.l10n.appointment_complited,
        color: context.color.green,
      ),
      AppoinmentInfo(
        statusIcon: AppIcons.circleCancel,
        drCardInfo: DrCardInfo.cancelled,
        status: context.l10n.appointment_canceled,
        color: context.color.gradientRed,
      ),
    ];
    return RefreshIndicator(
      onRefresh: onRefresh,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: PaginatorList(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentItem(
            specialist: SpecialistInfoModel(
              appointmentName: appointment.name,
              username: appointment.responsible?.username,
              phone: '',
              avatar:
                  appointment.currentWorkState?.specialist.avatar ??
                  appointment.responsible?.avatar,
              fullname: appointment.currentWorkState != null
                  ? '${appointment.currentWorkState?.specialist.name ?? '-'} ${appointment.currentWorkState?.specialist.lastname ?? '-'}'
                  : '${appointment.responsible?.name ?? '-'} ${appointment.responsible?.lastname ?? '-'}',
              job:
                  appointment.currentWorkState?.specialist.job ??
                  appointment.responsible?.job,
              id:
                  appointment.currentWorkState?.specialist.id ??
                  appointment.responsible?.id ??
                  0,
            ),
            appoinmentInfo: infos[infoIndex],
            bottomInfo: getBottomWidget(appointments[index], infos, context),
          );
        },
        paginatorStatus: paginatorStatus,
        fetchMoreFunction: () {
          scrollEndFunction();
        },
        hasMoreToFetch: hasReachedMax,
      ),
    );
  }

  Widget getBottomWidget(
    Appointment appointment,
    List<AppoinmentInfo> infos,
    BuildContext context,
  ) {
    switch (infos[infoIndex].drCardInfo) {
      case DrCardInfo.pending:
        return AppointmentBottomInfo(
          isPending: true,
          meetDate: appointment.meetDate ?? "",
          onDetailPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.appointment,
            arguments: AppointmentArgModel(
              appoinmentInfo: infos[infoIndex],
              appointment: appointment,
            ),
          ),
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
          onDetailPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.appointment,
            arguments: AppointmentArgModel(
              appoinmentInfo: infos[infoIndex],
              appointment: appointment,
            ),
          ),
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
          onDetailPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.appointment,
            arguments: AppointmentArgModel(
              appoinmentInfo: infos[infoIndex],
              appointment: appointment,
            ),
          ),
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
}

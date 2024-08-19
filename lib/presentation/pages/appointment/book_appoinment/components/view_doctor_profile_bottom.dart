import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class ViewDoctorProfileBottom extends StatelessWidget {
  const ViewDoctorProfileBottom({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {
          context.pushNamed(AppRouteNames.drProfilebyid, extra: {
            'specialist' : SpecialistInfoModel(
              id: appointment.currentWorkState?.specialist.id ?? 0,
              username: appointment.currentWorkState?.specialist.username ?? "",
              job: appointment.currentWorkState?.specialist.job,
              fullname: '${appointment.currentWorkState?.specialist.name ?? "__"} ${appointment.currentWorkState?.specialist.lastname ?? "__"}',
              avatar: appointment.currentWorkState?.specialist.avatar,
            )
          });
         
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              context.l10n.appointment_view_doctor_profile,
              style: Styles.headline7.copyWith(color: mainBlue, fontSize: 14),
            ),
            AppIcons.forward.svg(
              height: 18,
              width: 18,
              color:  mainBlue,
            ),
          ],
        ),
      ),
    );
  }
}

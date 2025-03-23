import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_info_model.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

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
        onPressed: () => Navigator.pushNamed(
          context,
          AppRoutes.drProfilebyid,
          arguments: SpecialistInfoModel(
            phone: "",
            id: appointment.responsible?.id ?? 0,
            username: appointment.responsible!.username,
            job: appointment.responsible?.job,
            fullname:
                '${appointment.responsible!.name} ${appointment.responsible!.lastname}',
            avatar: appointment.responsible?.avatar,
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              context.l10n.appointment_view_doctor_profile,
              style: Styles.headline7
                  .copyWith(color: context.color.mainBlue, fontSize: 14.sp),
            ),
            SvgPicture.asset(
              AppIcons.forward,
              colorFilter:
                  ColorFilter.mode(context.color.mainBlue, BlendMode.srcIn),
              height: 18.h,
              width: 18.h,
            )
          ],
        ),
      ),
    );
  }
}

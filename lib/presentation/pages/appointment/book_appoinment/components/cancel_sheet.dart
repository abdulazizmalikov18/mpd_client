import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpd_client/application/appointment/cancel_appointment/cancel_appointment_bloc.dart';
import 'package:mpd_client/application/appointment/upcoming_appointment/upcoming_appoinment_bloc.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/presentation/pages/appointment/book_appoinment/book_appoinment.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/loading_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/my_custom_radiotile.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/transparent_long_button.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/ui_tools.dart';

class CancelSheet extends StatefulWidget {
  final Appointment appointment;

  const CancelSheet({super.key, required this.appointment});

  @override
  State<CancelSheet> createState() => _CancelSheetState();
}

class _CancelSheetState extends State<CancelSheet> {
  var cancelInfo = CancelInfo.changeMyMind;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(children: [
      const SizedBox(height: 32),
      Center(
        child: Text(
          context.l10n.cancel_appointment,
          style: Styles.boldTitle.copyWith(color: black, fontSize: 24, fontFamily: Styles.gilroyMedium),
        ),
      ),
      const SizedBox(height: 12),
      Text(
        context.l10n.cancel_appointment_are_you_sure,
        textAlign: TextAlign.center,
        style: Styles.descSubtitle.copyWith(color: grey),
      ),
      const SizedBox(height: 12),
      Text(
        context.l10n.cancel_appointment_desctiption,
        style: Styles.expTitle.copyWith(color: black),
      ),
      ScreenUtil().setVerticalSpacing(16.h),
      StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            MyCustomRadioTile(
                text: context.l10n.cancel_appointment_change_my_mind,
                value: CancelInfo.changeMyMind,
                onChanged: (value) {
                  setState(() {
                    cancelInfo = value;
                  });
                },
                groupValue: cancelInfo),
            MyCustomRadioTile(
                text: context.l10n.cancel_appointment_wrong_doctor,
                value: CancelInfo.bookingTheWrong,
                onChanged: (value) {
                  setState(() {
                    cancelInfo = value;
                  });
                },
                groupValue: cancelInfo)
          ],
        );
      }),
      const SizedBox(height: 20),
      BlocListener<CancelAppointmentBloc, CancelAppointmentState>(
        listener: (context, state) {
          if (state is CancelAppointmentLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const CupertinoActivityIndicator(),
            );
          } else if (state is CancelAppointmentSuccess) {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 200)).then((value) => Navigator.pop(context));
            Future.delayed(const Duration(milliseconds: 200)).then((value) => Navigator.pop(context));
            context.read<UpcomingAppoinmentsBloc>().add(DeleteUpcomingAppointment(widget.appointment));
          } else {
            Navigator.pop(context);
            fToast.showToast(
              child: UiTools.toast(title: (state as CancelAppointmentFailure).failure, context: context),
              gravity: ToastGravity.TOP,
              toastDuration: const Duration(seconds: 2),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: LongButton(
              gradient: gradientRed,
              gradientOpacity: gradientRedOpacity,
              buttonName: context.l10n.cancel_appointment_confirm,
              onPress: () {
                context.read<CancelAppointmentBloc>().add(CancelPressedEvent(productid: widget.appointment.id.toString(), cancelInfo: cancelInformation));
              }),
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TransparentLongButton(buttonName: context.l10n.cancel_appointment_not_want, onPress: () => Navigator.pop(context)),
      ),
      const SizedBox(height: 32),
    ]);
  }

  String get cancelInformation {
    switch (cancelInfo) {
      case CancelInfo.changeMyMind:
        return 'Change my mind';
      case CancelInfo.bookingTheWrong:
        return 'Booking the wrong doctor';
      default:
        return 'Unknown cause';
    }
  }
}

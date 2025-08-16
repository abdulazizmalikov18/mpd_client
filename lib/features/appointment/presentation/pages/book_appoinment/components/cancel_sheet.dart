import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';
import 'package:mpd_client/features/appointment/domain/blocs/cancel_appointment/cancel_appointment_bloc.dart';
import 'package:mpd_client/features/appointment/domain/blocs/appointment/appoinment_bloc.dart';
import 'package:mpd_client/features/appointment/presentation/pages/book_appoinment/book_appoinment.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/my_custom_radiotile.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
// import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/transparent_long_button.dart';

class CancelSheet extends StatefulWidget {
  final Appointment appointment;

  const CancelSheet({super.key, required this.appointment});

  @override
  State<CancelSheet> createState() => _CancelSheetState();
}

class _CancelSheetState extends State<CancelSheet> {
  var cancelInfo = CancelInfo.changeMyMind;
  // late FToast fToast;

  @override
  void initState() {
    super.initState();
    // fToast = FToast();
    // fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      children: [
        ScreenUtil().setVerticalSpacing(32.h),
        Center(
          child: Text(
            context.l10n.cancel_appointment,
            style: Styles.boldTitle.copyWith(
              color: context.color.black,
              fontSize: 24,
              fontFamily: Styles.gilroyMedium,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Text(
          context.l10n.cancel_appointment_are_you_sure,
          textAlign: TextAlign.center,
          style: Styles.descSubtitle.copyWith(color: context.color.grey),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Text(
          context.l10n.cancel_appointment_desctiption,
          style: Styles.expTitle.copyWith(color: context.color.black),
        ),
        ScreenUtil().setVerticalSpacing(16.h),
        StatefulBuilder(
          builder: (context, setState) {
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
                  groupValue: cancelInfo,
                ),
                MyCustomRadioTile(
                  text: context.l10n.cancel_appointment_wrong_doctor,
                  value: CancelInfo.bookingTheWrong,
                  onChanged: (value) {
                    setState(() {
                      cancelInfo = value;
                    });
                  },
                  groupValue: cancelInfo,
                ),
              ],
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        BlocListener<CancelAppointmentBloc, CancelAppointmentState>(
          listener: (context, state) {
            if (state is CancelAppointmentLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialogWidget(),
              );
            } else if (state is CancelAppointmentSuccess) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
              context.read<AppoinmentsBloc>().add(
                DeleteAppointment(widget.appointment),
              );
            } else {
              Navigator.pop(context);
              // fToast.showToast(
              //   child: UiTools.toast(
              //       title: (state as CancelAppointmentFailure).failure,
              //       context: context),
              //   gravity: ToastGravity.TOP,
              //   toastDuration: const Duration(seconds: 2),
              // );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: LongButton(
              gradient: context.color.gradientRed,
              gradientOpacity: context.color.gradientRedOpacity,
              buttonName: context.l10n.cancel_appointment_confirm,
              onPress: () {
                context.read<CancelAppointmentBloc>().add(
                  CancelPressedEvent(
                    productid: widget.appointment.id.toString(),
                    cancelInfo: cancelInformation,
                  ),
                );
              },
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TransparentLongButton(
            buttonName: context.l10n.cancel_appointment_not_want,
            onPress: () => Navigator.pop(context),
          ),
        ),
        ScreenUtil().setVerticalSpacing(32.h),
      ],
    );
  }

  String get cancelInformation {
    switch (cancelInfo) {
      case CancelInfo.changeMyMind:
        return 'Change my mind';
      case CancelInfo.bookingTheWrong:
        return 'Booking the wrong doctor';
    }
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/appointment_item.dart';
import 'package:mpd_client/features/appointment/presentation/pages/book_appoinment/components/view_doctor_profile_bottom.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/appoinment_payment.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/appointment_place_date.dart';
import 'package:mpd_client/features/home/data/models/local_service_model.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';
import 'package:mpd_client/src/widgets/transparent_long_button.dart';

import '../../widgets/appoinment_services.dart';
import 'components/cancel_sheet.dart';

enum CancelInfo { changeMyMind, bookingTheWrong }

class BookAppoinment extends StatelessWidget {
  final AppoinmentInfo appoinmentInfo;
  final Appointment appointment;
  const BookAppoinment({
    super.key,
    required this.appoinmentInfo,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final totalCost = Utils.priceFormat(appointment.cost! * appointment.qty!);
    return Scaffold(
      backgroundColor: context.color.background,
      appBar: AppBarWidget(title: context.l10n.appointment_appointment_list),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          children: [
            AppointmentItem(
              specialist: SpecialistInfoModel(
                phone: "",
                appointmentName: appointment.name,
                avatar:
                    appointment.currentWorkState?.specialist.avatar ??
                    appointment.responsible?.avatar,
                fullname: appointment.currentWorkState != null
                    ? '${appointment.currentWorkState?.specialist.name ?? "__"} ${appointment.currentWorkState?.specialist.lastname ?? "__"}'
                    : '${appointment.responsible?.name ?? "__"} ${appointment.responsible?.lastname ?? "__"}',
                job:
                    appointment.currentWorkState?.specialist.job ??
                    appointment.responsible?.job ??
                    "__",
                id:
                    appointment.currentWorkState?.specialist.id ??
                    appointment.responsible?.id ??
                    0,
              ),
              appoinmentInfo: appoinmentInfo,
              bottomInfo: ViewDoctorProfileBottom(appointment: appointment),
            ),
            AppointmentPlaceDate(
              onPress: () => UiTools.openMapsSheet(
                context,
                appointment.currentWorkState?.specialist.job ?? "--",
                Coords(
                  appointment.currentWorkState?.specialist.location?.latitude ??
                      41.311015,
                  appointment
                          .currentWorkState
                          ?.specialist
                          .location
                          ?.longitude ??
                      69.279760,
                ),
              ),
              placeName: "MPD",
              date: appointment.meetDate != null
                  ? Utils.dateFormat(appointment.meetDate!)
                  : "--",
              time: appointment.meetDate != null
                  ? Utils.clockFormat(appointment.meetDate!)
                  : "--",
            ),
            AppointmentService(
              localProducts: [
                LocalService(
                  id: appointment.id ?? 0,
                  price: appointment.cost ?? 0,
                  name: appointment.name ?? "",
                  image: appointment.image,
                  count: appointment.qty ?? 0,
                ),
              ],
              appointmentInfo: DrCardInfo.pending,
            ),
            AppointmentPaymentCard(
              paymentMethod: AppImages.cash,
              isCash: false,
              amount: '$totalCost UZS',
              discount: '${appointment.surcharge} UZS',
              total: '$totalCost UZS',
            ),
            ScreenUtil().setVerticalSpacing(90.h),
          ],
        ),
      ),
      bottomSheet: PinnedSheet(
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (appoinmentInfo.drCardInfo == DrCardInfo.pending)
              TransparentLongButton(
                width: double.maxFinite,
                onPress: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<CancelAppointmentBloc>(
                            context,
                            listen: false,
                          ),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<AppoinmentsBloc>(
                            context,
                            listen: false,
                          ),
                        ),
                      ],
                      child: CancelSheet(appointment: appointment),
                    ),
                  );
                },
                buttonName: context.l10n.appointment_cancel,
                borderColor: context.color.gradientRedOpacity,
                textColor: context.color.gradientRedOpacity,
              ),
            if (appoinmentInfo.drCardInfo != DrCardInfo.pending)
              Row(
                children: [
                  Expanded(
                    child: LongButton(
                      buttonName: context.l10n.appointment_book_again,
                      onPress: () {
                        controller.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.fastOutSlowIn,
                        );
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

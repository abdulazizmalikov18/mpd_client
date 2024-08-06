import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/appointment/cancel_appointment/cancel_appointment_bloc.dart';
import 'package:mpd_client/application/appointment/upcoming_appointment/upcoming_appoinment_bloc.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/appointment_info_models.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/components/appointment_item.dart';
import 'package:mpd_client/presentation/pages/appointment/book_appoinment/components/view_doctor_profile_bottom.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/appoinment_payment.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/appointment_place_date.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/transparent_long_button.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/appointment_tools.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/ui_tools.dart';
import 'package:mpd_client/utils/utils.dart';

import '../widgets/appoinment_services.dart';
import 'components/cancel_sheet.dart';

enum CancelInfo { changeMyMind, bookingTheWrong }

class BookAppoinment extends StatelessWidget {
  final AppoinmentInfo appoinmentInfo;
  final Appointment appointment;
  const BookAppoinment({super.key, required this.appoinmentInfo, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final totalCost = Utils.priceFormat(appointment.cost! * appointment.qty!);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBarWidget(title: context.l10n.appointment_appointment_list),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          children: [
            AppointmentItem(
              specialist: SpecialistInfoModel(
                appointmentName: appointment.name,
                avatar: appointment.currentWorkState?.specialist.avatar ?? appointment.responsible?.avatar,
                fullname: appointment.currentWorkState != null
                    ? '${appointment.currentWorkState?.specialist.name ?? "__"} ${appointment.currentWorkState?.specialist.lastname ?? "__"}'
                    : '${appointment.responsible?.name ?? "__"} ${appointment.responsible?.lastname ?? "__"}',
                job: appointment.currentWorkState?.specialist.job ?? appointment.responsible?.job ?? "__",
                id: appointment.currentWorkState?.specialist.id ?? appointment.responsible?.id ?? 0,
              ),
              appoinmentInfo: appoinmentInfo,
              bottomInfo: ViewDoctorProfileBottom(appointment: appointment),
            ),
            AppointmentPlaceDate(
              onPress: () => UiTools.openMapsSheet(
                context,
                appointment.currentWorkState?.specialist.job ?? "--",
                Coords(
                  appointment.currentWorkState?.specialist.location?.latitude ?? 41.311015,
                  appointment.currentWorkState?.specialist.location?.longitude ?? 69.279760,
                ),
              ),
              placeName: 'Medion Family hospital',
              date: 'Today, 13 Decemer, 2023',
              time: '15:00 - 17:00',
            ),
            AppointmentService(
              localProducts: [
                LocalService(
                  id: appointment.id ?? 0,
                  price: appointment.cost ?? 0,
                  name: appointment.name ?? "",
                  image: appointment.image,
                  count: appointment.qty ?? 0,
                )
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
            ScreenUtil().setVerticalSpacing(90.h)
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
                                value: BlocProvider.of<CancelAppointmentBloc>(context, listen: false),
                              ),
                              BlocProvider.value(value: BlocProvider.of<UpcomingAppoinmentsBloc>(context, listen: false))
                            ],
                            child: CancelSheet(appointment: appointment),
                          ));
                },
                buttonName: context.l10n.appointment_cancel,
                borderColor: gradientRedOpacity,
                textColor: gradientRedOpacity,
              ),
            if (appoinmentInfo.drCardInfo != DrCardInfo.pending)
              Row(
                children: [
                  Expanded(
                    child: LongButton(
                      buttonName: context.l10n.appointment_book_again,
                      onPress: () {
                        context.goNamed(AppRouteNames.doctor);
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

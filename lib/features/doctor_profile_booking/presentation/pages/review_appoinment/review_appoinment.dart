import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/appoinment_payment.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/appoinment_services.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/appointment_place_date.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/add_to_cart/add_to_cart_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/create_order/create_order_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/review_appoinment/components/review_dialog_body.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/review_appoinment/components/review_dr_card.dart';
import 'package:mpd_client/features/home/data/models/local_service_model.dart';
import 'package:mpd_client/features/main_page.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

class ReviewAppoinmentDetail extends StatelessWidget {
  final bool isOffering;
  final List<LocalService> localProducts;
  const ReviewAppoinmentDetail({
    super.key,
    this.isOffering = false,
    required this.localProducts,
  });

  @override
  Widget build(BuildContext context) {
    final time = context.select((TimetableBloc bloc) => bloc.state);

    double totalDoublePrice = 0;
    for (var product in localProducts) {
      totalDoublePrice += product.price * product.count;
    }
    final totalPrice = Utils.priceFormat(totalDoublePrice);
    final doctorProfile = context.select(
      (DoctorProfileBloc bloc) => bloc.state.doctor,
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(context.l10n.book_doctor_reviews_appointment_detail),
      ),
      backgroundColor: context.color.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(12.h),
            isOffering
                ? const SizedBox()
                : ReviewCard(localProducts: localProducts),
            AppointmentPlaceDate(
              onPress: () {
                UiTools.openMapsSheet(
                  context,
                  doctorProfile!.job.name,
                  Coords(
                    doctorProfile.location?.latitude ?? 41.311015,
                    doctorProfile.location?.longitude ?? 69.279760,
                  ),
                );
              },
              placeName: 'Shox Med Center',
              date:
                  '${Utils.dateCheckByNow(time.datetime!, context)}, ${Utils.dateReviewFormat(time.datetime!, context)}, ${time.datetime!.year}',
              time: time.selectedTime,
            ),
            AppointmentService(
              localProducts: localProducts,
              appointmentInfo: DrCardInfo.pending,
            ),
            AppointmentPaymentCard(
              isCash: true,
              paymentMethod: AppImages.cash,
              amount: '$totalPrice UZS',
              discount: '0 UZS',
              total: '$totalPrice UZS',
            ),
            ScreenUtil().setVerticalSpacing(90.h),
          ],
        ),
      ),
      bottomSheet: PinnedSheet(
        widget: BlocListener<CreateOrderBloc, CreateOrderState>(
          listener: (context, state) {
            if (state is CreateOrderLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialogWidget(),
              );
            } else if (state is CreateOrderSuccess) {
              Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => _buildWaitingApproveDialog(context, time),
              );
            } else {
              Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => _buildCanceledDialog(context),
              );
            }
          },
          child: LongButton(
            buttonName: context.l10n.book_doctor_book,
            onPress: () => orderCallBack(context),
          ),
        ),
      ),
    );
  }

  void orderCallBack(BuildContext context) {
    final carts = context.read<AddToCartBloc>().state.carts;
    if (carts.isEmpty || isOffering) {
      List<Map<String, dynamic>> carts = [];
      for (var element in localProducts) {
        carts.add({"product": element.id, "qty": element.count});
      }
      context.read<CreateOrderBloc>().add(
        CreateOrderProcess(carts: carts, payment: 1, action: 'save'),
      );
    } else {
      context.read<CreateOrderBloc>().add(
        CreateOrderProcess(carts: carts, payment: 1, action: 'save'),
      );
    }
  }

  Dialog _buildWaitingApproveDialog(BuildContext context, TimetableState time) {
    return Dialog(
      backgroundColor: context.color.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ReviewDialogBody(
        icon: AppIcons.circleCheckBig,
        title: "Success",
        subtitle:
            "Your appointment has been successfully booked for ${Utils.formatDateTime(time.datetime ?? DateTime.now())} at ${time.selectedTime}",
        firstButtonName: "Okey",
        secondButtonName:
            context.l10n.book_doctor_reviews_success_second_button,
        firstButtonPressed: () {
          controller.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        secondButtonPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }

  Dialog _buildCanceledDialog(BuildContext context) {
    return Dialog(
      backgroundColor: context.color.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ReviewDialogBody(
        isError: true,
        icon: AppIcons.clipboardCancel,
        title: context.l10n.book_doctor_reviews_cancel_title,
        subtitle: context.l10n.book_doctor_reviews_cancel_subtitle,
        firstButtonName: context.l10n.book_doctor_reviews_cancel_first_button,
        secondButtonName: context.l10n.book_doctor_reviews_cancel_second_button,
        firstButtonPressed: () {
          Navigator.pop(context);
          orderCallBack(context);
        },
        secondButtonPressed: () {
          controller.animateToPage(
            1,
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}

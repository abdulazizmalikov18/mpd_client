import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/doctor_booking/add_to_cart/add_to_cart_bloc.dart';
import 'package:mpd_client/application/doctor_booking/create_order/create_order_bloc.dart';
import 'package:mpd_client/application/doctor_booking/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/application/doctor_booking/timetable_bloc/timetable_bloc.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/appoinment_payment.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/appoinment_services.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/appointment_place_date.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/loading_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/review_appoinment/components/review_dialog_body.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/review_appoinment/components/review_dr_card.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/appointment_tools.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/ui_tools.dart';
import 'package:mpd_client/utils/utils.dart';

class ReviewAppoinmentDetail extends StatelessWidget {
  final List<LocalService> localProducts;
  const ReviewAppoinmentDetail({
    super.key,
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
    final doctorProfile = context.select((DoctorProfileBloc bloc) => bloc.state.doctor);

    return Scaffold(
      appBar: AppBarWidget(title: context.l10n.book_doctor_reviews_appointment_detail),
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(12.h),
            ReviewCard(localProducts: localProducts),
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
              date: '${Utils.dateCheckByNow(time.datetime!, context)}, ${Utils.dateReviewFormat(time.datetime!, context)}, ${time.datetime!.year}',
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
            ScreenUtil().setVerticalSpacing(90.h)
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
                builder: (_) => _buildWaitingApproveDialog(context),
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
    context.read<CreateOrderBloc>().add(CreateOrderProcess(carts: carts, payment: 1, action: 'save'));
  }

  Dialog _buildWaitingApproveDialog(BuildContext context) {
    return Dialog(
      backgroundColor: white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ReviewDialogBody(
        icon: AppIcons.timer,
        title: context.l10n.book_doctor_reviews_success_title,
        subtitle: context.l10n.book_doctor_reviews_success_subtitle,
        firstButtonName: context.l10n.book_doctor_reviews_success_first_button,
        secondButtonName: context.l10n.book_doctor_reviews_success_second_button,
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
      backgroundColor: white,
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

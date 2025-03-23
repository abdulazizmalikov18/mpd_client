import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/appointment_payment/components/payment_radio_tile.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/appointment_payment/components/select_card_sheet.dart';
import 'package:mpd_client/features/home/presentation/widgets/build_label.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

class AppoinmentPayment extends StatelessWidget {
  const AppoinmentPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: BlocSelector<MyCardsBloc, MyCardsState, PaymentMethod>(
        selector: (state) => state.paymentMethod,
        builder: (context, payment) {
          return Column(
            children: [
              ScreenUtil().setVerticalSpacing(12.h),
              const BuildLabel(label: 'Select payment method'),
              ScreenUtil().setVerticalSpacing(16.h),
              MyPaymentRadioTile(
                  extraText: 'Pay with add card',
                  value: PaymentMethod.paymeCard,
                  onChanged: (value) {
                    context.read<MyCardsBloc>().add(SelectPaymentType(value));
                  },
                  groupValue: payment,
                  imagePath: AppImages.payMe),
              ScreenUtil().setVerticalSpacing(12.h),
              MyPaymentRadioTile(
                  extraText: 'Pay in app',
                  value: PaymentMethod.paymeApp,
                  onChanged: (value) {
                    context.read<MyCardsBloc>().add(SelectPaymentType(value));
                  },
                  groupValue: payment,
                  imagePath: AppImages.payMe),
              ScreenUtil().setVerticalSpacing(12.h),
              MyPaymentRadioTile(
                  text: 'Cash',
                  value: PaymentMethod.cash,
                  onChanged: (value) {
                    context.read<MyCardsBloc>().add(SelectPaymentType(value));
                  },
                  groupValue: payment,
                  imagePath: AppImages.cash),
            ],
          );
        },
      )),
      appBar: const AppBarWidget(title: 'Payment'),
      bottomSheet: PinnedSheet(
        widget: BlocSelector<MyCardsBloc, MyCardsState, PaymentMethod>(
          selector: (state) => state.paymentMethod,
          builder: (context, payment) {
            return LongButton(
              buttonName: 'Next',
              onPress: () {
                if (payment == PaymentMethod.paymeCard) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<MyCardsBloc>(context),
                      child: const SelectCardSheet(),
                    ),
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.appointmentReview,
                    // arguments: widget.localProducts,
                  );
                }
                // Navigator.of(context).pushNamed(AppRoutes.appointmentReview);
              },
            );
          },
        ),
      ),
    );
  }
}

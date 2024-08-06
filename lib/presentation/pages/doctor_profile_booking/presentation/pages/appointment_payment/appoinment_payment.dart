// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mpd_client/application/doctor_booking/my_cards_bloc/my_cards_bloc.dart';
// import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
// import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
// import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_payment/components/payment_radio_tile.dart';
// import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_payment/components/select_card_sheet.dart';
// import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/w_build_label.dart';
// import 'package:mpd_client/presentation/styles/app_images.dart';
// import 'package:mpd_client/presentation/widgets/w_long_button.dart';

// class AppoinmentPayment extends StatelessWidget {
//   const AppoinmentPayment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//           child: BlocSelector<MyCardsBloc, MyCardsState, PaymentMethod>(
//         selector: (state) => state.paymentMethod,
//         builder: (context, payment) {
//           return Column(
//             children: [
//               ScreenUtil().setVerticalSpacing(12.h),
//               const BuildLabel(label: 'Select payment method'),
//               ScreenUtil().setVerticalSpacing(16.h),
//               MyPaymentRadioTile(
//                   extraText: 'Pay with add card',
//                   value: PaymentMethod.paymeCard,
//                   onChanged: (value) {
//                     context.read<MyCardsBloc>().add(SelectPaymentType(value));
//                   },
//                   groupValue: payment,
//                   imagePath: AppImages.payMe),
//               ScreenUtil().setVerticalSpacing(12.h),
//               MyPaymentRadioTile(
//                   extraText: 'Pay in app',
//                   value: PaymentMethod.paymeApp,
//                   onChanged: (value) {
//                     context.read<MyCardsBloc>().add(SelectPaymentType(value));
//                   },
//                   groupValue: payment,
//                   imagePath: AppImages.payMe),
//               ScreenUtil().setVerticalSpacing(12.h),
//               MyPaymentRadioTile(
//                 text: 'Cash',
//                 value: PaymentMethod.cash,
//                 onChanged: (value) {
//                   context.read<MyCardsBloc>().add(SelectPaymentType(value));
//                 },
//                 groupValue: payment,
//                 imagePath: AppImages.cash,
//               ),
//             ],
//           );
//         },
//       )),
//       appBar: const AppBarWidget(title: 'Payment'),
//       bottomSheet: PinnedSheet(
//           widget: BlocSelector<MyCardsBloc, MyCardsState, PaymentMethod>(
//         selector: (state) => state.paymentMethod,
//         builder: (context, payment) {
//           return LongButton(
//               buttonName: 'Next',
//               onPress: () {
//                 if (payment == PaymentMethod.paymeCard) {
//                   showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     backgroundColor: Colors.transparent,
//                     builder: (_) => BlocProvider.value(value: BlocProvider.of<MyCardsBloc>(context), child: const SelectCardSheet()),
//                   );
//                 } else {

//                   // FIXME: Navigate To
//                   // Navigator.pushNamed(context, AppRoutes.appointmentReview);
//                 }
//                 // Navigator.of(context).pushNamed(AppRoutes.appointmentReview);
//               });
//         },
//       )),
//     );
//   }
// }

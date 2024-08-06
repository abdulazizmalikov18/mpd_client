// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:mpd_client/application/doctor_booking/insert_card/insert_card_bloc.dart';
// import 'package:mpd_client/application/doctor_booking/my_cards_bloc/my_cards_bloc.dart';
// import 'package:mpd_client/application/doctor_booking/resend_verify_card/resend_verify_card_bloc.dart';
// import 'package:mpd_client/application/doctor_booking/verify_card/verify_card_bloc.dart';
// import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
// import 'package:mpd_client/infrastructure/services/service_locator.dart';
// import 'package:mpd_client/presentation/pages/appointment/widgets/loading_widget.dart';
// import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_payment/components/verification_card_sheet.dart';
// import 'package:mpd_client/presentation/styles/colors.dart';
// import 'package:mpd_client/presentation/styles/theme.dart';
// import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
// import 'package:mpd_client/presentation/widgets/w_long_button.dart';
// import 'package:mpd_client/utils/utils.dart';

// class AddCardBotomSheet extends StatelessWidget {
//   final BuildContext contextCons;
//   const AddCardBotomSheet({super.key, required this.contextCons});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<InsertCardBloc, InsertCardState>(
//       listener: (_, state) {
//         if (state is InsertCardLoading) {
//           //? When in progress
//           FocusScope.of(context).unfocus();
//           showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (context) => const LoadingDialogWidget(),
//           );
//         } else if (state is InsertCardSuccess) {
//           //? Have to verify
//           Navigator.pop(context);
//           Navigator.pop(context);
//           showModalBottomSheet(
//               backgroundColor: Colors.transparent,
//               context: _,
//               builder: (_) => MultiBlocProvider(
//                     providers: [
//                       BlocProvider(
//                         create: (context) => VerifyCardBloc(serviceLocator.get<DoctorProfileRepository>()),
//                       ),
//                       BlocProvider(
//                         create: (context) => ResendVerifyCardBloc(serviceLocator.get<DoctorProfileRepository>(), const Ticker()),
//                       ),
//                       BlocProvider.value(value: BlocProvider.of<MyCardsBloc>(contextCons))
//                     ],
//                     child: VerificationCardSheet(id: state.card!.id!),
//                   ),
//               isScrollControlled: true);
//         } else if (state is InsertCardFailure) {
//           //? When have a error
//           Navigator.pop(context);
//         }
//       },
//       child: Form(
//         key: context.read<InsertCardBloc>().formkey,
//         child: BottomSheetWidget(children: [
//           ScreenUtil().setVerticalSpacing(32.h),
//           Center(
//             child: Text(
//               'Add card',
//               style: Styles.boldTitle.copyWith(color: black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
//             ),
//           ),
//           ScreenUtil().setVerticalSpacing(32.h),
//           BlocBuilder<InsertCardBloc, InsertCardState>(
//             builder: (context, state) {
//               return LabelInputWidget(
//                 topHint: 'Card number',
//                 inputHint: '0000 0000 0000 0000',
//                 validator: Validators.cardNumber,
//                 errorText: state is InsertCardFailure ? state.failure : null,
//                 textInputType: TextInputType.number,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 inputformater: [
//                   MaskTextInputFormatter(mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')})
//                 ],
//                 textInputAction: TextInputAction.next,
//                 controller: context.read<InsertCardBloc>().cardController,
//                 require: '*',
//               );
//             },
//           ),
//           ScreenUtil().setVerticalSpacing(20.h),
//           LabelInputWidget(
//             topHint: 'Expiry',
//             inputHint: 'mm/yy',
//             textInputType: TextInputType.number,
//             validator: Validators.expiryNumber,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             inputformater: [
//               MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')})
//             ],
//             textInputAction: TextInputAction.next,
//             controller: context.read<InsertCardBloc>().expiryController,
//             require: '*',
//           ),
//           ScreenUtil().setVerticalSpacing(20.h),
//           LabelInputWidget(
//             topHint: 'Card name',
//             inputHint: 'Card name',
//             validator: (value) => Validators.empty(value, context),
//             textInputAction: TextInputAction.done,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             controller: context.read<InsertCardBloc>().nameController,
//           ),
//           ScreenUtil().setVerticalSpacing(32.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: LongButton(
//               buttonName: 'Add',
//               onPress: () {
//                 context.read<InsertCardBloc>().add(InsertCard());
//               },
//             ),
//           ),
//           ScreenUtil().setVerticalSpacing(32.h),
//         ]),
//       ),
//     );
//   }
// }

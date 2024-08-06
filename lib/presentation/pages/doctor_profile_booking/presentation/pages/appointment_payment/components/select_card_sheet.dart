// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mpd_client/application/doctor_booking/insert_card/insert_card_bloc.dart';
// import 'package:mpd_client/application/doctor_booking/my_cards_bloc/my_cards_bloc.dart';
// import 'package:mpd_client/domain/models/doctor_booking/card_remote_model.dart';
// import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
// import 'package:mpd_client/infrastructure/services/service_locator.dart';
// import 'package:mpd_client/presentation/pages/appointment/widgets/transparent_long_button.dart';
// import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/appointment_payment/components/add_card_bottom_sheet.dart';
// import 'package:mpd_client/presentation/styles/colors.dart';
// import 'package:mpd_client/presentation/styles/theme.dart';
// import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
// import 'package:mpd_client/presentation/widgets/w_long_button.dart';

// class SelectCardSheet extends StatelessWidget {
//   const SelectCardSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomSheetWidget(children: [
//       ScreenUtil().setVerticalSpacing(32.h),
//       Center(
//         child: Text(
//           'Select your card',
//           style: Styles.boldTitle.copyWith(color: black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
//         ),
//       ),
//       ScreenUtil().setVerticalSpacing(32.h),
//       BlocBuilder<MyCardsBloc, MyCardsState>(
//         builder: (context, state) {
//           if (state is MyCardsLoading) {
//             return Center(
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 32.h),
//                 child: const CupertinoActivityIndicator(),
//               ),
//             );
//           }
//           return Column(
//             children: [
//               ...List.generate(state.cards.length, (index) {
//                 final card = state.cards[index];
//                 return Column(
//                   children: [
//                     ScreenUtil().setVerticalSpacing(12.h),
//                     _buildCard(card: card, selectedId: state.selectId, context: context),
//                   ],
//                 );
//               })
//             ],
//           );
//         },
//       ),
//       ScreenUtil().setVerticalSpacing(24.h),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: TransparentLongButton(
//           buttonName: 'Add your card',
//           onPress: () {
//             showModalBottomSheet(
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 context: context,
//                 builder: (_) => MultiBlocProvider(
//                       providers: [
//                         BlocProvider(
//                           create: (context) =>
//                               InsertCardBloc(serviceLocator.get<DoctorProfileRepository>(), TextEditingController(), TextEditingController(), TextEditingController(), GlobalKey<FormState>()),
//                         ),
//                         BlocProvider.value(value: BlocProvider.of<MyCardsBloc>(context))
//                       ],
//                       child: AddCardBotomSheet(contextCons: context),
//                     ));
//           },
//           textColor: mainBlue,
//           borderColor: mainBlue,
//         ),
//       ),
//       ScreenUtil().setVerticalSpacing(12.h),
//       BlocSelector<MyCardsBloc, MyCardsState, int>(
//         selector: (state) => state.selectId,
//         builder: (context, selectedId) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: LongButton(
//                 isDisable: selectedId == -1,
//                 buttonName: 'Next',
//                 onPress: () {
//                   // FIXME: Navigate to
//                   // Navigator.pushNamed(context, AppRoutes.appointmentReview);
//                 }),
//           );
//         },
//       ),
//       ScreenUtil().setVerticalSpacing(24.h),
//     ]);
//   }

//   Container _buildCard({required CardRemoteModel card, required int selectedId, required BuildContext context}) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       decoration: BoxDecoration(
//         color: white,
//         boxShadow: [BoxShadow(color: cardShadow, blurRadius: 20.r)],
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: MaterialButton(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//         onPressed: () {
//           context.read<MyCardsBloc>().add(SelectCardEvent(card.id!));
//         },
//         child: Row(
//           children: [
//             _buildRadio(selectedId, card, context),
//             ScreenUtil().setHorizontalSpacing(16.w),
//             Text(card.cardNumber!, style: Styles.headline7),
//             ScreenUtil().setHorizontalSpacing(12.w),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRadio(int selectedId, CardRemoteModel card, BuildContext context) {
//     bool isSelected = card.id == selectedId;
//     return Container(
//         alignment: Alignment.center,
//         height: 22,
//         width: 22,
//         decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(color: isSelected ? mainBlue : grey, width: 1.5))),
//         child: CircleAvatar(
//           backgroundColor: isSelected ? mainBlue : white,
//           radius: 7,
//         ));
//   }
// }

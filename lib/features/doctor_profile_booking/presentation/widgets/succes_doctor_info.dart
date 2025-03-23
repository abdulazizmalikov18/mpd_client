// import 'dart:math';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mpd_client/app/app_colors.dart';
// import 'package:mpd_client/app/app_icons.dart';
// import 'package:mpd_client/app/app_images.dart';
// import 'package:mpd_client/app/app_routes.dart';
// import 'package:mpd_client/core/utils/utils.dart';
// import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';
// import 'package:mpd_client/features/doctor_profile_booking/data/models/pdf_viewer_model.dart';
// import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/dr_profile_document.dart';
// import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/dr_profile_listile.dart';
// import 'package:mpd_client/features/home/domain/blocs/send_coment/send_coment_bloc.dart';
// import 'package:mpd_client/provider/language.dart';
// import 'package:mpd_client/src/widgets/review_widget.dart';
// import 'package:mpd_client/src/themes/styles.dart';
// import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
// import 'package:mpd_client/src/widgets/transparent_long_button.dart';

// import '../../../home/presentation/widgets/build_label.dart';
// import '../widgets/dr_profile_info.dart';

// class SuccessDoctorInfo extends StatelessWidget {
//   final DoctorProfileModel doctor;

//   const SuccessDoctorInfo({super.key, required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     if (doctor.specialists == null) {
//       return const SizedBox();
//     } else if (doctor.specialists!.isEmpty) {
//       return const SizedBox();
//     }
//     final specialist = doctor.specialists!.first;
//     final rundomReview = Random().nextInt(10);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 21.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               DrProfileInfo(
//                 label: context.l10n.book_doctor_patients_patients,
//                 iconName: AppIcons.patient,
//                 count: specialist.specialistOrders!.isEmpty ? 0 : specialist.specialistOrders!.first.patientNumber!,
//               ),
//               DrProfileInfo(
//                 label: context.l10n.book_doctor_year_expirience,
//                 iconName: AppIcons.briefcase,
//                 count: specialist.specialistOrders!.isEmpty ? 0 : specialist.specialistOrders!.first.patientNumber!,
//               ),
//               DrProfileInfo(
//                 label: context.l10n.book_doctor_patients_orders,
//                 iconName: AppIcons.order,
//                 count: specialist.specialistOrders!.isEmpty ? 0 : specialist.specialistOrders!.first.patientNumber!,
//               ),
//               DrProfileInfo(
//                 label: context.l10n.book_doctor_patients_reviews,
//                 iconName: AppIcons.message,
//                 count: rundomReview,
//               )
//             ],
//           ),
//         ),
//         ScreenUtil().setVerticalSpacing(24.h),
//         BuildLabel(label: context.l10n.book_doctor_about_doctor),
//         ScreenUtil().setVerticalSpacing(8.h),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Text(
//             specialist.bio.toString(),
//             style: Styles.descSubtitle.copyWith(fontSize: 14.sp, color: context.color.grey),
//           ),
//         ),
//         ScreenUtil().setVerticalSpacing(20.h),
//         BuildLabel(
//           label: context.l10n.book_doctor_place_work_hours,
//         ),
//         ScreenUtil().setVerticalSpacing(5.h),
//         DrProfileListile(
//           title: '${specialist.position!.org!.name}',
//           subtitle:
//               '${Utils.weekDayFormatObrevation(specialist.todayTimetable!.dayOfWeek!)}, ${Utils.todayTimeFormat(specialist.todayTimetable!.startTime!)} -  ${Utils.todayTimeFormat(specialist.todayTimetable!.endTime!)}',
//           iconName: AppImages.place,
//         ),

//         if (specialist.currentWorkplace!.isNotEmpty)
//           Column(
//             children: [
//               ScreenUtil().setVerticalSpacing(12.h),
//               _buildWorkBuilding('Корпус:  ${specialist.currentWorkplace!.last.value}'),
//               ScreenUtil().setVerticalSpacing(8.h),
//               _buildWorkBuilding('Бино:  ${specialist.currentWorkplace![1].value}'),
//               ScreenUtil().setVerticalSpacing(8.h),
//               _buildWorkBuilding('Кават: ${specialist.currentWorkplace![0].value}'),
//               ScreenUtil().setVerticalSpacing(8.h),
//               _buildWorkBuilding('Хона: ${specialist.currentWorkplace![2].value}'),
//             ],
//           ),
//         if (doctor.documents!.isNotEmpty) ScreenUtil().setVerticalSpacing(20.h),
//         if (doctor.documents!.isNotEmpty) BuildLabel(label: context.l10n.book_doctor_education_sertificate),
//         ScreenUtil().setVerticalSpacing(5.h),
//         for (int i = 0; i < doctor.documents!.length; i++)
//           DrProfileDocument(
//             title: doctor.documents![i].type!.name!,
//             iconName: AppIcons.documentPng,
//             onPressed: () => Navigator.pushNamed(context, AppRoutes.pdfViewer,
//                 arguments: PdfViewerModel(pdfUrl: doctor.documents![i].file!, name: doctor.documents![i].type!.name!)),
//           ),
//         ScreenUtil().setVerticalSpacing(20.h),
//         BuildLabel(label: context.l10n.book_doctor_reviews),
//         // ScreenUtil().setVerticalSpacing(8.h),
//         // Padding(
//         //     padding: EdgeInsets.symmetric(horizontal: 16.w),
//         //     child: const ReviewWidget(status: SendComentInitial(null))),
//         ScreenUtil().setVerticalSpacing(20.h),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: TransparentLongButton(
//             buttonName:
//                 '${context.l10n.book_doctor_reviews_all} $rundomReview ${context.l10n.book_doctor_reviews.toLowerCase()}',
//             onPress: () {
//               showModalBottomSheet(
//                   isScrollControlled: true,
//                   backgroundColor: Colors.transparent,
//                   context: context,
//                   builder: (_) => BottomSheetWidget(children: [
//                         ScreenUtil().setVerticalSpacing(32.h),
//                         Center(
//                           child: Text(
//                             context.l10n.book_doctor_reviews,
//                             style: Styles.boldTitle
//                                 .copyWith(color: context.color.black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
//                           ),
//                         ),
//                         ScreenUtil().setVerticalSpacing(28.h),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16.w),
//                           child: const ReviewWidget(status: SendComentInitial(null)),
//                         ),
//                         ScreenUtil().setVerticalSpacing(32.h),
//                       ]));
//             },
//             textColor: context.color.mainBlue,
//             borderColor: context.color.mainBlue,
//           ),
//         ),
//         ScreenUtil().setVerticalSpacing(20.h)
//       ],
//     );
//   }

//   Padding _buildWorkBuilding(String text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Text(text, style: Styles.boldHeadline6),
//     );
//   }
// }

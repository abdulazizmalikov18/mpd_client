import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/transparent_long_button.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/dr_profile_listile.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/review_widget.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/w_build_label.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';

import '../widgets/dr_profile_info.dart';

class DoctorInfoItem extends StatelessWidget {
  final DoctorProfileModel doctor;

  const DoctorInfoItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final rundomReview = Random().nextInt(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DrProfileInfo(
                label: context.l10n.book_doctor_patients_patients,
                iconName: AppIcons.patient,
                count: doctor.specialistOrders.isEmpty ? 0 : doctor.specialistOrders.first.patientNumber,
              ),
              DrProfileInfo(
                label: context.l10n.book_doctor_year_expirience,
                iconName: AppIcons.briefcase,
                count: doctor.experience != null && doctor.experience is int ? doctor.experience : 0,
              ),
              DrProfileInfo(
                label: context.l10n.book_doctor_patients_orders,
                iconName: AppIcons.order,
                count: doctor.specialistOrders.isEmpty ? 0 : doctor.specialistOrders.first.patientNumber,
              ),
              DrProfileInfo(
                label: context.l10n.book_doctor_patients_reviews,
                iconName: AppIcons.message,
                count: rundomReview,
              )
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(24.h),
        BuildLabel(label: context.l10n.book_doctor_about_doctor),
        ScreenUtil().setVerticalSpacing(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            doctor.bio != null ? doctor.bio.toString() : "Malumot yoq",
            style: Styles.descSubtitle.copyWith(fontSize: 14.sp, color: grey),
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        BuildLabel(label: context.l10n.book_doctor_place_work_hours),
        ScreenUtil().setVerticalSpacing(5.h),
        DrProfileListile(
          title: doctor.job.name,
          subtitle: doctor.todayTimetable.id != 0
              ? '${Utils.weekDayFormatObrevation(doctor.todayTimetable.dayOfWeek)}, ${Utils.todayTimeFormat(doctor.todayTimetable.startTime)} -  ${Utils.todayTimeFormat(doctor.todayTimetable.endTime)}'
              : "",
          iconName: AppImages.place,
        ),

        if (doctor.currentWorkplace.isNotEmpty)
          Column(
            children: [
              ScreenUtil().setVerticalSpacing(12.h),
              _buildWorkBuilding('Корпус:  ${doctor.currentWorkplace.last.value}'),
              ScreenUtil().setVerticalSpacing(8.h),
              _buildWorkBuilding('Бино:  ${doctor.currentWorkplace[1].value}'),
              ScreenUtil().setVerticalSpacing(8.h),
              _buildWorkBuilding('Кават: ${doctor.currentWorkplace[0].value}'),
              ScreenUtil().setVerticalSpacing(8.h),
              _buildWorkBuilding('Хона: ${doctor.currentWorkplace[2].value}'),
            ],
          ),
        // if (doctor.documents!.isNotEmpty) ScreenUtil().setVerticalSpacing(20.h),
        // if (doctor.documents!.isNotEmpty) BuildLabel(label: context.l10n.book_doctor_education_sertificate),
        // ScreenUtil().setVerticalSpacing(5.h),
        // for (int i = 0; i < doctor.documents!.length; i++)
        //   DrProfileDocument(
        //     title: doctor.documents![i].type!.name!,
        //     iconName: AppIcons.documentPng,
        //     onPressed: () => Navigator.pushNamed(context, AppRoutes.pdfViewer,
        //         arguments: PdfViewerModel(pdfUrl: doctor.documents![i].file!, name: doctor.documents![i].type!.name!)),
        //   ),
        ScreenUtil().setVerticalSpacing(20.h),
        BuildLabel(label: context.l10n.book_doctor_reviews),
        // ScreenUtil().setVerticalSpacing(8.h),
        // Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 16.w),
        //     child: const ReviewWidget(status: SendComentInitial(null))),
        ScreenUtil().setVerticalSpacing(20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TransparentLongButton(
            buttonName: '${context.l10n.book_doctor_reviews_all} $rundomReview ${context.l10n.book_doctor_reviews.toLowerCase()}',
            onPress: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => BottomSheetWidget(children: [
                        ScreenUtil().setVerticalSpacing(32.h),
                        Center(
                          child: Text(
                            context.l10n.book_doctor_reviews,
                            style: Styles.boldTitle.copyWith(color: black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
                          ),
                        ),
                        ScreenUtil().setVerticalSpacing(28.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const ReviewWidget(
                            // status: SendComentInitial(null),
                          ),
                        ),
                        ScreenUtil().setVerticalSpacing(32.h),
                      ]));
            },
            textColor: mainBlue,
            borderColor: mainBlue,
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h)
      ],
    );
  }

  Padding _buildWorkBuilding(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(text, style: Styles.boldHeadline6),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/dr_profile_document.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class RecordFile extends StatelessWidget {
  final String file;
  const RecordFile({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription',
            style: Styles.boldTopHint.copyWith(fontSize: 16.sp, color: black),
          ),
          ScreenUtil().setVerticalSpacing(4.h),
          DrProfileDocument(
            title: 'Prescription',
            iconName: AppIcons.documentPng,
            onPressed: () {},
            // onPressed: () => Navigator.pushNamed(
            //   context,
            //   AppRoutes.pdfViewer,
            //   arguments: PdfViewerModel(pdfUrl: file, name: 'Prescription'),
            // ),
          ),
        ],
      ),
    );
  }
}

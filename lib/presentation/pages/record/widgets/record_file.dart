import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/dr_profile_document.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:url_launcher/url_launcher.dart';

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
            style: Styles.boldTopHint.copyWith(fontSize: 16, color: black),
          ),
          ScreenUtil().setVerticalSpacing(4.h),
          DrProfileDocument(
            title: 'Prescription',
            iconName: AppIcons.documentPng,
            onPressed: () {
              try { 

              launchUrl(Uri.parse(file));
              }catch(e) {
                Log.e("File ochilmadi !");
              }
            },
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/pdf_viewer_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/dr_profile_document.dart';
import 'package:mpd_client/src/themes/styles.dart';

class RecordFile extends StatelessWidget {
  final String file;
  const RecordFile({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: context.color.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription',
            style: Styles.boldTopHint
                .copyWith(fontSize: 16.sp, color: context.color.black),
          ),
          ScreenUtil().setVerticalSpacing(4.h),
          DrProfileDocument(
            title: 'Prescription',
            iconName: AppIcons.documentPng,
            iconNetwork: file.endsWith('.pdf') ? null : file,
            onPressed: () {
              if (file.endsWith('.pdf')) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.pdfViewer,
                  arguments: PdfViewerModel(pdfUrl: file, name: 'Prescription'),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    insetPadding: EdgeInsets.zero,
                    child: InteractiveViewer(
                      child: SizedBox(
                        child: CachedNetworkImage(imageUrl: file),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

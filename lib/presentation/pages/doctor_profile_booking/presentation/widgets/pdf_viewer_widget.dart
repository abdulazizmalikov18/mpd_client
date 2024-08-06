import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PdfViewerPage extends StatelessWidget {
  final String url;
  final String name;

  const PdfViewerPage({super.key, required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
          icon: SvgPicture.asset(
            AppIcons.back,
            colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
            height: 22.h,
            width: 22.h,
          ),
        ),
        backgroundColor: white,
        centerTitle: true,
        title: Text(name, style: Styles.title.copyWith(color: black, fontSize: 20.sp)),
      ),
      body: SfPdfViewer.network(url),
    );
  }
}

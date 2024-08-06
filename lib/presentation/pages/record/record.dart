import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/record_doctor_card.dart';
import 'package:mpd_client/presentation/pages/record/widgets/record_file.dart';
import 'package:mpd_client/presentation/pages/record/widgets/record_review.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';

class Record extends StatelessWidget {
  final RecordModel record;

  const Record({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: record.title ?? "--"),
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(16.h),
            RecordReview(
              title: 'Medical records full name',
              subtitle: Utils.commentDateFormat(record.date!, context),
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            RecordReview(
              title: 'Medical records',
              subtitle: record.conclusion!,
              isHtml: true,
            ),
            ScreenUtil().setVerticalSpacing(12),
            if (record.conclusionFile != null) RecordFile(file: record.conclusionFile!),
            if (record.conclusionFile != null) ScreenUtil().setVerticalSpacing(12.h),
            RecordDoctorCard(
              buttonName: context.l10n.appointment_view_doctor_profile,
              record: record,
              onPress: () {
                if (record.writer?.username == null) {
                  debugPrint("User Null Kelyapti");
                } else {
                  context.pushNamed(
                    AppRouteNames.drProfilebyid,
                    extra: {
                      'specialist': SpecialistInfoModel(
                        id: record.writer?.id ?? 0,
                        username: record.writer?.username ?? "--",
                        job: record.writer?.job ?? "--",
                        fullname: '${record.writer?.name ?? "--"} ${record.writer?.lastname ?? "--"}',
                        avatar: record.writer?.avatar ?? "--",
                      ),
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

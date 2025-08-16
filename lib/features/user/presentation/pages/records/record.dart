import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/appointment/presentation/widgets/record_doctor_card.dart';
import 'package:mpd_client/features/records/presentation/widgets/record_file.dart';
import 'package:mpd_client/features/user/data/models/specialist_info_model.dart';
import 'package:mpd_client/features/user/data/models/user_records_model.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import '../../../../records/presentation/widgets/record_review.dart';

class Record extends StatelessWidget {
  final RecordModel record;

  const Record({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: record.title ?? "--"),
      backgroundColor: context.color.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(16.h),
            RecordReview(
              title: 'Medical records full name ${record.id}',
              subtitle: Utils.commentDateFormat(
                record.date ?? DateTime.now(),
                context,
              ),
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            if (record.conclusion != null)
              RecordReview(
                title: 'Medical records',
                subtitle: (record.conclusion ?? "Nomalum"),
                // isHtml: true,
              ),
            ScreenUtil().setVerticalSpacing(12.h),
            if (record.conclusionFile != null)
              RecordFile(file: record.conclusionFile!),
            if (record.conclusionFile != null)
              ScreenUtil().setVerticalSpacing(12.h),
            RecordDoctorCard(
              buttonName: context.l10n.appointment_view_doctor_profile,
              record: record,
              onPress: () {
                if (record.writer?.username == null) {
                  debugPrint("User Null Kelyapti");
                }
                Navigator.pushNamed(
                  context,
                  AppRoutes.drProfilebyid,
                  arguments: SpecialistInfoModel(
                    id: record.writer?.id ?? 0,
                    phone: "",
                    username: record.writer?.username ?? "--",
                    job: record.writer?.job ?? "--",
                    fullname:
                        '${record.writer?.name ?? "--"} ${record.writer?.lastname ?? "--"}',
                    avatar: record.writer?.avatar ?? "--",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

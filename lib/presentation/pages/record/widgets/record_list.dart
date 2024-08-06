import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/presentation/pages/record/widgets/record_card.dart';
import 'package:mpd_client/presentation/pages/record/widgets/records_label.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/date_time_ext.dart';

class RecordList extends StatelessWidget {
  final List<RecordModel> records;
  final ScrollController scrollController;
  final VoidCallback scrollEndFunc;
  final Future<void> Function() onRefresh;

  const RecordList({
    super.key,
    required this.records,
    required this.onRefresh,
    required this.scrollController,
    required this.scrollEndFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: NotificationListener(
          onNotification: _handleScrollNotification,
          child: ListView.separated(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            separatorBuilder: (context, index) {
              if (records.length == 1) {
                return RecordsLabelPart(dateTime: context.l10n.records_new_added);
              }
              final initialDate = records[index].date!;
              final nextDate = records[index + 1].date!;
              bool isFirstTime = initialDate.isDateEqual(nextDate);
              if (isFirstTime && !initialDate.isDateEqual(nextDate)) {
                isFirstTime = false;
                return RecordsLabelPart(dateTime: context.l10n.records_new_added);
              } else {
                return const SizedBox();
              }
            },
            itemBuilder: (context, index) {
              if (index >= records.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.h,
                      width: 25.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: mainBlue,
                      ),
                    ),
                    ScreenUtil().setHorizontalSpacing(10.w),
                    Text(
                      'Loading...',
                      style: Styles.headline7.copyWith(color: mainBlue),
                    )
                  ],
                );
              }
              final record = records[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0) RecordsLabelPart(dateTime: context.l10n.records_new_added),
                  RecordsCard(
                    onPressed: () {
                      // FIXME: NavigateTo
                      context.pushNamed(AppRouteNames.conclusionHistory, extra: {
                        "arguments": record,
                      });
                      // Navigator.of(context).pushNamed(AppRoutes.record, arguments: record);
                    },
                    record: record,
                  ),
                ],
              );
            },
            itemCount: records.length,
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && scrollController.position.extentAfter == 0) {
      scrollEndFunc();
    }
    return false;
  }
}

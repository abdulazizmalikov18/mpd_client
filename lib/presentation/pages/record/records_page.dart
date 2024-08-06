import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/profile/user_records/records_bloc.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/record/widgets/no_records_part.dart';
import 'package:mpd_client/presentation/pages/record/widgets/record_list.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_search_text_field.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: context.l10n.records_title),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SearchFieldWidget(
              controller: context.read<RecordsBloc>().searchController,
              searchHint: context.l10n.records_seach,
              onChanged: (query) {
                context.read<RecordsBloc>().add(SearchRecordEvent(query));
              },
            ),
          ),
          BlocBuilder<RecordsBloc, RecordsState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
                if (state.records.isEmpty) {
                  return const Expanded(child: NoRecordsPart());
                }

                return RecordList(
                  onRefresh: () async {
                    context.read<RecordsBloc>().add(const GetRecordsEvent(true));
                    await context.read<RecordsBloc>().stream.first;
                  },
                  records: state.records,
                  scrollController: ScrollController(),
                  scrollEndFunc: () => context.read<RecordsBloc>().add(const GetRecordsEvent()),
                );
              }

              return Expanded(child: _buildRecordsShimmer(context));
            },
          )
        ],
      ),
    );
  }

  Widget _buildRecordsShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenUtil().setVerticalSpacing(12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: WShimmer(width: 98, height: 24),
                ),
                ScreenUtil().setVerticalSpacing(12),
                const WShimmer(width: double.maxFinite, height: 96, radius: 12),
                ScreenUtil().setVerticalSpacing(12),
                const WShimmer(width: double.maxFinite, height: 96, radius: 12),
              ],
            ),
          );
        },
        itemCount: 0,
      ),
    );
  }
}

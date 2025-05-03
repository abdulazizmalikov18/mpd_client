import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/user/domain/blocs/user_records/records_bloc.dart';
import 'package:mpd_client/features/user/presentation/pages/records/components/no_records_part.dart';
import 'package:mpd_client/features/user/presentation/pages/records/components/record_list.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/shimmer_container.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../src/widgets/search_field_widget.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.records_title)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SearchFieldWidget(
              controller: context.watch<RecordsBloc>().searchController,
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
                    context
                        .read<RecordsBloc>()
                        .add(const GetRecordsEvent(true));
                    await context.read<RecordsBloc>().stream.first;
                  },
                  records: state.records,
                  scrollController: ScrollController(),
                  scrollEndFunc: () =>
                      context.read<RecordsBloc>().add(const GetRecordsEvent()),
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
      baseColor: context.color.baseColor,
      highlightColor: context.color.highlightColor,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 30.h),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenUtil().setVerticalSpacing(12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: const ShimmerContainer(size: Size(98, 24)),
                  ),
                  ScreenUtil().setVerticalSpacing(12.h),
                  const ShimmerContainer(
                      size: Size(double.maxFinite, 96), radius: 12),
                  ScreenUtil().setVerticalSpacing(12.h),
                  const ShimmerContainer(
                      size: Size(double.maxFinite, 96), radius: 12),
                ],
              ),
            );
          },
          itemCount: 3),
    );
  }
}

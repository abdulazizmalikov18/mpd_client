import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/comment_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CommentListWidget extends StatelessWidget {
  final List<CommentsModel> list;
  final bool limited;
  const CommentListWidget(
      {super.key, required this.list, this.limited = false});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            return state.statusComment.isInProgress ||
                    state.statusComments.isInitial
                ? const CommentShimmerList()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: limited && list.length > 2 ? 2 : list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: colors.searchTextfieldColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StarsComp(
                                  starCount: item.rating ?? 0,
                                  title: item.owner?.fullName ?? "",
                                  color: colors.black,
                                ),
                                10.verticalSpace,
                                Text(
                                  item.comment ?? "",
                                  style: Style.medium14(size: 12),
                                ),
                                10.verticalSpace,
                                Text(
                                  (item.postedAt ?? "")
                                      .substring(0, 10)
                                      .replaceAll("-", "."),
                                  style: Style.medium14(
                                      size: 12, color: colors.grey88),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/comment_list_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/write_comment_widget.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CommentsWidget extends StatefulWidget {
  final ReviewController vmController;
  const CommentsWidget({super.key, required this.vmController});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  void dispose() {
    widget.vmController.rateValue = 5;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vmCtr = widget.vmController;
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final list = state.commentsList;
            final rating =
                state.safetyConvenienceModel?.ratedByOrientMotors ?? 0;
            final id = state.safetyConvenienceModel?.id;

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: StarsComp(
                    starCount: rating,
                    title:
                        "${(list ?? []).isNotEmpty ? list?.length : ""} ${"comments".tr()}"
                            .trim(),
                  ),
                ),
                8.verticalSpace,
                WriteCommentWidget(vmCtr: vmCtr, id: id),
                6.verticalSpace,
                CommentListWidget(list: list ?? []),
                const ReviewCarsComp(),
                const PolicyComp(),
                20.verticalSpace,
              ],
            );
          },
        );
      },
    );
  }
}

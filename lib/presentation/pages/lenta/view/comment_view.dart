import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/comment/comment_bloc.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
import 'package:mpd_client/domain/models/lenta/post_model.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/presentation/pages/lenta/view/comment_bottom_sheet.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/post_widget.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_comment.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_comment_bottom_sheet.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';

part '../mixin/comment_mixin.dart';

class CommentView extends StatefulWidget {
  final PostModel post;
  final String? message;

  const CommentView({
    super.key,
    required this.post,
    this.message,
  });

  @override
  State<CommentView> createState() => _CommentViewState();

  static _CommentViewState? maybeOf(BuildContext context) => context.findAncestorStateOfType<_CommentViewState>();
}

class _CommentViewState extends State<CommentView> with CommentMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldSecondaryBackground,
      appBar: const WAppBar(
        title: Text('Comment View'),
      ),
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostWidget(
                isLentaView: false,
                post: widget.post,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      calculateDate(widget.post.date),
                      style: AppTheme.labelLarge.copyWith(color: gray),
                    ),
                    const SizedBox(height: 36),
                    BlocBuilder<CommentBloc, CommentState>(
                      builder: (context, state) {
                        // When Comment is In Progress that show !
                        if (state.status.isInProgress) {
                          return const SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        }

                        // Comments Builder
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int index = 0; index < state.comments.length; index++)
                              WComment(
                                isMine: state.comments[index].user == username,
                                comment: state.comments[index],
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Input(TextField) for send Comment
      bottomSheet: const WCommentBottomSheet(),
    );
  }
}

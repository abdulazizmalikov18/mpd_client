import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/domain/blocs/post_coment/post_coment_bloc.dart';
import 'package:mpd_client/features/home/domain/blocs/send_coment/send_coment_bloc.dart';
import 'package:mpd_client/features/home/presentation/pages/coment_sheet/components/coment_loading.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/infinite_loading.dart';
import 'package:mpd_client/src/widgets/review_widget.dart';

class Coments extends StatefulWidget {
  const Coments({super.key, required this.post});

  final Post post;

  @override
  State<Coments> createState() => _ComentsState();
}

class _ComentsState extends State<Coments> {
  @override
  void initState() {
    context
        .read<PostComentBloc>()
        .add(GetComentPostEvent(widget.post.id!, false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostComentBloc, PostComentState>(
      builder: (context, state) {
        if (state.coments.isEmpty && state is PostComentLoading) {
          return const ComentLoading();
        } else if (state.coments.isNotEmpty) {
          return ListView.builder(
            itemCount: state.coments.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.coments.length) {
                if (state.isEnd) {
                  return const SizedBox();
                }
                return const InfiniteLoadingWidget();
              }
              return BlocBuilder<SendComentBloc, SendComentState>(
                builder: (context, sendState) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ReviewWidget(
                      postId: widget.post.id!,
                      coment: state.coments[index],
                      status: sendState,
                    ),
                  );
                },
              );
            },
          );
          // return Column(
          //   children: List.generate(state.coments.length + 1, (index) {
          //     if (index >= state.coments.length) {
          //       if (state.isEnd) {
          //         return const SizedBox();
          //       }
          //       return const InfiniteLoadingWidget();
          //     }
          //     return BlocBuilder<SendComentBloc, SendComentState>(
          //       builder: (context, sendState) {
          //         return Padding(
          //           padding: EdgeInsets.only(bottom: 16.h),
          //           child: ReviewWidget(
          //             postId: post.id!,
          //             coment: state.coments[index],
          //             status: sendState,
          //           ),
          //         );
          //       },
          //     );
          //   }),
          // );
        } else if (state is PostComentSuccess && state.coments.isEmpty) {
          return Text(context.l10n.lenth_no_comments);
        }
        return const SizedBox();
      },
    );
  }
}

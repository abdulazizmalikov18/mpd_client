import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/features/home/domain/blocs/create_post/create_post_bloc.dart';
import 'package:mpd_client/features/home/presentation/pages/create_post/components/dotted_add_image.dart';
import 'package:mpd_client/features/home/presentation/pages/create_post/components/post_image_card.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import 'package:mpd_client/src/widgets/comment_input_widget.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(title: context.l10n.lenth_create_post),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenUtil().setVerticalSpacing(16.h),
          BlocBuilder<CreatePostBloc, CreatePostState>(
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      if (state.files.isNotEmpty)
                        ...List.generate(
                          state.files.length,
                          (index) => PostImageAndVideoView(
                            filemodel: state.files[index],
                            onRemovePressed: () {
                              context.read<CreatePostBloc>().add(
                                RemoveImageEvent(state.files[index]),
                              );
                            },
                          ),
                        ),
                      DottedAddImage(
                        onPressed: () => context.read<CreatePostBloc>().add(
                          SelectImagesAndVideosEvent(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ScreenUtil().setVerticalSpacing(24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              context.l10n.lenth_post_description,
              style: Styles.headline5,
            ),
          ),
          ScreenUtil().setVerticalSpacing(12.h),
          CommentInputWidget(
            hintText: context.l10n.lenth_postwrite,
            controller: context.read<CreatePostBloc>().descriptionController,
            onChanged: (value) {},
          ),
          const Spacer(),
          BlocListener<CreatePostBloc, CreatePostState>(
            listener: (context, state) {
              if (state is CreatePostLoading) {
                FocusScope.of(context).unfocus();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingDialogWidget(),
                );
              } else if (state is CreatePostSucces) {
                Navigator.pop(context);
                Navigator.of(context).pop(true);
              } else if (state is CreatePostFailure) {
                Navigator.pop(context);
                if (state.failure.startsWith('<!')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    UiTools.failurefailureSnackBar(
                      title: 'Oh snap',
                      message: state.failure,
                    ),
                  );
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: LongButton(
                buttonName: context.l10n.lenth_publish_post,
                onPress: () {
                  context.read<CreatePostBloc>().add(CreatePostPressed());
                },
              ),
            ),
          ),
          ScreenUtil().setVerticalSpacing(24.h),
        ],
      ),
    );
  }
}

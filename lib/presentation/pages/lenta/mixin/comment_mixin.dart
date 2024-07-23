part of '../view/comment_view.dart';

mixin CommentMixin on State<CommentView> {
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final username = StorageRepository.getString(StorageKeys.USERNAME);

  @override
  void initState() {
    context.read<CommentBloc>().add(GetCommentEvent(postId: widget.post.id));
    // if (widget.message != null) {
    //   controller.text = widget.message!;
    //   focusNode.requestFocus();
    // }
    super.initState();
  }

  void onPressReply(CommentEntity comment) {
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    isLoading.dispose();
    super.dispose();
  }

  void sendComment() {
    if (controller.text.trim().isEmpty) return;
    isLoading.value = true;
    context.read<CommentBloc>().add(CommentSendEvent(
          message: controller.text.trim(),
          postId: widget.post.id,
          onSuccess: () {
            isLoading.value = false;
            controller.clear();
          },
          onError: (errorMessage) {
            isLoading.value = false;
          },
        ));
    isLoading.value = false;
  }

  String calculateDate(String dateTime) {
    final oldTime = DateTime.tryParse(dateTime) ?? DateTime.now();
    final time = DateTime.now().difference(oldTime);
    if (time.inDays != 0) {
      return "${time.inDays} day ago";
    } else if (time.inHours != 0) {
      return "${time.inHours} hour ago";
    } else if (time.inMinutes != 0) {
      return "${time.inMinutes} minute ago";
    } else {
      return "${time.inSeconds} second ago";
    }
  }
}

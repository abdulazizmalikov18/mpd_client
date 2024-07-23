part of '../view/create_post_view.dart';

mixin CreatePostMixin on State<CreatePostView> {
  List<File> files = [];
  TextEditingController descriptionController = TextEditingController();

  void onPressCreate() {
    onCreatePostValidate(
      onValidate: () {
        context.read<PostBloc>().add(
              PostCreateEvent(
                onSuccess: () {
                  Navigator.pop(context);
                },
                onError: () {},
                param: CreatePostParam(
                  text: descriptionController.text.trim(),
                  files: files.where((element) => isVideo(element.path)).map((e) => e.path).toList(),
                  images: files.where((element) => isPhoto(element.path)).map((e) => e.path).toList(),
                ),
              ),
            );
      },
      onError: (String text) {
        print(text);
      },
    );
  }

  void onCreatePostValidate({required void Function() onValidate, required void Function(String text) onError}) {
    if (files.isEmpty) {
      onError("Iltimos Rasm yoki Video kiriting !");
      return;
    } else if (descriptionController.text.trim().isEmpty) {
      onError("Description Kiritilmagan !");
      return;
    } else if (files.fold(0, (previousValue, element) => previousValue + element.statSync().size) > 2e+8) {
      onError("Rasm va videolar hajmi 100 mbdan oshmasligi kerak");
      return;
    }
    onValidate();
    return;
  }

  bool isVideo(String path) {
    final name = path.toUpperCase();
    return name.endsWith("MP4") || name.endsWith("MOV") || name.endsWith("AVI") || name.endsWith("WMV") || name.endsWith("AVCHD");
  }

  bool isPhoto(String path) {
    final name = path.toUpperCase();
    return name.endsWith("JPG") || name.endsWith("JPEG") || name.endsWith("PNG") || name.endsWith("RAW") || name.endsWith("WEBP");
  }
}

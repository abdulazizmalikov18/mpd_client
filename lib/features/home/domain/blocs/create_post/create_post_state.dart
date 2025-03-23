part of 'create_post_bloc.dart';

abstract class CreatePostState {
  final List<FileModel> files;

  final bool isValidImage;
  const CreatePostState(this.files, {this.isValidImage = true});
}

class CreatePostInitial extends CreatePostState {
  const CreatePostInitial(super.files, {super.isValidImage});
}

class CreatePostLoading extends CreatePostState {
  const CreatePostLoading(super.files, {super.isValidImage});
}

class CreatePostSucces extends CreatePostState {
  final Map<String, dynamic> createdPost;
  const CreatePostSucces(super.files,
      {required this.createdPost, super.isValidImage});
}

class CreatePostFailure extends CreatePostState {
  final String failure;
  const CreatePostFailure(super.files,
      {required this.failure, super.isValidImage});
}

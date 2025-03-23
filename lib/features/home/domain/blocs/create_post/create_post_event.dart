part of 'create_post_bloc.dart';

abstract class CreatePostEvent {
  const CreatePostEvent();
}

class SelectImagesAndVideosEvent extends CreatePostEvent {
  final BuildContext context;
  const SelectImagesAndVideosEvent(this.context);
}

class SelectVideoEvent extends CreatePostEvent {}

class RemoveImageEvent extends CreatePostEvent {
  final FileModel file;
  const RemoveImageEvent(this.file);
}

class CreatePostPressed extends CreatePostEvent {}

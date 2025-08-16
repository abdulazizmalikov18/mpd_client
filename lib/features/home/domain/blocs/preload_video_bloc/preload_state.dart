part of 'preload_bloc.dart';

// @immutable
class PreloadState {
  List<Post> urls;
  Map<int, Map<int, VideoPlayerController>> controllers;
  List<int> focusedIndex;

  int reloadCounter;
  PreloadState({
    required this.urls,
    required this.controllers,
    required this.focusedIndex,
    required this.reloadCounter,
  });

  PreloadState copyWith({
    List<Post>? urls,
    Map<int, Map<int, VideoPlayerController>>? controllers,
    List<int>? focusedIndex,
    int? reloadCounter,
  }) => PreloadState(
    controllers: controllers ?? this.controllers,
    focusedIndex: focusedIndex ?? this.focusedIndex,
    urls: urls ?? this.urls,
    reloadCounter: reloadCounter ?? this.reloadCounter,
  );
}

class PreloadInitial extends PreloadState {
  PreloadInitial({
    required super.urls,
    required super.controllers,
    required super.focusedIndex,
    required super.reloadCounter,
  });
}

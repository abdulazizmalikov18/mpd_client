part of 'preload_bloc.dart';

// @immutable
abstract class PreloadEvent {}

class GetVideoesFromList extends PreloadEvent {
  final List<Post> urls;
  final int baseIndex;
  GetVideoesFromList({required this.baseIndex, required this.urls});
}

class FillVideoIndex extends PreloadEvent {
  final int length;
  FillVideoIndex(this.length);
}

class VideoIndexChanged extends PreloadEvent {
  final int baseIndex;
  final int index;
  VideoIndexChanged({required this.baseIndex, required this.index});
}

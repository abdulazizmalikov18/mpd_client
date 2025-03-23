part of 'banner_bloc.dart';

class BannerState {
  List<Post> banners;
  final int currentIndexBanner;
  final List<int> mediaIndexes;
  final bool showLoading, isEnd;
  final String failure;
  final int comentPostIndex;
  BannerState(
      {required this.banners,
      this.currentIndexBanner = 0,
      this.mediaIndexes = const [],
      this.showLoading = false,
      this.isEnd = false,
      this.comentPostIndex = 0,
      this.failure = ''});

  BannerState copyWith(
      {List<Post>? banners,
      final int? currentIndexBanner,
      final List<int>? mediaIndexes,
      final bool? showLoading,
      final bool? isEnd,
      final String? failure,
      final int? comentPostIndex}) {
    return BannerState(
        comentPostIndex: comentPostIndex ?? this.comentPostIndex,
        mediaIndexes: mediaIndexes ?? this.mediaIndexes,
        banners: banners ?? this.banners,
        currentIndexBanner: currentIndexBanner ?? this.currentIndexBanner,
        showLoading: showLoading ?? this.showLoading,
        isEnd: isEnd ?? this.isEnd,
        failure: failure ?? this.failure);
  }
}

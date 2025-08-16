import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc(this._homeRepository, this._postPageController)
    : super(BannerState(banners: [])) {
    on<BannerIndexChangedEvent>(_onBannerIndexChanged);
    on<GetBannersEvent>(_onGetBanners);
    on<PostIndexChangedEvent>(_onPostIndexChanged);
    on<InsertComentToPost>(_onInsertComentCount);
    on<LikeToPost>(_onLikeToPost);
    on<ComentPostImageChange>(_onComentPostChange);
  }
  final HomeRepository _homeRepository;
  final PageController _postPageController;
  List<Post> _banners = [];
  List<int> _mediaSelectedindexes = [];
  final int _limit = 10;
  int _offset = 0;

  PageController get postPageController => _postPageController;

  void _onComentPostChange(
    ComentPostImageChange event,
    Emitter<BannerState> emit,
  ) {
    emit(
      state.copyWith(
        comentPostIndex: event.index,
        banners: _banners,
        currentIndexBanner: state.currentIndexBanner,
        isEnd: state.isEnd,
        mediaIndexes: state.mediaIndexes,
        failure: state.failure,
      ),
    );
  }

  void _onLikeToPost(LikeToPost event, Emitter<BannerState> emit) {
    for (var post in _banners) {
      if (post.id == event.postId) {
        post.isLiked = !post.isLiked!;
        if (post.isLiked!) {
          post.likesCount = post.likesCount! + 1;
        } else {
          post.likesCount = post.likesCount! - 1;
        }

        emit(
          state.copyWith(
            banners: _banners,
            currentIndexBanner: state.currentIndexBanner,
            isEnd: state.isEnd,
            mediaIndexes: state.mediaIndexes,
            failure: state.failure,
          ),
        );
      }
    }
  }

  void _onInsertComentCount(
    InsertComentToPost event,
    Emitter<BannerState> emit,
  ) {
    for (var post in _banners) {
      if (post.id == event.postId) {
        post.commentCount = post.commentCount! + 1;
        emit(
          state.copyWith(
            banners: _banners,
            currentIndexBanner: state.currentIndexBanner,
            isEnd: state.isEnd,
            mediaIndexes: state.mediaIndexes,
            failure: state.failure,
          ),
        );
      }
    }
  }

  void _onBannerIndexChanged(
    BannerIndexChangedEvent event,
    Emitter<BannerState> emit,
  ) {
    emit(
      state.copyWith(currentIndexBanner: event.index, banners: state.banners),
    );
  }

  void _onPostIndexChanged(
    PostIndexChangedEvent event,
    Emitter<BannerState> emit,
  ) {
    _mediaSelectedindexes[event.postIndex] = event.mediaIndex;
    emit(
      state.copyWith(
        mediaIndexes: _mediaSelectedindexes,
        banners: state.banners,
      ),
    );
  }

  Future<void> _onGetBanners(
    GetBannersEvent event,
    Emitter<BannerState> emit,
  ) async {
    if (state.isEnd) return;
    if (event.isRefresh) _offset = 0;
    if (state.showLoading) return;
    emit(state.copyWith(banners: state.banners, showLoading: true));

    final result = await _homeRepository.getBanners(
      limit: _limit,
      offset: _offset,
    );
    if (result.isRight) {
      _addOffset(result.right, event);
      emit(
        state.copyWith(
          failure: 'No',
          banners: _banners,
          isEnd: _banners.length < _offset,
          mediaIndexes: _mediaSelectedindexes,
          showLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          banners: state.banners,
          failure: result.left.message,
          showLoading: false,
        ),
      );
    }
  }

  void _addOffset(PostsModel r, GetBannersEvent event) {
    _offset += 10;
    if (event.isRefresh) {
      _mediaSelectedindexes = List.filled(r.results!.length, 0);
      _banners = r.results!;
    } else {
      _banners.addAll(r.results!);
    }
  }
}

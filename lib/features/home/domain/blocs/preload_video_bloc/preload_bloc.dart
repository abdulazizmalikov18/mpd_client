import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/posts_model.dart';

part 'preload_event.dart';
part 'preload_state.dart';

class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  PreloadBloc() : super(PreloadState(controllers: {}, urls: [], focusedIndex: [], reloadCounter: 0)) {
    on<FillVideoIndex>(_onFillVideoIndex);
    on<GetVideoesFromList>(_onGetVideoUrls);
    on<VideoIndexChanged>(_onVideoIndexChanged);
  }

  List<int> focusedIndexes = [];

  void _onFillVideoIndex(FillVideoIndex event, Emitter<PreloadState> emit) {
    final more = List.filled(event.length, 0);
    focusedIndexes.addAll(more);
    emit(state.copyWith(focusedIndex: focusedIndexes));
  }

  Future<void> _onGetVideoUrls(GetVideoesFromList event, Emitter<PreloadState> emit) async {
    final filledUrls = [...event.urls];
    state.urls = filledUrls;

    /// Initialize 1st video
    await _initializeControllerAtIndex(event.baseIndex, 0);

    // /// Play 1st video
    // _playControllerAtIndex(0);

    /// Initialize 2nd video
    _initializeControllerAtIndex(event.baseIndex, 1);
    emit(state.copyWith(reloadCounter: state.reloadCounter + 1, focusedIndex: state.focusedIndex));
  }

  Future<void> _onVideoIndexChanged(VideoIndexChanged event, Emitter<PreloadState> emit) async {
    // if (event.baseIndex > 0 &&
    //     state.urls[event.baseIndex - 1]['videoes']!.length == 1) {
    //   state.focusedIndex = 0;
    // }

    /// Next / Prev video decider
    if (event.index > state.focusedIndex[event.baseIndex]) {
      await _playNext(event.baseIndex, event.index);
      state.focusedIndex[event.baseIndex] = event.index;

      emit(state.copyWith(focusedIndex: state.focusedIndex));

      return;
    } else {
      _playPrevious(event.baseIndex, event.index);
      state.focusedIndex[event.baseIndex] = event.index;

      emit(state.copyWith(focusedIndex: state.focusedIndex));
      return;
    }
  }

  Future<void> _playNext(int baseIndex, int index) async {
    /// Stop [index - 1] controller

    _stopControllerAtIndex(baseIndex, index - 1);

    /// Dispose [index - 2] controller
    // _disposeControllerAtIndex(index - 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(baseIndex, index);

    /// Image came
    if (state.controllers[baseIndex] == null) return;

    /// Initialize [index + 1] controller
    if (state.controllers[baseIndex]![index + 1] != null &&
        state.controllers[baseIndex]![index + 1]!.value.isInitialized) {
      return;
    }
    await _initializeControllerAtIndex(baseIndex, index + 1);
  }

  Future<void> _playPrevious(int baseIndex, int index) async {
    /// Stop [index + 1] controller
    _stopControllerAtIndex(baseIndex, index + 1);

    /// Dispose [index + 2] controller
    // _disposeControllerAtIndex(index + 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(baseIndex, index);

    /// Initialize [index - 1] controller
    // _initializeControllerAtIndex(index - 1);
  }

  Future _initializeControllerAtIndex(int baseIndex, int index) async {
    if (state.urls[baseIndex].media!.length > index && index >= 0) {
      if (state.urls[baseIndex].media![index].file == null || state.urls[baseIndex].media!.isEmpty) {
        return;
      }

      /// Create new controller
      final VideoPlayerController controller =
          VideoPlayerController.networkUrl(Uri.parse(state.urls[baseIndex].media![index].file!));

      /// Add to [controllers] list
      if (state.controllers[baseIndex] == null) {
        state.controllers[baseIndex] = {index: controller};
      } else {
        state.controllers[baseIndex]!.addEntries({index: controller}.entries);
      }

      /// Initialize
      await controller.initialize();
    }
  }

  void _playControllerAtIndex(int baseIndex, int index) {
    if (state.urls[baseIndex].media!.length > index && index >= 0) {
      if (state.urls[baseIndex].media![index].file == null || state.urls[baseIndex].media!.isEmpty) {
        return;
      }

      /// Get controller at [index]
      final VideoPlayerController controller = state.controllers[baseIndex]![index]!;

      /// Play controller
      controller.play();
      controller.setLooping(true);
    }
  }

  void _stopControllerAtIndex(int baseIndex, int index) {
    if (state.urls[baseIndex].media!.length > index && index >= 0) {
      if (state.urls[baseIndex].media![index].file == null || state.urls[baseIndex].media!.isEmpty) {
        return;
      }

      /// Get controller at [index]
      final VideoPlayerController controller = state.controllers[baseIndex]![index]!;

      /// Pause
      controller.pause();

      /// Reset postiton to beginning
      // controller.seekTo(const Duration());
    }
  }

  // void _disposeControllerAtIndex(int index) {
  //   if (state.urls.length > index && index >= 0) {
  //     /// Get controller at [index]
  //     final VideoPlayerController controller = state.controllers[index];

  //     /// Dispose controller
  //     controller.dispose();

  //     state.controllers.remove(controller);

  //     print('🚀🚀🚀 DISPOSED $index');
  //   }
  // }
}

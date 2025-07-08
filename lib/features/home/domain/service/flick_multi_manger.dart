import 'package:flick_video_player/flick_video_player.dart';

class FlickMultiManager {
  final List<FlickManager?> _flickManagers = [];
  FlickManager? _activeManager;
  bool _isMute = false;

  FlickManager? getFlickManager(String url) {
    final flick = _flickManagers.firstWhere(
        (flickManager) =>
            flickManager!
                .flickVideoManager!.videoPlayerController!.dataSource ==
            url,
        orElse: () => null);

    return flick;
  }

  void init(FlickManager? flickManager) {
    _flickManagers.add(flickManager);

    if (_isMute) {
      flickManager?.flickControlManager?.mute();
    } else {
      flickManager?.flickControlManager?.unmute();
    }
    // if (_flickManagers.length == 1 && flickManager != null) {
    //   play(flickManager);
    // }
  }

  void remove(FlickManager flickManager) {
    if (_activeManager == flickManager) {
      _activeManager = null;
    }
    flickManager.dispose();
    _flickManagers.remove(flickManager);
  }

  void togglePlay(FlickManager flickManager) {
    if (_activeManager?.flickVideoManager?.isPlaying == true &&
        flickManager == _activeManager) {
      pause();
    } else {
      play(flickManager);
    }
  }

  void pause() {
    if (_activeManager != null) _activeManager?.flickControlManager?.pause();
  }

  void play([FlickManager? flickManager]) {
    if (flickManager == null) {
      _activeManager?.flickControlManager?.pause();
      return;
    }
    _activeManager?.flickControlManager?.pause();
    _activeManager = flickManager;

    if (_isMute) {
      _activeManager?.flickControlManager?.mute();
    } else {
      _activeManager?.flickControlManager?.unmute();
    }

    _activeManager?.flickControlManager?.play();
  }

  void toggleMute() {
    _activeManager?.flickControlManager?.toggleMute();
    _isMute = _activeManager?.flickControlManager?.isMute ?? false;
    if (_isMute) {
      for (var manager in _flickManagers) {
        manager?.flickControlManager?.mute();
      }
    } else {
      for (var manager in _flickManagers) {
        manager?.flickControlManager?.unmute();
      }
    }
  }

  void clearAll() {
    for (var flickManager in _flickManagers) {
      flickManager!.dispose();
    }
    _flickManagers.clear();
  }
}

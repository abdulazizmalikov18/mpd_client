import 'package:mpd_client/app/app_images.dart';

enum AppType {
  tmed,
  dasuty,
  mpd,
  sharqdarmon,
  dwed;

  String get cluster => switch (this) {
    AppType.tmed => "t-med",
    AppType.dasuty => "dasuty",
    AppType.dwed => "dwed",
    AppType.mpd => "mpd",
    AppType.sharqdarmon => "sharqdarmon",
  };
  String get appTitle => switch (this) {
    AppType.tmed => "T-MED Kassa",
    AppType.dasuty => "DASUTY TASK",
    AppType.dwed => "DWED TASK",
    AppType.mpd => "MPD KASSA",
    AppType.sharqdarmon => "SHARQDARMON",
  };

  String get logoImage => switch (this) {
    AppType.tmed => AppImages.tmed,
    AppType.dasuty => AppImages.logo,
    AppType.dwed => AppImages.dwed,
    AppType.mpd => AppImages.logo,
    AppType.sharqdarmon => AppImages.logo,
  };

  String get lottie => switch (this) {
    AppType.tmed => 'assets/anim/auth_anima.json',
    AppType.dasuty => 'assets/anim/auth_anima.json',
    AppType.dwed => 'assets/anim/auth_anima.json',
    AppType.mpd => 'assets/anim/auth_anima.json',
    AppType.sharqdarmon => 'assets/anim/aus_shd.json',
  };

  String get updateUrl => switch (this) {
    AppType.dasuty =>
      "https://raw.githubusercontent.com/abdulazizmalikov18/tmed/main/appcast.xml",
    AppType.dwed =>
      "https://api.github.com/repos/abdulazizmalikov18/dwed_task/releases/latest",
    AppType.tmed =>
      "https://api.github.com/repos/abdulazizmalikov18/tmed/releases/latest",
    AppType.mpd =>
      "https://raw.githubusercontent.com/abdulazizmalikov18/mpd/main/appcast.xml",
    AppType.sharqdarmon =>
      'https://api.github.com/repos/abdulazizmalikov18/sharqdarmon/releases/latest',
  };

  String get baseUrl => switch (this) {
    AppType.dasuty => "https://sharq-api.sharqdarmon.uz/",
    AppType.dwed => "https://api.eascompany.uz/",
    AppType.tmed => "https://sharq-api.sharqdarmon.uz/",
    AppType.mpd => "https://api.mpdinfo.uz/",
    AppType.sharqdarmon => "https://sharq-api.sharqdarmon.uz/",
  };

  String get socketUrl => switch (this) {
    AppType.dasuty => "wss://sharq-api.sharqdarmon.uz",
    AppType.dwed => "wss://sharq-api.sharqdarmon.uz",
    AppType.tmed => "wss://sharq-api.sharqdarmon.uz",
    AppType.mpd => "wss://api.mpdinfo.uz",
    AppType.sharqdarmon => "wss://sharq-api.sharqdarmon.uz",
  };
}

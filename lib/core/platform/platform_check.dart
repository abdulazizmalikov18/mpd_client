import 'dart:io';

abstract class PlatformCheck {
  static bool get platform => Platform.isIOS ? true : false;
}

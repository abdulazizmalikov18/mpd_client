import 'package:flutter/cupertino.dart';

class AdverticementInheritedNotifier
    extends InheritedNotifier<AdverticementNotifier> {
  const AdverticementInheritedNotifier({
    super.key,
    required AdverticementNotifier adverticementNotifier,
    required super.child,
  }) : super(notifier: adverticementNotifier);

  static AdverticementInheritedNotifier of(BuildContext context) {
    final AdverticementInheritedNotifier? result = context
        .dependOnInheritedWidgetOfExactType<AdverticementInheritedNotifier>();
    assert(
      result != null,
      'No AdverticementInheritedNotifier found in context',
    );
    return result!;
  }
}

class AdverticementNotifier extends ChangeNotifier {
  int _currentAdvertIndex = 0;
  int get currentAdvertIndex => _currentAdvertIndex;

  void advertChanged(int value) {
    _currentAdvertIndex = value;
    notifyListeners();
  }
}

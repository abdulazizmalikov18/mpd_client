import 'package:flutter/cupertino.dart';

class TutorialInheritedNotifier extends InheritedNotifier<TutorialNotifier> {
  const TutorialInheritedNotifier(
      {super.key,
      required TutorialNotifier tutorialNotifier,
      required super.child})
      : super(notifier: tutorialNotifier);

  static TutorialInheritedNotifier of(BuildContext context) {
    final TutorialInheritedNotifier? result =
        context.dependOnInheritedWidgetOfExactType<TutorialInheritedNotifier>();
    assert(result != null, 'No TutorialInheritedNotifier found in context');
    return result!;
  }
}

class TutorialNotifier extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}

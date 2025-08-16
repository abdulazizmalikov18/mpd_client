import 'package:flutter/cupertino.dart';

class AuthInheritedNotifier extends InheritedNotifier<AuthNotifier> {
  const AuthInheritedNotifier({
    super.key,
    required AuthNotifier authNotifier,
    required super.child,
  }) : super(notifier: authNotifier);

  static AuthInheritedNotifier of(BuildContext context) {
    final AuthInheritedNotifier? result = context
        .dependOnInheritedWidgetOfExactType<AuthInheritedNotifier>();
    assert(result != null, 'No AuthInheritedNotifier found in context');
    return result!;
  }
}

class AuthNotifier extends ChangeNotifier {
  bool _remember = true;
  bool _isSignIn = true;

  final ScrollController _controller = ScrollController();

  int _currentIndex = 0;

  bool get remember => _remember;
  bool get isSignIn => _isSignIn;
  int get currentIndex => _currentIndex;
  ScrollController get controller => _controller;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set remember(bool isChecked) {
    _remember = isChecked;
    notifyListeners();
  }

  void setAuthPage() {
    _isSignIn = !_isSignIn;
    notifyListeners();
  }

  void topScroll() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }
}

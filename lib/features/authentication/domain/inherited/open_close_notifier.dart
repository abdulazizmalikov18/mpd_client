import 'package:flutter/cupertino.dart';

class OpenCloseExpansionInheritedNotifier
    extends InheritedNotifier<OpenCloseNotifier> {
  const OpenCloseExpansionInheritedNotifier({
    super.key,
    required OpenCloseNotifier openCloseNotifier,
    required super.child,
  }) : super(notifier: openCloseNotifier);

  static OpenCloseExpansionInheritedNotifier of(BuildContext context) {
    final OpenCloseExpansionInheritedNotifier? result =
        context.dependOnInheritedWidgetOfExactType<
            OpenCloseExpansionInheritedNotifier>();
    assert(result != null,
        'No OpenCloseExpansionInheritedNotifier found in context');
    return result!;
  }
}

class OpenCloseNotifier extends ChangeNotifier {
  int selectedTile = -1;

  set selectTile(int value) {
    selectedTile = value;
    notifyListeners();
  }
}

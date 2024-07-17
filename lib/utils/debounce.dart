import 'dart:async';
import 'dart:ui';

Timer? _debounce;

void onDebounce(VoidCallback func,
    [Duration duration = const Duration(milliseconds: 400)]) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(duration, func);
}

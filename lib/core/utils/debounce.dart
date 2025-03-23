import 'dart:async';

Timer? _debounce;

void onDebounce(Function func, [Duration duration = const Duration(milliseconds: 400)]) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(duration, () {
    func();
  });
}
String secondToTime(int second) {
  String time = '00:';

  if (second < 60) {
    time += _getSecond(second);
  } else {
    int minute = second ~/ 60;
    int s = second % 60;

    if (minute < 10) {
      time = '0$minute:';
    } else {
      time = "$minute:";
    }

    time += _getSecond(s);
  }

  return time;
}

String _getSecond(int second) {
  if (second < 10) {
    return '0$second';
  } else {
    return second.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/src/widgets/intepolate.dart';

class StrokePaint extends CustomPainter {
  final double progress;
  final p1 = const Offset(4, 20);
  final p2 = const Offset(20, 4);
  final interpolateY = Interpolate(
    inputRange: [0, 1],
    outputRange: [20, 4],
    extrapolate: Extrapolate.clamp,
  );
  final interpolateX = Interpolate(
    inputRange: [0, 1],
    outputRange: [4, 20],
    extrapolate: Extrapolate.clamp,
  );

  StrokePaint(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final interpolateW = Interpolate(
      inputRange: [0, 1],
      outputRange: [size.width, 5],
      extrapolate: Extrapolate.clamp,
    );
    final interpolateH = Interpolate(
      inputRange: [0, 1],
      outputRange: [4, size.height - 5],
      extrapolate: Extrapolate.clamp,
    );
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..color = greyText.withValues(alpha: 0.7);
    final paint2 = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..color = greyText.withValues(alpha: 0.7);
    final finalPainter = progress == 1 ? Paint() : paint;
    final path = Path()
      ..moveTo(interpolateH.eval(progress), interpolateW.eval(progress) - 3)
      ..lineTo(size.width - 4, 3)
      ..lineTo(size.width - 3, 6)
      ..lineTo(
        interpolateH.eval(progress) + 1,
        interpolateW.eval(progress) - 2,
      );
    canvas
      ..drawPath(path, paint2)
      ..drawLine(
        Offset(interpolateX.eval(progress), interpolateY.eval(progress)),
        p2,
        finalPainter,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}

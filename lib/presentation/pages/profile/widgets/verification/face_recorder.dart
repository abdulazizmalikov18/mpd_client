// import 'dart:math';

// import 'package:flutter/material.dart';

// class WPaintVideoRecord extends StatelessWidget {
//   final double height;
//   final double width;
//   final double percentage;
//   final String image;
//   const WPaintVideoRecord({
//     super.key,
//     required this.percentage,
//     required this.height,
//     required this.width,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CustomPaint(
//             size: Size(
//               width,
//               height,
//             ),
//             painter: RPSCustomPainter(percentage: percentage),
//           ),
//           Image.asset(
//             image,
//             width: width + 100,
//             height: height,
//             fit: BoxFit.cover,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RPSCustomPainter extends CustomPainter {
//   final double percentage;
//   const RPSCustomPainter({
//     required this.percentage,
//   });

//   deg2Rand(double deg) => deg * pi / 180;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final radius = size.width / 2;
//     final sweepAngle = deg2Rand(360 * percentage);
//     final theta = deg2Rand(-90) + sweepAngle;

//     final midOffset = Offset(radius, radius);
//     final endOffset =
//         Offset(radius + radius * cos(theta), radius + radius * sin(theta));

//     // final midEndDiff = sqrt(pow(endOffset.dx - midOffset.dx, 2) +
//     //     pow(endOffset.dy - midOffset.dy, 2));

//     final paint = Paint()
//       ..strokeCap = StrokeCap.round
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     canvas.drawLine(
//       Offset(midOffset.dy, 10),
//       Offset(midOffset.dy, -10),
//       paint,
//     );
//     canvas.drawArc(
//       Rect.fromCenter(
//           center: midOffset, width: size.width, height: size.height),
//       deg2Rand(-90),
//       sweepAngle,
//       false,
//       paint,
//     );
//     // canvas.drawLine(
//     //   Offset(endOffset.dx + (10 / midEndDiff) * (endOffset.dx - midOffset.dx),
//     //       endOffset.dy + (10 / midEndDiff) * (endOffset.dy - midOffset.dy)),
//     //   Offset(endOffset.dx - (10 / midEndDiff) * (endOffset.dx - midOffset.dx),
//     //       endOffset.dy - (10 / midEndDiff) * (endOffset.dy - midOffset.dy)),
//     //   paint,
//     // );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
// // //Copy this CustomPainter code to the Bottom of the File
// // class RPSCustomPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     Paint paint0Fill = Paint()..style = PaintingStyle.fill;
// //     paint0Fill.color = Colors.white.withOpacity(1.0);
// //     canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.5015404, size.height * 0.4999646), width: size.width * 0.9937888, height: size.height), paint0Fill);

// //     Path path_1 = Path();
// //     path_1.moveTo(size.width * 0.5015404, size.height * 0.6347917);
// //     path_1.cubicTo(size.width * 0.5903410, size.height * 0.6347917, size.width * 0.6623292, size.height * 0.5744271, size.width * 0.6623292, size.height * 0.4999646);
// //     path_1.cubicTo(size.width * 0.6623292, size.height * 0.4255016, size.width * 0.5903410, size.height * 0.3651375, size.width * 0.5015404, size.height * 0.3651375);
// //     path_1.cubicTo(size.width * 0.4127404, size.height * 0.3651375, size.width * 0.3407534, size.height * 0.4255016, size.width * 0.3407534, size.height * 0.4999646);
// //     path_1.cubicTo(size.width * 0.3407534, size.height * 0.5744271, size.width * 0.4127404, size.height * 0.6347917, size.width * 0.5015404, size.height * 0.6347917);
// //     path_1.close();
// //     path_1.moveTo(size.width * 0.5015404, size.height * 0.6457969);
// //     path_1.cubicTo(size.width * 0.5975901, size.height * 0.6457969, size.width * 0.6754534, size.height * 0.5805052, size.width * 0.6754534, size.height * 0.4999646);
// //     path_1.cubicTo(size.width * 0.6754534, size.height * 0.4194229, size.width * 0.5975901, size.height * 0.3541313, size.width * 0.5015404, size.height * 0.3541313);
// //     path_1.cubicTo(size.width * 0.4054913, size.height * 0.3541313, size.width * 0.3276273, size.height * 0.4194229, size.width * 0.3276273, size.height * 0.4999646);
// //     path_1.cubicTo(size.width * 0.3276273, size.height * 0.5805052, size.width * 0.4054913, size.height * 0.6457969, size.width * 0.5015404, size.height * 0.6457969);
// //     path_1.close();

// //     Paint paint1Fill = Paint()..style = PaintingStyle.fill;
// //     paint1Fill.color = Colors.white.withOpacity(1.0);
// //     canvas.drawPath(path_1, paint1Fill);

// //     Path path_2 = Path();
// //     path_2.moveTo(size.width * 0.5310627, size.height * 0.5772135);
// //     path_2.cubicTo(size.width * 0.5327422, size.height * 0.5802448, size.width * 0.5311720, size.height * 0.5838437, size.width * 0.5275559, size.height * 0.5852500);
// //     path_2.cubicTo(size.width * 0.5108441, size.height * 0.5917604, size.width * 0.4942876, size.height * 0.5929531, size.width * 0.4807217, size.height * 0.5877292);
// //     path_2.cubicTo(size.width * 0.4669621, size.height * 0.5824375, size.width * 0.4579907, size.height * 0.5712031, size.width * 0.4550441, size.height * 0.5559635);
// //     path_2.lineTo(size.width * 0.4692957, size.height * 0.5540260);
// //     path_2.cubicTo(size.width * 0.4716764, size.height * 0.5663385, size.width * 0.4784019, size.height * 0.5735156, size.width * 0.4867447, size.height * 0.5767292);
// //     path_2.cubicTo(size.width * 0.4952820, size.height * 0.5800156, size.width * 0.5072342, size.height * 0.5798177, size.width * 0.5214752, size.height * 0.5742708);
// //     path_2.cubicTo(size.width * 0.5250913, size.height * 0.5728646, size.width * 0.5293839, size.height * 0.5741771, size.width * 0.5310627, size.height * 0.5772135);
// //     path_2.close();

// //     Paint paint2Fill = Paint()..style = PaintingStyle.fill;
// //     paint2Fill.color = const Color(0xffF0F0F0).withOpacity(1.0);
// //     canvas.drawPath(path_2, paint2Fill);

// //     Path path_3 = Path();
// //     path_3.moveTo(size.width * 0.5113845, size.height * 0.5164734);
// //     path_3.lineTo(size.width * 0.5113845, size.height * 0.4917094);
// //     path_3.lineTo(size.width * 0.5245099, size.height * 0.4917094);
// //     path_3.lineTo(size.width * 0.5245099, size.height * 0.5274792);
// //     path_3.lineTo(size.width * 0.4884149, size.height * 0.5274792);
// //     path_3.lineTo(size.width * 0.4884149, size.height * 0.5164734);
// //     path_3.lineTo(size.width * 0.5113845, size.height * 0.5164734);
// //     path_3.close();

// //     Paint paint3Fill = Paint()..style = PaintingStyle.fill;
// //     paint3Fill.color = const Color(0xffF0F0F0).withOpacity(1.0);
// //     canvas.drawPath(path_3, paint3Fill);

// //     Path path_4 = Path();
// //     path_4.moveTo(size.width * 0.5934217, size.height * 0.4641922);
// //     path_4.cubicTo(size.width * 0.5934217, size.height * 0.4702708, size.width * 0.5875453, size.height * 0.4751984, size.width * 0.5802963, size.height * 0.4751984);
// //     path_4.cubicTo(size.width * 0.5730472, size.height * 0.4751984, size.width * 0.5671708, size.height * 0.4702708, size.width * 0.5671708, size.height * 0.4641922);
// //     path_4.cubicTo(size.width * 0.5671708, size.height * 0.4581135, size.width * 0.5730472, size.height * 0.4531859, size.width * 0.5802963, size.height * 0.4531859);
// //     path_4.cubicTo(size.width * 0.5875453, size.height * 0.4531859, size.width * 0.5934217, size.height * 0.4581135, size.width * 0.5934217, size.height * 0.4641922);
// //     path_4.close();

// //     Paint paint4Fill = Paint()..style = PaintingStyle.fill;
// //     paint4Fill.color = const Color(0xffF0F0F0).withOpacity(1.0);
// //     canvas.drawPath(path_4, paint4Fill);

// //     Path path_5 = Path();
// //     path_5.moveTo(size.width * 0.4359099, size.height * 0.4641922);
// //     path_5.cubicTo(size.width * 0.4359099, size.height * 0.4702708, size.width * 0.4300335, size.height * 0.4751984, size.width * 0.4227845, size.height * 0.4751984);
// //     path_5.cubicTo(size.width * 0.4155354, size.height * 0.4751984, size.width * 0.4096590, size.height * 0.4702708, size.width * 0.4096590, size.height * 0.4641922);
// //     path_5.cubicTo(size.width * 0.4096590, size.height * 0.4581135, size.width * 0.4155354, size.height * 0.4531859, size.width * 0.4227845, size.height * 0.4531859);
// //     path_5.cubicTo(size.width * 0.4300335, size.height * 0.4531859, size.width * 0.4359099, size.height * 0.4581135, size.width * 0.4359099, size.height * 0.4641922);
// //     path_5.close();

// //     Paint paint5Fill = Paint()..style = PaintingStyle.fill;
// //     paint5Fill.color = const Color(0xffF0F0F0).withOpacity(1.0);
// //     canvas.drawPath(path_5, paint5Fill);

// //     Path path_6 = Path();
// //     path_6.moveTo(size.width * 0.9984348, size.height * 0.4999646);
// //     path_6.cubicTo(size.width * 0.9984348, size.height * 0.7761042, size.width * 0.7759689, size.height * 0.9999635, size.width * 0.5015404, size.height * 0.9999635);
// //     path_6.cubicTo(size.width * 0.2271137, size.height * 0.9999635, size.width * 0.004646255, size.height * 0.7761042, size.width * 0.004646255, size.height * 0.4999646);
// //     path_6.cubicTo(size.width * 0.004646255, size.height * 0.2238219, size.width * 0.2271137, size.height * -0.00003560385, size.width * 0.5015404, size.height * -0.00003560385);
// //     path_6.cubicTo(size.width * 0.7759689, size.height * -0.00003560385, size.width * 0.9984348, size.height * 0.2238219, size.width * 0.9984348, size.height * 0.4999646);
// //     path_6.close();
// //     path_6.moveTo(size.width * 0.02375037, size.height * 0.4999646);
// //     path_6.cubicTo(size.width * 0.02375037, size.height * 0.7654896, size.width * 0.2376646, size.height * 0.9807396, size.width * 0.5015404, size.height * 0.9807396);
// //     path_6.cubicTo(size.width * 0.7654161, size.height * 0.9807396, size.width * 0.9793292, size.height * 0.7654896, size.width * 0.9793292, size.height * 0.4999646);
// //     path_6.cubicTo(size.width * 0.9793292, size.height * 0.2344391, size.width * 0.7654161, size.height * 0.01918792, size.width * 0.5015404, size.height * 0.01918792);
// //     path_6.cubicTo(size.width * 0.2376646, size.height * 0.01918792, size.width * 0.02375037, size.height * 0.2344391, size.width * 0.02375037, size.height * 0.4999646);
// //     path_6.close();

// //     Paint paint6Fill = Paint()..style = PaintingStyle.fill;
// //     paint6Fill.color = const Color(0xffF0F0F0).withOpacity(1.0);
// //     canvas.drawPath(path_6, paint6Fill);
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return true;
// //   }
// // }

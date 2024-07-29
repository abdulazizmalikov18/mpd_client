import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class BottomSheetWidget extends StatelessWidget {
  final List<Widget> children;

  const BottomSheetWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.r),
                color: trapezia,
              ),
            ),
          ),
          ClipPath(
            clipper: MyClip(),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width * 0.5923077, 0);

    path0.quadraticBezierTo(size.width * 0.5800000, size.height * 0.0008857, size.width * 0.5615385, 9);

    path0.quadraticBezierTo(size.width * 0.5562051, 12, size.width * 0.5000513, 12);

    path0.quadraticBezierTo(size.width * 0.4427179, 12, size.width * 0.4384615, 9);

    path0.quadraticBezierTo(size.width * 0.4232051, size.height * 0.0009143, size.width * 0.4075897, 0);

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

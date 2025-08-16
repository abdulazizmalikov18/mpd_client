import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/themes/styles.dart';

class AppointmentTimeWidget extends StatefulWidget {
  final String time;
  final bool isBooked;
  final bool selected;
  final VoidCallback? onTap;
  const AppointmentTimeWidget({
    super.key,
    this.selected = false,
    this.isBooked = false,
    this.onTap,
    required this.time,
  });

  @override
  State<AppointmentTimeWidget> createState() => _AppointmentTimeWidgetState();
}

class _AppointmentTimeWidgetState extends State<AppointmentTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: widget.isBooked ? context.color.background : context.color.white,
        gradient: widget.selected
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.color.gradientBlueOpacity,
                  context.color.gradientBlue,
                ],
              )
            : null,
        border: widget.isBooked
            ? Border.all(width: 1, color: context.color.grey)
            : !widget.selected
            ? Border.all(width: 1, color: context.color.transparentBorder)
            : Border.all(width: 1, color: Colors.transparent),
      ),
      // height: 42.h,
      // width: 112.w,
      child: CustomPaint(
        foregroundPainter: widget.isBooked
            ? LinePainter(color: context.color.grey)
            : null,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: widget.isBooked ? null : widget.onTap,
          child: Text(
            widget.time,
            style: Styles.headline7.copyWith(
              fontSize: 14.sp,
              color: widget.isBooked
                  ? context.color.grey
                  : widget.selected
                  ? context.color.white
                  : context.color.black,
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Color color;
  const LinePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset(2, 4);
    final p2 = Offset(size.width - 2, size.height - 4);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}

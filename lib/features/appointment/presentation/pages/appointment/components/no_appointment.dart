import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/text_button_widget.dart';

class NoAppointment extends StatelessWidget {
  const NoAppointment({
    super.key,
    this.isServer = false,
    required this.title,
    required this.subtitle,
    required this.buttonName,
    required this.onPressed,
    this.onRefresh,
  });

  final bool isServer;
  final String title, subtitle, buttonName;
  final VoidCallback onPressed;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isServer
              ? Image.asset(
                  'assets/images/server_appointment_error.png',
                  height: 250.h,
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  'assets/images/notAppoint.png',
                  height: 130.h,
                  fit: BoxFit.contain,
                ),
          ScreenUtil().setVerticalSpacing(23.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Styles.boldTopHint.copyWith(fontSize: 22),
          ),
          ScreenUtil().setVerticalSpacing(8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Styles.descSubtitle.copyWith(color: context.color.grey),
          ),
          ScreenUtil().setVerticalSpacing(32.h),
          LongButton(buttonName: buttonName, onPress: onPressed),
          if (isServer) ScreenUtil().setVerticalSpacing(16.h),
          if (isServer)
            TextButtonWidget(
              onPressed: onRefresh,
              text: context.l10n.appointment_server_error_reload,
            )
        ],
      ),
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/filled_gradient_button.dart';

import 'text_button_widget.dart';

class ErrorTypeWidget extends StatelessWidget {
  final String errorIcon, errorTitle, errorSubtitle;
  final VoidCallback tryAgainPressed;
  final VoidCallback? returnToHomePressed;
  final bool hasReturnButton;
  const ErrorTypeWidget(
      {super.key,
      this.returnToHomePressed,
      this.hasReturnButton = true,
      required this.tryAgainPressed,
      required this.errorIcon,
      required this.errorSubtitle,
      required this.errorTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(errorIcon, height: 250.h),
        ScreenUtil().setVerticalSpacing(32.h),
        Text(errorTitle, textAlign: TextAlign.center, style: Styles.title),
        ScreenUtil().setVerticalSpacing(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Text(
            errorSubtitle,
            textAlign: TextAlign.center,
            style: Styles.headline7Bold.copyWith(color: context.color.grey),
          ),
        ),
        ScreenUtil().setVerticalSpacing(40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.w),
          child: FilledGradientButton(
              height: 50,
              onPressed: tryAgainPressed,
              text: Text(
                context.l10n.error_try_again,
                style: Styles.headline7Bold.copyWith(fontSize: 16.sp),
              )),
        ),
        if (hasReturnButton) ScreenUtil().setVerticalSpacing(20.h),
        if (hasReturnButton)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: TextButtonWidget(
              onPressed: returnToHomePressed,
              text: context.l10n.error_return_tohome,
            ),
          )
      ],
    );
  }
}

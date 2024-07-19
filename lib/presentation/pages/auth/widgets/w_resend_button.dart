import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class WResendButton extends StatefulWidget {
  final void Function()? resentOtp;
  final int resentSMSSecond;

  const WResendButton({
    super.key,
    this.resentSMSSecond = 5,
    this.resentOtp,
  });

  @override
  State<WResendButton> createState() => _WResendButtonState();
}

class _WResendButtonState extends State<WResendButton> {
  Timer? timer;
  int time = 0;

  void startTimer() {
    time = widget.resentSMSSecond;
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (time <= 1) {
          stopTimer();
        }
        setState(() {
          time--;
        });
      },
    );
  }

  void stopTimer() {
    timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void resentSms() {
    widget.resentOtp?.call();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!timer!.isActive)
            InkWell(
              onTap: resentSms,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // AppIcons.refresh.svg(),
                  const SizedBox(width: 8),
                  Text(
                    "SMS qaytadan yuborish",
                    style: AppTheme.headlineSmall.copyWith(
                      fontWeight: FontWeight.w500,

                      color: white,
                    ),
                  ),
                ],
              ),
            ),
          if (timer!.isActive)
            Text.rich(
              TextSpan(
                style: AppTheme.labelSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: white,
                ),
                children: [
                  const TextSpan(text: 'Kod '),
                  TextSpan(
                    text: '0:${time.toString().padLeft(2, '0')}',
                    style: AppTheme.labelSmall.copyWith(
                      fontWeight: FontWeight.w500,

                      color: primary,
                    ),
                  ),
                  const TextSpan(text: ' keyin qayta yuboriladi'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

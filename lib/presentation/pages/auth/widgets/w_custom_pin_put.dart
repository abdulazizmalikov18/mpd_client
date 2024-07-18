import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:pinput/pinput.dart';

class WCustomPinPut extends StatelessWidget {
  final void Function(String pin) onComplete;
  final TextEditingController pinController;
  final ValueNotifier<String?> hasError;

  const WCustomPinPut({
    super.key,
    required this.pinController,
    required this.onComplete,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hasError,
      builder: (BuildContext context, String? error, Widget? child) {
        return Pinput(
          controller: pinController,
          obscureText: true,
          onSubmitted: onComplete,
          onChanged: (value) {
            if (error != null) {
              hasError.value = null;
            }
          },
          // errorText: error,
          forceErrorState: error != null && error != 'success',
          obscuringWidget: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: error != null ? (error == 'success' ? green : red) : primary,
              shape: BoxShape.circle,
            ),
          ),
          defaultPinTheme: PinTheme(
            height: 14,
            width: 14,
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: error == 'success' ? green : primary,
              shape: BoxShape.circle,
            ),
          ),
          focusedPinTheme: PinTheme(
            height: 14,
            width: 14,
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: error == 'success' ? green : primary,
              shape: BoxShape.circle,
            ),
          ),
          followingPinTheme: PinTheme(
            height: 14,
            width: 14,
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
          errorPinTheme:  PinTheme(
            height: 14,
            width: 14,
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: error == 'success' ? green : red,
              shape: BoxShape.circle,
            ),
          ),
          onCompleted: onComplete,
        );
      },
    );
  }
}

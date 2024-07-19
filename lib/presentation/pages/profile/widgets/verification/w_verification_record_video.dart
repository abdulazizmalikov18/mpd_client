import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';

class WVerificationVideRecorder extends StatefulWidget {
  const WVerificationVideRecorder({super.key});

  @override
  State<WVerificationVideRecorder> createState() => _WVerificationVideRecorderState();
}

class _WVerificationVideRecorderState extends State<WVerificationVideRecorder> {
  ValueNotifier<int> milliseconds = ValueNotifier(0);
  late Timer? timer;

  void startButton() {
    setState(() {
      status.value = FormzSubmissionStatus.inProgress;
    });
    timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      if (milliseconds.value >= 3600) {
        stop();
        timer!.cancel();
        return;
      }
      milliseconds.value++;
    });
  }

  void stop() {
    setState(() {
      status.value = FormzSubmissionStatus.success;
    });
  }

  ValueNotifier<FormzSubmissionStatus> status = ValueNotifier(FormzSubmissionStatus.initial);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTheme.bodySmall.copyWith(color: black),
            children: [
              TextSpan(
                text: "Face video",
                style: AppTheme.bodySmall.copyWith(color: black),
              ),
              const TextSpan(
                text: '*',
                style: TextStyle(color: red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(100),
              //   child: SizedBox(
              //     width: MediaQuery.sizeOf(context).width * 0.5,
              //     height: MediaQuery.sizeOf(context).width * 0.5,
              //     child: const WFaceRegocnizerCamera(),
              //   ),
              // ),
              // ValueListenableBuilder(
              //   valueListenable: milliseconds,
              //   builder: (BuildContext context, dynamic value, Widget? child) {
              //     return GradientCircularProgressIndicator(
              //       radius: 100,
              //       gradientColors: wgradient.colors,
              //       strokeWidth: 2,
              //       value: value / 3600,
              //     );
              //   },
              // ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: ValueListenableBuilder(
            valueListenable: status,
            builder: (BuildContext context, value, Widget? child) {
              return WButton(
                color: status.value == FormzSubmissionStatus.success ? const Color(0xFF00C1C1) : scaffoldSecondaryBackground,
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.3,
                onTap: () {
                  startButton();
                },
                child: status.value == FormzSubmissionStatus.initial
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // AppIcons.icHome.svg(),
                          const SizedBox(width: 8),
                          Text(
                            'Boshlash',
                            style: AppTheme.labelSmall.copyWith(
                              color: black,
                            ),
                          ),
                        ],
                      )
                    : (status.value == FormzSubmissionStatus.success
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Tayyor',
                                style: AppTheme.labelSmall.copyWith(
                                  color: white,
                                ),
                              )
                            ],
                          )
                        : Container(
                            color: black,
                          ) /*const SpinKitCircle(
                            size: 30,
                            color: black,
                          )*/
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/chat/presentation/controller/api.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/recording_indicator.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/spacer.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:videosdk/videosdk.dart';

class MeetingAppBar extends StatefulWidget {
  final String token;
  final Room meeting;
  final String recordingState;
  final bool isFullScreen;
  const MeetingAppBar({
    super.key,
    required this.meeting,
    required this.token,
    required this.isFullScreen,
    required this.recordingState,
  });

  @override
  State<MeetingAppBar> createState() => MeetingAppBarState();
}

class MeetingAppBarState extends State<MeetingAppBar> {
  Duration? elapsedTime;
  Timer? sessionTimer;

  List<VideoDeviceInfo>? cameras = [];

  @override
  void initState() {
    startTimer();
    fetchCameras();
    super.initState();
  }

  void fetchCameras() async {
    cameras = await VideoSDK.getVideoDevices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: !widget.isFullScreen
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        secondChild: const SizedBox.shrink(),
        firstChild: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 8.0, 0.0),
          child: Row(
            children: [
              if (widget.recordingState == "RECORDING_STARTING" ||
                  widget.recordingState == "RECORDING_STOPPING" ||
                  widget.recordingState == "RECORDING_STARTED")
                RecordingIndicator(recordingState: widget.recordingState),
              if (widget.recordingState == "RECORDING_STARTING" ||
                  widget.recordingState == "RECORDING_STOPPING" ||
                  widget.recordingState == "RECORDING_STARTED")
                const HorizontalSpacer(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.meeting.id,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Icon(Icons.copy, size: 16),
                          ),
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: widget.meeting.id),
                            );
                            CustomSnackbar.show(
                              context,
                              "Meeting ID has been copied.",
                            );
                          },
                        ),
                      ],
                    ),
                    // VerticalSpacer(),
                    Text(
                      elapsedTime == null
                          ? "00:00:00"
                          : elapsedTime.toString().split(".").first,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: AppIcons.icSwitchCamera.svg(
                  width: 24,
                  height: 24,
                  color: context.color.black,
                ),
                onPressed: () {
                  VideoDeviceInfo? newCam = cameras?.firstWhere(
                    (camera) =>
                        camera.deviceId != widget.meeting.selectedCam?.deviceId,
                  );
                  if (newCam != null) {
                    widget.meeting.changeCam(newCam);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startTimer() async {
    dynamic session = await fetchSession(widget.token, widget.meeting.id);
    DateTime sessionStartTime = DateTime.parse(session['start']);
    final difference = DateTime.now().difference(sessionStartTime);

    setState(() {
      elapsedTime = difference;
      sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          elapsedTime = Duration(
            seconds: elapsedTime != null ? elapsedTime!.inSeconds + 1 : 0,
          );
        });
      });
    });
    // log("session start time" + session.data[0].start.toString());
  }

  @override
  void dispose() {
    if (sessionTimer != null) {
      sessionTimer!.cancel();
    }
    super.dispose();
  }
}

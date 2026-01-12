import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/constants/colors.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/spacer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

// Meeting ActionBar
class MeetingActionBar extends StatelessWidget {
  // control states
  final bool isMicEnabled, isCamEnabled, isScreenShareEnabled;
  final String recordingState;

  // callback functions
  final void Function() onCallEndButtonPressed,
      onCallLeaveButtonPressed,
      onMicButtonPressed,
      onCameraButtonPressed,
      onChatButtonPressed;

  final void Function(String) onMoreOptionSelected;

  final void Function(TapDownDetails) onSwitchMicButtonPressed;
  const MeetingActionBar({
    super.key,
    required this.isMicEnabled,
    required this.isCamEnabled,
    required this.isScreenShareEnabled,
    required this.recordingState,
    required this.onCallEndButtonPressed,
    required this.onCallLeaveButtonPressed,
    required this.onMicButtonPressed,
    required this.onSwitchMicButtonPressed,
    required this.onCameraButtonPressed,
    required this.onMoreOptionSelected,
    required this.onChatButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            padding: const EdgeInsets.all(0),
            color: Colors.black,
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red),
                color: Colors.red,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.call_end, size: 30, color: Colors.white),
            ),
            offset: const Offset(0, -185),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) => {
              if (value == "leave")
                onCallLeaveButtonPressed()
              else if (value == "end")
                onCallEndButtonPressed(),
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              _buildMeetingPoupItem(
                "leave",
                "Leave",
                "Only you will leave the call",
                AppIcons.icLeave.svg(width: 20, height: 20),
              ),
              const PopupMenuDivider(),
              _buildMeetingPoupItem(
                "end",
                "End",
                "End call for all participants",
                AppIcons.icLeave.svg(width: 20, height: 20),
              ),
            ],
          ),

          // Mic Control
          TouchRippleEffect(
            borderRadius: BorderRadius.circular(12),
            rippleColor: isMicEnabled ? primaryColor : Colors.white,
            onTap: onMicButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: secondaryColor),
                color: isMicEnabled ? primaryColor : Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    isMicEnabled ? Icons.mic : Icons.mic_off,
                    size: 30,
                    color: isMicEnabled ? Colors.white : primaryColor,
                  ),
                  GestureDetector(
                    onTapDown: (details) => {onSwitchMicButtonPressed(details)},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: isMicEnabled ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Camera Control
          TouchRippleEffect(
            borderRadius: BorderRadius.circular(12),
            rippleColor: Colors.blue,
            onTap: onCameraButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                color: isCamEnabled ? Colors.blue : Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: isCamEnabled
                  ? AppIcons.icVideo.svg(
                      width: 26,
                      height: 26,
                      color: Colors.white,
                    )
                  : AppIcons.icVideoOff.svg(
                      width: 26,
                      height: 26,
                      color: primaryColor,
                    ),
            ),
          ),

          TouchRippleEffect(
            borderRadius: BorderRadius.circular(12),
            rippleColor: Colors.blue,
            onTap: onChatButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                color: Colors.blue,
              ),
              padding: const EdgeInsets.all(10),
              child: AppIcons.icChat.svg(
                width: 26,
                height: 26,
                color: Colors.white,
              ),
            ),
          ),

          // More options
          PopupMenuButton(
            position: PopupMenuPosition.under,
            padding: const EdgeInsets.all(0),
            color: Colors.black,
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                // color: red,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.more_vert, size: 30),
            ),
            offset: const Offset(0, -250),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) => {onMoreOptionSelected(value.toString())},
            itemBuilder: (context) => <PopupMenuEntry>[
              _buildMeetingPoupItem(
                "recording",
                recordingState == "RECORDING_STARTED"
                    ? "Stop Recording"
                    : recordingState == "RECORDING_STARTING"
                    ? "Recording is starting"
                    : "Start Recording",
                null,
                AppIcons.icRecording.svg(width: 20, height: 20),
              ),
              const PopupMenuDivider(),
              _buildMeetingPoupItem(
                "screenshare",
                isScreenShareEnabled
                    ? "Stop Screen Share"
                    : "Start Screen Share",
                null,
                AppIcons.icScreenShare.svg(width: 20, height: 20),
              ),
              const PopupMenuDivider(),
              _buildMeetingPoupItem(
                "participants",
                "Participants",
                null,
                AppIcons.icParticipants.svg(width: 20, height: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _buildMeetingPoupItem(
    String value,
    String title,
    String? description,
    Widget leadingIcon,
  ) {
    return PopupMenuItem(
      value: value,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Row(
        children: [
          leadingIcon,
          const HorizontalSpacer(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              if (description != null) const VerticalSpacer(4),
              if (description != null)
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpd_client/constants/colors.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/chat_view.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/conference_participant_grid.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/conference_screenshare_view.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/meeting_action_bar.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/meeting_appbar.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/participant_list.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/waiting_to_join.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:videosdk/videosdk.dart';

class ConferenceMeetingScreen extends StatefulWidget {
  final String meetingId, token, displayName;
  final bool micEnabled, camEnabled, chatEnabled;
  final AudioDeviceInfo? selectedAudioOutputDevice, selectedAudioInputDevice;

  final CustomTrack? cameraTrack;
  final CustomTrack? micTrack;

  const ConferenceMeetingScreen({
    super.key,
    required this.meetingId,
    required this.token,
    required this.displayName,
    this.micEnabled = true,
    this.camEnabled = true,
    this.chatEnabled = true,
    this.selectedAudioOutputDevice,
    this.selectedAudioInputDevice,
    this.cameraTrack,
    this.micTrack,
  });

  @override
  State<ConferenceMeetingScreen> createState() =>
      _ConferenceMeetingScreenState();
}

class _ConferenceMeetingScreenState extends State<ConferenceMeetingScreen> {
  bool isRecordingOn = false;
  bool showChatSnackbar = true;
  String recordingState = "RECORDING_STOPPED";
  // Meeting
  late Room meeting;
  bool _joined = false;

  // Streams
  Stream? shareStream;
  Stream? videoStream;
  Stream? audioStream;
  Stream? remoteParticipantShareStream;

  bool fullScreen = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Create instance of Room (Meeting)
    Room room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      customCameraVideoTrack: widget.cameraTrack,
      customMicrophoneAudioTrack: widget.micTrack,
      displayName: widget.displayName,
      micEnabled: widget.micEnabled,
      camEnabled: widget.camEnabled,
      maxResolution: 'hd',
      //defaultCameraIndex: kIsWeb ? 0 : (Platform.isAndroid || Platform.isIOS) ? 1 : 0,
      notification: const NotificationInfo(
        title: "Video SDK",
        message: "Video SDK is sharing screen in the meeting",
        icon: "notification_share", // drawable icon name
      ),
    );

    // Register meeting events
    registerMeetingEvents(room);

    // Join meeting
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    //Get statusbar height
    final statusbarHeight = MediaQuery.of(context).padding.top;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        _onWillPopScope();
      },
      child: _joined
          ? Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MeetingAppBar(
                    meeting: meeting,
                    token: widget.token,
                    recordingState: recordingState,
                    isFullScreen: fullScreen,
                  ),
                  const Divider(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 8.0,
                      ),
                      child: Flex(
                        direction: ResponsiveValue<Axis>(
                          context,
                          conditionalValues: [
                            Condition.equals(
                              name: MOBILE,
                              value: Axis.vertical,
                            ),
                            Condition.largerThan(
                              name: MOBILE,
                              value: Axis.horizontal,
                            ),
                          ],
                        ).value,
                        children: [
                          ConferenseScreenShareView(meeting: meeting),
                          Expanded(
                            child: ConferenceParticipantGrid(meeting: meeting),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Divider(),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        crossFadeState: !fullScreen
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        secondChild: const SizedBox.shrink(),
                        firstChild: MeetingActionBar(
                          isMicEnabled: audioStream != null,
                          isCamEnabled: videoStream != null,
                          isScreenShareEnabled: shareStream != null,
                          recordingState: recordingState,
                          // Called when Call End button is pressed
                          onCallEndButtonPressed: () {
                            meeting.end();
                          },

                          onCallLeaveButtonPressed: () {
                            meeting.leave();
                          },
                          // Called when mic button is pressed
                          onMicButtonPressed: () {
                            if (audioStream != null) {
                              meeting.muteMic();
                            } else {
                              meeting.unmuteMic();
                            }
                          },
                          // Called when camera button is pressed
                          onCameraButtonPressed: () {
                            if (videoStream != null) {
                              meeting.disableCam();
                            } else {
                              meeting.enableCam();
                            }
                          },

                          onSwitchMicButtonPressed: (details) async {
                            List<AudioDeviceInfo>? outputDevice =
                                await VideoSDK.getAudioDevices();

                            double bottomMargin = (70.0 * outputDevice!.length);
                            final screenSize = MediaQuery.of(context).size;
                            await showMenu(
                              context: context,
                              color: black700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              position: RelativeRect.fromLTRB(
                                screenSize.width - details.globalPosition.dx,
                                details.globalPosition.dy - bottomMargin,
                                details.globalPosition.dx,
                                (bottomMargin),
                              ),
                              items: outputDevice.map((e) {
                                return PopupMenuItem(
                                  padding: EdgeInsets.zero,
                                  value: e,
                                  child: Container(
                                    color:
                                        e.deviceId ==
                                            meeting.selectedSpeaker?.deviceId
                                        ? Color.fromRGBO(109, 110, 113, 1)
                                        : Colors.transparent,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          16,
                                          10,
                                          5,
                                          10,
                                        ), // Ensure no padding
                                        child: Text(e.label),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              elevation: 8.0,
                            ).then((value) {
                              if (value != null) {
                                meeting.switchAudioDevice(value);
                              }
                            });
                          },

                          onChatButtonPressed: () {
                            setState(() {
                              showChatSnackbar = false;
                            });
                            showModalBottomSheet(
                              context: context,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height -
                                    statusbarHeight,
                              ),
                              isScrollControlled: true,
                              builder: (context) => ChatScreen(
                                key: const Key("ChatScreen"),
                                meeting: meeting,
                              ),
                            ).whenComplete(() {
                              setState(() {
                                showChatSnackbar = true;
                              });
                            });
                          },

                          // Called when more options button is pressed
                          onMoreOptionSelected: (option) {
                            // Showing more options dialog box
                            if (option == "screenshare") {
                              if (remoteParticipantShareStream == null) {
                                if (shareStream == null) {
                                  meeting.enableScreenShare();
                                } else {
                                  meeting.disableScreenShare();
                                }
                              } else {
                                CustomSnackbar.show(
                                  context,
                                  "Someone is already presenting",
                                );
                              }
                            } else if (option == "recording") {
                              if (recordingState == "RECORDING_STOPPING") {
                                CustomSnackbar.show(
                                  context,
                                  "Recording is in stopping state",
                                );
                              } else if (recordingState ==
                                  "RECORDING_STARTED") {
                                meeting.stopRecording();
                              } else if (recordingState ==
                                  "RECORDING_STARTING") {
                                CustomSnackbar.show(
                                  context,
                                  "Recording is in starting state",
                                );
                              } else {
                                meeting.startRecording();
                              }
                            } else if (option == "participants") {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: false,
                                builder: (context) =>
                                    ParticipantList(meeting: meeting),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ],
              ),
            )
          : const WaitingToJoin(),
    );
  }

  void registerMeetingEvents(Room _meeting) {
    // Called when joined in meeting
    _meeting.on(Events.roomJoined, () {
      setState(() {
        meeting = _meeting;
        _joined = true;
      });

      if (kIsWeb || Platform.isWindows || Platform.isMacOS) {
        _meeting.switchAudioDevice(widget.selectedAudioOutputDevice!);
      }

      subscribeToChatMessages(_meeting);
    });

    // Called when meeting is ended
    _meeting.on(Events.roomLeft, (String? errorMsg) {
      if (errorMsg != null) {
        CustomSnackbar.show(context, "Meeting left due to $errorMsg !!");
      }
      Navigator.of(context)
        ..pop()
        ..pop();
    });

    // Called when recording is started
    _meeting.on(Events.recordingStateChanged, (String status) {
      CustomSnackbar.show(
        context,
        "Meeting recording ${status == "RECORDING_STARTING"
            ? "is starting"
            : status == "RECORDING_STARTED"
            ? "started"
            : status == "RECORDING_STOPPING"
            ? "is stopping"
            : "stopped"}",
      );

      setState(() {
        recordingState = status;
      });
    });

    // Called when stream is enabled
    _meeting.localParticipant.on(Events.streamEnabled, (Stream _stream) {
      if (_stream.kind == 'video') {
        setState(() {
          videoStream = _stream;
        });
      } else if (_stream.kind == 'audio') {
        setState(() {
          audioStream = _stream;
        });
      } else if (_stream.kind == 'share') {
        setState(() {
          shareStream = _stream;
        });
      }
    });

    // Called when stream is disabled
    _meeting.localParticipant.on(Events.streamDisabled, (Stream _stream) {
      if (_stream.kind == 'video' && videoStream?.id == _stream.id) {
        setState(() {
          videoStream = null;
        });
      } else if (_stream.kind == 'audio' && audioStream?.id == _stream.id) {
        setState(() {
          audioStream = null;
        });
      } else if (_stream.kind == 'share' && shareStream?.id == _stream.id) {
        setState(() {
          shareStream = null;
        });
      }
    });

    // Called when presenter is changed
    _meeting.on(Events.presenterChanged, (_activePresenterId) {
      Participant? activePresenterParticipant =
          _meeting.participants[_activePresenterId];

      // Get Share Stream
      Stream? _stream = activePresenterParticipant?.streams.values.singleWhere(
        (e) => e.kind == "share",
      );

      setState(() => remoteParticipantShareStream = _stream);
    });

    _meeting.on(
      Events.error,
      (error) => {
        CustomSnackbar.show(context, "${error['name']} :: ${error['message']}"),
      },
    );
  }

  void subscribeToChatMessages(Room meeting) {
    meeting.pubSub.subscribe("CHAT", (message) {
      if (message.senderId != meeting.localParticipant.id) {
        if (mounted) {
          if (showChatSnackbar) {
            CustomSnackbar.show(
              context,
              "${message.senderName}: ${message.message}",
            );
          }
        }
      }
    });
  }

  Future<bool> _onWillPopScope() async {
    meeting.leave();
    return true;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}

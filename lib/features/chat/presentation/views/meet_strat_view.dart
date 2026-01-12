import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpd_client/constants/colors.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/chat/presentation/controller/api.dart';
import 'package:mpd_client/features/chat/presentation/views/conference_meeting_screen.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/join_view.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/select_audio_device.dart';
import 'package:mpd_client/features/chat/presentation/widgets/video/select_video_device.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:videosdk/videosdk.dart';

class MeetStratView extends StatefulWidget {
  final String meetingId;

  const MeetStratView({super.key, required this.meetingId});

  @override
  State<MeetStratView> createState() => _MeetStratViewState();
}

class _MeetStratViewState extends State<MeetStratView>
    with WidgetsBindingObserver {
  String _token = "";

  // Control Status
  bool isMicOn = !kIsWeb && (Platform.isMacOS || Platform.isWindows)
      ? true
      : false;
  bool isCameraOn = !kIsWeb && (Platform.isMacOS || Platform.isWindows)
      ? true
      : false;

  CustomTrack? cameraTrack;
  CustomTrack? microphoneTrack;
  RTCVideoRenderer? cameraRenderer;

  bool isJoinMeetingSelected = true;

  bool? isCameraPermissionAllowed =
      !kIsWeb && (Platform.isMacOS || Platform.isWindows) ? true : false;
  bool? isMicrophonePermissionAllowed =
      !kIsWeb && (Platform.isMacOS || Platform.isWindows) ? true : false;

  VideoDeviceInfo? selectedVideoDevice;
  AudioDeviceInfo? selectedAudioOutputDevice;
  AudioDeviceInfo? selectedAudioInputDevice;
  List<VideoDeviceInfo>? videoDevices;
  List<AudioDeviceInfo>? audioDevices;
  List<AudioDeviceInfo> audioInputDevices = [];
  List<AudioDeviceInfo> audioOutputDevices = [];

  late Function handler;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await fetchToken(context);
      setState(() => _token = token);
    });
    checkandReqPermissions();
    subscribe();
  }

  void updateselectedAudioOutputDevice(AudioDeviceInfo? device) {
    if (device?.deviceId != selectedAudioOutputDevice?.deviceId) {
      setState(() {
        selectedAudioOutputDevice = device;
      });
      if (!kIsWeb) {
        if (Platform.isAndroid || Platform.isIOS) {
          disposeMicTrack();
          initMic();
        }
      }
    }
  }

  void updateselectedAudioInputDevice(AudioDeviceInfo? device) {
    if (device?.deviceId != selectedAudioInputDevice?.deviceId) {
      setState(() {
        selectedAudioInputDevice = device;
      });
      disposeMicTrack();
      initMic();
    }
  }

  void updateSelectedVideoDevice(VideoDeviceInfo? device) {
    if (device?.deviceId != selectedVideoDevice?.deviceId) {
      disposeCameraPreview();
      setState(() {
        selectedVideoDevice = device;
      });

      initCameraPreview();
    }
  }

  Future<void> checkBluetoothPermissions() async {
    try {
      bool bluetoothPerm = await VideoSDK.checkBluetoothPermission();
      if (bluetoothPerm != true) {
        await VideoSDK.requestBluetoothPermission();
      }
    } catch (e) {
      Log.e('Error checking bluetooth permissions: $e');
    }
  }

  void getDevices() async {
    if (isCameraPermissionAllowed != null &&
        isCameraPermissionAllowed == true) {
      videoDevices = await VideoSDK.getVideoDevices();
      setState(() {
        // Try to find front camera first, fallback to first available camera
        if (videoDevices != null && videoDevices!.isNotEmpty) {
          selectedVideoDevice = videoDevices!.firstWhere(
            (device) =>
                device.label.toLowerCase().contains('front') ||
                device.label.toLowerCase().contains('selfie'),
            orElse: () => videoDevices!.first,
          );
        }
      });
      initCameraPreview();
    }
    if (isMicrophonePermissionAllowed != null &&
        isMicrophonePermissionAllowed == true) {
      audioDevices = await VideoSDK.getAudioDevices();
      if (!kIsWeb && !Platform.isMacOS && !Platform.isWindows) {
        //Condition for android and ios devices
        setState(() {
          selectedAudioOutputDevice = audioDevices?.first;
        });
      } else {
        audioInputDevices = [];
        audioOutputDevices = [];
        for (AudioDeviceInfo device in audioDevices!) {
          if (device.kind == 'audioinput') {
            audioInputDevices.add(device);
          } else {
            audioOutputDevices.add(device);
          }
        }
        setState(() {
          selectedAudioOutputDevice = audioOutputDevices.first;
          selectedAudioInputDevice = audioInputDevices.first;
        });
        initMic();
      }
    }
  }

  void checkandReqPermissions([Permissions? perm]) async {
    perm ??= Permissions.audio_video;
    try {
      if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
        Map<String, bool> permissions = await VideoSDK.checkPermissions();

        if (perm == Permissions.audio || perm == Permissions.audio_video) {
          if (permissions['audio'] != true) {
            Map<String, bool> reqPermissions =
                await VideoSDK.requestPermissions(Permissions.audio);
            setState(() {
              isMicrophonePermissionAllowed = reqPermissions['audio'];
              isMicOn = reqPermissions['audio']!;
            });
          } else {
            setState(() {
              isMicrophonePermissionAllowed = true;
              isMicOn = true;
            });
          }
        }

        if (perm == Permissions.video || perm == Permissions.audio_video) {
          if (permissions['video'] != true) {
            Map<String, bool> reqPermissions =
                await VideoSDK.requestPermissions(Permissions.video);

            setState(() => isCameraPermissionAllowed = reqPermissions['video']);
          } else {
            setState(() => isCameraPermissionAllowed = true);
          }
        }
        if (!kIsWeb) {
          if (Platform.isAndroid) {
            await checkBluetoothPermissions();
          }
        }
      }
      getDevices();
    } catch (e) {
      Log.e('Error checking and requesting permissions: $e');
    }
  }

  void checkPermissions() async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      Map<String, bool> permissions = await VideoSDK.checkPermissions();
      setState(() {
        isMicrophonePermissionAllowed = permissions['audio'];
        isCameraPermissionAllowed = permissions['video'];
        isMicOn = permissions['audio']!;
        isCameraOn = permissions['video']!;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        checkPermissions();
        break;
      case AppLifecycleState.detached:
        throw UnimplementedError();
      case AppLifecycleState.inactive:
        throw UnimplementedError();
      case AppLifecycleState.hidden:
        throw UnimplementedError();
      case AppLifecycleState.paused:
        throw UnimplementedError();
    }
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        await _onWillPopScope();
      },
      child: Scaffold(
        appBar: !kIsWeb && (Platform.isAndroid || Platform.isIOS)
            ? AppBar(
                flexibleSpace: Align(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.volume_up,
                            size: 27,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: black750,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: SelectAudioDevice(
                                      isMicrophonePermissionAllowed:
                                          isMicrophonePermissionAllowed,
                                      selectedAudioOutputDevice:
                                          selectedAudioOutputDevice,
                                      audioDevices: audioDevices,
                                      onAudioDeviceSelected:
                                          updateselectedAudioOutputDevice,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            size: 27,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: black750,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: SelectVideoDevice(
                                      isCameraPermissionAllowed:
                                          isCameraPermissionAllowed,
                                      selectedVideoDevice: selectedVideoDevice,
                                      videoDevices: videoDevices,
                                      onVideoDeviceSelected:
                                          updateSelectedVideoDevice,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: black750,
                elevation: 0,
              )
            : null,
        backgroundColor: primaryColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              Widget _buildContent() {
                return IntrinsicHeight(
                  child: kIsWeb || Platform.isWindows || Platform.isMacOS
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(40, 150, 40, 150),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: maxHeight,
                                width: maxWidth / 2,
                                child: Column(
                                  children: [
                                    JoinView(
                                      cameraRenderer: cameraRenderer,
                                      isMicOn: isMicOn,
                                      isCameraOn: isCameraOn,
                                      onMicToggle: () =>
                                          isMicrophonePermissionAllowed !=
                                                  null &&
                                              isMicrophonePermissionAllowed ==
                                                  true
                                          ? {
                                              if (isMicOn)
                                                {disposeMicTrack()}
                                              else
                                                {initMic()},
                                              setState(
                                                () => isMicOn = !isMicOn,
                                              ),
                                            }
                                          : checkandReqPermissions(
                                              Permissions.audio,
                                            ),
                                      onCameraToggle: () {
                                        isCameraPermissionAllowed != null &&
                                                isCameraPermissionAllowed ==
                                                    true
                                            ? {
                                                if (isCameraOn)
                                                  {disposeCameraPreview()}
                                                else
                                                  {initCameraPreview()},
                                                setState(
                                                  () =>
                                                      isCameraOn = !isCameraOn,
                                                ),
                                              }
                                            : checkandReqPermissions(
                                                Permissions.video,
                                              );
                                      },
                                    ),
                                    // kIsWeb ||
                                    //         Platform.isMacOS ||
                                    //         Platform.isWindows
                                    //     ? Padding(
                                    //         padding: const EdgeInsets.fromLTRB(
                                    //           0,
                                    //           20,
                                    //           0,
                                    //           0,
                                    //         ),
                                    //         child: DropdownsWebWidget(
                                    //           isCameraPermissionAllowed:
                                    //               isCameraPermissionAllowed,
                                    //           isMicrophonePermissionAllowed:
                                    //               isMicrophonePermissionAllowed,
                                    //           selectedAudioOutputDevice:
                                    //               selectedAudioOutputDevice,
                                    //           selectedAudioInputDevice:
                                    //               selectedAudioInputDevice,
                                    //           selectedVideoDevice:
                                    //               selectedVideoDevice,
                                    //           audioInputDevices:
                                    //               audioInputDevices,
                                    //           audioOutputDevices:
                                    //               audioOutputDevices,
                                    //           videoDevices: videoDevices,
                                    //           onAudioOutputDeviceSelected:
                                    //               updateselectedAudioOutputDevice,
                                    //           onAudioInputDeviceSelected:
                                    //               updateselectedAudioInputDevice,
                                    //           onVideoDeviceSelected:
                                    //               updateSelectedVideoDevice,
                                    //         ),
                                    //       )
                                    //     : Container(),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: maxWidth / 10),
                                child: ElevatedButton(
                                  onPressed: _onClickMeetingJoin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                  ),
                                  child: Text(
                                    "Join Meeting",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 400,
                              width: maxWidth,
                              child: JoinView(
                                cameraRenderer: cameraRenderer,
                                isMicOn: isMicOn,
                                isCameraOn: isCameraOn,
                                onMicToggle: () =>
                                    isMicrophonePermissionAllowed != null &&
                                        isMicrophonePermissionAllowed == true
                                    ? {
                                        if (isMicOn)
                                          {disposeMicTrack()}
                                        else
                                          {initMic()},
                                        setState(() => isMicOn = !isMicOn),
                                      }
                                    : checkandReqPermissions(Permissions.audio),
                                onCameraToggle: () {
                                  isCameraPermissionAllowed != null &&
                                          isCameraPermissionAllowed == true
                                      ? {
                                          if (isCameraOn)
                                            {disposeCameraPreview()}
                                          else
                                            {initCameraPreview()},
                                          setState(
                                            () => isCameraOn = !isCameraOn,
                                          ),
                                        }
                                      : checkandReqPermissions(
                                          Permissions.video,
                                        );
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _onClickMeetingJoin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                "Join Meeting",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              }

              return kIsWeb || Platform.isMacOS || Platform.isWindows
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: _buildContent(),
                    )
                  : SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: _buildContent(),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPopScope() async {
    return true;
  }

  void initCameraPreview() async {
    if (isCameraPermissionAllowed != null &&
        isCameraPermissionAllowed == true) {
      CustomTrack? track = await VideoSDK.createCameraVideoTrack(
        cameraId: selectedVideoDevice?.deviceId,
      );
      RTCVideoRenderer render = RTCVideoRenderer();
      await render.initialize();
      render.setSrcObject(
        stream: track?.mediaStream,
        trackId: track?.mediaStream.getVideoTracks().first.id,
      );
      setState(() {
        cameraTrack = track;
        cameraRenderer = render;
        isCameraOn = true;
      });
    }
  }

  void initMic() async {
    if (isMicrophonePermissionAllowed != null &&
        isMicrophonePermissionAllowed == true) {
      CustomTrack? track = await VideoSDK.createMicrophoneAudioTrack(
        microphoneId: kIsWeb || Platform.isMacOS || Platform.isWindows
            ? selectedAudioInputDevice?.deviceId
            : selectedAudioOutputDevice?.deviceId,
      );
      setState(() {
        microphoneTrack = track;
      });
    }
  }

  void disposeCameraPreview() {
    cameraTrack?.dispose();
    setState(() {
      cameraRenderer = null;
      cameraTrack = null;
    });
  }

  void disposeMicTrack() {
    microphoneTrack?.dispose();
    setState(() {
      microphoneTrack = null;
    });
  }

  void _onClickMeetingJoin() async {
    final displayName = "Guest";
    joinMeeting("GROUP", displayName, widget.meetingId);
  }

  Future<void> joinMeeting(callType, displayName, meetingId) async {
    if (meetingId.isEmpty) {
      CustomSnackbar.show(context, "Please enter Valid Meeting ID");
      return;
    }
    var validMeeting = await validateMeeting(_token, meetingId);
    if (validMeeting) {
      if (mounted) {
        setState(() {
          cameraRenderer = null;
        });
        unsubscribe();

        if (callType == "GROUP") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConferenceMeetingScreen(
                token: _token,
                meetingId: meetingId,
                displayName: displayName,
                micEnabled: isMicOn,
                camEnabled: isCameraOn,
                selectedAudioOutputDevice: selectedAudioOutputDevice,
                selectedAudioInputDevice: selectedAudioInputDevice,
                cameraTrack: cameraTrack,
                micTrack: microphoneTrack,
              ),
            ),
          );
        } else {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => OneToOneMeetingScreen(
          //       token: _token,
          //       meetingId: meetingId,
          //       displayName: displayName,
          //       micEnabled: isMicOn,
          //       camEnabled: isCameraOn,
          //       selectedAudioOutputDevice: selectedAudioOutputDevice,
          //       selectedAudioInputDevice: selectedAudioInputDevice,
          //       cameraTrack: cameraTrack,
          //       micTrack: microphoneTrack,
          //     ),
          //   ),
          // );
        }
      }
    } else {
      if (mounted) {
        CustomSnackbar.show(context, "Invalid Meeting ID");
      }
    }
  }

  void subscribe() {
    handler = (devices) {
      getDevices();
    };
    VideoSDK.on(Events.deviceChanged, handler);
  }

  void unsubscribe() {
    VideoSDK.off(Events.deviceChanged, handler);
  }

  @override
  void dispose() {
    unsubscribe();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}

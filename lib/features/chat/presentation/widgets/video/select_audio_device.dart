import 'package:flutter/material.dart';
import 'package:mpd_client/constants/colors.dart';
import 'package:videosdk/videosdk.dart';

class SelectAudioDevice extends StatefulWidget {
  final bool? isMicrophonePermissionAllowed;
  final AudioDeviceInfo? selectedAudioOutputDevice;
  final List<AudioDeviceInfo>? audioDevices;
  final Function(AudioDeviceInfo?) onAudioDeviceSelected;

  const SelectAudioDevice({
    super.key,
    required this.isMicrophonePermissionAllowed,
    this.selectedAudioOutputDevice,
    this.audioDevices,
    required this.onAudioDeviceSelected,
  });

  @override
  State<SelectAudioDevice> createState() => _SelectAudioOutputState();
}

class _SelectAudioOutputState extends State<SelectAudioDevice> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.audioDevices != null &&
                  widget.audioDevices!.isNotEmpty &&
                  widget.isMicrophonePermissionAllowed == true
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.audioDevices!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.audioDevices!.length) {
                      return ListTile(
                        leading: Icon(Icons.close, color: Colors.white),
                        title: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      AudioDeviceInfo device = widget.audioDevices![index];
                      return ListTile(
                        leading: widget.selectedAudioOutputDevice == device
                            ? Icon(Icons.check, color: Colors.white)
                            : SizedBox(width: 24),
                        title: Text(
                          device.label,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          widget.onAudioDeviceSelected(device);
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                )
              : Text(
                  "Permission Denied",
                  style: TextStyle(fontSize: 15, color: black500),
                ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mpd_client/constants/colors.dart';
// import 'package:videosdk/videosdk.dart';

// class SelectAudioDevice extends StatefulWidget {
//   final bool? isMicrophonePermissionAllowed;
//   final AudioDeviceInfo? selectedAudioOutputDevice;
//   final List<AudioDeviceInfo>? audioDevices;
//   final Function(AudioDeviceInfo?) onAudioDeviceSelected;

//   const SelectAudioDevice({
//     super.key,
//     required this.isMicrophonePermissionAllowed,
//     this.selectedAudioOutputDevice,
//     this.audioDevices,
//     required this.onAudioDeviceSelected,
//   });

//   @override
//   State<SelectAudioDevice> createState() => _SelectAudioOutputState();
// }

// class _SelectAudioOutputState extends State<SelectAudioDevice> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           widget.audioDevices != null &&
//                   widget.audioDevices!.isNotEmpty &&
//                   widget.isMicrophonePermissionAllowed == true
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: widget.audioDevices!.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == widget.audioDevices!.length) {
//                       return ListTile(
//                         leading: Icon(Icons.close, color: Colors.white),
//                         title: Text(
//                           "Cancel",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                       );
//                     } else {
//                       AudioDeviceInfo device = widget.audioDevices![index];
//                       return ListTile(
//                         leading: widget.selectedAudioOutputDevice == device
//                             ? Icon(Icons.check, color: Colors.white)
//                             : SizedBox(width: 24),
//                         title: Text(
//                           device.label,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onTap: () {
//                           widget.onAudioDeviceSelected(device);
//                           Navigator.pop(context);
//                         },
//                       );
//                     }
//                   },
//                 )
//               : Text(
//                   "Permission Denied",
//                   style: TextStyle(fontSize: 15, color: black500),
//                 ),
//         ],
//       ),
//     );
//   }
// }

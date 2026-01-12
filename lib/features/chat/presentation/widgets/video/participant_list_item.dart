import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:videosdk/videosdk.dart';

class ParticipantListItem extends StatefulWidget {
  final Participant participant;
  const ParticipantListItem({super.key, required this.participant});

  @override
  State<ParticipantListItem> createState() => _ParticipantListItemState();
}

class _ParticipantListItemState extends State<ParticipantListItem> {
  Stream? videoStream;
  Stream? audioStream;

  @override
  void initState() {
    widget.participant.streams.forEach((key, Stream stream) {
      if (stream.kind == "video") {
        videoStream = stream;
      } else if (stream.kind == 'audio') {
        audioStream = stream;
      }
      log("Stream: ${stream.kind}");
    });

    super.initState();
    addParticipantListener(widget.participant);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: const Icon(Icons.person),
          ),
          Expanded(
            child: Text(
              widget.participant.isLocal
                  ? "You"
                  : widget.participant.displayName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: audioStream != null ? Colors.grey[800] : Colors.red,
              border: Border.all(
                color: audioStream != null ? Colors.grey[800]! : Colors.red,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(audioStream != null ? Icons.mic : Icons.mic_off),
          ),
          Container(
            // margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: videoStream != null ? Colors.grey[800] : Colors.red,
              border: Border.all(
                color: videoStream != null ? Colors.grey[800]! : Colors.red,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(
              videoStream != null
                  ? "assets/ic_video.svg"
                  : "assets/ic_video_off.svg",
            ),
          ),
        ],
      ),
    );
  }

  void addParticipantListener(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (mounted) {
        setState(() {
          if (stream.kind == "video") {
            videoStream = stream;
          } else if (stream.kind == 'audio') {
            audioStream = stream;
          }
        });
      }
    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (mounted) {
        setState(() {
          if (stream.kind == "video") {
            videoStream = null;
          } else if (stream.kind == 'audio') {
            audioStream = null;
          }
        });
      }
    });
  }
}

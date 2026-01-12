import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:videosdk/videosdk.dart';

class ChatWidget extends StatelessWidget {
  final bool isLocalParticipant;
  final PubSubMessage message;
  const ChatWidget({
    super.key,
    required this.isLocalParticipant,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLocalParticipant
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: message.message));
          CustomSnackbar.show(context, "Message has been copied");
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black87,
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLocalParticipant ? "You" : message.senderName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    message.timestamp.toLocal().format('h:i a'),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

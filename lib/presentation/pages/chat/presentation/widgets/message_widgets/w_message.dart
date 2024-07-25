import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mpd_client/domain/models/chat/message.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/message_widgets/w_chat_media_view.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/message_widgets/w_live_and_meeting_item.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class WMessage extends StatefulWidget {
  final MessageModel? message;

  const WMessage({
    super.key,
    required this.message,
  });

  @override
  State<WMessage> createState() => _WMessageState();
}

class _WMessageState extends State<WMessage> {
  bool get messageIsMeetingId => widget.message?.text != null && (widget.message!.text!.contains("#meet#") || widget.message!.text!.contains("#live#"));

  @override
  Widget build(BuildContext context) {
    final isMe = (widget.message?.isMe ?? false);
    return Align(
      alignment: (isMe) ? Alignment.topRight : Alignment.topLeft,
      child: messageIsMeetingId
          ? WLiveAndMeetingItem(message: widget.message)
          : Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * ((Platform.isIOS || Platform.isAndroid) ? 0.9 : 0.18),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                gradient: isMe ? wgradient : null,
                color: isMe ? null : white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: (widget.message?.isMe ?? false) ? const Radius.circular(20) : Radius.zero,
                  bottomRight: (widget.message?.isMe ?? false) ? Radius.zero : const Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  if (widget.message?.file != null)
                    WChatMediaView(
                      file: widget.message!.file!,
                      isLocalFile: widget.message!.isLocalFile,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (widget.message?.text?.isNotEmpty ?? false)
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * ((Platform.isAndroid || Platform.isIOS) ? 0.6 : 0.10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SelectableText(
                                  widget.message?.text ?? "-",
                                  style: AppTheme.labelSmall.copyWith(
                                    color: isMe ? white : black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(width: 12),
                        if ((widget.message?.file?.endsWith(".jpg") ?? false) || (widget.message?.file?.endsWith(".png") ?? false)) const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.message?.date != null ? parseDateToTime(widget.message!.date!) : "-",
                              style: AppTheme.labelLarge.copyWith(
                                color: isMe ? white : black,
                                fontSize: 11,
                              ),
                            ),
                            if (isMe) const SizedBox(width: 3),
                            if (isMe)
                              const Icon(
                                Icons.check,
                                size: 12,
                                color: white,
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

    String parseDateToTime(String date) {
    var myDate = DateTime.parse(date);
    return "${myDate.hour.toString().padLeft(2, "0")}:${myDate.minute.toString().padLeft(2, "0")}";
  }
}

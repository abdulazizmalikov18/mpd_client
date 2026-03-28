import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_app_bar.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_chat_file_view.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

class WChatMediaView extends StatelessWidget {
  final String file;
  final bool isLocalFile;

  const WChatMediaView({
    super.key,
    required this.file,
    required this.isLocalFile,
  });

  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  /// Telegram-style max size for chat image (compact in bubble)
  static const double _maxChatImageWidth = 260.0;
  static const double _maxChatImageHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    if (file.endsWith(".jpg") || file.endsWith(".png")) {
      final screenWidth = MediaQuery.sizeOf(context).width;
      final maxW = screenWidth * 0.75;
      final maxWidth = maxW > _maxChatImageWidth ? _maxChatImageWidth : maxW;

      return GestureDetector(
        onTap: () {
          isMobile
              ? Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatImageScreen(file: file, isLocalFile: isLocalFile),
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: PinchToZoomScrollableWidget(
                      maxScale: 2.5,
                      child: switch (isLocalFile) {
                        true => Image.file(
                          File(file),
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.7,
                        ),
                        false => CachedNetworkImage(
                          imageUrl: file,
                          fit: BoxFit.contain,
                        ),
                      },
                    ),
                  ),
                );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: _maxChatImageHeight,
          ),
          child: switch (isLocalFile) {
            true => Image.file(File(file), fit: BoxFit.cover),
            false => CachedNetworkImage(imageUrl: file, fit: BoxFit.cover),
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: WChatFileView(file: file, isLocalFile: isLocalFile),
      );
    }
  }
}

class ChatImageScreen extends StatelessWidget {
  final bool isLocalFile;
  final String file;

  const ChatImageScreen({
    super.key,
    required this.isLocalFile,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(back: true, title: SizedBox()),
      body: PinchToZoomScrollableWidget(
        maxScale: 2.5,
        child: Center(
          child: switch (isLocalFile) {
            true => Image.file(
              File(file),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
            ),
            false => CachedNetworkImage(
              imageUrl: file,
              // fit: BoxFit.cover,
              width: double.infinity,
            ),
          },
        ),
      ),
    );
  }
}

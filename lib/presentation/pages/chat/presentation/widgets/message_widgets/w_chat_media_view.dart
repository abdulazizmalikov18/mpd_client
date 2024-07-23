import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/widgets/message_widgets/w_chat_file_view.dart';

class WChatMediaView extends StatelessWidget {
  final String file;
  final bool isLocalFile;

  const WChatMediaView({super.key, required this.file, required this.isLocalFile});

  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: switch (file.endsWith(".jpg") || file.endsWith(".png")) {
        true => SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: GestureDetector(
                onTap: () {
                  isMobile
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatImageScreen(
                                    file: file,
                                    isLocalFile: isLocalFile,
                                  )))
                      : showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: switch (isLocalFile) {
                              true => Image.file(
                                  File(file),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: MediaQuery.of(context).size.height * 0.7,
                                ),
                              false => Image.network(
                                  file,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                            },
                          ),
                        );
                },
                child: switch (isLocalFile) {
                  true => Image.file(
                      File(file),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  false => Image.network(
                      file,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                },
              ),
            ),
          ),
        false => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: WChatFileView(
              file: file,
              isLocalFile: isLocalFile,
            ),
          ),
      },
    );
  }
}

class ChatImageScreen extends StatelessWidget {
  final bool isLocalFile;
  final String file;

  const ChatImageScreen({super.key, required this.isLocalFile, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: switch (isLocalFile) {
          true => Image.file(
              File(file),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
            ),
          false => Image.network(
              file,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
        },
      ),
    );
  }
}

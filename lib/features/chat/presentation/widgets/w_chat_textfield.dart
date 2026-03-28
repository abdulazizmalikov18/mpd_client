import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_message/bloc/chat_message_bloc.dart';
import 'package:mpd_client/features/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/features/chat/presentation/views/in_app_chat.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';
import 'package:mpd_client/provider/language.dart';

class WChatTextField extends StatelessWidget {
  const WChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChatVMController();
    final slugName = InChatView.of(context)!.widget.group.slugName;

    return BlocBuilder<ChatMessageBloc, ChatMessageState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected files preview
            ValueListenableBuilder<List<File>>(
              valueListenable: controller.selectedFiles,
              builder: (context, files, _) {
                if (files.isEmpty) return const SizedBox.shrink();
                return Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: files.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final file = files[index];
                      final isImage =
                          file.path.endsWith('.jpg') ||
                          file.path.endsWith('.jpeg') ||
                          file.path.endsWith('.png');

                      return Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(top: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: border),
                              color: background,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: isImage
                                ? Image.file(file, fit: BoxFit.cover)
                                : const Icon(
                                    Icons.insert_drive_file,
                                    color: gray,
                                  ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => controller.removeFile(file),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: mainBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      controller: controller.messageController,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          top: 14,
                          left: 16,
                        ),
                        filled: true,
                        fillColor: background,
                        prefixIcon: WButton(
                          width: 30,
                          color: Colors.transparent,
                          padding: EdgeInsets.zero,
                          border: const Border(),
                          onTap: () =>
                              controller.showFileOptions(context, slugName),
                          child: const Icon(
                            CupertinoIcons.paperclip,
                            color: gray,
                          ),
                        ),
                        hintText: context.l10n.chat_type_message,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: gray,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: border),
                        ),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ListenableBuilder(
                  listenable: controller.messageController,
                  builder: (context, _) {
                    return WButton(
                      isDisabled: controller.messageController.text
                          .trim()
                          .isEmpty,
                      onTap: () => controller.sendAllFiles(context, slugName),
                      width: 48,
                      height: 48,
                      child: AppIcons.send.svg(color: white),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

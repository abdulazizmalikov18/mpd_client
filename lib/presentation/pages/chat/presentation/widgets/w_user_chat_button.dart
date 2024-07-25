import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';

class WUserChatButton extends StatelessWidget {
  final void Function() onTap;
  final ChatGroupModel group;

  const WUserChatButton({
    super.key,
    required this.onTap,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 83,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: group.unreadMessageCount != 0 ? null : background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.5, vertical: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    children: [
                      WNetworkImage(
                        image: group.avatar,
                        height: 56,
                        width: 56,
                        borderRadius: 16,
                        defaultWidget: Image.asset(
                          AppImages.userAvatar,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: group.isOnline && (group.isUserToUser) ? green : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.displayLarge,
                    ),
                    Text(
                      group.lastMessage.isEmpty ? (group.lastFile.isEmpty ? "file" : "") : (group.lastMessage.isNotEmpty ? group.lastMessage : ""),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: group.unreadMessageCount == 0 ? greyText : black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                      parseDateToTime(group.date.isNotEmpty ? group.date : "-"),
                      style: const TextStyle(
                        color: greyText,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    if (group.unreadMessageCount == 0)
                      const SizedBox()
                    else
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: wgradient,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${group.unreadMessageCount}',
                          style: const TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String parseDateToTime(String date) {
    var myDate = DateTime.parse(date);
    return "${myDate.hour.toString().padLeft(2, "0")}:${myDate.minute.toString().padLeft(2, "0")}";
  }
}

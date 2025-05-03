import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';

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
    return ListTile(
      onTap: onTap,
      title: Text(
        group.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: black,
        ),
      ),
      subtitle: Text(
        group.lastMessage.isEmpty
            ? (group.lastFile.isEmpty ? "file" : "")
            : (group.lastMessage.isNotEmpty
                ? group.lastMessage
                : ""),
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: group.unreadMessageCount == 0
              ? context.color.grey
              : context.color.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: SizedBox(
        height: 56,
        width: 56,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: mainBlue.withValues(alpha: 0.1),
              backgroundImage: CachedNetworkImageProvider(
                group.avatar,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 6,
                backgroundColor: group.isOnline &&
                        (group.isUserToUser)
                    ? context.color.green
                    : Colors.transparent,
              ),
            )
          ],
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              parseDateToTime(
                group.date.isNotEmpty
                    ? group.date
                    : "-",
              ),
              style: TextStyle(
                color: context.color.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          if (group.unreadMessageCount == 0)
            const SizedBox()
          else
            CircleAvatar(
              radius: 9,
              backgroundColor: mainBlue,
              child: Text(
                group.unreadMessageCount.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: context.color.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String parseDateToTime(String date) {
    var myDate = DateTime.parse(date);
    return "${myDate.hour.toString().padLeft(2, "0")}:${myDate.minute.toString().padLeft(2, "0")}";
  }
}

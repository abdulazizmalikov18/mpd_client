import 'package:flutter/material.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class WChatUserViewItem extends StatelessWidget {
  final ChatUserModel user;

  const WChatUserViewItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          onTap: () => $chatController
              .of(context)
              .createChatAndPush(context, user: user),
          title: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: user.avatar.isNotEmpty
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.avatar),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const BoxDecoration(
                        shape: BoxShape.circle,
                        color: blue,
                      ),
                child: user.avatar.isNotEmpty
                    ? Text(
                        user.name.isEmpty ? "D" : (user.name)[0],
                        style: AppTheme.titleMedium,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "${user.name} ${user.lastname}",
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.bodyLarge.copyWith(color: white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

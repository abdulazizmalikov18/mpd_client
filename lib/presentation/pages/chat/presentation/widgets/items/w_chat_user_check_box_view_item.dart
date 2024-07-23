import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class WChatUserCheckBoxViewItem extends StatelessWidget {
  final ChatUserModel user;
  final bool isActive;

  const WChatUserCheckBoxViewItem({
    super.key,
    required this.user,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckboxListTile(
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
                  : const BoxDecoration(shape: BoxShape.circle, color: blue),
              child: user.avatar.isNotEmpty
                  ? Text(
                      user.name.isEmpty ? "D" : (user.name)[0],
                      style: AppTheme.titleMedium,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              user.name,
              style: AppTheme.bodyLarge.copyWith(color: white),
            ),
          ],
        ),
        value: isActive,
        checkColor: white,
        onChanged: (bool? value) {
          context.read<ChatBloc>().add(GroupUsersSelectionEvent(isActive: value!, user: user));
        },
      ),
    );
  }
}

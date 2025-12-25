import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/utils/log_service.dart';

class BlockUserDialog extends StatelessWidget {
  final String username;
  final String userName;
  final bool isBlocked;
  final Function()? onBlocked;

  const BlockUserDialog({
    super.key,
    required this.username,
    required this.userName,
    this.isBlocked = false,
    this.onBlocked,
  });

  static Future<void> show(
    BuildContext context, {
    required String username,
    required String userName,
    bool isBlocked = false,
    Function()? onBlocked,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => BlockUserDialog(
        username: username,
        userName: userName,
        isBlocked: isBlocked,
        onBlocked: onBlocked,
      ),
    );
  }

  Future<void> _toggleBlock(BuildContext context) async {
    try {
      final current = StorageRepository.getString(StorageKeys.BLOCKED_USERS);
      final blocked = current.isEmpty ? <String>{} : current.split(',').toSet();

      if (isBlocked) {
        blocked.remove(username);
      } else {
        blocked.add(username);
      }

      await StorageRepository.putString(
        StorageKeys.BLOCKED_USERS,
        blocked.where((e) => e.isNotEmpty).join(','),
      );

      if (context.mounted) {
        Navigator.pop(context);
        if (onBlocked != null) {
          onBlocked!();
        }
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isBlocked
                  ? context.l10n.unblock_user_confirm
                  : context.l10n.block_user_success,
            ),
            backgroundColor: context.color.green,
          ),
        );
      }
    } catch (e) {
      Log.e(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: context.color.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isBlocked
            ? context.l10n.unblock_user_title
            : context.l10n.block_user_title,
      ),
      content: Text(
        isBlocked
            ? context.l10n.unblock_user_message
            : context.l10n.block_user_message.replaceAll('this user', userName),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.block_user_cancel,
            style: TextStyle(color: context.color.grey),
          ),
        ),
        TextButton(
          onPressed: () => _toggleBlock(context),
          child: Text(
            isBlocked
                ? context.l10n.unblock_user_confirm
                : context.l10n.block_user_confirm,
            style: TextStyle(color: context.color.red),
          ),
        ),
      ],
    );
  }
}

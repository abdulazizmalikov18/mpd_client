import 'package:flutter/cupertino.dart';
import 'package:mpd_client/domain/models/chat/message.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WLiveAndMeetingItem extends StatefulWidget {
  final MessageModel? message;

  const WLiveAndMeetingItem({super.key, required this.message});

  @override
  State<WLiveAndMeetingItem> createState() => _WLiveAndMeetingItemState();
}

class _WLiveAndMeetingItemState extends State<WLiveAndMeetingItem> {
  late bool isLive = widget.message!.text!.contains("#live#");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: wgradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.home.svg(color: white),
                const SizedBox(width: 8),
                SizedBox(
                  width: 145,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLive ? "Login to Live" : "Login to Meet",
                        style: AppTheme.labelSmall.copyWith(
                          color: white,
                        ),
                      ),
                      Text(
                        isLive ? "Login to Live" : "Login to Meet",
                        style: AppTheme.labelLarge.copyWith(
                          fontWeight: FontWeight.w300,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.right_chevron,
                  color: white,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

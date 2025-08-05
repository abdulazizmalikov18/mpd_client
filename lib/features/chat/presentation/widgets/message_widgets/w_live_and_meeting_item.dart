import 'package:flutter/cupertino.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';

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
        // gradient: wgradient,
        color: mainBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.home.svg(color: context.color.white),
                const SizedBox(width: 8),
                SizedBox(
                  width: 145,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLive ? "Login to Live" : "Login to Meet",
                        style: TextStyle(
                          color: context.color.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        isLive ? "Login to Live" : "Login to Meet",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: context.color.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  CupertinoIcons.right_chevron,
                  color: context.color.white,
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

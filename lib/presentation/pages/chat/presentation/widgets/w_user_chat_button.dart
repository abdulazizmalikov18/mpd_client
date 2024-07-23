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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Positioned(
            top: 100,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: white),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              height: 83,
              child: DecoratedBox(
                decoration: BoxDecoration(color: group.lastMessageIsRead ? white.withOpacity(0.1) : primary.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
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
                              defaultWidget: Image.asset(AppImages.userAvatar,
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
                            style: AppTheme.displayLarge.copyWith(
                              color: white,
                            ),
                          ),
                          Text(
                            group.lastMessage.isEmpty ? (group.lastFile.isEmpty ? "file" : "") : (group.lastMessage.isNotEmpty ? group.lastMessage : ""),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: greyText,
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
                          const Text(
                            '',// MyFunctions.parseDateToTime(group.date.isNotEmpty ? group.date : "-"),
                            style: TextStyle(
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
                              decoration: const BoxDecoration(
                                color: blue,
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
          ),
        ],
      ),
    );
    // return WButton(
    //   height: 70,
    //   onTap: onTap,
    //   color: Colors.transparent,
    //   padding: const EdgeInsets.all(12),
    //   child: Row(
    //     children: [
    //       SizedBox(
    //         width: 48,
    //         height: 48,
    //         child: Stack(
    //           children: [
    //             ClipRRect(
    //               borderRadius: BorderRadius.circular(100),
    //               child: Image(
    //                 image: NetworkImage(group.avatar ?? "https://w7.pngwing.com/pngs/423/699/png-transparent-chat-dialogue-bubbles-bubble-talk-man-person-icon.png"),
    //                 fit: BoxFit.cover,
    //                 width: 48,
    //                 height: 48,
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.bottomRight,
    //               child: Container(
    //                 width: 10,
    //                 height: 10,
    //                 decoration: BoxDecoration(
    //                   color: group.isOnline && (group.isUserToUser ?? false) ? green : Colors.transparent,
    //                   shape: BoxShape.circle,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       const SizedBox(width: 12),
    //       ConstrainedBox(
    //         constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * ((Platform.isIOS || Platform.isAndroid) ? 0.6 : 0.10)),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               group.name ?? "-",
    //               overflow: TextOverflow.ellipsis,
    //               style: AppTheme.displayLarge.copyWith(
    //                 color: black,
    //               ),
    //             ),
    //             const SizedBox(height: 4),
    //             Text(
    //               (group.lastMessage ?? "").isEmpty ? (group.lastFile != null ? "file" : "") : (group.lastMessage ?? ""),
    //               overflow: TextOverflow.ellipsis,
    //               style: const TextStyle(
    //                 color: greyText,
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const Spacer(),
    //       Column(
    //         children: [
    //           Text(
    //             MyFunctions.parseDateToTime(group.date ?? "-"),
    //             style: const TextStyle(
    //               color: greyText,
    //               fontSize: 12,
    //               fontWeight: FontWeight.w400,
    //             ),
    //           ),
    //           const Spacer(),
    //           if (group.unreadMessageCount == 0)
    //             if (group.lastMessage != null && group.lastFile != null)
    //               if (group.lastMessageIsRead)
    //                 Icon(Icons.mark_email_read)
    //               // AppIcons.checkRead.svg(
    //               //   color: context.color.tealAccent,
    //               // )
    //               else
    //                 Icon(
    //                   Icons.check,
    //                   color: secondary,
    //                   size: 15,
    //                 )
    //             else
    //               SizedBox()
    //           else
    //             Container(
    //               width: 20,
    //               height: 20,
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                 color: blue,
    //                 shape: BoxShape.circle,
    //               ),
    //               child: Text(
    //                 '${group.unreadMessageCount}',
    //                 style: TextStyle(
    //                   color: white,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //               ),
    //             ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}

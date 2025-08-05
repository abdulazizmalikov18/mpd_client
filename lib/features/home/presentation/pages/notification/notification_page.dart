import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: context.l10n.notification,
        actions: [
          if (kDebugMode)
            IconButton(
              onPressed: () async {
                final token = StorageRepository.getString(StorageKeys.FCMTOKEN);
                await Clipboard.setData(ClipboardData(text: token));
              },
              icon: const Icon(Icons.copy),
            ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.chatNotFound),
          const SizedBox(height: 32),
          const Text(
            "No Notification",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            "You have no notification",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: greyText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
        ],
      ),
      // body: ValueListenableBuilder(
      //   valueListenable: $notificationList,
      //   builder: (context, List<RemoteMessage> value, child) {
      //     if (value.isEmpty) {
      //       return Center(
      //         child: Image.asset(
      //           'assets/images/notAppoint.png',
      //           height: 130.h,
      //           fit: BoxFit.contain,
      //         ),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: value.length,
      //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      //       itemBuilder: (context, index) => Container(
      //         margin: EdgeInsets.only(bottom: 12.h),
      //         decoration: BoxDecoration(
      //           color: context.color.white,
      //           borderRadius: BorderRadius.circular(10.r),
      //           boxShadow: [
      //             BoxShadow(color: context.color.cardShadow, blurRadius: 10.r)
      //           ],
      //         ),
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Image.asset(AppImages.logo, height: 20.h),
      //                   Text(
      //                     '31 Mar 2023 22:30',
      //                     style: Styles.bottomLabel.copyWith(
      //                       color: context.color.grey,
      //                     ),
      //                   )
      //                 ],
      //               ),
      //               ScreenUtil().setVerticalSpacing(8.h),
      //               Text(
      //                 value[index].notification?.title ?? '--',
      //                 style: Styles.boldHeadline6,
      //               ),
      //               ScreenUtil().setVerticalSpacing(4.h),
      //               Text(
      //                 value[index].notification?.body ?? '--',
      //                 style: Styles.postTitle,
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

/*



 */

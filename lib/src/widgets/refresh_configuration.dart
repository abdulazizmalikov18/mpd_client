// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mpd_client/app/app_colors.dart';
// import 'package:mpd_client/src/themes/styles.dart';

// class RefreshConfigWidget extends StatelessWidget {
//   final Widget child;
//   const RefreshConfigWidget({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return RefreshConfiguration(
//         footerTriggerDistance: 15,
//         dragSpeedRatio: 0.91,
//         headerBuilder: () => ClassicHeader(
//             completeIcon:  Icon(Icons.done, color: context.color.mainBlue),
//             releaseIcon:  Icon(Icons.refresh, color: context.color.mainBlue),
//             idleIcon:  Icon(Icons.arrow_downward, color: context.color.mainBlue),
//             textStyle: Styles.headline7.copyWith(color: context.color.mainBlue),
//             refreshingIcon: SizedBox(
//               height: 25.h,
//               width: 25.h,
//               child:  CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: context.color.mainBlue,
//               ),
//             )),
//         footerBuilder: () => ClassicFooter(
//               noMoreIcon:  Icon(Icons.error, color: context.color.red),
//               noDataText: 'No more Data',
//               failedIcon:  Icon(Icons.error, color: context.color.red),
//               failedText: 'Failed !!!',
//               idleIcon:  Icon(Icons.arrow_downward, color: context.color.mainBlue),
//               textStyle: Styles.headline7.copyWith(color: context.color.mainBlue),
//               loadingIcon: SizedBox(
//                 height: 25.h,
//                 width: 25.h,
//                 child:  CircularProgressIndicator(strokeWidth: 2, color: context.color.mainBlue),
//               ),
//             ),
//         enableLoadingWhenNoData: true,
//         enableRefreshVibrate: false,
//         enableLoadMoreVibrate: true,
//         enableLoadingWhenFailed: true,
//         shouldFooterFollowWhenNotFull: (state) {
//           // If you want load more with noMoreData state ,may be you should return false
//           return false;
//         },
//         child: child);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:orient_motors/presentation/component/animation_effect.dart';
// import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
//
// class CustomSuccessDialogComponent extends StatelessWidget {
//   const CustomSuccessDialogComponent({super.key, required this.title, this.subtitle});
//
//   final String title;
//   final String? subtitle;
//
//   @override
//   Widget build(BuildContext context) {
//     return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
//       return AlertDialog(
//         backgroundColor: colors.white,
//         surfaceTintColor: colors.transparent,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//           Radius.circular(15.0.r),
//         )),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             AnimationButtonEffect(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Icon(Icons.clear, color: colors.text)),
//           ],
//         ),
//         content: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 height: 50.w,
//                 width: 50.w,
//                 decoration: BoxDecoration(
//                   color: colors.confirmed,
//                   borderRadius: BorderRadius.circular(50.r),
//                 ),
//                 child: Icon(
//                   Icons.check_rounded,
//                   color: colors.white,
//                   size: 40.w,
//                 ),
//               ),
//               16.verticalSpace,
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: fonts.subtitle1.copyWith(fontSize: 18.sp),
//               ),
//               if (subtitle != null)
//                 Column(children: [
//                   4.verticalSpace,
//                   Text(
//                     subtitle ?? "",
//                     textAlign: TextAlign.center,
//                     style: fonts.headline1
//                         .copyWith(color: colors.text.withOpacity(0.5)),
//                   ),
//                 ]),
//               36.verticalSpace,
//             ]),
//       );
//     });
//   }
// }

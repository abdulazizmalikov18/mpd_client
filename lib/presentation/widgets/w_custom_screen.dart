import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/application/show_pop_up/show_pop_up_bloc.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class CustomScreen extends StatelessWidget {
  final Widget child;

  const CustomScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(child: child),
          BlocBuilder<ShowPopUpBloc, ShowPopUpState>(
            builder: (context, state) {
              return AnimatedPositioned(
                top: state.showPopUp ? MediaQuery.of(context).padding.top + 30 : -(MediaQuery.of(context).padding.top + 68 + 80),
                duration: const Duration(milliseconds: 300),
                // width: MediaQuery.of(context).size.width - 64,
                left: (MediaQuery.of(context).size.width - 360) / 10,
                right: (MediaQuery.of(context).size.width - 360) / 10,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: statusColor(state.status),
                    // color: statusColor(state.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: statusImage(state.status).svg(
                                width: 36,
                                height: 36,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: Text(
                              state.message,
                              style: AppTheme.bodySmall.copyWith(
                                color: white,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // AppIcons.close.svg(),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  String statusImage(PopStatus status) {
    return '';
    // return switch (status) {
    //   PopStatus.success => AppIcons.success,
    //   PopStatus.error => AppIcons.error,
    //   PopStatus.warning => AppImages.success,
    // };
  }

  LinearGradient statusColor(PopStatus status) {
    switch (status) {
      case PopStatus.success:
        return wgradient;
      case PopStatus.error:
        return wgradientRed;
      case PopStatus.warning:
        return wgradient;
    }
  }

// @override
// Widget build(BuildContext context) {
//   var size = MediaQuery.of(context).size;
//   return Material(
//     child: Stack(
//       children: [
//         Positioned.fill(child: child),
//         BlocBuilder<ShowPopUpBloc, ShowPopUpState>(
//           builder: (context, state) {
//             return AnimatedPositioned(
//               top: state.showPopUp
//                   ? MediaQuery.of(context).padding.top + 30
//                   : -(MediaQuery.of(context).padding.top + 68 + 92),
//               duration: const Duration(milliseconds: 300),
//               height: size.width >= 601
//                   ? 88
//                   : state.message.length > 28
//                   ? 88
//                   : 56,
//               left: (MediaQuery.of(context).size.width - 360) / 4,
//               right: (MediaQuery.of(context).size.width - 360) / 4,
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: size.width >= 601 ? 32 : 12,
//                   horizontal: 16,
//                 ),
//                 margin: const EdgeInsets.symmetric(horizontal: 32),
//                 decoration: BoxDecoration(
//                   color: statusColor(state.status).withOpacity(.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   state.message,
//                   style: AppTheme.bodyMedium.copyWith(
//                     fontWeight: FontWeight.w400,
//                     color: statusColor(state.status),
//                   ),
//                   maxLines: 3,
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             );
//           },
//         )
//       ],
//     ),
//   );
// }
//
// Color statusColor(PopStatus status) {
//   switch (status) {
//     case PopStatus.success:
//       return green;
//     case PopStatus.error:
//       return red;
//     case PopStatus.warning:
//       return Colors.orange;
//   }
// }
}

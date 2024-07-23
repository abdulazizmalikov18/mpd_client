// import 'dart:io';
//
// import 'package:dwed_client/assets/colors/colors.dart';
// import 'package:dwed_client/assets/constants/icons.dart';
// import 'package:dwed_client/assets/themes/theme.dart';
// import 'package:dwed_client/core/extensions/context_extension.dart';
// import 'package:dwed_client/features/chat/presentation/bloc/chat/chat_bloc.dart';
// import 'package:dwed_client/features/chat/presentation/controller/vm_controller.dart';
// import 'package:dwed_client/features/chat/presentation/widgets/create_group_screen.dart';
// import 'package:dwed_client/features/chat/presentation/widgets/dialog/create_group_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ChatCreateGroupCounter extends StatelessWidget {
//   const ChatCreateGroupCounter({
//     super.key,
//   });
//
//   bool get isMobile => Platform.isAndroid || Platform.isIOS;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//             onTap: () {
//               $chatController.of(context).pushToGroup(context);
//             },
//             child: const Icon(Icons.chevron_left) /*AppIcons.icArrowLeft.svg(
//             color: white.withOpacity(0.5),
//           ),*/
//             ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 flex: 7,
//                 child: Text(
//                   "LocaleKeys.selectUsers.tr()",
//                   overflow: TextOverflow.ellipsis,
//                   style: AppTheme.bodyLarge.copyWith(
//                     color: white.withOpacity(0.5),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 4),
//               ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   maxWidth: 100,
//                   minWidth: 20,
//                 ),
//                 child: BlocBuilder<ChatBloc, ChatState>(
//                   builder: (context, state) {
//                     return Text(
//                       '${state.createGroupContainer.selectionUser.length}/${state.createGroupContainer.count}',
//                       style: AppTheme.labelLarge.copyWith(
//                         color: white.withOpacity(0.5),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 12),
//         GestureDetector(
//           onTap: () => isMobile
//               ? Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const CreateGroupScreen(),
//                   ))
//               : showCreateGroupDialog(context),
//           child: Text(
//             "LocaleKeys.next.tr()",
//             style: AppTheme.bodyLarge.copyWith(
//               color: blue,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

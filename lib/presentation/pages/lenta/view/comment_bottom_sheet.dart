// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mpd_client/application/comment/comment_bloc.dart';
// import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
// import 'package:mpd_client/domain/entity/lenta/post_entity.dart';
// import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
// import 'package:mpd_client/presentation/pages/lenta/view/comment_view.dart';
// import 'package:mpd_client/presentation/pages/lenta/widgets/w_comment.dart';
// import 'package:mpd_client/presentation/styles/app_icons.dart';
// import 'package:mpd_client/presentation/styles/colors.dart';
// import 'package:mpd_client/presentation/styles/theme.dart';
// import 'package:mpd_client/presentation/widgets/w_button.dart';
// import 'package:mpd_client/presentation/widgets/w_text_field.dart';
// import 'package:mpd_client/utils/extensions/string_ext.dart';

// part '../mixin/comment_mixin.dart';

// void $showCommentBottomSheet(BuildContext context, PostEntity post) {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topRight: Radius.circular(16),
//         topLeft: Radius.circular(16),
//       ),
//     ),
//     builder: (context) => Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Align(
//           alignment: Alignment.topRight,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               height: 48,
//               width: 48,
//               margin: const EdgeInsets.all(12),
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                 color: closeButton,
//                 shape: BoxShape.circle,
//               ),
//               child: AppIcons.back.svg(),
//             ),
//           ),
//         ),
//         ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(16),
//             topLeft: Radius.circular(16),
//           ),
//           child: CommentBottomSheet(post: post),
//         ),
//       ],
//     ),
//   );
// }

// class CommentBottomSheet extends StatefulWidget {
//   final PostEntity post;

//   const CommentBottomSheet({
//     super.key,
//     required this.post,
//   });

//   @override
//   State<CommentBottomSheet> createState() => _CommentBottomSheetState();
// }

// class _CommentBottomSheetState extends State<CommentBottomSheet> with CommentMixin {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CommentBloc, CommentState>(
//       builder: (context, state) {
//         return SizedBox(
//           height: state.comments.length > 4 ? MediaQuery.sizeOf(context).height * 0.85 : 500,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   Text(
//                     'Comments',
//                     style: AppTheme.displayLarge.copyWith(
//                       fontSize: 20,
//                       color: white,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           for (int index = 0; index < state.comments.length; index++)
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                               child: WComment(
//                                 isMine: state.comments[index].user == username,
//                                 comment: state.comments[index],
//                               ),
//                             ),
//                           const SizedBox(height: 100),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned.fill(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(16),
//                       topLeft: Radius.circular(16),
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: 108,
//                           child: BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                             child: Container(color: white),
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           height: 100,

//                           decoration: BoxDecoration(
//                             color: white.withOpacity(.1),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(16),
//                               topLeft: Radius.circular(16),
//                             ),
//                             border: Border(
//                               top: BorderSide(color: white.withOpacity(0.2)),
//                             ),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 12,
//                           ),
//                           child: WTextField(
//                             fillColor: white.withOpacity(0.1),
//                             borderColor: white.withOpacity(0.2),
//                             style: AppTheme.headlineSmall.copyWith(
//                               color: white
//                             ),
//                             onChanged: (String value) {},
//                             suffixMaxWidth: 70,
//                             hintText: 'Yozing...',
//                             controller: controller,
//                             onEditingComplete: sendComment,
//                             suffixIcon: WButton(
//                               width: 40,
//                               height: 40,
//                               borderRadius: 30,
//                               margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(right: 12),
//                               onTap: sendComment,
//                               child: Transform.rotate(
//                                 angle: 0.8,
//                                 child: AppIcons.send.svg(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

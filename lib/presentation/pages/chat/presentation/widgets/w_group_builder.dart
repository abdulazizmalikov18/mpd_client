// import 'package:flutter/material.dart';
// import 'package:dwed_client/assets/colors/colors.dart';
// import 'package:dwed_client/features/chat/presentation/bloc/chat/chat_bloc.dart';
// import 'package:dwed_client/features/chat/presentation/controller/vm_controller.dart';
// import 'package:dwed_client/features/chat/presentation/widgets/items/w_chat_user_check_box_view_item.dart';
// import 'package:dwed_client/features/chat/presentation/widgets/items/w_chat_user_view_item.dart';
// import 'package:dwed_client/features/chat/presentation/widgets/w_user_chat_button.dart';
// import 'package:dwed_client/features/common/pagination/presentation/paginator_list.dart';
// import 'package:dwed_client/features/common/widgets/w_shimmer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';
//
// class WChatGroupBuilder extends StatelessWidget {
//   const WChatGroupBuilder({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChatBloc, ChatState>(
//       builder: (context, state) {
//         return CustomScrollView(
//           slivers: [
//             CupertinoSliverRefreshControl(
//               onRefresh: () async {
//                 $chatController.of(context).getGroups(context);
//                 await Future.delayed(const Duration(seconds: 1));
//               },
//               refreshTriggerPullDistance: 50,
//               refreshIndicatorExtent: 30,
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   var group = (state.groupContainer.isSearch ? state.groupContainer.searchGroup : state.groupContainer.groups)?[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: BlocBuilder<ChatBloc, ChatState>(
//                       builder: (context, state) {
//                         return WUserChatButton(
//                           onTap: () => $chatController.of(context).pushToChat(context, slugName: group.slugName),
//                           group: group!,
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 childCount: (state.groupContainer.isSearch ? state.groupContainer.searchGroup : state.groupContainer.groups)?.length ?? 0,
//               ),
//             ),
//             if (state.groupContainer.findUser.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                   child: Text("Search Users"),
//                 ),
//               ),
//             if (state.groupContainer.findUser.isNotEmpty)
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                     return WChatUserViewItem(
//                       user: state.groupContainer.findUser[index],
//                     );
//                   },
//                   childCount: state.groupContainer.findUser.length,
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//     return BlocBuilder<ChatBloc, ChatState>(
//       builder: (context, state) {
//         return switch (state.screenStatus) {
//           ChatScreenStatus.createGroup => PaginatorList(
//               paginatorStatus: state.createGroupContainer.status,
//               itemBuilder: (context, index) => WChatUserCheckBoxViewItem(
//                 user: state.createGroupContainer.users[index],
//                 isActive: state.createGroupContainer.selectionUser.contains(state.createGroupContainer.users[index]),
//               ),
//               separatorBuilder: (context, index) => const SizedBox(height: 8),
//               itemCount: state.createGroupContainer.users.length,
//               fetchMoreFunction: () {},
//               hasMoreToFetch: false,
//             ),
//           ChatScreenStatus.createChat => switch (state.usersContainer.status) {
//               FormzSubmissionStatus.inProgress => ListView.separated(
//                   itemBuilder: (context, index) => const WShimmer(
//                     height: 48,
//                     width: double.infinity,
//                     radius: 6,
//                   ),
//                   separatorBuilder: (context, index) => const SizedBox(height: 10),
//                   itemCount: 30,
//                 ),
//               _ => PaginatorList(
//                   paginatorStatus: state.usersContainer.status,
//                   itemBuilder: (context, index) => WChatUserViewItem(
//                     user: state.usersContainer.users[index],
//                   ),
//                   separatorBuilder: (context, index) => const SizedBox(height: 8),
//                   itemCount: state.usersContainer.users.length,
//                   fetchMoreFunction: () {},
//                   hasMoreToFetch: false,
//                 ),
//             },
//           _ => switch (state.groupContainer.status) {
//               FormzSubmissionStatus.inProgress => ListView.separated(
//                   itemBuilder: (context, index) => const WShimmer(
//                     height: 48,
//                     width: double.infinity,
//                     radius: 6,
//                   ),
//                   separatorBuilder: (context, index) => const SizedBox(height: 10),
//                   itemCount: 30,
//                 ),
//               _ => BlocBuilder<ChatBloc, ChatState>(
//                   builder: (context, state) {
//                     return CustomScrollView(
//                       slivers: [
//                         CupertinoSliverRefreshControl(
//                           onRefresh: () async {
//                             $chatController.of(context).getGroups(context);
//                             await Future.delayed(const Duration(seconds: 1));
//                           },
//                           refreshTriggerPullDistance: 50,
//                           refreshIndicatorExtent: 30,
//                         ),
//                         SliverList(
//                           delegate: SliverChildBuilderDelegate(
//                             (context, index) {
//                               var group = (state.groupContainer.isSearch ? state.groupContainer.searchGroup : state.groupContainer.groups)?[index];
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 8),
//                                 child: BlocBuilder<ChatBloc, ChatState>(
//                                   builder: (context, state) {
//                                     return WUserChatButton(
//                                       onTap: () => $chatController.of(context).pushToChat(context, slugName: group.slugName),
//                                       group: group!,
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                             childCount: (state.groupContainer.isSearch ? state.groupContainer.searchGroup : state.groupContainer.groups)?.length ?? 0,
//                           ),
//                         ),
//                         if (state.groupContainer.findUser.isNotEmpty)
//                           const SliverToBoxAdapter(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                               child: Text("Search Users"),
//                             ),
//                           ),
//                         if (state.groupContainer.findUser.isNotEmpty)
//                           SliverList(
//                             delegate: SliverChildBuilderDelegate(
//                               (context, index) {
//                                 return WChatUserViewItem(
//                                   user: state.groupContainer.findUser[index],
//                                 );
//                               },
//                               childCount: state.groupContainer.findUser.length,
//                             ),
//                           ),
//                       ],
//                     );
//                   },
//                 ),
//             },
//         };
//       },
//     );
//   }
// }

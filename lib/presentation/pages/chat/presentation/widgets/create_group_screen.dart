// import 'dart:io';
// import 'package:dwed_client/assets/colors/colors.dart';
// import 'package:dwed_client/assets/themes/theme.dart';
// import 'package:dwed_client/features/chat/presentation/bloc/chat/chat_bloc.dart';
// import 'package:dwed_client/features/common/widgets/w_button.dart';
// import 'package:dwed_client/features/common/widgets/w_textfield.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';
//
//
// class CreateGroupScreen extends StatefulWidget {
//   const CreateGroupScreen({super.key});
//
//   @override
//   State<CreateGroupScreen> createState() => _CreateGroupScreenState();
// }
//
// class _CreateGroupScreenState extends State<CreateGroupScreen> {
//   TextEditingController groupNameController = TextEditingController();
//   bool isPrivate = false;
//   ValueNotifier<bool> isNotValidate = ValueNotifier(true);
//   bool isOnTap = false;
//   File? avatar;
//
//   void _getAvatar() async {
//     final file = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//     if (file?.files.first != null) {
//       avatar = File(file!.files.first.path!);
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size.width * 0.50;
//     return SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         child: BlocConsumer<ChatBloc, ChatState>(
//           listener: (context, state) {
//             if (isOnTap && (!state.usersContainer.status.isInProgress)) {
//               Navigator.pop(context);
//             }
//           },
//           builder: (context, state) {
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: (){
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(
//                               Icons.arrow_back,
//                               color: blue,
//                             ),
//                           ),
//                           const Text(
//                             "Create Group",
//                             style: AppTheme.displaySmall,
//                           ),
//                           const SizedBox.shrink(),
//                         ],
//                       ),
//                       const SizedBox(height: 32),
//                       const Text(
//                         "LocaleKeys.groupPicture.tr()",
//                         style: AppTheme.titleMedium,
//                       ),
//                       const SizedBox(height: 16),
//                       Center(
//                         child: switch (avatar != null) {
//                           true => Tooltip(
//                               message: "LocaleKeys.groupPicture.tr()",
//                               child: SizedBox(
//                                 width: size,
//                                 height: size,
//                                 child: Stack(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: _getAvatar,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.file(
//                                           avatar!,
//                                           width: size,
//                                           height: size,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topRight,
//                                       child: CloseButton(
//                                         onPressed: () {
//                                           avatar = null;
//                                           setState(() {});
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           _ => WButton(
//                               width: size,
//                               height: size,
//                               borderRadius: 8,
//                               border: Border.all(color: white.withOpacity(0.1)),
//                               color: Colors.transparent,
//                               onTap: _getAvatar,
//                               text: "LocaleKeys.picture.tr()",
//                             ),
//                         },
//                       ),
//                       const SizedBox(height: 32),
//                       const Text(
//                         "LocaleKeys.groupName.tr()",
//                         style: AppTheme.titleMedium,
//                       ),
//                       const SizedBox(height: 16),
//                       WTextField(
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             isNotValidate.value = false;
//                             return;
//                           }
//                           isNotValidate.value = true;
//                         },
//                         controller: groupNameController,
//                         fillColor: white.withOpacity(0.05),
//                         borderColor: white.withOpacity(0.1),
//                       ),
//                       const SizedBox(height: 32),
//                       const Text(
//                         "LocaleKeys.groupType.tr()",
//                         style: AppTheme.titleMedium,
//                       ),
//                       const SizedBox(height: 16),
//                       DecoratedBox(
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: white.withOpacity(0.1),
//                             ),
//                             borderRadius: BorderRadius.circular(8)),
//                         child: DefaultTabController(
//                           length: 2,
//                           child: TabBar(
//                             onTap: (value) {
//                               isPrivate = value == 1;
//                             },
//                             indicatorSize: TabBarIndicatorSize.tab,
//                             indicator: BoxDecoration(
//                               color: blue,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             splashBorderRadius: BorderRadius.circular(8),
//                             dividerColor: Colors.transparent,
//                             labelStyle: const TextStyle(color: white),
//                             tabs: const [
//                               Tab(
//                                 text: "LocaleKeys.public.tr()",
//                               ),
//                               Tab(
//                                 text: "LocaleKeys.private.tr()",
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 80),
//                       ValueListenableBuilder(
//                         valueListenable: isNotValidate,
//                         builder: (BuildContext context, value, Widget? child) {
//                           return WButton(
//                             isDisabled: value,
//                             disabledColor: blue.withOpacity(0.4),
//                             onTap: () {
//                               isOnTap = true;
//                               context.read<ChatBloc>().add(
//                                     CreateGroupEvent(
//                                       name: groupNameController.text.trim(),
//                                       isPrivate: isPrivate,
//                                       avatar: avatar?.path,
//                                     ),
//                                   );
//                             },
//                             text: "LocaleKeys.create.tr()",
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       WButton(
//                         color: white.withOpacity(0.1),
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         text: "LocaleKeys.cancel.tr()",
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (state.usersContainer.status.isInProgress)
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// ////// Musr
//
//
//
// class WBox extends StatelessWidget {
//   final String title;
//   final Widget child;
//   final Widget rightWidgets;
//   final EdgeInsets? margin;
//   final EdgeInsets? padding;
//   final bool leftDivider;
//   final void Function()? onTap;
//
//   const WBox({
//     super.key,
//     required this.child,
//     this.rightWidgets = const SizedBox.shrink(),
//     required this.title,
//     this.margin,
//     this.padding,
//     this.onTap,
//     this.leftDivider = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: margin ??
//             const EdgeInsets.only(
//               left: 32,
//               right: 32,
//               top: 16,
//             ),
//         child: SizedBox(
//           width: double.infinity,
//           child: Stack(
//             children: [
//               DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: white,
//                   borderRadius: leftDivider ?  BorderRadius.circular(8) :  BorderRadius.circular(0),
//                 ),
//                 child: Padding(
//                   padding: padding ?? const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: onTap,
//                               child: Text(
//                                 title,
//                                 style: AppTheme.displaySmall.copyWith(
//                                   color: greyText,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             rightWidgets,
//                           ],
//                         ),
//                       ),
//                       // const SizedBox(height: 16),
//                       child,
//                     ],
//                   ),
//                 ),
//               ),
//               if(leftDivider)Positioned(
//                 top: 16,
//                 child: GestureDetector(
//                   onTap: onTap,
//                   child: const SizedBox(
//                     width: 4,
//                     height: 40,
//                     child: DecoratedBox(
//                       decoration: ShapeDecoration(
//                         color: blue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(100),
//                             bottomRight: Radius.circular(100),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

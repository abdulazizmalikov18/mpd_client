import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';

void showCreateGroupDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const WCreateGroupDialog();
    },
  );
}

class WCreateGroupDialog extends StatefulWidget {
  const WCreateGroupDialog({
    super.key,
  });

  @override
  State<WCreateGroupDialog> createState() => _WCreateGroupDialogState();
}

class _WCreateGroupDialogState extends State<WCreateGroupDialog> {
  TextEditingController groupNameController = TextEditingController();
  bool isPrivate = false;
  ValueNotifier<bool> isNotValidate = ValueNotifier(true);
  bool isOnTap = false;
  File? avatar;

  void _getAvatar() async {
    // final file = await FilePicker.platform.pickFiles(
    //   type: FileType.image,
    // );
    // if (file?.files.first != null) {
    //   avatar = File(file!.files.first.path!);
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.24;
    return Dialog(
      backgroundColor: backGroundColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (isOnTap && (!state.usersContainer.status.isInProgress)) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            "LocaleKeys.createGroup.tr()",
                            style: AppTheme.displaySmall.copyWith(color: white),
                          ),
                        ),
                        Text(
                          "LocaleKeys.groupPicture.tr()",
                          style: AppTheme.titleMedium.copyWith(color: white),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: switch (avatar != null) {
                            true => Tooltip(
                                message: "LocaleKeys.groupPicture.tr()",
                                child: SizedBox(
                                  width: size,
                                  height: size,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: _getAvatar,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            avatar!,
                                            width: size,
                                            height: size,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: CloseButton(
                                          onPressed: () {
                                            avatar = null;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            _ => WButton(
                                width: size,
                                height: size,
                                borderRadius: 8,
                                border:
                                    Border.all(color: white.withOpacity(0.1)),
                                color: Colors.transparent,
                                onTap: _getAvatar,
                                text: "LocaleKeys.picture.tr()",
                                textStyle:
                                    AppTheme.titleMedium.copyWith(color: white),
                              ),
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "LocaleKeys.groupName.tr()",
                          style: AppTheme.titleMedium.copyWith(color: white),
                        ),
                        const SizedBox(height: 8),
                        WTextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              isNotValidate.value = false;
                              return;
                            }
                            isNotValidate.value = true;
                          },
                          controller: groupNameController,
                          fillColor: white.withOpacity(0.05),
                          borderColor: white.withOpacity(0.1),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "LocaleKeys.groupType.tr()",
                          style: AppTheme.titleMedium.copyWith(color: white),
                        ),
                        const SizedBox(height: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: white.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DefaultTabController(
                            length: 2,
                            child: TabBar(
                              onTap: (value) {
                                isPrivate = value == 1;
                              },
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              splashBorderRadius: BorderRadius.circular(8),
                              dividerColor: Colors.transparent,
                              labelStyle: const TextStyle(color: white),
                              tabs: const [
                                Tab(
                                  text: "LocaleKeys.public.tr()",
                                ),
                                Tab(
                                  text: "LocaleKeys.private.tr()",
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(height: 16),
                        ValueListenableBuilder(
                          valueListenable: isNotValidate,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return WButton(
                              isDisabled: value,
                              disabledColor: blue.withOpacity(0.4),
                              onTap: () {
                                isOnTap = true;
                                context.read<ChatBloc>().add(
                                      CreateGroupEvent(
                                        name: groupNameController.text.trim(),
                                        isPrivate: isPrivate,
                                        avatar: avatar?.path,
                                      ),
                                    );
                              },
                              text: "LocaleKeys.create.tr()",
                              textColor: white,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        WButton(
                          color: white.withOpacity(0.1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: "LocaleKeys.cancel.tr()",
                          textColor: white,
                        ),
                      ],
                    ),
                  ),
                  if (state.usersContainer.status.isInProgress)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

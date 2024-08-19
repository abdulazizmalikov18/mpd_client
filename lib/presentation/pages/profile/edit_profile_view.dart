import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/domain/entity/auth/data_entity.dart';
import 'package:mpd_client/domain/models/auth/user.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/w_select_profession.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/w_select_region.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_select_gender.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_textfield_with_title.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_button_gradient.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/date_time_ext.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

part './mixin/edit_profile_mixin.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> with EditProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: WAppBar(
        back: true,
        backIconColor: white,
        backgroundColor: Colors.transparent,
        title: Text("", style: TextStyle(
          color: white,
        )),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
              tag: 'profile_background',
              child: ValueListenableBuilder(
                valueListenable: backgroundImage,
                builder: (BuildContext context, String? value, Widget? child) {
                  return value == null ?  WNetworkImage(
                    image: "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13",
                    width: double.maxFinite,
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    borderRadius: 0,
                    defaultWidget: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      color: black,
                    ),
                  ) : Image.file(File(value));
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.8, 1),
              child: WButton(
                width: 48,
                height: 48,
                margin: EdgeInsets.only(
                  top: (MediaQuery.sizeOf(context).height * 0.25) - 56,
                ),
                color: mainBlue,
                borderRadius: 100,
                onTap: pickImageBackgroudnBottomSheet,
                child: AppIcons.edit.svg(color: white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).copyWith(top: (MediaQuery.sizeOf(context).height * 0.25) - 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: avatar,
                          builder: (BuildContext context, avatar, Widget? child) {
                            return Hero(
                              tag: 'profile_image',
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 4,
                                    color: white,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: avatar != null
                                        ? Image.file(
                                            File(avatar),
                                            width: 96,
                                            height: 96,
                                            fit: BoxFit.cover,
                                          )
                                        : WNetworkImage(
                                            image: user.value.avatar,
                                            borderRadius: 100,
                                            width: 96,
                                            height: 96,
                                            defaultWidget: Image.asset(
                                              AppImages.doctor,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: pickImageBottomSheet,
                          child: Text(
                            context.l10n.profile_edit_photo,
                            style: AppTheme.displaySmall.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: mainBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'ism',
                    hintText: user.value.name,
                    onChange: (newName) {
                      if (newName.isEmpty) {
                        user.value = user.value.copyWith(
                          name: oldUser.name,
                        );
                      } else {
                        user.value = user.value.copyWith(
                          name: newName,
                        );
                      }
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Familya',
                    hintText: user.value.lastname,
                    onChange: (lastName) {
                      if (lastName.isEmpty) {
                        user.value = user.value.copyWith(
                          lastname: oldUser.lastname,
                        );
                      } else {
                        user.value = user.value.copyWith(
                          lastname: lastName,
                        );
                      }
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Tug’ilgan sana',
                    hintText: user.value.birthday.split('-').reversed.toList().join('-'),
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (ctx) {
                            return builtCupertinoDatePicker(context);
                          }).then(
                        (value) {
                          if (value is Map) {
                            user.value = user.value.copyWith(
                              birthday: value['date'].toString().replaceAll('.', '-'),
                            );
                          }
                        },
                      );
                    },
                    onChange: (birthday) {
                      if (birthday.isEmpty) {
                        user.value = user.value.copyWith(
                          birthday: oldUser.surname,
                        );
                      } else {
                        user.value = user.value.copyWith(
                          birthday: birthday,
                        );
                      }
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationSelectGender(
                    isMale: user.value.gender.startsWith("m"),
                    onChange: (bool newValue) {
                      user.value = user.value.copyWith(
                        gender: newValue ? "m" : "f",
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Tumani',
                    hintText: user.value.region.name,
                    isRequired: true,
                    isReadOnly: true,
                    onTap: onPressedSelectAddress,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Mutaxasisligi',
                    hintText: user.value.mainCat.name.isNotEmpty ? user.value.mainCat.name : "Kiritilmagan",
                    isRequired: true,
                    isReadOnly: true,
                    onTap: onPressedSelectSpecialist,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'PINFL',
                    hintText: user.value.pinfl.isNotEmpty ? user.value.pinfl : "Kiritilmagan",
                    isRequired: true,
                    onChange: (pinfl) {
                      if (pinfl.isEmpty) {
                        user.value = user.value.copyWith(
                          pinfl: oldUser.pinfl,
                        );
                      } else {
                        user.value = user.value.copyWith(
                          pinfl: pinfl,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  ValueListenableBuilder(
                    valueListenable: user,
                    builder: (BuildContext context, user, Widget? child) {
                      return ValueListenableBuilder(
                        valueListenable: avatar,
                        builder: (BuildContext context, avatar, Widget? child) {
                          print(!(avatar != null || oldUser != user));
                          return WButton(
                            isDisabled: !(avatar != null || oldUser != user),
                            onTap: updateUserOnPress,
                            text: "O'zgarishlarni saqlash",
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  WButtonGradient(
                    onTap: () {
                      context.pop();
                    },
                    color: mainBlue,
                    text: "Bekor qilish",
                    textStyle: AppTheme.bodyLarge.copyWith(
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container builtCupertinoDatePicker(BuildContext context) {
  DateTime dateTime = DateTime.now();
  return Container(
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground.resolveFrom(context),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    height: 300,
    padding: const EdgeInsets.only(top: 6.0),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32, top: 24),
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  dateTime = date;
                },
                initialDateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                minimumYear: 1940,
                maximumYear: DateTime.now().year,
                minimumDate: DateTime(1940),
                maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LongButton(
                buttonName: 'Saqlash',
                onPress: () {
                  Navigator.pop(context, {
                    'date': dateTime.toView,
                  });
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}

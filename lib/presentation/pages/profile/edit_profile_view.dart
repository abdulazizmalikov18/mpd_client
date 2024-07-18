import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/domain/entity/auth/data_entity.dart';
import 'package:mpd_client/domain/models/auth/user.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/w_select_profession.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/w_select_region.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/w_shadowed_container.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_phone.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_select_gender.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_textfield_with_title.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_button_gradient.dart';

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
      appBar: const WAppBar(
        title: Text('Profilni tasdiqlash'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ValueListenableBuilder(
            valueListenable: user,
            builder: (BuildContext context, user, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 88,
                    height: 88,
                    child: Stack(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: avatar,
                          builder: (BuildContext context, avatar, Widget? child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: avatar != null
                                  ? Image.file(
                                      File(avatar),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      user!.avatar,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return SizedBox();
                                        // return AppImages.userImg.imgAsset(
                                        //   width: 80,
                                        //   height: 80,
                                        //   fit: BoxFit.cover,
                                        // );
                                      },
                                    ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: pickImageBottomSheet,
                            child: DecoratedBox(
                              decoration: BoxDecoration(gradient: wgradient, shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: SizedBox()//AppIcons.icHome.svg(color: white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const WVerificationPhone(),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'ism',
                    hintText: user.name,
                    onChange: (newName) {
                      if (newName.isEmpty) {
                        this.user.value = user.copyWith(
                          name: oldUser.name,
                        );
                      } else {
                        this.user.value = user.copyWith(
                          name: newName,
                        );
                      }
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Familya',
                    hintText: user.lastname,
                    onChange: (lastName) {
                      if (lastName.isEmpty) {
                        this.user.value = user.copyWith(
                          lastname: oldUser.lastname,
                        );
                      } else {
                        this.user.value = user.copyWith(
                          lastname: lastName,
                        );
                      }
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Tug’ilgan sana',
                    hintText: user.birthday,
                    onChange: (surname) {
                      if (surname.isEmpty) {
                        this.user.value = user.copyWith(
                          surname: oldUser.surname,
                        );
                      } else {
                        this.user.value = user.copyWith(
                          surname: surname,
                        );
                      }
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationSelectGender(
                    isMale: user.gender.startsWith("male"),
                    onChange: (bool newValue) {
                      this.user.value = user.copyWith(
                        gender: newValue ? "male" : "female",
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Tumani',
                    hintText: user.region.name,
                    isRequired: true,
                    isReadOnly: true,
                    onTap: onPressedSelectAddress,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Mutaxasisligi',
                    hintText: user.mainCat.name.isNotEmpty ? user.mainCat.name : "Kiritilmagan",
                    isRequired: true,
                    isReadOnly: true,
                    onTap: onPressedSelectSpecialist,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'Login',
                    hintText: user.login.isNotEmpty ? user.login : "Kiritilmagan",
                    isRequired: true,
                    onChange: (login) {
                      if (login.isEmpty) {
                        this.user.value = user.copyWith(
                          login: oldUser.login,
                        );
                      } else {
                        this.user.value = user.copyWith(
                          login: login,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const WVerificationTextFieldWithTitle(
                    title: 'Parol',
                    hintText: "Not Found",
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  WVerificationTextFieldWithTitle(
                    title: 'PINFL',
                    hintText: user.pinfl.isNotEmpty ? user.pinfl : "Kiritilmagan",
                    isRequired: true,
                    onChange: (pinfl) {
                      if (pinfl.isEmpty) {
                        this.user.value = user.copyWith(
                          pinfl: oldUser.pinfl,
                        );
                      } else {
                        this.user.value = user.copyWith(
                          pinfl: pinfl,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  ValueListenableBuilder(
                    valueListenable: avatar,
                    builder: (BuildContext context, avatar, Widget? child) {
                      print(!(avatar != null || oldUser != user));
                      return WButton(
                        isDisabled: !(avatar != null || oldUser != user),
                        onTap: updateUserOnPress,
                        text: "O'zgarishlarni saqlash",
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  WButtonGradient(
                    onTap: () {
                      context.pop();
                    },
                    text: "Bekor qilish",
                    textStyle: AppTheme.bodyLarge.copyWith(
                      color: black,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

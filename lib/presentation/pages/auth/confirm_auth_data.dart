import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/auth/controller/registration_view_model.dart';
import 'package:mpd_client/application/show_pop_up/show_pop_up_bloc.dart';
import 'package:mpd_client/domain/models/auth/create_user_model.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/w_select_profession.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/w_select_region.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/w_pick_avatar.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/w_shadowed_container.dart';
import 'package:mpd_client/presentation/pages/profile/edit_profile_view.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_select_gender.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/verification/w_verification_textfield_with_title.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

part './mixin/confirm_data_mixin.dart';

class ConfirmAuthDataView extends StatefulWidget {
  final String phone;
  final String login;
  final String password;

  const ConfirmAuthDataView({
    super.key,
    required this.phone,
    required this.login,
    required this.password,
  });

  @override
  State<ConfirmAuthDataView> createState() => _ConfirmAuthDataViewState();
}

class _ConfirmAuthDataViewState extends State<ConfirmAuthDataView> with ConfirmDataMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    'Ma’lumotlaringzini kiriting',
                    textAlign: TextAlign.center,
                    style: context.textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Tizimga kiring va barcha xizmatlardan foydalaning',
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineSmall!.copyWith(
                      color: gray,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: WPickAvatar(
                    pickImage: pickImageBottomSheet,
                    avatar: avatar,
                  ),
                ),
                const SizedBox(height: 24),
                WVerificationTextFieldWithTitle(
                  title: 'Ism',
                  hintText: 'Ism',
                  controller: nameController,
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                WVerificationTextFieldWithTitle(
                  title: 'Familya',
                  hintText: 'Familya',
                  isRequired: true,
                  controller: lastnameController,
                ),
                const SizedBox(height: 24),
                WVerificationTextFieldWithTitle(
                  title: 'Otasining ismi',
                  hintText: 'Otasining ismi',
                  controller: surnameController,
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: birthdate,
                  builder: (BuildContext context, DateTime? value, Widget? child) {
                    return WVerificationTextFieldWithTitle(
                      title: 'Tug’ilgan sana',
                      hintText: value != null ? '${value.day.toString().padLeft(2, "0")}.${value.month.toString().padLeft(2, "0")}.${value.year}' : "Sana tanlang !",
                      isRequired: true,
                      isReadOnly: true,
                      rightIcon: const SizedBox(),
                      //AppIcons.icHome.svg(),
                      onTap: onPressedDateTime,
                    );
                  },
                ),
                const SizedBox(height: 24),
                WVerificationSelectGender(
                  isMale: isMale,
                  onChange: (bool newValue) {
                    isMale = newValue;
                  },
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: specialist,
                  builder: (BuildContext context, value, Widget? child) {
                    return WVerificationTextFieldWithTitle(
                      title: 'Mutaxasisligi',
                      hintText: value != null ? value.value.toString() : "Tanlang",
                      isReadOnly: true,
                      rightIcon: const Icon(
                        CupertinoIcons.chevron_down,
                        color: gray,
                        size: 20,
                      ),
                      onTap: onPressedSelectSpecialist,
                    );
                  },
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: selectedAddress,
                  builder: (BuildContext context, value, Widget? child) {
                    return WVerificationTextFieldWithTitle(
                      title: 'Manzil',
                      hintText: value != null ? value.value.toString() : 'Tanalng',
                      isReadOnly: true,
                      rightIcon: const Icon(
                        CupertinoIcons.chevron_down,
                        color: gray,
                        size: 20,
                      ),
                      onTap: onPressedSelectAddress,
                    );
                  },
                ),
                const SizedBox(height: 32),
                ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (BuildContext context, value, Widget? child) {
                    return WButton(
                      onTap: onPressedContinue,
                      text: "Davom etish",
                      isLoading: value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

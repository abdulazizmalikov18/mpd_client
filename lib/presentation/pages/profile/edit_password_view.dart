import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/controller/registration_view_model.dart';
import 'package:dwed_client/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:dwed_client/features/common/loading/view_scope/loading_wrapper.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/common/widgets/w_main_app_bar.dart';
import 'package:dwed_client/features/common/widgets/w_textfield.dart';

class EditPasswordView extends StatefulWidget {
  const EditPasswordView({super.key});

  @override
  State<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<EditPasswordView> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newReTryPassword = TextEditingController();
  ValueNotifier<bool> isRight = ValueNotifier(false);
  ValueNotifier<String?> hasError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: Scaffold(
        appBar: const WAppBar(
          title: Text('Parolni o’zgartirish'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder(
            valueListenable: hasError,
            builder: (BuildContext context, value, Widget? child) {
              return Column(
                children: [
                  WTextField(
                    controller: currentPassword,
                    hasError: value != null,
                    onChanged: (e) {
                      checkText();
                    },
                    style: AppTheme.labelSmall.copyWith(
                      color: mainColor,
                    ),
                    hintStyle: AppTheme.labelSmall.copyWith(
                      color: gray,
                    ),
                    borderColor: grayLight,
                    hintText: 'Current Password',
                    prefixIcon: AppIcons.lock.svg(),
                  ),
                  const SizedBox(height: 32),
                  WTextField(
                    controller: newPassword,
                    hasError: value != null,
                    onChanged: (e) {
                      checkText();
                    },
                    style: AppTheme.labelSmall.copyWith(
                      color: mainColor,
                    ),
                    hintStyle: AppTheme.labelSmall.copyWith(
                      color: gray,
                    ),
                    borderColor: grayLight,
                    hintText: 'New Password',
                    prefixIcon: AppIcons.lock.svg(),
                  ),
                  const SizedBox(height: 16),
                  WTextField(
                    controller: newReTryPassword,
                    hasError: value != null,
                    onChanged: (e) {
                      checkText();
                    },
                    style: AppTheme.labelSmall.copyWith(
                      color: mainColor,
                    ),
                    hintStyle: AppTheme.labelSmall.copyWith(
                      color: gray,
                    ),
                    borderColor: grayLight,
                    hintText: 'Repeat Password',
                    prefixIcon: AppIcons.lock.svg(),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ValueListenableBuilder(
          valueListenable: isRight,
          builder: (BuildContext context, bool value, Widget? child) {
            return WButton(
              isDisabled: !value,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              onTap: onPressChangePassword,
              text: 'Davom etish',
            );
          },
        ),
      ),
    );
  }

  void checkText() {
    if (currentPassword.text.isEmpty && newPassword.text.isEmpty && newReTryPassword.text.isEmpty) {
      isRight.value = true;
    }
  }

  void onPressChangePassword() {
    $loading.on(context);
    $regVM().changePassword(
      currentPassword.text,
      newPassword.text,
      newReTryPassword.text,
      onSuccess: () {
        $loading.off(context);
        context.read<ShowPopUpBloc>().add(ShowPopUp(message: "Muvaffaqiyatli Almashtirildi !", status: PopStatus.success));
      },
      onError: (errorMessage) {
        context.read<ShowPopUpBloc>().add(ShowPopUp(message: errorMessage, status: PopStatus.error));
        hasError.value = errorMessage;
        $loading.off(context);
      },
    );
  }
}

import 'package:dwed_client/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:dwed_client/features/common/widgets/custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/controller/registration_view_model.dart';
import 'package:dwed_client/features/auth/presentation/widgets/w_error_text_for_text_field.dart';
import 'package:dwed_client/features/common/navigation/routs_contact.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/common/widgets/w_textfield.dart';

class CreatePasswordView extends StatefulWidget {
  final String phone;
  final String login;

  const CreatePasswordView({
    super.key,
    required this.phone,
    required this.login,
  });

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  late TextEditingController passwordController;

  late TextEditingController reTryPasswordController;

  late ValueNotifier<String?> hasError;

  late ValueNotifier<bool> isLoading;

  @override
  void initState() {
    passwordController = TextEditingController();
    reTryPasswordController = TextEditingController();
    hasError = ValueNotifier(null);
    isLoading = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    reTryPasswordController.dispose();
    hasError.dispose();
    isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Kirish',
                    style: context.textTheme.displaySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tizimga kiring va barcha xizmatlardan foydalaning',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                ValueListenableBuilder(
                  valueListenable: hasError,
                  builder: (context, value, _) {
                    return WTextField(
                      hasError: value != null,
                      controller: passwordController,
                      fillColor: white.withOpacity(0.2),

                      hintText: 'Parol',
                      style: context.textTheme.labelSmall.copyWith(
                        color: value != null ? red : white,
                      ),
                      hintStyle: context.textTheme.labelSmall.copyWith(
                        color: value != null ? red : greyText,
                      ),
                      borderColor: borderColor,
                      onChanged: (e) {
                        hasError.value = null;
                      },
                      prefixIcon: AppIcons.lock.svg(
                        color: value != null ? red : greyText,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: hasError,
                  builder: (context, value, _) {
                    return WTextField(
                      hasError: value != null,
                      controller: reTryPasswordController,
                      fillColor: white.withOpacity(0.2),
                      hintText: 'Parolni takrorlang',
                      style: context.textTheme.labelSmall.copyWith(
                        color: value != null ? red : white,
                      ),
                      hintStyle: context.textTheme.labelSmall.copyWith(
                        color: value != null ? red : greyText,
                      ),
                      borderColor: borderColor,
                      onChanged: (e) {
                        hasError.value = null;
                      },
                      prefixIcon: AppIcons.lock.svg(
                        color: value != null ? red : greyText,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (BuildContext context, value, Widget? child) {
            return WButton(
              isLoading: value,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                isLoading.value = true;
                 $regVM().checkPassword(
                  passwordController.text,
                  reTryPasswordController.text,
                  onSuccess: () {
                    isLoading.value = false;
                    hasError.value = null;
                    context.pushNamed(AppRouteNames.confirmAuthData, extra: {
                      "phone": widget.phone,
                      "login": widget.login,
                      "password": passwordController.text,
                    });
                  },
                  onError: (errorMessage) {
                    isLoading.value = false;
                    context.read<ShowPopUpBloc>().add(
                      ShowPopUp(
                        message: errorMessage,
                        status: PopStatus.error,
                      ),
                    );
                    hasError.value = errorMessage;
                  },
                );
              },
              textStyle: context.textTheme.bodyLarge.copyWith(
                color: white,
              ),
              text: 'Davom etish',
              // isLoading: value,
            );
          },
        ),
      ),
    );
  }
}

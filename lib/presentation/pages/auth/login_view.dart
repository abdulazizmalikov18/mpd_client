import 'package:dwed_client/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:dwed_client/features/common/widgets/custom_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dwed_client/features/common/navigation/routs_contact.dart';
import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/common/widgets/w_textfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<String?> hasError = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isEnable = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return WBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Kirish',
                  style: context.textTheme.displaySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Tizimga kiring va barcha xizmatlardan foydalaning',
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineSmall.copyWith(
                      fontWeight: FontWeight.w300,
                      color: white.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: hasError,
                  builder: (_, hasError, ___) {
                    return WTextField(
                      controller: loginController,
                      fillColor: hasError == null ? white.withOpacity(0.1) : red.withOpacity(0.2),
                      hintText: 'Login',
                      hasError: hasError != null,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '#####################',
                          filter: {"#": RegExp(r'[a-z]')},
                          type: MaskAutoCompletionType.lazy,
                        ),
                      ],
                      style: context.textTheme.labelSmall.copyWith(
                        color: white,
                      ),
                      hintStyle: context.textTheme.labelSmall.copyWith(
                        color: greyText,
                      ),
                      borderColor: borderColor,
                      onChanged: (e) {
                        onChangeText();
                      },
                      prefixIcon: AppIcons.profile.svg(
                        color: hasError != null ? white : greyText,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: hasError,
                  builder: (_, hasError, ___) {
                    return WTextField(
                      hasError: hasError != null,
                      controller: passwordController,
                      fillColor: hasError == null ? white.withOpacity(0.1) : red.withOpacity(0.2),
                      hintText: 'Parol',
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '#####################',
                          filter: {"#": RegExp(r'[A-Z a-z 0-9 !@#$%^&*]')},
                          type: MaskAutoCompletionType.lazy,
                        ),
                      ],
                      style: context.textTheme.labelSmall.copyWith(
                        color: white,
                      ),
                      hintStyle: context.textTheme.labelSmall.copyWith(
                        color: greyText,
                      ),
                      borderColor: borderColor,
                      onChanged: (e) {
                        onChangeText();
                      },
                      prefixIcon: AppIcons.lock.svg(
                        color: hasError != null ? white : greyText,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                if (!isKeyboardOpen)
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: primary,
                        ),
                      ),
                    ),
                    child: Text(
                      'Parolni unutdingizmi?',
                      style: context.textTheme.labelSmall.copyWith(
                        fontWeight: FontWeight.w300,
                        color: primary,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder(
                valueListenable: isEnable,
                builder: (BuildContext context, enable, Widget? child) {
                  return ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return WButton(
                        height: 56,
                        isDisabled: !enable,
                        onTap: onPressLogin,
                        textStyle: context.textTheme.bodyLarge.copyWith(
                          color: white,
                        ),
                        text: 'Tizimga kirish',
                        isLoading: value,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              WButton(
                height: 56,
                onTap: onPressSkip,
                text: 'Oʻtkazib yuborish',
                color: white.withOpacity(0.1),
                shadow: const [],
              ),
              const SizedBox(height: 24),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Akauntingiz yo’qmi?',
                        style: context.textTheme.labelSmall.copyWith(
                          color: white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: ' Ro’yhatdan o’tish',
                        style: context.textTheme.labelSmall.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.goNamed(AppRouteNames.registration);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChangeText() {
    if (loginController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
      isEnable.value = true;
    } else {
      isEnable.value = false;
    }
    hasError.value = null;
  }

  void onPressSkip() {
    context.goNamed(AppRouteNames.home);
  }

  void onPressLogin() {
    isLoading.value = true;
    context.read<AuthBloc>().add(LoginEvent(
          login: loginController.text.trim(),
          password: passwordController.text.trim(),
          onSuccess: () {
            isLoading.value = false;
            // hasError.value = "Error";

            debugPrint("Success");
          },
          onError: (e) {
            isLoading.value = false;
            context.read<ShowPopUpBloc>().add(
              ShowPopUp(
                message: "Noto’g’ri login yoki parol",
                status: PopStatus.error,
              ),
            );
            hasError.value = "Error";
          },
        ));
  }

  void onTapPravicyPolicy() {
    showBottomSheet(
      context: context,
      builder: (context) {
        return DecoratedBox(
          decoration: const BoxDecoration(color: white),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Ommaviy oferta shartlari',
                    style: context.textTheme.titleSmall.copyWith(
                      color: black,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

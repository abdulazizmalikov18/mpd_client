import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/show_pop_up/show_pop_up_bloc.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

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
  ValueNotifier<bool> isPhone = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                context.l10n.login_text,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder(
                valueListenable: hasError,
                builder: (_, hasError, ___) {
                  return ValueListenableBuilder(
                    valueListenable: isPhone,
                    builder: (_, phoneFormatter, ___) {
                      return WTextField(
                        controller: loginController,
                        // textCapitalization: TextCapitalization.sentences,
                        fillColor: hasError == null ? white.withOpacity(0.1) : red.withOpacity(0.2),
                        hintText: context.l10n.login_phone,
                        hasError: hasError != null,
                        inputFormatters: setFormat(loginController.text),
                        style: context.textTheme.labelSmall!.copyWith(
                          color: black,
                        ),
                        hintStyle: context.textTheme.labelSmall!.copyWith(
                          color: greyText,
                        ),
                        borderColor: border,
                        onChanged: (e) {
                          onChangeText();
                          if (e.length > 1) return;
                          isPhone.value = !phoneFormatter;
                        },
                      );
                    },
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
                    hintText: context.l10n.login_password,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '#####################',
                        filter: {"#": RegExp(r'[A-Z a-z 0-9 !@#$%^&*]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                    ],
                    style: context.textTheme.labelSmall!.copyWith(
                      color: black,
                    ),
                    hintStyle: context.textTheme.labelSmall!.copyWith(
                      color: greyText,
                    ),
                    borderColor: border,
                    onChanged: (e) {
                      onChangeText();
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              if (!isKeyboardOpen)
                DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: mainBlue,
                      ),
                    ),
                  ),
                  child: Text(
                    context.l10n.login_forgot,
                    style: context.textTheme.labelSmall!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: mainBlue,
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
                      textStyle: context.textTheme.bodyLarge!.copyWith(
                        color: white,
                      ),
                      text: context.l10n.login_enter,
                      isLoading: value,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: context.l10n.login_register_account,
                      style: context.textTheme.labelSmall!.copyWith(
                        color: black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: " ${context.l10n.login_register}",
                      style: context.textTheme.labelSmall!.copyWith(
                        color: mainBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
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
    );
  }

  List<TextInputFormatter>? setFormat(String text) {
    if (text.isEmpty) {
      return null;
    }
    print(text);
    if (int.tryParse(text) != null) {
      return [
        MaskTextInputFormatter(mask: '+998 ($text#) ###-##-##', filter: {"#": RegExp(r'[0-9]')})
      ];
    } else {
      return [
        MaskTextInputFormatter(
          mask: '${text.toLowerCase()}##################################',
          filter: {
            "#": RegExp(r'[a-z 0-9]'),
          },
          // type: MaskAutoCompletionType.lazy,
        ),
      ];
    }
  }

  void onChangeText() {
    if (loginController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
      isEnable.value = true;
    } else {
      isEnable.value = false;
    }
    hasError.value = null;
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
                    style: context.textTheme.titleSmall!.copyWith(
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/application/auth/controller/registration_view_model.dart';
import 'package:mpd_client/application/show_pop_up/show_pop_up_bloc.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/privacy_policy_dialog.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

part './mixin/registration_mixin.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> with RegistrationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  context.l10n.register_title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder(
                valueListenable: hasError,
                builder: (BuildContext context, String? value, Widget? child) {
                  return WTextField(
                    controller: phoneController,
                    fillColor: value == null ? white.withOpacity(0.2) : red.withOpacity(0.1),
                    hintText: '+998 (--) --- -- --',
                    hasError: value != null,
                    style: context.textTheme.labelSmall,
                    hintStyle: context.textTheme.labelSmall!.copyWith(
                      color: greyText,
                    ),
                    borderColor: border,
                    inputFormatters: [
                      maskForTextField,
                    ],
                    onChanged: (e) {
                      hasError.value = null;
                    },
                    // prefixIcon: AppImages.uzFlag.imgAsset(),
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: isSurePrivacyPolicy,
                    builder: (BuildContext context, isSure, _) {
                      return GestureDetector(
                        onTap: () {
                          isSurePrivacyPolicy.value = !isSure;
                        },
                        child: Checkbox(
                          side: const BorderSide(color: border),
                          value: isSure,
                          onChanged: (value) {
                            isSurePrivacyPolicy.value = value ?? false;
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      maxLines: 5,
                      text: TextSpan(
                        style: context.textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(text: context.l10n.register_terms_of_use),
                          TextSpan(
                            text: " ${context.l10n.register_agree_privacy_and_policy}",
                            style: context.textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.w300,
                              color: mainBlue,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = privacyPolicy,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
              valueListenable: isSurePrivacyPolicy,
              builder: (BuildContext context, isEnable, Widget? child) {
                return ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return WButton(
                      isDisabled: !isEnable,
                      onTap: onPressRegister,
                      textStyle: context.textTheme.bodyLarge!.copyWith(
                        color: white,
                      ),
                      text: context.l10n.register_register,
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
                      text: context.l10n.register_have_account,
                      style: context.textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: ' ${context.l10n.login_enter}',
                      style: context.textTheme.labelSmall!.copyWith(
                        color: mainBlue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed(AppRouteNames.login);
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
}

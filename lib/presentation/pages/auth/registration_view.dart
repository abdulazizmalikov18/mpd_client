import 'package:dwed_client/features/auth/presentation/widgets/sheets/privacy_policy_dialog.dart';
import 'package:dwed_client/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:dwed_client/features/common/widgets/custom_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/constants/images.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/controller/registration_view_model.dart';
import 'package:dwed_client/features/common/navigation/routs_contact.dart';
import 'package:dwed_client/features/common/widgets/log_service.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/common/widgets/w_textfield.dart';

import 'presentation/widgets/w_error_text_for_text_field.dart';

part 'presentation/mixin/registration_mixin.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> with RegistrationMixin {
  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Telefon raqamingizni kiriting',
                  style: context.textTheme.displaySmall.copyWith(
                    color: white,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Ro’yhatdan o’ting va barcha xizmatlardan foydalaning',
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineSmall.copyWith(
                    color: white.withOpacity(0.5)
                  ),
                ),
                const SizedBox(height: 32),
                ValueListenableBuilder(
                  valueListenable: hasError,
                  builder: (BuildContext context, String? value, Widget? child) {
                    return WTextField(
                      controller: phoneController,
                      fillColor: value== null ? white.withOpacity(0.2) : red.withOpacity(0.2),
                      hintText: '+998 (--) --- -- --',
                      hasError: value != null,
                      style: context.textTheme.labelSmall.copyWith(
                        color: white,
                      ),
                      hintStyle: context.textTheme.labelSmall.copyWith(
                        color: greyText,
                      ),
                      borderColor: borderColor,
                      inputFormatters: [
                        maskForTextField,
                      ],
                      onChanged: (e) {
                        hasError.value = null;
                      },
                      prefixIcon: AppImages.uzFlag.imgAsset(),
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
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: (isSure ? AppIcons.checkbox : AppIcons.unCheckbox).svg(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        maxLines: 5,
                        text: TextSpan(
                          style: context.textTheme.labelSmall.copyWith(
                            fontWeight: FontWeight.w300,
                            color: white,
                          ),
                          children: [
                            const TextSpan(text: 'Men '),
                            TextSpan(
                              text: 'Ommaviy oferta shartlari ',
                              style: context.textTheme.labelSmall.copyWith(
                                fontWeight: FontWeight.w300,
                                color: primary,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = privacyPolicy,
                            ),
                            const TextSpan(
                              text: 'bilan tanishganimni va roziligimni tasdiqlayman',
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
                        textStyle: context.textTheme.bodyLarge.copyWith(
                          color: white,
                        ),
                        text: 'Ro’yhatdan o’tish',
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
                        text: 'Akauntingiz bormi?',
                        style: context.textTheme.labelSmall.copyWith(
                          color: white,
                        ),
                      ),
                      TextSpan(
                        text: ' Kirish',
                        style: context.textTheme.labelSmall.copyWith(
                          color: primary,
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
      ),
    );
  }
}

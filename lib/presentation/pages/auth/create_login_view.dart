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

class CreateLoginView extends StatefulWidget {
  final String phone;

  const CreateLoginView({super.key, required this.phone});

  @override
  State<CreateLoginView> createState() => _CreateLoginViewState();
}

class _CreateLoginViewState extends State<CreateLoginView> {
  late TextEditingController loginController;

  late ValueNotifier<String?> hasError;

  late ValueNotifier<bool> isLoading;

  @override
  void initState() {
    loginController = TextEditingController(text: "u${widget.phone}");
    isLoading = ValueNotifier(false);
    hasError = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    isLoading.dispose();
    hasError.dispose();
    super.dispose();
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
                  builder: (context, value, ___) {
                    return WTextField(
                      hasError: value != null,
                      controller: loginController,
                      fillColor: value == null ? white.withOpacity(0.2) : error.withOpacity(0.2),
                      hintText: 'Login',
                      style: context.textTheme.labelSmall.copyWith(
                        color: white,
                      ),
                      hintStyle: context.textTheme.labelSmall.copyWith(
                        color: greyText,
                      ),
                      borderColor: borderColor,
                      onChanged: (e) {
                        hasError.value = null;
                      },
                      prefixIcon: AppIcons.profile.svg(
                        color: value != null ? white : greyText,
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
              margin: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                isLoading.value = true;
                $regVM().checkLogin(
                  loginController.text.trim(),
                  onSuccess: () {
                    isLoading.value = false;
                    context.pushNamed(AppRouteNames.createPassword, extra: {
                      "phone": widget.phone,
                      "login": loginController.text.trim(),
                    });
                  },
                  onError: (errorMessage) {
                    isLoading.value = false;
                    context.read<ShowPopUpBloc>().add(
                          ShowPopUp(
                            message: "Bunday login mavjud yoki xato login kiritdingiz",
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
              isLoading: value,
            );
          },
        ),
      ),
    );
  }
}

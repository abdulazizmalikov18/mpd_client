import 'package:dwed_client/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:dwed_client/features/common/widgets/custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/controller/registration_view_model.dart';
import 'package:dwed_client/features/auth/presentation/widgets/w_error_text_for_text_field.dart';
import 'package:dwed_client/features/common/navigation/routs_contact.dart';
import 'package:dwed_client/features/common/widgets/log_service.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/edit_number/presentation/widgets/w_resend_text.dart';

class ConfirmOtpView extends StatefulWidget {
  final String phone;

  const ConfirmOtpView({super.key, required this.phone});

  @override
  State<ConfirmOtpView> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends State<ConfirmOtpView> {
  late ValueNotifier<bool> isLoading;
  late ValueNotifier<String?> hasError;

  late TextEditingController controller;

  void resendOtp() {}

  void onTapConfirm() {
    isLoading.value = true;
    final pvc = controller.text.trim();
    Log.i("pvc : $pvc");
    $regVM().confirmPvc(
      widget.phone,
      pvc,
      onSuccess: () {
        isLoading.value = false;
        context.pushNamed(
          AppRouteNames.createLogin,
          extra: {"phone": widget.phone},
        );
      },
      onError: (errorMessage) {
        context.read<ShowPopUpBloc>().add(
          ShowPopUp(
            message: "Kot xato kiritildi",
            status: PopStatus.error,
          ),
        );
        hasError.value = '';
        isLoading.value = false;
      },
    );
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
                    'Tasdiq kodi',
                    textAlign: TextAlign.center,
                    style: context.textTheme.displaySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: context.textTheme.headlineSmall.copyWith(
                      color: white.withOpacity(0.5),
                    ),
                    children: [
                      const TextSpan(text: 'Iltimos, biz '),
                      TextSpan(
                        text: '(+998) ${widget.phone.substring(3, 5)} ${widget.phone.substring(5, 8)} XX XX ',
                        style: context.textTheme.headlineSmall.copyWith(
                          color: primary,
                        ),
                      ),
                      const TextSpan(text: 'telefon raqamiga yuborgan kodni kiriting.'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ValueListenableBuilder(
                    valueListenable: hasError,
                    builder: (BuildContext context, value, Widget? child) {
                      return Pinput(
                        controller: controller,
                        length: 6,
                        errorText: value,
                        autofocus: true,
                        defaultPinTheme: PinTheme(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: value == null ? white.withOpacity(0.1) : red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: value == null ? white.withOpacity(0.2) : red,
                            )
                          )
                        ),
                        onCompleted: (_) {
                          onTapConfirm();
                        },
                        onChanged: (_) {
                          hasError.value = null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                WResendButton(
                  resentSMSSecond: 60,
                  resentOtp: resendOtp,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ValueListenableBuilder(
          valueListenable: hasError,
          builder: (BuildContext context, String? error, Widget? child) {
            return ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (BuildContext context, bool value, Widget? child) {
                return WButton(
                  isDisabled: error != null || controller.text.length <= 5,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: onTapConfirm,
                  textStyle: context.textTheme.bodyLarge.copyWith(
                    color: white,
                  ),
                  text: 'Tasdiqlash',
                  isLoading: value,
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    controller = TextEditingController();
    isLoading = ValueNotifier(false);
    hasError = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    isLoading.dispose();
    hasError.dispose();
    super.dispose();
  }
}

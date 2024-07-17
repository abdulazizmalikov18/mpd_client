import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/controller/pin_view_model.dart';
import 'package:dwed_client/features/auth/presentation/widgets/w_custom_pin_put.dart';
import 'package:dwed_client/features/auth/presentation/widgets/w_keyboard_number.dart';
import 'package:dwed_client/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:dwed_client/features/common/widgets/custom_screen.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/common/widgets/w_button_border_gradient.dart';
import 'package:dwed_client/features/common/widgets/w_main_app_bar.dart';

class EditPinCodeView extends StatefulWidget {
  const EditPinCodeView({super.key});

  @override
  State<EditPinCodeView> createState() => _EditPinCodeViewState();
}

class _EditPinCodeViewState extends State<EditPinCodeView> {
  bool isDisable = false;
  bool isVerified = false;
  TextEditingController pinController = TextEditingController();
  ValueNotifier<String?> hasError = ValueNotifier(null);

  void onPressSave() {
    if(isDisable) return;
    $pinVM().updatePin(
      pinController.text.trim(),
      isVerified,
      onSuccess: () {
        context.read<ShowPopUpBloc>().add(ShowPopUp(message: "Muvaffaqiyatli Code Almashtirildi !", status: PopStatus.success));
        isDisable = true;
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          context.pop();
        });
      },
      onError: (errorMessage) {
        hasError.value = errorMessage;
        context.read<ShowPopUpBloc>().add(ShowPopUp(message: errorMessage, status: PopStatus.error));
      },
      onVerified: () {
        context.read<ShowPopUpBloc>().add(ShowPopUp(message: "Muvaffaqiyatli Code Tasdiqlandi !", status: PopStatus.success));
        pinController.clear();
        isVerified = true;
        setState(() {});
      },
    );
  }

  void onPressCancel() {
    if(isDisable) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(title: Text("Parolni o'zgartirinsh")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 56),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "PIN Kod",
                  style: AppTheme.displaySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isVerified ? "Mobil ilova uchun PIN kod yarating" : "Mobil ilova uchun PIN kod tasfiqlang",
                  style: AppTheme.headlineSmall.copyWith(
                    color: greyText,
                  ),
                ),
                const SizedBox(height: 32),
                WCustomPinPut(
                  pinController: pinController,
                  hasError: hasError,
                  onComplete: (String pin) {},
                ),
                WCustomKeyboardNumber(
                  enteredNumber: enteredNumber,
                  pinController: pinController,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                WButton(
                  onTap: onPressSave,
                  text: isVerified ? "Tasdiqlash" : "Kiritish",
                ),
                const SizedBox(height: 12),
                WButtonGradient(
                  onTap: onPressCancel,
                  text: "Bekor qilish",
                  textColor: black,
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ],
      ),
    );
  }

  void enteredNumber(int index) {
    if (index == 11) {
      if (pinController.text.isNotEmpty) {
        pinController.text = pinController.text.substring(0, pinController.text.length - 1);
      }
      return;
    }
    if (pinController.text.length == 4) return;
    if (index == 10) {
      pinController.text += "0";
    } else {
      pinController.text += (index + 1).toString();
    }
  }
}

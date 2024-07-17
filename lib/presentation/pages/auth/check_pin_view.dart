import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/auth/controller/pin_view_model.dart';
import 'package:mpd_client/application/show_pop_up/show_pop_up_bloc.dart';
import 'package:mpd_client/presentation/pages/auth/mixin/biometric_auth_mixin.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/w_custom_pin_put.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/w_keyboard_number.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class CheckPinView extends StatefulWidget {
  static bool isLogged = false;

  const CheckPinView({super.key});

  @override
  State<CheckPinView> createState() => _CheckPinViewState();
}

class _CheckPinViewState extends State<CheckPinView> with BiometricAuth {
  TextEditingController pinController = TextEditingController();

  ValueNotifier<String?> hasError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 84),
          const Spacer(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pin Kiriting",
                  style: context.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  $pinVM().hasPin ? "Mobile Ilova uchun Pin Kiriting" : "Mobil ilova uchun PIN kod yarating",
                  style: context.textTheme.headlineSmall!.copyWith(
                    color: greyText,
                  ),
                ),
                const SizedBox(height: 32),
                WCustomPinPut(
                  pinController: pinController,
                  onComplete: (String pin) {
                    success();
                  },
                  hasError: hasError,
                ),
                WCustomKeyboardNumber(
                  enteredNumber: enteredNumber,
                  pinController: pinController,
                ),
              ],
            ),
          ),
          const Spacer(),
          if ($pinVM().hasPin)
            Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await authenticate().then((authState) {
                        if (authState) {
                          context.goNamed(AppRouteNames.home);
                        }
                      });
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: white.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: white.withOpacity(0.2),
                          )),
                      child: AppImages.faceId.imgAsset(),
                    ),
                  ),
                  WButton(
                    width: 250,
                    height: 20,
                    borderRadius: 8,
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                    onTap: () {
                      context.read<AuthBloc>().add(const Logout());
                      context.goNamed(AppRouteNames.login);
                    },
                    child: Text(
                      'Войти по логину и паролю',
                      style: context.textTheme.headlineSmall!.copyWith(
                        color: white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 50),
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

  void completed() {}

  void success() {
    $pinVM().mainPinChecker(
      pinController.text.trim(),
      onSuccess: () {
        hasError.value = 'success';

        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          context.goNamed(AppRouteNames.home);
        });
      },
      onError: (errorMessage) {
        pinController.clear();

        context.read<ShowPopUpBloc>().add(
              ShowPopUp(
                message: "Pin kod Noto’g’ri iltimos qayta urinib ko'ring",
                status: PopStatus.error,
              ),
            );
        hasError.value = errorMessage;
      },
      onSave: () {
        hasError.value = 'success';
        pinController.clear();
        setState(() {});
      },
    );
  }
}

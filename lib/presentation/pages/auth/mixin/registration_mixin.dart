part of '../registration_view.dart';
mixin RegistrationMixin on State<RegistrationView> {
  late ValueNotifier<bool> isLoading;

  late TextEditingController phoneController;
  late ValueNotifier<String?> hasError;

  final maskForTextField = MaskTextInputFormatter(
    mask: '+998 (##) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  ValueNotifier<bool> isSurePrivacyPolicy = ValueNotifier(false);


  void onPressRegister() {
    if (!isSurePrivacyPolicy.value) {
      hasError.value = "Shartlarga rozilik bildiring";
      return;
    }
    isLoading.value = true;
    final phoneNumber = "998${maskForTextField.unmaskText(phoneController.text)}";
    Log.i("phone : $phoneNumber");
    $regVM().registerPhone(
      phoneNumber,
      onSuccess: () {
        context.pushNamed(AppRouteNames.authConfirmOtp, extra: {"phone": phoneNumber});
        isLoading.value = false;
      },
      onError: (String errorMessage) {
        context.read<ShowPopUpBloc>().add(
          ShowPopUp(
            message: "Bu telefon raqam orqali oldin ro'yhatdan o'tilgan",
            status: PopStatus.error,
          ),
        );
        hasError.value = "";
        isLoading.value = false;
      },
    );
  }

  void privacyPolicy() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
      isScrollControlled: true,
      builder: (context) {
        return const WPrivacyPolicyBottomSheet();
      },
    ).then((value) {
      if (value != null) {
        isSurePrivacyPolicy.value = true;
      }
    });
  }

  @override
  void initState() {
    isLoading = ValueNotifier(false);
    hasError = ValueNotifier(null);
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
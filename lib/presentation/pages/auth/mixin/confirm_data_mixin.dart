part of '../confirm_auth_data.dart';

mixin ConfirmDataMixin on State<ConfirmAuthDataView> {
  late TextEditingController nameController;
  late TextEditingController lastnameController;
  late TextEditingController surnameController;
  late ValueNotifier<DateTime?> birthdate;
  bool isMale = false;
  late ValueNotifier<MapEntry<int?, String>?> specialist;
  late ValueNotifier<MapEntry<int?, String>?> selectedAddress;
  late ValueNotifier<String?> avatar;
  late ValueNotifier<bool> isLoading;
  late ValueNotifier<String> hasError;

  @override
  void initState() {
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    surnameController = TextEditingController();
    birthdate = ValueNotifier(null);
    specialist = ValueNotifier(null);
    selectedAddress = ValueNotifier(null);
    avatar = ValueNotifier(null);
    isLoading = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    surnameController.dispose();
    birthdate.dispose();
    specialist.dispose();
    selectedAddress.dispose();
    avatar.dispose();
    isLoading.dispose();
    super.dispose();
  }

  void onPressedContinue() {
    isLoading.value = true;
    $regVM().setUserData(
      CreateUser(
        phone: widget.phone,
        login: widget.login,
        password: widget.password,
        name: nameController.text,
        lastname: lastnameController.text,
        surname: surnameController.text,
        birthday: birthdate.value != null ? "${birthdate.value!.year}-${birthdate.value!.month.toString().padLeft(2, "0")}-${birthdate.value!.day.toString().padLeft(2, "0")}" : null,
        gender: isMale ? "m" : "f",
        region: selectedAddress.value?.key,
        specialist: specialist.value?.key,
      ),
      avatar.value,
      onSuccess: () {
        context.read<ShowPopUpBloc>().add(
              ShowPopUp(
                message: 'Account yaratildi !',
                status: PopStatus.success,
              ),
            );
        context.read<AuthBloc>().add(const AuthStatusChanged(AuthStatus.authenticated));
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          isLoading.value = false;
          // context.goNamed(AppRouteNames.login);
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
      },
    );
  }

  void onPressedDateTime() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400, minHeight: 0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: white,
                    onPrimary: white,
                    onSurface: white,
                    secondary: red,
                    surface: red,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
                child: DatePicker(
                  padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                  selectedDate: birthdate.value ?? DateTime(2000, 1, 1),
                  maxDate: DateTime.now(),
                  minDate: DateTime(1920, 1, 1),
                  splashColor: Colors.transparent,
                  daysOfTheWeekTextStyle: context.textTheme.labelSmall!.copyWith(
                    color: gray,
                    overflow: TextOverflow.ellipsis,
                  ),
                  selectedCellDecoration: BoxDecoration(
                    gradient: wgradient,
                    shape: BoxShape.circle,
                  ),
                  selectedCellTextStyle: const TextStyle(
                    color: white,
                  ),
                  currentDateDecoration: BoxDecoration(
                    gradient: wgradient,
                    shape: BoxShape.circle,
                  ),
                  onDateSelected: (newValue) {
                    birthdate.value = newValue;
                    context.pop();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onPressedSelectSpecialist() {
    context.read<AccountsBloc>().add(const GetProfession());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const WSelectProfessionSheet();
      },
    ).then((value) {
      if (value is MapEntry<int, String>) {
        specialist.value = value;
      }
    });
  }

  void onPressedSelectAddress() {
    context.read<AccountsBloc>().add(const GetRegion());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const WSelectRegionBottomSheet();
      },
    ).then((value) {
      if (value is MapEntry<int, String>) {
        selectedAddress.value = value;
      }
    });
  }

  void pickImageBottomSheet() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      avatar.value = result.path;
      if (context.mounted) {
        context.pop();
      }
    }
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    //   context: context,
    //   builder: (context) {
    //     return ClipRRect(
    //       borderRadius: const BorderRadius.only(
    //         topRight: Radius.circular(16),
    //         topLeft: Radius.circular(16),
    //       ),
    //       child: SizedBox(
    //         child: WBottomSheet(
    //           title: 'Upload a picture',
    //           child: Column(
    //             children: [
    //               const SizedBox(height: 24),
    //               WShadowedItemContainer(
    //                 title: 'Сфотографировать',
    //                 icon: '', //AppIcons.camera,
    //                 onTap: () async {
    //                   final result = await ImagePicker().pickImage(source: ImageSource.camera);
    //                   if (result != null) {
    //                     avatar.value = result.path;
    //                     if (context.mounted) {
    //                       context.pop();
    //                     }
    //                   }
    //                 },
    //               ),
    //               const SizedBox(height: 16),
    //               WShadowedItemContainer(
    //                 title: 'Из галареии',
    //                 icon: '', //AppIcons.folderAdd,
    //                 onTap: () async {
    //                   final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    //                   if (result != null) {
    //                     avatar.value = result.path;
    //                     if (context.mounted) {
    //                       context.pop();
    //                     }
    //                   }
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

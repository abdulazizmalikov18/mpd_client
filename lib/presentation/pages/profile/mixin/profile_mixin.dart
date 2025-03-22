part of '../profile_view.dart';

mixin ProfileMixin on State<ProfileView> {
  void verificationProfile() {
    // $loading.on(context);
    context.read<AccountsBloc>().add(GetAccountUserEvent(onSuccess: () {
      // $loading.off(context);
      context.pushNamed(AppRouteNames.verificationProfile);
    }));
  }

  void onPressEditProfile() {
    // $loading.on(context);
    context.read<AccountsBloc>().add(GetAccountUserEvent(onSuccess: () {
      // $loading.off(context);
      context.pushNamed(AppRouteNames.editProfile);
    }));
  }

  void onPressSecurity() {
    context.pushNamed(AppRouteNames.editPinCode);
  }

  void onPressNotificationSettings() {
    context.pushNamed(AppRouteNames.settings);
  }

  void onPressLogOut() {
    $pinVM().clearPin();
    context.read<AuthBloc>().add(const Logout());
    context.pushNamed(AppRouteNames.login);
  }

  void onPressMyPosts() {
    context.read<PostBloc>().add(GetMyPostEvent());
    context.pushNamed(AppRouteNames.myPost);
  }

  void onPressPayment() {
    context.pushNamed(AppRouteNames.payment);
  }

  void showQrCode() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 12),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF174B93),
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const SizedBox(), // AppIcons.close.svg(),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'My QR code',
                        style: AppTheme.displaySmall.copyWith(),
                      ),
                      Text(
                        'Scan code of winner',
                        style: AppTheme.labelSmall.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).width * 0.7,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CreateQRCode(
                                  text: context
                                      .read<AccountsBloc>()
                                      .state
                                      .userContainer
                                      .user
                                      .qrcode,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onPressGoToDoctorProfile() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      builder: (context) => BottomSheetWidget(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        children: [
          const SizedBox(height: 12),
          const Text(
            "Ma’lumotlaringiz saqlanishiga rozimisiz?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            "Agar rozi bo’lsangiz bla bla bla, agar rozi bo’lmasangiz bla bla bla.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          LongButton(
            height: 52,
            buttonName: "Xa, roziman",
            onPress: () {
              Navigator.of(context)
                ..pop()
                ..push(MaterialPageRoute(
                  builder: (context) => const SpecialistRegisterPage(),
                ));
            },
          ),
          const SizedBox(height: 12),
          LongButton(
            height: 52,
            buttonName: "Yo’q, rozi emasman",
            color: red,
            onPress: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void onPressLanguage() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      builder: (_) => const LanguageSheet(),
    );
  }

  @override
  void initState() {
    context.read<AccountsBloc>().add(const GetAccountUserEvent());
    super.initState();
  }

  void onPressSOS() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context) => BottomSheetWidget(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        children: [
          const SizedBox(height: 12),
          Text(
            context.l10n.ambulance_services,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            context.l10n.ambulance_services_condition,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: cardShadow,
                  blurRadius: 8,
                )
              ],
            ),
            child: ListTile(
              title: Text(
                context.l10n.ambulance_accident,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: mainBlue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: cardShadow,
                  blurRadius: 8,
                )
              ],
            ),
            child: const ListTile(
              title: Text(
                "DTP",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: cardShadow,
                  blurRadius: 8,
                )
              ],
            ),
            child: ListTile(
              title: Text(
                context.l10n.ambulance_first_aid,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: cardShadow,
                  blurRadius: 8,
                )
              ],
            ),
            child: ListTile(
              title: Text(
                context.l10n.ambulance_fainting,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20),
          // LongButton(
          //   height: 52,
          //   buttonName: "SOS",
          //   color: red,
          //   onPress: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          // const SizedBox(height: 16),
        ],
      ),
    );
  }
}

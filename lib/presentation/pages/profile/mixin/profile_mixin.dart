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

  void onPressMyOrders() {
    context.pushNamed(AppRouteNames.myOrders);
  }

  void onPressPayment() {
    context.pushNamed(AppRouteNames.payment);
  }

  void showQrCode() {
    showModalBottomSheet(
      context: context, //MainView.of(context).context,
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
                                  text: context.read<AccountsBloc>().state.userContainer.user.qrcode,
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

  void onPressLanguage() {
    
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: MainView.of(context).context,
      builder: (_) => const LanguageSheet(),
    );
  }

  @override
  void initState() {
    context.read<AccountsBloc>().add(const GetAccountUserEvent());
    super.initState();
  }
}

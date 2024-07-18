import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/auth/controller/pin_view_model.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_not_login_profile.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_profile_header.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_profile_item.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_qr_code.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';

part 'mixin/profile_mixin.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        title: const Text("Profile"),
        action: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: showQrCode,
            icon: SizedBox(), //AppIcons.barcode.svg(),
          ),
        ),
      ),
      body: StorageRepository.getBool(StorageKeys.ISLOGGED)
          ? SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  WProfileHeader(
                    onPressEditProfile: onPressEditProfile,
                    verificationProfile: verificationProfile,
                  ),
                  const SizedBox(height: 24),
                  WProfileItem(
                    icon: '',//AppIcons.lock2,
                    title: 'Xavfsizlik',
                    onPressed: onPressSecurity,
                    subTitle: '',
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: '',//AppIcons.icHome,
                    title: 'Mening buyurtmalarim',
                    subTitle: '',
                    onPressed: onPressMyOrders,
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: '',//AppIcons.square,
                    title: 'Payment',
                    subTitle: 'Select a payment method',
                    onPressed: onPressPayment,
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: '',//AppIcons.icHome,
                    title: 'Mening kuponlarim',
                    subTitle: '',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: '',//AppIcons.setting,
                    title: 'Bildirishnomalarni sozlash',
                    subTitle: '',
                    onPressed: onPressNotificationSettings,
                  ),

                  // WProfileItem(
                  //   icon: AppIcons.icHome,
                  //   title: 'Ilova tili',
                  //   subTitle: '',
                  //   onPressed: MainView.of(context).showLanguageBottomSheet,
                  // ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: '',//AppIcons.question,
                    title: 'My Quiz',
                    subTitle: 'Create question, or dictonary with you student, make a prize',
                    onPressed: () {
                      context.push(AppRoutePath.quizCreate);
                    },
                  ),
                  const SizedBox(height: 8),
                  WButton(
                    onTap: onPressLogOut,
                    height: 56,
                    color: const Color(0xFFFA193E).withOpacity(.2),
                    shadow: wboxShadowRed,
                    border: Border.all(color: const Color(0xFFFA193E)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // AppIcons.logout.svg(),
                        const SizedBox(width: 8),
                        Text(
                          'Chiqish',
                          style: AppTheme.headlineSmall.copyWith(color: white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            )
          : const WNotLoginProfile(),
    );
  }
}

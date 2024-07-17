import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/constants/storage_keys.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dwed_client/features/auth/presentation/controller/pin_view_model.dart';
import 'package:dwed_client/features/common/loading/view_scope/loading_wrapper.dart';
import 'package:dwed_client/features/common/navigation/routs_contact.dart';
import 'package:dwed_client/features/common/repo/storage_repository.dart';
import 'package:dwed_client/features/common/widgets/w_main_app_bar.dart';
import 'package:dwed_client/features/main/presentation/view/main_view.dart';
import 'package:dwed_client/features/profile/presentation/controller/accounts/accounts_bloc.dart';
import 'package:dwed_client/features/profile/presentation/widgets/w_not_login_profile.dart';
import 'package:dwed_client/features/profile/presentation/widgets/w_profile_header.dart';
import 'package:dwed_client/features/profile/presentation/widgets/w_profile_item.dart';
import 'presentation/widgets/w_qr_code.dart';

part 'presentation/mixin/profile_mixin.dart';

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
            icon: AppIcons.barcode.svg(),
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
                    icon: AppIcons.lock2,
                    title: 'Xavfsizlik',
                    onPressed: onPressSecurity,
                    subTitle: '',
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.icHome,
                    title: 'Mening buyurtmalarim',
                    subTitle: '',
                    onPressed: onPressMyOrders,
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.square,
                    title: 'Payment',
                    subTitle: 'Select a payment method',
                    onPressed: onPressPayment,
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.icHome,
                    title: 'Mening kuponlarim',
                    subTitle: '',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.setting,
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
                    icon: AppIcons.question,
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
                        AppIcons.logout.svg(),
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

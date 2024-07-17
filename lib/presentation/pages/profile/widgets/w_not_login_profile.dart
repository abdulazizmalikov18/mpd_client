import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/constants/images.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/common/navigation/routs_contact.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/profile/presentation/widgets/w_profile_item.dart';

class WNotLoginProfile extends StatelessWidget {
  const WNotLoginProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                AppImages.appLogoBlue.imgAsset(height: 80),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Center(
                    child: Text(
                      'Chat va savat xizmatidan foydalanish uchun tizimga kiring',
                      style: AppTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // WProfileItem(
                //   icon: AppIcons.icHome,
                //   title: 'Ilova tili',
                //   onPressed: () {
                //   },
                //   subTitle: '',
                // ),
                const SizedBox(height: 8),
                WProfileItem(
                  icon: AppIcons.icHome,
                  title: 'Bildirishnomalarni sozlash',
                  subTitle: '',
                  onPressed: () {
                    context.pushNamed(AppRouteNames.notificationSettings);
                  },
                ),
              ],
            ),
          ),
          WButton(
            onTap: () {
              context.goNamed(AppRouteNames.login);
            },
            margin: const EdgeInsets.all(16),
            text: "Kirish",
          ),
        ],
      ),
    );
  }
}

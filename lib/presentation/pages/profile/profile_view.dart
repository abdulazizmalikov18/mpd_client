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
import 'package:mpd_client/utils/extensions/context_extension.dart';

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
      body: StorageRepository.getBool(StorageKeys.ISLOGGED)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const WProfileHeader(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        WProfileItem(
                          icon: AppIcons.user,
                          title: context.l10n.profile_personal_info,
                          onPressed: onPressEditProfile,
                        ),
                        const SizedBox(height: 8),
                        WProfileItem(
                          icon: AppIcons.userAdd,
                          subTitle: '5 ${context.l10n.profile_following_doctors_doctor.toLowerCase()}',
                          title: context.l10n.profile_following_doctors,
                          onPressed: onPressMyOrders,
                        ),
                        const SizedBox(height: 8),
                        WProfileItem(
                          icon: AppIcons.languageCircle,
                          title: context.l10n.profile_language,
                          onPressed: onPressPayment,
                        ),
                        const SizedBox(height: 8),
                        WProfileItem(
                          icon: AppIcons.receipt,
                          title: context.l10n.records_title,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 8),
                        WProfileItem(
                          icon: AppIcons.logOut,
                          isRed: true,
                          title: context.l10n.profile_logout,
                          onPressed: onPressLogOut,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const WNotLoginProfile(),
    );
  }
}

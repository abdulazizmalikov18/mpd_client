import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/auth/controller/pin_view_model.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/application/profile/user_records/records_bloc.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_language_sheet.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_profile_header.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_profile_item.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_qr_code.dart';
import 'package:mpd_client/presentation/pages/specialist_reg/specialist_registration_view.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

part 'mixin/profile_mixin.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileMixin {
  Map<String, dynamic> languages = {
    'uz': 'Uzbek',
    'ru': 'Russian',
    'en': 'English',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WProfileHeader(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  WProfileItem(
                    icon: AppIcons.user,
                    title: context.l10n.profile_personal_info,
                    onPressed: onPressEditProfile,
                  ),
                  WProfileItem(
                    icon: AppIcons.likeDislike,
                    title: "Shaxsiy postlar",
                    onPressed: onPressMyPosts,
                  ),
                  WProfileItem(
                    icon: AppIcons.userAdd,
                    subTitle: '5 ${context.l10n.profile_following_doctors_doctor.toLowerCase()}',
                    title: context.l10n.profile_following_doctors,
                    onPressed: () {
                      context.pushNamed(AppRouteNames.userFollowing);
                    },
                  ),
                  WProfileItem(
                    icon: AppIcons.languageCircle,
                    title: context.l10n.profile_language,
                    subTitle: languages[context.l10n.localeName],
                    onPressed: onPressLanguage,
                  ),
                  WProfileItem(
                    icon: AppIcons.receipt,
                    title: context.l10n.records_title,
                    onPressed: () {
                      context.read<RecordsBloc>().add(const GetRecordsEvent());
                      context.pushNamed(AppRouteNames.record);
                    },
                  ),
                  WProfileItem(
                    icon: AppIcons.briefcaseLite,
                    title: "Shifokor profiliga kirish",
                    onPressed: onPressGoToDoctorProfile,
                  ),
                  WProfileItem(
                    icon: AppIcons.warning,
                    isRed: true,
                    title: "SOS",
                    onPressed: onPressSOS,
                  ),
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
      ),
    );
  }
}

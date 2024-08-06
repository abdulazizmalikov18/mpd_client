import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/auth/controller/pin_view_model.dart';
import 'package:mpd_client/application/profile/user_records/records_bloc.dart';
import 'package:mpd_client/presentation/pages/main/main_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    title: "Shaxsiy postlar",
                    onPressed: onPressMyOrders,
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
                    onPressed: onPressLanguage,
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.receipt,
                    title: context.l10n.records_title,
                    onPressed: () {
                      context.read<RecordsBloc>().add(const GetRecordsEvent());
                      context.pushNamed(AppRouteNames.record);
                    },
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.receipt,
                    title: "Shifokor profiliga kirish",
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
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
                    },
                  ),
                  const SizedBox(height: 8),
                  WProfileItem(
                    icon: AppIcons.warning,
                    isRed: true,
                    title: "SOS",
                    onPressed: onPressLogOut,
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
      ),
    );
  }
}

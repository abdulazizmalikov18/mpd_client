import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WProfileHeader extends StatelessWidget {
  final void Function() onPressEditProfile;
  final void Function() verificationProfile;

  const WProfileHeader({
    super.key,
    required this.onPressEditProfile,
    required this.verificationProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: onPressEditProfile,
                  child: BlocBuilder<AccountsBloc, AccountsState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WNetworkImage(
                              image: state.userContainer.user.avatar,
                              height: 60,
                              width: 60,
                              borderRadius: 100,
                              defaultWidget: Container(
                                color: black,
                              ) /*AppImages.profileImg.imgAsset(
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),*/
                              ),
                          const SizedBox(width: 8),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: state.userContainer.status.isInProgress
                                  ? [
                                      const WShimmer(
                                        height: 20,
                                        width: 200,
                                      ),
                                      const SizedBox(height: 10),
                                      const WShimmer(
                                        height: 20,
                                        width: 150,
                                      ),
                                    ]
                                  : [
                                      Text(
                                        '${state.userContainer.user.name} ${state.userContainer.user.lastname}',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.displayLarge.copyWith(
                                          color: white,
                                        ),
                                      ),
                                      Text(
                                        state.userContainer.user.mainCat.name,
                                        textAlign: TextAlign.center,
                                        style: AppTheme.labelSmall.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: WProfileHeaderItem(
                        icon: '',// AppIcons.briefcaseLeft,
                        label: 'Tajriba',
                        title: '8 level',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: WProfileHeaderItem(
                        icon: '',// AppIcons.briefcaseCenter,
                        label: 'Bilim',
                        title: '6 level',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: WProfileHeaderItem(
                        icon: '',// AppIcons.briefcaseRight,
                        label: 'Muomala',
                        title: '24 level',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                WButton(
                  onTap: verificationProfile,
                  height: 56,
                  textStyle: AppTheme.bodyLarge.copyWith(color: white),
                  text: 'Profilni tasdiqlash',
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Row(
                children: [
                  Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      children: [
                        // AppIcons.like.svg(),
                        const SizedBox(width: 2),
                        Text(
                          '563',
                          style: AppTheme.labelSmall.copyWith(
                            fontSize: 9,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      children: [
                        // AppIcons.unLike.svg(),
                        const SizedBox(width: 2),
                        Text(
                          '563',
                          style: AppTheme.labelSmall.copyWith(
                            fontSize: 9,
                            color: white,
                          ),
                        ),
                      ],
                    ),
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

class WProfileHeaderItem extends StatelessWidget {
  final String icon;
  final String label;
  final String title;

  const WProfileHeaderItem({
    super.key,
    required this.icon,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Transform.scale(
              scale: 1.2,
              child: icon.svg(
                width: double.infinity,
                height: 52,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTheme.displayLarge.copyWith(
                fontSize: 12,
                color: white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: AppTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 10,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

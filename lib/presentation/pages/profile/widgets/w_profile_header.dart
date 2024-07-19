import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WProfileHeader extends StatelessWidget {

  const WProfileHeader({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.15,
          decoration: BoxDecoration(
            gradient: wgradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            )
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
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
                    defaultWidget: Image.asset(
                      AppImages.doctor,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
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
                            // color: white,
                          ),
                        ),
                        Text(
                          "+${state.userContainer.user.phone}",
                          textAlign: TextAlign.center,
                          style: AppTheme.labelSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            // color: white.withOpacity(0.5),
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
      ],
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

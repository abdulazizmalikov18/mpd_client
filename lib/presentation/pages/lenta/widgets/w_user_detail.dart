import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';

class WUserDetail extends StatelessWidget {
  const WUserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  width: 2,
                  color: white.withOpacity(0.2),
                ),
              ),
              child: WNetworkImage(
                image: state.userContainer.user.avatar,
                height: 64,
                width: 64,
                borderRadius: 24,
                defaultWidget: Image.asset(
                  AppImages.userAvatar,
                  height: 64,
                  width: 64,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${state.userContainer.user.name} ${state.userContainer.user.lastname}",
                  style: AppTheme.displayLarge.copyWith(
                    color: white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Text(
                    state.userContainer.user.mainCat.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.labelLarge.copyWith(
                      color: white.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

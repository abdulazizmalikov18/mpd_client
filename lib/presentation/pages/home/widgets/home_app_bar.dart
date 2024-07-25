import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppbarComponent extends StatelessWidget implements PreferredSize {
  const HomeAppbarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: white,
      elevation: .0,
      toolbarHeight: 60,
      centerTitle: false,
      titleSpacing: 16,
      title: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state.userContainer.status.isSuccess) {
            return _buildUserInfo(
              state.userContainer.user.name,
              state.userContainer.user.surname,
              state.userContainer.user.avatar,
              () {
                // Navigator.of(context).pushNamed(AppRoutes.userInfo, arguments: state.userLocalInfo);
              },
              context,
            );
          } else if (state.userContainer.status.isInProgress) {
            return Shimmer.fromColors(
              baseColor: mainBlue.withOpacity(0.2),
              highlightColor: mainBlue.withOpacity(0.4),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 42,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: white),
                ),
                title: Container(
                  height: 14,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
                ),
                subtitle: Container(
                  height: 16,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
                ),
              ),
            );
          } else {
            return const Text('Error');
          }
        },
      ),
      actions: [
        IconButton(
          splashRadius: 26,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          constraints: const BoxConstraints(),
          onPressed: () {
            context.pushNamed(AppRouteNames.createPost);
          },
          icon: SvgPicture.asset(
            AppIcons.plusCircle,
            colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Theme _buildUserInfo(String name, String surname, String image, VoidCallback onTap, BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            WNetworkImage(
              image: image,
              height: 40,
              width: 40,
              borderRadius: 100,
              defaultWidget: Image.asset(
                AppImages.userAvatar,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.lenth_hello,
                  style: AppTheme.headlineMedium.copyWith(color: grey),
                ),
                Text(
                  '$name $surname',
                  style: AppTheme.headlineMedium.copyWith(color: black, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

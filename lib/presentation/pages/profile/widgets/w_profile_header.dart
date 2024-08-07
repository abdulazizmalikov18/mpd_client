import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_qr_code.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_bottom_sheet_clipper.dart';
import 'package:mpd_client/presentation/widgets/w_network_image.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WProfileHeader extends StatelessWidget {
  const WProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          heightFactor: 0,
          child: Image.network(
            "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13",
            width: double.infinity,
            // height: 300,
            fit: BoxFit.cover,
          ),
        ),
        // Container(
        //   width: double.infinity,
        // height: MediaQuery.sizeOf(context).height * 0.15,
        //   decoration: BoxDecoration(
        //     gradient: wgradient,
        //     borderRadius: const BorderRadius.only(
        //       bottomLeft: Radius.circular(100),
        //       bottomRight: Radius.circular(100),
        //     )
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
          child: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WNetworkImage(
                    image: state.userContainer.user.avatar,
                    height: 96,
                    width: 96,
                    borderRadius: 100,
                    defaultWidget: Image.asset(
                      AppImages.doctor,
                      width: 96,
                      height: 96,
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
        Positioned(
          right: 16,
          top: MediaQuery.sizeOf(context).height * 0.1,
          child: GestureDetector(
            onTap: () {
              final qrCode = context.read<AccountsBloc>().state.userContainer.user.qrcode;
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => BottomSheetWidget(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My QR code',
                            style: Styles.emptyboldTitle,
                          ),
                          const CloseButton(
                            color: black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: MediaQuery.sizeOf(context).width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ColoredBox(
                            color: Colors.black,
                            child: CreateQRCode(text: qrCode),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 36,
              child: AppIcons.scanBarcode.svg(color: const Color(0xFF677294)),
            ),
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

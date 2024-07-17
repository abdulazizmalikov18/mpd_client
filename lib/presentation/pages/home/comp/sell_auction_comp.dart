import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SellAuctionComp extends StatelessWidget {
  const SellAuctionComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                return _customCard(colors, icons.sell, "sell".tr(), "receive_directly_at_the_desired_price".tr(), colors.primary,
                    onTap: () {
                  checkTokenDialog(context, () {
                    if (state.profileParam?.username != null) {
                      Navigator.push(context,
                              AppRoutes.getCreateCar(phoneNumber: state.profileParam!.username!, regionId: state.profileParam?.region))
                          .then((value) {
                        context.read<BottomNavBarController>().changeNavBar(false);
                      });
                    }
                  });
                });
              }),
              16.horizontalSpace,
              _customCard(colors, icons.buy, "auction".tr(), "get_the_best_price_offers".tr(), colors.primary),
            ],
          ),
        ),
      );
    });
  }

  Widget _customCard(CustomColorSet colors, iconName, title, subtitle, cardColor, {GestureTapCallback? onTap}) {
    return Expanded(
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
                color: colors.colorF5F5F5,
                shape: BoxShape.circle,
                border: Border.all(color: cardColor, width: 0.7.r),
                boxShadow: [
                  BoxShadow(
                    color: colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(1.w, 2.h),
                  ),
                ]),
            child: SvgPicture.asset(
              iconName,
              height: 28.r,
              width: 28.r,
              colorFilter: ColorFilter.mode(cardColor, BlendMode.srcIn),
            )),
        title: Text(
          title,
          style: Style.semiBold16(),
        ),
        subtitle: Text(
          subtitle,
          textAlign: TextAlign.start,
          style: Style.medium14(size: 10.sp),
        ),
      ),
    );
  }
}

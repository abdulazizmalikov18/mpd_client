import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class InfoAboutBranchComp extends StatelessWidget {
  final BranchModel param;
  const InfoAboutBranchComp({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'branch_information'.tr(),
            style: Style.medium14(size: 15.sp),
          ),
          16.verticalSpace,
          _listTile(icons.time, "${"working_hours".tr()}: ${param.workingTime}",
              colors, fonts),
          _listTile(
              icons.phone,
              "${"contact".tr()}: ${InternationalPhoneFormatter().internationalPhoneFormat(param.contact ?? "")}",
              colors,
              fonts),
          _listTile(icons.location, param.address ?? "", colors, fonts)
        ]),
      );
    });
  }

  ListTile _listTile(
      String icon, String title, CustomColorSet colors, FontSet fonts) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon.svg(
        width: 20.w,
        height: 20.h,
        color: colors.customRed,
      ),
      horizontalTitleGap: 8.0.w,
      minVerticalPadding: 4.w,
      title: Opacity(
        opacity: 0.50,
        child: Text(
          title,
          style: fonts.headline1.copyWith(fontSize: 15.sp),
        ),
      ),
    );
  }
}

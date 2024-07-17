import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:info_popup/info_popup.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

class SaveFilterComponent extends StatelessWidget {
  const SaveFilterComponent({
    super.key,
    required this.colors,
    required this.fonts,
    required this.value,
    required this.icons,
  });

  final IconSet icons;
  final CustomColorSet colors;
  final FontSet fonts;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InfoPopupWidget(
          contentTitle: 'this_setting_saves'.tr(),
          arrowTheme: InfoPopupArrowTheme(
              arrowGap: 12.h,
              color: colors.white,
              arrowSize: Size(12.w, 12.h),
              arrowAlignment: ArrowAlignment.center),
          contentTheme: InfoPopupContentTheme(
              infoTextAlign: TextAlign.start,
              infoTextStyle: fonts.subtitle1
                  .copyWith(fontSize: 12.sp, color: colors.customBlack)),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  icons.infoRounden,
                  height: 12.h,
                  width: 12.h,
                  fit: BoxFit.contain,
                ),
                5.horizontalSpace,
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200.w, minWidth: 70.w),
                  child: Text("remember_filter".tr(),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: fonts.subtitle1.copyWith(
                          fontSize: 12.sp,
                          color: colors.customBlack.withOpacity(0.71))),
                )
              ],
            ),
          ),
        ),
        5.horizontalSpace,
        SizedBox(
          height: 30.h,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch.adaptive(
                value: value,
                inactiveTrackColor: colors.customGreyC3,
                inactiveThumbColor: colors.white,
                trackOutlineColor: MaterialStatePropertyAll(colors.white),
                onChanged: (value) {
                  context
                      .read<SearchBloc>()
                      .add(SearchEvent.setFilterSaved(value: value));
                }),
          ),
        ),
      ],
    );
  }
}

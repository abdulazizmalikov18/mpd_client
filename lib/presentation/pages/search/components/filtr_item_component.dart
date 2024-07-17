import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class FitrItemComponent extends StatelessWidget {
  const FitrItemComponent({
    super.key,
    required this.title,
    required this.onTap,
    required this.onRemove,
    this.selectedFiltr,
    this.isHaveInfoButton = false,
    this.onTapInfoButton,
    this.isRemove = false,
  });

  final String title;
  final List<String?>? selectedFiltr;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final bool isHaveInfoButton;
  final VoidCallback? onTapInfoButton;
  final bool isRemove;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AnimationButtonEffect(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              8.h.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          title,
                          style: fonts.subtitle1.copyWith(fontSize: 15.sp),
                        ),
                        if (isHaveInfoButton)
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: AnimationButtonEffect(
                              onTap: onTapInfoButton!,
                              child: SvgPicture.asset(
                                icons.infoRounden,
                                height: 16.w,
                                width: 16.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 15.h,
                          child: VerticalDivider(
                            width: 20.h,
                            thickness: 1.sp,
                            color: colors.customGreyC3.withOpacity(0.7),
                          ),
                        ),
                        if (selectedFiltr != null &&
                            (selectedFiltr?.isNotEmpty ?? false))
                          for (int index = 0;
                              index < (selectedFiltr?.length ?? 0);
                              index++)
                            Builder(builder: (context) {
                              if (selectedFiltr?[index] == null ||
                                  (selectedFiltr?[index]?.isEmpty ?? true)) {
                                return const SizedBox();
                              }
                              if (index + 1 == selectedFiltr?.length) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${selectedFiltr?[index] ?? ""}${index + 1 == selectedFiltr?.length ? "" : ", "}",
                                      textAlign: TextAlign.start,
                                      maxLines: 100,
                                      style: fonts.subtitle1.copyWith(
                                          fontSize: 14.sp,
                                          color: colors.customBlack
                                              .withOpacity(0.5)),
                                    ),
                                    4.horizontalSpace,
                                    AnimationButtonEffect(
                                        onTap: onRemove,
                                        child: SvgPicture.asset(
                                          icons.remove,
                                          height: 20.h,
                                          width: 20.w,
                                          fit: BoxFit.contain,
                                        )),
                                  ],
                                );
                              } else {
                                return Text(
                                  "${selectedFiltr?[index] ?? ""}${isRemove ? " " : index + 1 == selectedFiltr?.length ? "" : ", "}",
                                  textAlign: TextAlign.start,
                                  maxLines: 100,
                                  style: fonts.subtitle1.copyWith(
                                      fontSize: 14.sp,
                                      color:
                                          colors.customBlack.withOpacity(0.5)),
                                );
                              }
                            }),
                        4.horizontalSpace,
                      ],
                    ),
                  ),
                  icons.forward.svg(
                    color: colors.customBlack.withOpacity(0.3),
                    height: 20.sp,
                  ),
                ],
              ),
              8.h.verticalSpace,
              Divider(
                thickness: 1.sp,
                color: colors.customGreyC3.withOpacity(0.3),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class FitrItemComponentWithButton extends StatelessWidget {
  const FitrItemComponentWithButton({
    super.key,
    required this.title,
    required this.value,
    required this.filtrItems,
    required this.onSelectedItem,
  });

  final String title;
  final List<String>? filtrItems;
  final String? value;
  final Function(String value) onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        children: [
          10.h.verticalSpace,
          Row(
            children: [
              Text(
                title, //  "Марка",
                style: fonts.subtitle1.copyWith(fontSize: 15.sp),
              ),
              10.w.horizontalSpace,
              Expanded(
                child: Wrap(spacing: 10.w, children: [
                  for (int i = 0; i < (filtrItems?.length ?? 0); i++)
                    CustomButton(
                      onPressed: () {
                        onSelectedItem(filtrItems?[i] ?? "");
                      },
                      title: filtrItems?[i] ?? "",
                      isInfinityWidth: false,
                      // haveBorder:
                      //     filtrItems?.indexOf(value ?? "") == i ? false : true,
                      backgroundColor: filtrItems?.indexOf(value ?? "") == i
                          ? colors.customRed
                          : colors.white,
                      titleStyle: fonts.subtitle1.copyWith(
                          fontSize: 14.sp,
                          color: filtrItems?.indexOf(value ?? "") == i
                              ? colors.white
                              : colors.customGreyC3),
                      borderColor: colors.customGreyC3,
                      borderWidth: 1.sp,
                      horizontalPadding: 10.w,
                      verticalPadding: 3.h,
                    )
                ]),
              ),
            ],
          ),
          10.h.verticalSpace,
          Divider(
            thickness: 1.sp,
            color: colors.customGreyC3.withOpacity(0.3),
          ),
        ],
      );
    });
  }
}

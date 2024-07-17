import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/easy_loading.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/top_image_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class FalseAdsWidget extends StatefulWidget {
  const FalseAdsWidget({super.key});

  @override
  State<FalseAdsWidget> createState() => _FalseAdsWidgetState();
}

class _FalseAdsWidgetState extends State<FalseAdsWidget> {
  late String marka;

  @override
  void initState() {
    marka = listMarka.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: SingleChildScrollView(
            child: Column(children: [
          TopImageComp(
            title: "new_way_choose_used_car".tr(),
            subtitle: "trust_ans_consult_with_performance_experts".tr(),
            image: icons.premiumD,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                12.verticalSpace,
                Text(
                  'available_after_login'.tr(),
                  style: Style.medium14(size: 12.sp, color: colors.primary),
                ),
                12.verticalSpace,
                Text(
                  'we_can_take_action_faster'.tr(),
                  style: Style.medium14(size: 12.sp),
                ),
                24.verticalSpace,
                Text(
                  'select_reason'.tr(),
                  style: Style.medium14(),
                ),
                8.verticalSpace,
                DropdownButtonHideUnderline(
                    child: Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: colors.customGreyC3,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: DropdownButton2<String>(
                    value: marka,
                    isExpanded: true,
                    style: Style.medium14(),
                    items:
                        listMarka.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: Style.medium14()),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        marka = val!;
                      });
                    },
                  ),
                )),
                24.verticalSpace,
                Text(
                  'describe_more_detail'.tr(),
                  style: Style.medium14(),
                ),
                8.verticalSpace,
                SizedBox(
                  height: 130.h,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0.r),
                            ),
                            borderSide: BorderSide(
                              color: colors.customGreyC3,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0.r),
                            ),
                            borderSide: BorderSide(
                              color: colors.customGreyC3,
                            )),
                        filled: true,
                        fillColor: colors.white,
                        hintText: 'more_details'.tr()),
                  ),
                ),
                24.verticalSpace,
                CustomButton(
                    backgroundColor: colors.primary,
                    verticalPadding: 13.h,
                    onPressed: () async {
                      await EasyLoading.showSuccess(
                        "thank_you_for_your_application".tr(),
                        description: 'we_will_check_this_advertisement'.tr(),
                      );
                    },
                    title: "send_complaint".tr()),
                36.verticalSpace
              ],
            ),
          ),
        ])),
      );
    });
  }
}

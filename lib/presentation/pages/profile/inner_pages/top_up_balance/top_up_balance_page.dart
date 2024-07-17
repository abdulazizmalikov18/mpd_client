import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/top_up_balance/comp/topup_bottomsheet_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class TopUpBalancePage extends StatefulWidget {
  const TopUpBalancePage({super.key});

  @override
  State<TopUpBalancePage> createState() => _TopUpBalancePageState();
}

class _TopUpBalancePageState extends State<TopUpBalancePage> {
  late TextEditingController _amountController;

  @override
  void initState() {
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return OnUnFocusTap(
        child: Scaffold(
          backgroundColor: colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: AppBarComponent(
                  title: "top_up_balance".tr(),
                  // color: colors.backgroundScaffold,
                ),
              )
            ],
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  CustomTextField(
                    controller: _amountController,
                    hintText: "enter_amount".tr(),
                    keyboardType: TextInputType.number,
                    suffixIcon: Opacity(
                      opacity: 0.50,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(
                          'Сум',
                          textAlign: TextAlign.center,
                          style: fonts.headline1.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            3,
                            (index) => _buildAmount(
                                  title: '15 000 сум',
                                  onTap: () {},
                                  colors: colors,
                                  fonts: fonts,
                                ))),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const TopupBottomsheetComp();
                        },
                      );
                    },
                    backgroundColor: colors.primary,
                    title: "top_up".tr(),
                    verticalPadding: 13.h,
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAmount({
    required VoidCallback onTap,
    required CustomColorSet colors,
    required FontSet fonts,
    required String title,
  }) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: colors.customGreyC3),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(title, style: fonts.subtitle1),
      ),
    );
  }
}

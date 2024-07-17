import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/top_up_balance/comp/topup_bottomsheet_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CardAddingPage extends StatefulWidget {
  const CardAddingPage({super.key});

  @override
  State<CardAddingPage> createState() => _CardAddingPageState();
}

class _CardAddingPageState extends State<CardAddingPage> {
  late bool isSaveCard;
  late bool isCorrectCard;

  @override
  void initState() {
    isSaveCard = false;
    isCorrectCard = false;
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
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'payment'.tr(),
                          textAlign: TextAlign.start,
                          style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                        ),
                        Text(
                          'Uzcard/Humo',
                          style: fonts.subtitle1
                              .copyWith(color: colors.customGreyC3),
                        ),
                      ]),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const TopupBottomsheetSafetyComp();
                              });
                        },
                        child: Text(
                          'safety'.tr(),
                          style: fonts.headline1.copyWith(
                            color: colors.confirmed,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCard(
                    colors: colors,
                    fonts: fonts,
                    icons: icons,
                    isCorrectCard: isCorrectCard,
                  ),
                  16.0.verticalSpace,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      'save_card'.tr(),
                      style: fonts.headline1,
                    ),
                    trailing: Transform.scale(
                      scale: 1.3.w,
                      child: Checkbox(
                        value: isSaveCard,
                        onChanged: (val) {
                          setState(() {
                            isSaveCard = val!;
                            isCorrectCard = !isCorrectCard;
                          });
                        },
                        activeColor: colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                  ),
                  24.0.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      Navigator.push(context, AppRoutes.getSafetyCodeEnter());
                    },
                    title: "pay".tr(),
                    verticalPadding: 13.h,
                    backgroundColor: colors.primary,
                    titleColor: colors.white,
                    isDisabled: isCorrectCard ? false : true,
                  ),
                  24.0.verticalSpace,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'by_continuing_you_agree_to'.tr(),
                          style: fonts.headline1,
                        ),
                        TextSpan(
                          text: 'terms_of_the_offer'.tr(),
                          style: fonts.headline1.copyWith(
                            color: colors.linkText,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCard({
    required CustomColorSet colors,
    required FontSet fonts,
    required IconSet icons,
    required bool isCorrectCard,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.textV1,
              colors.textV2,
              colors.textV2,
              colors.textV1,
            ]),
        image: DecorationImage(
            alignment: Alignment.centerRight,
            image: AssetImage(
              icons.emptyCard,
            )),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'card_number'.tr(),
            style: fonts.headline1.copyWith(color: colors.white),
          ),
          8.0.verticalSpace,
          CustomTextField(
            keyboardType: TextInputType.number,
            fillColor: colors.white,
            hintText: "8600 0602 5247 8442",
            suffixIcon: isCorrectCard
                ? Container(
                    height: 24.w,
                    width: 24.w,
                    decoration: BoxDecoration(
                      color: colors.confirmed,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: icons.check.svg(
                      color: colors.white,
                      height: 24.w,
                    ),
                  )
                : null,
          ),
          16.0.verticalSpace,
          Text(
            'validity_period'.tr(),
            style: fonts.headline1.copyWith(color: colors.white),
          ),
          8.0.verticalSpace,
          SizedBox(
            width: 120.w,
            child: CustomTextField(
              suffixIcon: isCorrectCard
                  ? Container(
                      height: 24.w,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: colors.confirmed,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: icons.check.svg(
                        color: colors.white,
                        height: 24.w,
                      ),
                    )
                  : null,
              keyboardType: TextInputType.number,
              fillColor: colors.white,
              hintText: "05/24",
            ),
          ),
        ]),
      ),
    );
  }
}

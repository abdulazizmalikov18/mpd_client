import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/my_cards/comp/card_empty_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  late bool hasHistory;

  @override
  void initState() {
    hasHistory = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: AppBarComponent(
                title: "payment_history".tr(),
                // color: colors.backgroundScaffold,
              ),
            )
          ],
          body: hasHistory
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (ctx, index) {
                    return (index % 3 == 0)
                        ? Text('28/11/2023',
                            textAlign: TextAlign.center,
                            style: fonts.headline1.copyWith(
                              color: colors.customGreyC3,
                            ))
                        : Container(
                            height: 90.h,
                            decoration: ShapeDecoration(
                              color: colors.text,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: Center(
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.w),
                                onTap: () {
                                  setState(() {
                                    hasHistory = !hasHistory;
                                  });
                                },
                                leading: SizedBox(
                                  width: 44.w,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(icons.wallet),
                                      12.horizontalSpace,
                                      Container(
                                        height: 40.h,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.w,
                                              color: colors.primary,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                title: Text(
                                  'account_replenishment'.tr(),
                                  style: fonts.headline1.copyWith(
                                    color: colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  '15 000 сум',
                                  style: fonts.headline1.copyWith(
                                    color: colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                  separatorBuilder: (ctx, index) {
                    return 16.verticalSpace;
                  },
                  itemCount: 6,
                )
              : CardEmptyComp(
                  onTap: () {
                    setState(() {
                      hasHistory = !hasHistory;
                    });
                  },
                  title: 'no_payments_yet'.tr(),
                  subtitle: 'entire_history_payments'.tr()),
        ),
      );
    });
  }
}

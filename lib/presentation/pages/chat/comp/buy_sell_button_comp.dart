import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BuySellButtonComp extends StatefulWidget {
  const BuySellButtonComp({super.key});

  @override
  State<BuySellButtonComp> createState() => _BuySellButtonCompState();
}

class _BuySellButtonCompState extends State<BuySellButtonComp> {
  late bool isBuy;

  @override
  void initState() {
    isBuy = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isBuy
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        )),
                    onPressed: () {
                      setState(() {
                        isBuy = true;
                      });
                    },
                    child: Text(
                      'buying'.tr(),
                      style: fonts.headline1.copyWith(color: colors.white),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        isBuy = true;
                      });
                    },
                    child: Text(
                      'buying'.tr(),
                      style: fonts.headline1,
                    ),
                  ),
            4.horizontalSpace,
            isBuy
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        isBuy = false;
                      });
                    },
                    child: Text(
                      'selling'.tr(),
                      style: fonts.headline1,
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        )),
                    onPressed: () {
                      setState(() {
                        isBuy = false;
                      });
                    },
                    child: Text(
                      'selling'.tr(),
                      style: fonts.headline1.copyWith(color: colors.white),
                    ),
                  )
          ],
        ),
      );
    });
  }
}

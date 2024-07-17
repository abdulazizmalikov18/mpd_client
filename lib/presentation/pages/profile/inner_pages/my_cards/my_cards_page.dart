import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/my_cards/comp/card_comp.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/my_cards/comp/card_empty_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  late bool hasCards;

  @override
  void initState() {
    hasCards = true;
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
                title: "my_cards".tr(),
                // color: colors.backgroundScaffold,
              ),
            )
          ],
          body: hasCards
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (ctx, index) {
                    return CardComp(onTap: () {
                      setState(() {
                        hasCards = !hasCards;
                      });
                    });
                  },
                  separatorBuilder: (ctx, index) {
                    return 16.verticalSpace;
                  },
                  itemCount: 3,
                )
              : CardEmptyComp(
                  onTap: () {
                    setState(() {
                      hasCards = !hasCards;
                    });
                  },
                  title: 'you_don_have_cards'.tr(),
                  subtitle: 'this_is_where_your'.tr()),
        ),
      );
    });
  }
}

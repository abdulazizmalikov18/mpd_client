import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/basic_information_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/options_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class InfoComp extends StatefulWidget {
  const InfoComp({super.key});

  @override
  State<InfoComp> createState() => _InfoCompState();
}

class _InfoCompState extends State<InfoComp> with TickerProviderStateMixin {
  late int _selectedIndex;
  late TabController _tabController;

  @override
  void initState() {
    _selectedIndex = 0;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'vehicle_information'.tr(),
                  style: Style.semiBold16(),
                ),
                12.verticalSpace,
                // tab bar
                _tabBar(colors),
                12.verticalSpace,
                [
                  const BasicInformationComp(),
                  const OptionsComp(),
                ][_selectedIndex],
              ],
            )),
      );
    });
  }

  Widget _tabBar(CustomColorSet colors) {
    return TabBar(
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          _tabController.animateTo(_selectedIndex);
        });
      },
      physics: const NeverScrollableScrollPhysics(),
      indicatorColor: colors.text,
      dividerColor: colors.customGreyC3,
      controller: _tabController,
      labelPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelStyle:
          Style.semiBold14(size: 12.sp, color: colors.text.withOpacity(0.5)),
      labelStyle: Style.semiBold14(size: 12.sp, color: colors.text),
      tabs: [
        Tab(
          text: 'basic_information'.tr(),
        ),
        Tab(
          text: 'options'.tr(),
        ),
      ],
    );
  }
}

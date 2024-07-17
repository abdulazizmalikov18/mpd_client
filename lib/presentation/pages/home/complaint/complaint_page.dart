import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/home/complaint/widget/false_ads_widget.dart';
import 'package:orient_motors/presentation/pages/home/complaint/widget/rules_widget.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.backgroundScaffold,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: AppBarComponent(
                color: colors.white,
                title: "complaint".tr(),
                isBorder: true,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildTabBar(colors),
            )
          ],
          body: _buildBody(),
        ),
      );
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const FalseAdsWidget();
      case 1:
        return const RulesWidget();

      default:
        return const FalseAdsWidget();
    }
  }

  Widget _buildTabBar(CustomColorSet colors) {
    return Container(
      color: colors.white,
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (context, index) => VerticalDivider(
          color: colors.customGreyC3,
          thickness: 1,
          indent: 8.h,
          endIndent: 8.h,
        ),
        itemBuilder: (context, index) {
          return AnimationButtonEffect(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: Text(
                      listComplaintTabbar[index],
                      style: Style.medium14(
                        color: _selectedIndex == index
                            ? colors.primary
                            : colors.text.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.h,
                    color: _selectedIndex == index
                        ? colors.primary
                        : colors.customGreyC3,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/home/news/comp/popular_comp.dart';
import 'package:orient_motors/presentation/pages/home/news/comp/recently_added_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50.h,
                    child: AppBarComponent(
                      title: "news".tr(),
                      color: colors.white,
                      isBorder: true,
                    ),
                  ),
                )
              ];
            },
            body: ListView(
              children: const [
                PopularComp(),
                RecentlyAddedComp(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

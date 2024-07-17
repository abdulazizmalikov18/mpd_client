import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orient_motors/presentation/component/nav_bar/lib/persistent_tab_view.dart';
import 'package:orient_motors/presentation/pages/chat/chat_page.dart';
import 'package:orient_motors/presentation/pages/home/favorites/favorites_page.dart';
import 'package:orient_motors/presentation/pages/home/home_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/my_ads_page.dart';
import 'package:orient_motors/presentation/pages/profile/profile_page.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:provider/provider.dart';

import 'componets/bottom_navigation_components.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.index});

  final int? index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> pageList;
  late PersistentTabController _controller;
  final ScrollController scrollController = ScrollController();

  @override
  initState() {
    Future.delayed(Duration.zero, () {
      context.read<BottomNavBarController>().changeNavBar(false);
    });
    _controller = PersistentTabController(initialIndex: widget.index ?? 0);
    super.initState();

    pageList = [
      HomePage(scrollController: scrollController),
      const FavoritesPage(index: 0),
      const MyAdsPage(),
      const ChatPage(),
      const ProfilePage(),
    ];
  }

  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, global) {
        return Scaffold(
            backgroundColor: colors.white,
            body: Consumer<BottomNavBarController>(builder: (context, theme, _) {
              return PersistentTabView(
                context,
                onItemSelected: (int index) {
                  if (index == 0) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                    if (isHome) {
                      scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOutSine);
                    }
                  }
                  isHome = index == 0;
                  setState(() {});
                },
                resizeToAvoidBottomInset: true,
                backgroundColor: colors.white,
                navBarHeight: 48 + MediaQuery.of(context).padding.bottom,
                controller: _controller,
                screens: pageList,
                confineInSafeArea: false,
                hideNavigationBarWhenKeyboardShows: false,
                hideNavigationBar: theme.hiddenNavBar,
                navBarStyle: NavBarStyle.simple,
                popAllScreensOnTapAnyTabs: true,
                popAllScreensOnTapOfSelectedTab: false,
                popActionScreens: PopActionScreensType.all,
                stateManagement: true,
                items: navBarsItems(
                  IconSet.create,
                ),
              );
            }));
      },
    );
  }
}

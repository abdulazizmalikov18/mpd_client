import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/presentation/pages/profile/widgets/w_select_lang_dialog.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class MainView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainView({super.key, required this.navigationShell});

  static _MainViewState of(BuildContext context) => context.findAncestorStateOfType<_MainViewState>()!;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  void initState() {
    context.read<AccountsBloc>().add(const GetAccountUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationItems = {
      context.l10n.navbar_home: {'inactive': AppIcons.mainComponentUnfill, 'active': AppIcons.mainComponent},
      context.l10n.navbar_Doctor: {'inactive': AppIcons.searchStatus, 'active': AppIcons.searchStatusFilled},
      context.l10n.navbar_Appointment: {'inactive': AppIcons.calendar, 'active': AppIcons.calendarFilled},
      'Chat': {'inactive': AppIcons.calendar, 'active': AppIcons.calendarFilled},
      context.l10n.navbar_profile: {'inactive': AppIcons.user, 'active': AppIcons.userFilled}
    };
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Padding(
        padding: Platform.isIOS ? const EdgeInsets.only(bottom: 0) : EdgeInsets.zero,
        child: BottomNavigationBar(
          elevation: 10,
          selectedItemColor: mainBlue,
          unselectedItemColor: grey,
          backgroundColor: white,
          onTap: (value) {
            _onTap(context, value);
          },
          selectedLabelStyle: AppTheme.headlineMedium.copyWith(
            color: mainBlue,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: AppTheme.headlineMedium.copyWith(
            color: grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          type: BottomNavigationBarType.fixed,
          iconSize: 24,
          currentIndex: widget.navigationShell.currentIndex,
          items: List.generate(
            bottomNavigationItems.length,
            (index) => BottomNavigationBarItem(
              label: bottomNavigationItems.keys.elementAt(index),
              icon: SvgPicture.asset(
                bottomNavigationItems.values.elementAt(index)['inactive']!,
                colorFilter: const ColorFilter.mode(grey, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                bottomNavigationItems.values.elementAt(index)['active']!,
                colorFilter: const ColorFilter.mode(mainBlue, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        // child: WBottomNavigationBar(
        //   onTap: (index) => _onTap(context, index),
        //   currentIndex: widget.navigationShell.currentIndex,
        // ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      backgroundColor: white,
      elevation: 0,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return const WSelectLangDialog();
      },
    );
  }
}

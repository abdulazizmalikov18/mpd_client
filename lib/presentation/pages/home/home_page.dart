import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/home/comp/home_sliver_app_bar.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/menu_page.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/car_draggable_sheet.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/home_items_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:animated_visibility/animated_visibility.dart';

class HomePage extends StatefulWidget {
  final ScrollController scrollController;
  const HomePage({super.key, required this.scrollController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShadow = false;
  final DraggableScrollableController draggableScrollableController = DraggableScrollableController();

  @override
  void initState() {
    draggableScrollableController.addListener(() {
      if (draggableScrollableController.size >= 0.636) {
        context.read<BottomNavBarController>().changeNavBar(true);
        isShadow = true;
        setState(() {});
      } else {
        isShadow = false;
        context.read<BottomNavBarController>().changeNavBar(false);
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return ThemeWrapper(
      builder: (contextT, colors, fonts, icons, controller) {
        return BlocBuilder<MainBloc, MainState>(
          builder: (context, mainState) {
            return BlocConsumer<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) =>
                  previous.proceedToSetPassword != current.proceedToSetPassword && current.proceedToSetPassword,
              listener: (context, state) {
                if (state.proceedToSetPassword) {
                  if (state.profileParam?.username != null) {
                    Navigator.of(context, rootNavigator: true).push(
                      AppRoutes.getFillPersonalInfo(
                        phoneNumber: state.profileParam!.username!,
                        onClose: () {
                          Navigator.of(context, rootNavigator: true).push(AppRoutes.main());
                        },
                      ),
                    );
                  }
                }
              },
              builder: (context, state) {
                return OnUnFocusTap(
                  child: Scaffold(
                    endDrawer: const MenuPage(),
                    backgroundColor: colors.white,
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        const Column(
                          children: [
                            HomeAppBar(),
                            HomeItemsComp(),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            draggableScrollableController.reset();
                          },
                          child: AnimatedVisibility(
                            visible: isShadow,
                            enterDuration: const Duration(milliseconds: 100),
                            exitDuration: const Duration(milliseconds: 100),
                            child: ColoredBox(
                              color: colors.dark.withOpacity(.4),
                            ),
                          ),
                        ),
                        CarDraggbleSheet(draggableScrollableController: draggableScrollableController),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

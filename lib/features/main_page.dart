import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/features/chat/presentation/views/chat_view.dart';
import 'package:mpd_client/features/home/presentation/pages/home_page.dart';
import 'package:mpd_client/features/main_view_modal.dart';
import 'package:mpd_client/src/themes/styles.dart';

import 'user/user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

enum Status { initial, loading, success, failure }

PageController controller = PageController(initialPage: 0);

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int currentIndex = 0;
  late MainViewModal viewModal;
  List<Widget> pagesss = [
    const HomePage(),
    const DoctorPage(),
    // const MarketPage(),
    const AppointmentPage(),
    const ChatView(),
    const UserPage(),
  ];

  @override
  void initState() {
    viewModal = MainViewModal();
    viewModal.initState(context);
    WidgetsBinding.instance.addObserver(this);
    context.read<UserInfoBloc>().add(GetUserInfoEvent());
    context.read<UserInfoBloc>().add(GetSpecialistUser());

    super.initState();

    /// Attach a listener which will update the state and refresh the page index
    controller.addListener(() {
      if (controller.page!.round() != currentIndex) {
        setState(() {
          currentIndex = controller.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationItems = {
      context.l10n.navbar_home: {
        'inactive': AppIcons.mainComponentUnfill,
        'active': AppIcons.mainComponent
      },
      context.l10n.navbar_Doctor: {
        'inactive': AppIcons.searchStatus,
        'active': AppIcons.searchStatusFilled
      },
      // 'Market': {'inactive': shop, 'active': shop_filled},
      context.l10n.navbar_Appointment: {
        'inactive': AppIcons.calendar,
        'active': AppIcons.calendarFilled
      },
      'Chat': {
        'inactive': AppIcons.noActiveMessage,
        'active': AppIcons.message
      },
      context.l10n.navbar_profile: {
        'inactive': AppIcons.user,
        'active': AppIcons.userFilled
      }
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        controller: controller,
        itemCount: pagesss.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return pagesss.elementAt(index);
        },
      ),
      backgroundColor: context.color.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: context.color.mainBlue,
        unselectedItemColor: context.color.grey,
        backgroundColor: context.color.white,
        onTap: (value) {
          controller.jumpToPage(value);
        },
        selectedLabelStyle: Styles.bottomLabel.copyWith(
          color: context.color.mainBlue,
        ),
        unselectedLabelStyle: Styles.bottomLabel.copyWith(
          color: context.color.grey,
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: List.generate(
          bottomNavigationItems.length,
          (index) => BottomNavigationBarItem(
            label: bottomNavigationItems.keys.elementAt(index),
            icon: SvgPicture.asset(
              bottomNavigationItems.values.elementAt(index)['inactive']!,
              colorFilter: ColorFilter.mode(
                context.color.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              bottomNavigationItems.values.elementAt(index)['active']!,
              colorFilter: ColorFilter.mode(
                context.color.mainBlue,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

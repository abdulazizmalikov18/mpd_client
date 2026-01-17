import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/appoinment.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_group/chat_group_bloc.dart';
import 'package:mpd_client/features/chat/presentation/controller/vm_controller.dart';
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
  bool _hasConnectedChat = false;
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
    return BlocConsumer<UserInfoBloc, UserInfoState>(
      listener: (context, userState) {
        // Connect to chat socket only once when user info is loaded
        if (!_hasConnectedChat &&
            userState.userInfo != null &&
            userState.status.isSuccess) {
          _hasConnectedChat = true;
          // Only connect to chat if user phone is not the restricted one
          if (userState.userInfo?.phone != '998909098108') {
            final chatController = ChatVMController();
            // Connect socket and wait for connection
            chatController.connectSocket(onError: (errorMessage) {}).then((_) {
              // Set up socket listener for chat messages to update chat list
              if (context.mounted) {
                chatController.onComingNewMessage((message) {
                  // Update chat group list when new message arrives
                  if (context.mounted) {
                    context.read<ChatGroupBloc>().add(
                      ChatSocketMessageGroup(message: message),
                    );
                  }
                });
              }
            });
            context.read<ChatGroupBloc>().add(const ChatGetGroupEvent());
          }
        }
      },
      builder: (context, userState) {
        // Show loading if user info is not loaded yet
        if (userState.status.isInProgress || userState.userInfo == null) {
          return Scaffold(
            backgroundColor: context.color.white,
            body: const Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        final shouldHideChat = userState.userInfo?.phone == '998909098108';

        final List<Widget> pages = [
          if (!shouldHideChat) const HomePage(),
          const DoctorPage(),
          // const MarketPage(),
          const AppointmentPage(),
          if (!shouldHideChat) const ChatView(),
          const UserPage(),
        ];

        final Map<String, Map<String, String>> bottomNavigationItems = {
          if (!shouldHideChat)
            context.l10n.navbar_home: {
              'inactive': AppIcons.mainComponentUnfill,
              'active': AppIcons.mainComponent,
            },
          context.l10n.navbar_Doctor: {
            'inactive': AppIcons.searchStatus,
            'active': AppIcons.searchStatusFilled,
          },
          // 'Market': {'inactive': shop, 'active': shop_filled},
          context.l10n.navbar_Appointment: {
            'inactive': AppIcons.calendar,
            'active': AppIcons.calendarFilled,
          },
          if (!shouldHideChat)
            context.l10n.chat: {
              'inactive': AppIcons.noActiveMessage,
              'active': AppIcons.message,
            },
          context.l10n.navbar_profile: {
            'inactive': AppIcons.user,
            'active': AppIcons.userFilled,
          },
        };

        // Adjust currentIndex if chat is hidden and user was on chat or later page
        int adjustedIndex = currentIndex;
        if (shouldHideChat && currentIndex >= 3) {
          // If on chat page (index 3), go to home (index 0)
          // If on user page (index 4), it becomes index 3 after removing chat
          adjustedIndex = currentIndex == 3 ? 0 : currentIndex - 1;
          if (adjustedIndex != currentIndex) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  currentIndex = adjustedIndex;
                });
                controller.jumpToPage(adjustedIndex);
              }
            });
          }
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView.builder(
            controller: controller,
            itemCount: pages.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return pages.elementAt(index);
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
            currentIndex: adjustedIndex,
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
      },
    );
  }
}

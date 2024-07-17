import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/home/notification/comp/notification_bottomsheet_comp.dart';
import 'package:orient_motors/presentation/pages/home/notification/comp/notification_item_comp.dart';
import 'package:orient_motors/presentation/pages/home/notification/comp/notifications_shimmer_list.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
                    height: 60.h,
                    child: AppBarComponent(
                      title: "notifications".tr(),
                      color: colors.white,
                      isBorder: true,
                      iconPath: icons.seen,
                      iconColor: colors.customRed,
                      onButtonPressed: () {
                        context
                            .read<MainBloc>()
                            .add(const MainEvent.patchNotificationsUnread());
                      },
                    ),
                  ),
                )
              ];
            },
            body: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.statusNotification.isInitial ||
                    state.statusNotification.isInProgress) {
                  return const NotificationsShimmerList();
                }
                if (state.notificationsList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(icons.adsCar,
                            height: 130.h, fit: BoxFit.contain),
                        16.verticalSpace,
                        Text(
                          "no_result_found".tr(),
                          style: Style.medium16(color: colors.grey1),
                        )
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 80),
                  itemBuilder: (context, index) {
                    final item = state.notificationsList[index];
                    return NotificationItemComp(
                      param: item,
                      onTap: () {
                        context
                            .read<BottomNavBarController>()
                            .changeNavBar(true);
                        context.read<MainBloc>().add(
                            MainEvent.patchNotificationsActions(
                                id: item.id ?? 0));

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: 1.sh -
                                MediaQuery.of(context).padding.top -
                                80.h,
                            minHeight: .46.sh,
                          ),
                          builder: (builder) {
                            return NotificationBottomSheetComp(param: item);
                          },
                        ).then((value) {
                          context
                              .read<BottomNavBarController>()
                              .changeNavBar(false);
                        });
                      },
                      isRead: item.read ?? false,
                    );
                  },
                  itemCount: state.notificationsList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      16.verticalSpace,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

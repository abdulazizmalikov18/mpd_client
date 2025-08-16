import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/appointment_item.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/filled_gradient_button.dart';

class FilledUserFollowers extends StatelessWidget {
  final ScrollController scrollController;
  final bool isSearch, hasReachedMax;
  final List<Subscription> subscriptions;

  const FilledUserFollowers({
    super.key,
    required this.subscriptions,
    required this.scrollController,
    required this.isSearch,
    required this.hasReachedMax,
  });

  bool _handleScrollNotification(
    ScrollNotification notification,
    BuildContext context,
  ) {
    if (notification is ScrollEndNotification &&
        scrollController.position.extentAfter == 0) {
      context.read<UserSubscriptionsBloc>().add(
        const GetUserSubscriptionsEvent(),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        notificationPredicate: isSearch ? (_) => false : (_) => true,
        onRefresh: () async {
          context.read<UserSubscriptionsBloc>().add(
            const GetUserSubscriptionsEvent(isRefresh: true),
          );
          await context.read<UserSubscriptionsBloc>().stream.first;
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _handleScrollNotification(notification, context),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            controller: scrollController,
            itemCount: hasReachedMax
                ? subscriptions.length
                : subscriptions.length + 1,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            itemBuilder: (context, index) {
              if (index >= subscriptions.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.h,
                      width: 25.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: context.color.mainBlue,
                      ),
                    ),
                    ScreenUtil().setHorizontalSpacing(10.w),
                    Text(
                      'Loading...',
                      style: Styles.headline7.copyWith(
                        color: context.color.mainBlue,
                      ),
                    ),
                  ],
                );
              }
              final subscription = subscriptions[index];
              return AppointmentItem(
                specialist: SpecialistInfoModel(
                  phone: "",
                  id: subscription.id ?? 0,
                  workingTime: subscription.region,
                  avatar: subscription.avatar,
                  fullname:
                      '${subscription.name ?? "__1"} ${subscription.lastname ?? "__"}',
                  job: subscription.mainCat,
                ),
                appoinmentInfo: AppoinmentInfo.infos(context)[3],
                bottomInfo: Align(
                  alignment: Alignment.centerRight,
                  child: FilledGradientButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.drProfilebyid,
                        arguments: SpecialistInfoModel(
                          id: subscription.id ?? 0,
                          avatar: subscription.avatar,
                          phone: "",
                          fullname:
                              '${subscription.name ?? "--"} ${subscription.lastname ?? "--"}',
                          username: subscription.username,
                        ),
                      );
                    },
                    text: Text(
                      'Book Now',
                      style: Styles.boldHeadline6.copyWith(
                        color: context.color.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

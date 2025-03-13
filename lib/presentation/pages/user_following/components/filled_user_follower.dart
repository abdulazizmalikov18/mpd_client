import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/user_subscriptions/user_subscriptions_bloc.dart';
import 'package:mpd_client/domain/models/appointment/appointment_info_models.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/components/appointment_item.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_filled_gradient_button.dart';

class FilledUserFollowers extends StatelessWidget {
  final ScrollController scrollController;
  final bool isSearch, hasReachedMax;
  final List<Subscription> subscriptions;

  const FilledUserFollowers({super.key, required this.subscriptions, required this.scrollController, required this.isSearch, required this.hasReachedMax});

  bool _handleScrollNotification(ScrollNotification notification, BuildContext context) {
    if (notification is ScrollEndNotification && scrollController.position.extentAfter == 0) {
      context.read<UserSubscriptionsBloc>().add(const GetUserSubscriptionsEvent());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        notificationPredicate: isSearch ? (_) => false : (_) => true,
        onRefresh: () async {
          context.read<UserSubscriptionsBloc>().add(const GetUserSubscriptionsEvent(isRefresh: true));
          await context.read<UserSubscriptionsBloc>().stream.first;
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) => _handleScrollNotification(notification, context),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            controller: scrollController,
            itemCount: hasReachedMax ? subscriptions.length : subscriptions.length + 1,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            itemBuilder: (context, index) {
              if (index >= subscriptions.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.h,
                      width: 25.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: mainBlue,
                      ),
                    ),
                    ScreenUtil().setHorizontalSpacing(10.w),
                    Text(
                      'Loading...',
                      style: Styles.headline7.copyWith(color: mainBlue),
                    )
                  ],
                );
              }
              final subscription = subscriptions[index];
              return AppointmentItem(
                specialist: SpecialistInfoModel(
                  id: subscription.id ?? 0,
                  workingTime: subscription.region,
                  avatar: subscription.avatar,
                  fullname: '${subscription.name ?? "__1"} ${subscription.lastname ?? "__"}',
                  job: subscription.mainCat,
                ),
                appoinmentInfo: AppoinmentInfo.infos(context)[3],
                bottomInfo: Align(
                  alignment: Alignment.centerRight,
                  child: FilledGradientButton(
                    onPressed: () {
                      context.pushNamed(AppRouteNames.drProfilebyid, extra: {
                        "specialist": SpecialistInfoModel(
                          id: subscription.id ?? 0,
                          avatar: subscription.avatar,
                          fullname: '${subscription.name ?? "--"} ${subscription.lastname ?? "--"}',
                          username: subscription.username,
                        ),
                      });
                    },
                    text: Text(
                      'Book Now',
                      style: Styles.boldHeadline6.copyWith(
                        color: white,
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

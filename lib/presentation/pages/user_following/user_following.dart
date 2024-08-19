import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/user_subscriptions/user_subscriptions_bloc.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/appoinment.dart';
import 'package:mpd_client/presentation/pages/appointment/appointment/components/appointment_shimmer.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/services/components/w_error_type.dart';
import 'package:mpd_client/presentation/pages/user_following/components/empty_user_followers.dart';
import 'package:mpd_client/presentation/pages/user_following/components/filled_user_follower.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/widgets/w_search_text_field.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class UserFollowing extends StatefulWidget {
  const UserFollowing({super.key});

  @override
  State<UserFollowing> createState() => _UserFollowingState();
}

class _UserFollowingState extends State<UserFollowing> {
  @override
  void initState() {
    // final state = context.read<UserSubscriptionsBloc>().state;
    // if (state.subscriptions.isEmpty && (state is UserSubscriptionsFailure || context.read<UserSubscriptionsBloc>().subscriptionCount != state.subscriptions.length)) {
      context.read<UserSubscriptionsBloc>().add(const GetUserSubscriptionsEvent(tryAgain: true));
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: context.l10n.profile_following_doctors_page),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SearchFieldWidget(
              searchHint: context.l10n.profile_following_doctors_search_doctor,
              controller: context.read<UserSubscriptionsBloc>().searchController,
              onChanged: (query) {
                context.read<UserSubscriptionsBloc>().add(SearchSubscriptionsEvent(query));
              },
            ),
          ),
          BlocBuilder<UserSubscriptionsBloc, UserSubscriptionsState>(
            builder: (context, state) {
              if (state is UserSubscriptionsFailure) {
                if (state.failure == 'Server failure') {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: ErrorTypeWidget(
                        returnToHomePressed: () {
                          FocusScope.of(context).unfocus();
                          controller.jumpToPage(0);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        tryAgainPressed: () => context.read<UserSubscriptionsBloc>().add(const GetUserSubscriptionsEvent(tryAgain: true)),
                        errorIcon: AppIcons.serverError,
                        errorSubtitle: context.l10n.error_internal_server_subtitle,
                        errorTitle: context.l10n.error_internal_server_title,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: ErrorTypeWidget(
                        returnToHomePressed: () {
                          FocusScope.of(context).unfocus();
                          controller.jumpToPage(0);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        tryAgainPressed: () {
                          FocusScope.of(context).unfocus();
                          context.read<UserSubscriptionsBloc>().add(const GetUserSubscriptionsEvent(tryAgain: true));
                        },
                        errorIcon: AppIcons.connectionLostError,
                        errorSubtitle: context.l10n.error_connection_lost_subtitle,
                        errorTitle: context.l10n.error_connection_lost_title),
                  ),
                );
              } else if (state is UserSubscriptionsSuccess) {
                if (state.subscriptions.isEmpty) {
                  return const Expanded(child: EmptyUserFollowers());
                }

                return FilledUserFollowers(
                  subscriptions: state.subscriptions,
                  scrollController: ScrollController(),
                  isSearch: state.isSearch,
                  hasReachedMax: state.hasReachedMax,
                );
              }
              return const AppointmentShimmer();
            },
          ),
        ],
      ),
    );
  }
}

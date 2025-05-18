import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/presentation/paginator.dart';
import 'package:mpd_client/core/utils/caller.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/appointment/data/models/user_posts_arg.dart';
import 'package:mpd_client/features/appointment/presentation/pages/appointment/components/no_appointment.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/components/follow_button.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/doctor_info_iteam.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/loading_doctor_info.dart';
import 'package:mpd_client/features/home/domain/blocs/bloc/user_profile_bloc.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:mpd_client/src/widgets/gradient_icon.dart';
import 'package:mpd_client/src/widgets/icon_gradient_button.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';
import 'package:mpd_client/src/widgets/shimmer_container.dart';
import 'package:mpd_client/src/widgets/w_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class UserAccountView extends StatefulWidget {
  const UserAccountView({
    super.key,
    required this.username,
    required this.name,
    required this.avatar,
    required this.specialistId,
  });
  final String username;
  final String avatar;
  final String name;
  final int specialistId;

  @override
  State<UserAccountView> createState() => _UserAccountViewState();
}

class _UserAccountViewState extends State<UserAccountView> {
  @override
  void initState() {
    if (widget.specialistId != 0) {
      context
          .read<DoctorProfileBloc>()
          .add(GetDoctorPprofileData(widget.specialistId.toString()));
    }
    context
        .read<UserProfileBloc>()
        .add(GetUserEvent(username: widget.username));
    context.read<PostBloc>().add(PostFetchedUser(username: widget.username));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
        builder: (context, state) {
          return AnimatedCrossFade(
            firstChild: const SizedBox(width: double.maxFinite),
            secondChild: PinnedSheet(
              widget: Row(
                children: [
                  Expanded(
                    child: LongButton(
                      color: mainBlue,
                      buttonName: context.l10n.book_doctor_book,
                      onPress: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.services,
                          arguments: state.doctor?.id ?? "_",
                        );
                      },
                    ),
                  ),
                  if (state.doctor != null && state.doctor?.phone != null) ...[
                    ScreenUtil().setHorizontalSpacing(16.w),
                    IconGradientButton(
                      icon: AppIcons.call,
                      onPressed: () =>
                          Caller.makePhoneCall(state.doctor?.phone ?? "__"),
                    )
                  ]
                ],
              ),
            ),
            crossFadeState:
                (state is DoctorProfileSuccess && widget.specialistId != 0)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
      body: widget.specialistId == 0
          ? BlocConsumer<UserProfileBloc, UserProfileState>(
              listener: (context, state) {
                context
                    .read<SubscriptionBloc>()
                    .add(SetSubscribedOrNot(state.userAccount.isRelated));
              },
              listenWhen: (previous, current) =>
                  current.userAccount.username != previous.userAccount.username,
              builder: (context, state) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      expandedHeight: 318.h,
                      centerTitle: false,
                      title: Text(
                        "${state.userAccount.name} ${state.userAccount.lastname}",
                      ),
                      elevation: 0,
                      actions: [
                        if (widget.specialistId != 0)
                          IconButton(
                            onPressed: () {},
                            icon: AppIcons.map.svg(color: context.color.black),
                          ),
                      ],
                      foregroundColor: context.color.black,
                      backgroundColor: context.color.white,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(height: 260.h),
                                Image.network(
                                  "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13",
                                  fit: BoxFit.fill,
                                  height: 200.h,
                                  width: double.maxFinite,
                                ),
                                Container(
                                  height: 200.h,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        context.color.white,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 150.h,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: SizedBox(
                                      height: 96.h,
                                      width: 96.h,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: widget.avatar.isNotEmpty
                                            ? CachedImageWidget(
                                                url: widget.avatar,
                                                size: 96,
                                              )
                                            : const DefaultAvatar(
                                                containerSize: 96,
                                                imageSize: 64,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${state.userAccount.name} ${state.userAccount.lastname}",
                                  style: Styles.headline4.copyWith(
                                    color: context.color.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                ScreenUtil().setHorizontalSpacing(4),
                                const GradientIcon(
                                  iconName: AppIcons.verify,
                                  size: 20,
                                ),
                              ],
                            ),
                            ScreenUtil().setVerticalSpacing(6.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 48.w),
                              child: Text(
                                state.userAccount.mainCat.name.isEmpty
                                    ? "--"
                                    : state.userAccount.mainCat.name,
                                style: Styles.descSubtitle.copyWith(
                                  color: context.color.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              width: MediaQuery.sizeOf(context).width,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: BlocConsumer<SubscriptionBloc,
                                        SubscriptionState>(
                                      listener: (context, state) {
                                        if (state is SubscriptionFailure) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            UiTools.failurefailureSnackBar(
                                              title: 'Oh snap',
                                              message: state.failure,
                                            ),
                                          );
                                        } else if (state
                                            is SubscriptionSuccess) {
                                          context.read<DoctorProfileBloc>().add(
                                              UpdateDoctorSubscription(
                                                  state.isSubscribed));
                                          context
                                              .read<UserSubscriptionsBloc>()
                                              .add(InsertSubscription(
                                                  state.isSubscribed));
                                        }
                                      },
                                      builder: (context, stateSub) {
                                        return FollowButton(
                                          height: 40.h,
                                          isFollowing: stateSub.isSubscribed,
                                          onTap: state is SubscriptionLoading
                                              ? null
                                              : () {
                                                  if (stateSub.isSubscribed) {
                                                    context
                                                        .read<
                                                            SubscriptionBloc>()
                                                        .add(
                                                            UnSubscribeToDrEvent(
                                                                state
                                                                    .userAccount
                                                                    .username));
                                                  } else {
                                                    context
                                                        .read<
                                                            SubscriptionBloc>()
                                                        .add(SubscribeToDrEvent(
                                                            state.userAccount
                                                                .username));
                                                  }
                                                },
                                        );
                                      },
                                    ),
                                  ),
                                  ScreenUtil().setHorizontalSpacing(12.w),
                                  Expanded(
                                    child: LongButton(
                                      onPress: () {},
                                      widget: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AppIcons.message.svg(
                                            color: context.color.mainBlue,
                                          ),
                                          Text(
                                            "Message",
                                            style: Styles.descSubtitle.copyWith(
                                              color: context.color.mainBlue,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      color: context.color.white,
                                      border: Border.all(
                                          color: context.color.mainBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ScreenUtil().setVerticalSpacing(16.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                  body: UserAllPosts(
                    avatar: widget.avatar,
                    name: widget.name,
                    username: widget.username,
                  ),
                );
              },
            )
          : DefaultTabController(
              length: 2,
              child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  return NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        expandedHeight: 334.h,
                        centerTitle: false,
                        title: Text(
                          "${state.userAccount.name} ${state.userAccount.lastname}",
                        ),
                        elevation: 0,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: AppIcons.map.svg(color: context.color.black),
                          ),
                        ],
                        foregroundColor: context.color.black,
                        backgroundColor: context.color.white,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(height: 260.h),
                                  Image.network(
                                    "https://avatars.mds.yandex.net/i?id=e002a4f0a9bf62b531dc38e481d078dcb0ff2ed3-4011696-images-thumbs&n=13",
                                    fit: BoxFit.fill,
                                    height: 200.h,
                                    width: double.maxFinite,
                                  ),
                                  Container(
                                    height: 200.h,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          context.color.white,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 150.h,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: SizedBox(
                                        height: 96.h,
                                        width: 96.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: widget.avatar.isNotEmpty
                                              ? CachedImageWidget(
                                                  url: widget.avatar,
                                                  size: 96,
                                                )
                                              : const DefaultAvatar(
                                                  containerSize: 96,
                                                  imageSize: 64,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${state.userAccount.name} ${state.userAccount.lastname}",
                                    style: Styles.headline4.copyWith(
                                      color: context.color.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  ScreenUtil().setHorizontalSpacing(4),
                                  const GradientIcon(
                                    iconName: AppIcons.verify,
                                    size: 20,
                                  ),
                                ],
                              ),
                              ScreenUtil().setVerticalSpacing(6.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 48.w),
                                child: Text(
                                  state.userAccount.mainCat.name.isEmpty
                                      ? "--"
                                      : state.userAccount.mainCat.name,
                                  style: Styles.descSubtitle.copyWith(
                                    color: context.color.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                width: MediaQuery.sizeOf(context).width,
                                child: Row(
                                  children: [
                                    BlocBuilder<DoctorProfileBloc,
                                        DoctorProfileState>(
                                      builder: (context, doctorState) {
                                        if (doctorState
                                            is DoctorProfileLoading) {
                                          return Expanded(
                                            child: Shimmer.fromColors(
                                              baseColor:
                                                  context.color.baseColor,
                                              highlightColor:
                                                  context.color.highlightColor,
                                              child: const ShimmerContainer(
                                                  size: Size(136, 34)),
                                            ),
                                          );
                                        } else if (doctorState
                                            is DoctorProfileSuccess) {
                                          context.read<SubscriptionBloc>().add(
                                              SetSubscribedOrNot(doctorState
                                                  .doctor!.isSubscribed));
                                          return BlocBuilder<SubscriptionBloc,
                                              SubscriptionState>(
                                            builder: (context, state) {
                                              return Expanded(
                                                child: FollowButton(
                                                  isFollowing:
                                                      state.isSubscribed,
                                                  height: 40.h,
                                                  onTap: state
                                                          is SubscriptionLoading
                                                      ? null
                                                      : () {
                                                          if (state
                                                              .isSubscribed) {
                                                            context
                                                                .read<
                                                                    SubscriptionBloc>()
                                                                .add(UnSubscribeToDrEvent(
                                                                    widget
                                                                        .username));
                                                          } else {
                                                            context
                                                                .read<
                                                                    SubscriptionBloc>()
                                                                .add(SubscribeToDrEvent(
                                                                    widget
                                                                        .username));
                                                          }
                                                        },
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                    BlocBuilder<DoctorProfileBloc,
                                        DoctorProfileState>(
                                      builder: (context, state) {
                                        if (state is DoctorProfileLoading ||
                                            state is DoctorProfileSuccess) {
                                          return SizedBox(width: 12.w);
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                    Expanded(
                                      child: LongButton(
                                        onPress: () {},
                                        widget: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppIcons.message.svg(
                                              color: context.color.mainBlue,
                                            ),
                                            Text(
                                              "Message",
                                              style:
                                                  Styles.descSubtitle.copyWith(
                                                color: context.color.mainBlue,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                        color: context.color.white,
                                        border: Border.all(
                                          color: context.color.mainBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ScreenUtil().setVerticalSpacing(8.h),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverTabBarDelegate(
                          maxHeight: 76.h,
                          minHeight: 76.h,
                          child: ColoredBox(
                            color: context.color.white,
                            child: Container(
                              height: 52.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: context.color.background,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: TabBar(
                                padding: const EdgeInsets.all(4),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: context.color.white,
                                ),
                                indicatorColor: Colors.transparent,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "About",
                                      style: Styles.descSubtitle.copyWith(
                                        color: context.color.black,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Post",
                                      style: Styles.descSubtitle
                                          .copyWith(color: context.color.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    body: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ScreenUtil().setVerticalSpacing(24.h),
                              BlocBuilder<DoctorProfileBloc,
                                  DoctorProfileState>(
                                builder: (context, state) {
                                  if (state is DoctorProfileSuccess) {
                                    debugPrint(
                                        "============>>>>>>>>>>>>. NImaga bilmima");
                                    return DoctorInfoItem(
                                      doctor:
                                          state.doctor ?? DoctorProfileModel(),
                                    );
                                  } else if (state is DoctorProfileLoading) {
                                    return Shimmer.fromColors(
                                      baseColor: context.color.mainBlue
                                          .withValues(alpha: 0.2),
                                      highlightColor: context.color.mainBlue
                                          .withValues(alpha: 0.4),
                                      child: const LoadingDoctorInfo(),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                              ScreenUtil().setVerticalSpacing(90.h)
                            ],
                          ),
                        ),
                        UserAllPosts(
                          avatar: widget.avatar,
                          name: widget.name,
                          username: widget.username,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class UserAllPosts extends StatelessWidget {
  const UserAllPosts({
    super.key,
    required this.username,
    required this.name,
    required this.avatar,
  });
  final String username;
  final String avatar;
  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.statusUser == PostStatus.inProgress) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => WShimmer(radius: 0),
          );
        } else if (state.statusUser == PostStatus.success) {
          if (state.postsUser.isNotEmpty) {
            return Paginator(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: state.postsUser.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  final bloc = context.read<PostBloc>();
                  Navigator.of(context).pushNamed(
                    AppRoutes.userPage,
                    arguments: UserPostsArg(
                      postsUser: state.postsUser,
                      index: index,
                      name: name,
                      avatar: avatar,
                      bloc: bloc,
                    ),
                  );
                },
                child: CachedImageWidget(
                  url: Utils.imageMediea(state.postsUser[index].media),
                  size: 20,
                  borderRadius: 0,
                ),
              ),
              paginatorStatus: FormzSubmissionStatus.success,
              fetchMoreFunction: () {
                context.read<PostBloc>().add(PostFetchedUser(
                      username: username,
                      isMore: true,
                    ));
              },
              hasMoreToFetch: state.count > state.postsUser.length,
            );
          }
          return NoAppointment(
            title: "No Posts",
            subtitle: "No Posts",
            buttonName: "Refresh",
            onPressed: () {
              context.read<PostBloc>().add(PostFetchedUser(username: username));
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  SliverTabBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

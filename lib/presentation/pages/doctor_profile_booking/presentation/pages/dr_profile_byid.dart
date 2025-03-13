import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/doctor_booking/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/w_icon_gradient_button.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/components/follow_button.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/doctor_info_iteam.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/loading_doctor_info.dart';
import 'package:mpd_client/presentation/pages/lenta/view/user_all_posts.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';
import 'package:mpd_client/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class DrProfileByid extends StatefulWidget {
  final SpecialistInfoModel specialist;

  const DrProfileByid({super.key, required this.specialist});

  @override
  State<DrProfileByid> createState() => _DrProfileByidState();
}

class _DrProfileByidState extends State<DrProfileByid> {
  bool isNull = false;
  @override
  void initState() {
    if (widget.specialist.id == 0) {
      isNull = true;
      setState(() {});
    } else {
      context
          .read<DoctorProfileBloc>()
          .add(GetDoctorPprofileData(widget.specialist.id.toString()));
      context
          .read<PostBloc>()
          .add(GetUserPostsEvent(widget.specialist.username ?? ""));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isNull
          ? const SizedBox()
          : DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: 334.h,
                    centerTitle: false,
                    title: Text(
                      widget.specialist.fullname ?? "-- --",
                    ),
                    elevation: 0,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: AppIcons.map.svg(color: black),
                      ),
                    ],
                    foregroundColor: black,
                    backgroundColor: white,
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
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      white,
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
                                      child: widget.specialist.avatar != null
                                          ? CachedImageWidget(
                                              url: widget.specialist.avatar ??
                                                  "",
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
                                widget.specialist.fullname ?? "-- --",
                                style: Styles.headline4.copyWith(
                                  color: black,
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
                          // ScreenUtil().setVerticalSpacing(6.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Text(
                              widget.specialist.job != null
                                  ? "--"
                                  : widget.specialist.job ?? "",
                              style: Styles.descSubtitle.copyWith(
                                color: grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 34,
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: FollowButton(
                                    isFollowing: true,
                                    onTap: () {},
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
                                          color: mainBlue,
                                        ),
                                        Text(
                                          "Message",
                                          style: Styles.descSubtitle.copyWith(
                                            color: mainBlue,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    color: white,
                                    border: Border.all(color: mainBlue),
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
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverTabBarDelegate(
                      maxHeight: 76,
                      minHeight: 76,
                      child: ColoredBox(
                        color: white,
                        child: Container(
                          height: 52,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: background,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: TabBar(
                            padding: const EdgeInsets.all(4),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: white,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Text(
                                  "About",
                                  style: Styles.descSubtitle.copyWith(
                                    color: black,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Post",
                                  style: Styles.descSubtitle
                                      .copyWith(color: black),
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
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 12.h),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(50),
                          //     child: widget.specialist.avatar != null
                          //         ? CachedImageWidget(
                          //             url: widget.specialist.avatar!, size: 88)
                          //         : const DefaultAvatar(
                          //             containerSize: 88, imageSize: 64),
                          //   ),
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       widget.specialist.fullname!,
                          //       style: Styles.headline4.copyWith(
                          //           color: black,
                          //           fontWeight: FontWeight.w600),
                          //     ),
                          //     ScreenUtil().setHorizontalSpacing(4),
                          //     const GradientIcon(
                          //       iconName: AppIcons.verify,
                          //       size: 20,
                          //     ),
                          //   ],
                          // ),
                          // ScreenUtil().setVerticalSpacing(6.h),
                          // Text(
                          //   widget.specialist.job ?? "--",
                          //   style: Styles.descSubtitle
                          //       .copyWith(color: grey),
                          // ),
                          // ScreenUtil().setVerticalSpacing(12.h),
                          // BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                          //   builder: (context, doctorState) {
                          //     if (doctorState is DoctorProfileLoading) {
                          //       return Shimmer.fromColors(
                          //         baseColor: baseColor,
                          //         highlightColor: highlightColor,
                          //         child: const ShimmerContainer(
                          //           size: Size(136, 34),
                          //         ),
                          //       );
                          //     } else if (doctorState is DoctorProfileSuccess) {
                          //       context.read<SubscriptionBloc>().add(
                          //           SetSubscribedOrNot(
                          //               doctorState.doctor!.isWorking));
                          //       return BlocConsumer<SubscriptionBloc,
                          //           SubscriptionState>(
                          //         listener: (context, state) {
                          //           if (state is SubscriptionFailure) {
                          //             ScaffoldMessenger.of(context)
                          //                 .showSnackBar(
                          //                     UiTools.failurefailureSnackBar(
                          //                         title: 'Oh snap',
                          //                         message: state.failure));
                          //           } else if (state is SubscriptionSuccess) {
                          //             // ScaffoldMessenger.of(context).showSnackBar(
                          //             //     UiTools.noInternetSnackbar(
                          //             //         'Successfully subcribed.'));
                          //             context.read<DoctorProfileBloc>().add(
                          //                 UpdateDoctorSubscription(
                          //                     state.isSubscribed));
                          //             context.read<UserSubscriptionsBloc>().add(
                          //                 InsertSubscription(
                          //                     state.isSubscribed));
                          //           }
                          //         },
                          //         builder: (context, state) {
                          //           return FollowButton(
                          //             isFollowing: state.isSubscribed,
                          //             onTap: state is SubscriptionLoading
                          //                 ? null
                          //                 : () {
                          //                     if (!state.isSubscribed) {
                          //                       context
                          //                           .read<SubscriptionBloc>()
                          //                           .add(
                          //                             UnSubscribeToDrEvent(
                          //                                 doctorState.doctor?.id
                          //                                         .toString() ??
                          //                                     "0"),
                          //                           );
                          //                     } else {
                          //                       context
                          //                           .read<SubscriptionBloc>()
                          //                           .add(
                          //                             SubscribeToDrEvent(
                          //                                 doctorState.doctor?.id
                          //                                         .toString() ??
                          //                                     "0"),
                          //                           );
                          //                     }
                          //                   },
                          //           );
                          //         },
                          //       );
                          //     } else {
                          //       return const SizedBox.shrink();
                          //     }
                          //   },
                          // ),
                          ScreenUtil().setVerticalSpacing(24.h),
                          BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                            builder: (context, state) {
                              if (state is DoctorProfileSuccess) {
                                debugPrint(
                                    "============>>>>>>>>>>>>. NImaga bilmima");
                                return DoctorInfoItem(
                                  doctor: state.doctor ?? DoctorProfileModel(),
                                );
                              } else if (state is DoctorProfileLoading) {
                                return Shimmer.fromColors(
                                  baseColor: mainBlue.withValues(alpha: 0.2),
                                  highlightColor:
                                      mainBlue.withValues(alpha: 0.4),
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
                      avatar: widget.specialist.avatar ?? "",
                      name: widget.specialist.fullname ?? "",
                      username: widget.specialist.username ?? "",
                    ),
                  ],
                ),
              ),
            ),
      bottomSheet: PinnedSheet(
        widget: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
          builder: (context, state) {
            return AnimatedCrossFade(
              firstChild: const SizedBox(width: double.maxFinite),
              secondChild: Row(
                children: [
                  Expanded(
                    child: LongButton(
                      buttonName: context.l10n.book_doctor_book,
                      onPress: () {
                        context.pushNamed(AppRouteNames.service, extra: {
                          "specialistId": state.doctor?.id ?? "_",
                        });
                      },
                    ),
                  ),
                  if (state.doctor == null && state.doctor?.phone == null)
                    Row(
                      children: [
                        ScreenUtil().setHorizontalSpacing(16.w),
                        IconGradientButton(
                          icon: AppIcons.call,
                          onPressed: () =>
                              Caller.makePhoneCall(state.doctor?.phone ?? "__"),
                        )
                      ],
                    )
                ],
              ),
              crossFadeState: state is DoctorProfileSuccess
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),
      ),
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

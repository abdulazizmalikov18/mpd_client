import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/caller.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/chat/domain/models/chat_user.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/features/chat/presentation/views/in_app_chat.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/components/follow_button.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/doctor_info_iteam.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/loading_doctor_info.dart';
import 'package:mpd_client/features/home/presentation/pages/user_account/user_account_view.dart';

import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:mpd_client/src/widgets/gradient_icon.dart';
import 'package:mpd_client/src/widgets/icon_gradient_button.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';
import 'package:mpd_client/src/widgets/shimmer_container.dart';
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
          .add(PostFetchedUser(username: widget.specialist.username ?? ""));
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
                    expandedHeight: 318.h,
                    centerTitle: false,
                    title: Text(
                      widget.specialist.fullname ?? "-- --",
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
                              SizedBox(height: 249.h),
                              CachedNetworkImage(
                                imageUrl:
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.specialist.fullname ?? "-- --",
                                  style: Styles.headline4.copyWith(
                                    color: context.color.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ScreenUtil().setHorizontalSpacing(4),
                                const GradientIcon(
                                  iconName: AppIcons.verify,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          ScreenUtil().setVerticalSpacing(6.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48.w),
                            child: Text(
                              widget.specialist.job != null
                                  ? "--"
                                  : widget.specialist.job ?? "",
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
                                    if (doctorState is DoctorProfileLoading) {
                                      return Expanded(
                                        child: Shimmer.fromColors(
                                          baseColor: context.color.baseColor,
                                          highlightColor:
                                              context.color.highlightColor,
                                          child: ShimmerContainer(
                                            size: Size(136, 40.h),
                                          ),
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
                                              isFollowing: state.isSubscribed,
                                              height: 40.h,
                                              onTap:
                                                  state is SubscriptionLoading
                                                      ? null
                                                      : () {
                                                          if (state
                                                              .isSubscribed) {
                                                            context
                                                                .read<
                                                                    SubscriptionBloc>()
                                                                .add(UnSubscribeToDrEvent(widget
                                                                        .specialist
                                                                        .username ??
                                                                    ""));
                                                          } else {
                                                            context
                                                                .read<
                                                                    SubscriptionBloc>()
                                                                .add(SubscribeToDrEvent(widget
                                                                        .specialist
                                                                        .username ??
                                                                    ""));
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
                                  child: BlocBuilder<ChatBloc, ChatState>(
                                    builder: (context, state) {
                                      return LongButton(
                                        loading: state.dataStatus.isInProgress,
                                        onPress: () {
                                          context
                                              .read<ChatBloc>()
                                              .add(GetGroupChat(
                                                username:
                                                    widget.specialist.username,
                                                onSucces: (model) {
                                                  Log.e(model.slugName);
                                                  final bloc = context
                                                      .read<UserInfoBloc>();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider.value(
                                                      value: bloc,
                                                      child: InChatView(
                                                        group: model,
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                onError: () {
                                                  context
                                                      .read<ChatBloc>()
                                                      .add(CreateChatEvent(
                                                        user: ChatUserModel(
                                                          username: widget
                                                                  .specialist
                                                                  .username ??
                                                              "",
                                                        ),
                                                        onSuccess: (model) {
                                                          Log.e(model.slugName);
                                                          final bloc =
                                                              context.read<
                                                                  UserInfoBloc>();
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    BlocProvider
                                                                        .value(
                                                              value: bloc,
                                                              child: InChatView(
                                                                group: model,
                                                              ),
                                                            ),
                                                          ));
                                                        },
                                                        onError: () {
                                                          Log.e("message");
                                                        },
                                                      ));
                                                },
                                              ));
                                        },
                                        widget: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          spacing: 8,
                                          children: [
                                            AppIcons.message.svg(
                                              color: context.color.mainBlue,
                                            ),
                                            Text(
                                              context.l10n.message,
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
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  context.l10n.about,
                                  style: Styles.descSubtitle.copyWith(
                                    color: context.color.black,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  context.l10n.posts,
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
                          //           color: context.color.black,
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
                          //       .copyWith(color: context.color.grey),
                          // ),
                          // ScreenUtil().setVerticalSpacing(12.h),
                          // BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                          //   builder: (context, doctorState) {
                          //     if (doctorState is DoctorProfileLoading) {
                          //       return Shimmer.fromColors(
                          //         baseColor: context.color.baseColor,
                          //         highlightColor: context.color.highlightColor,
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
                      avatar: widget.specialist.avatar ?? "",
                      name: widget.specialist.fullname ?? "",
                      username: widget.specialist.username ?? "",
                    ),
                  ],
                ),
              ),
            ),
      bottomSheet: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
        builder: (context, state) {
          return AnimatedCrossFade(
            firstChild: const SizedBox(width: double.maxFinite),
            secondChild: PinnedSheet(
              widget: Row(
                children: [
                  Expanded(
                    child: LongButton(
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
            crossFadeState: state is DoctorProfileSuccess
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}

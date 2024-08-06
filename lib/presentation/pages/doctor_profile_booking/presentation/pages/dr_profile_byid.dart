import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/doctor_booking/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/application/doctor_booking/subscripption/subscription_bloc.dart';
import 'package:mpd_client/domain/models/appointment/specialist_info_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/w_icon_gradient_button.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/components/follow_button.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/doctor_info_iteam.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/loading_doctor_info.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/cached_image_widget.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/ui_tools.dart';
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
      context.read<DoctorProfileBloc>().add(GetDoctorPprofileData(widget.specialist.id.toString()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.specialist.fullname ?? "-- --"),
      body: isNull
          ? const Center()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.specialist.avatar != null ? CachedImageWidget(url: widget.specialist.avatar!, size: 88) : const DefaultAvatar(containerSize: 88, imageSize: 64),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.specialist.fullname!,
                        style: Styles.headline4.copyWith(color: black, fontWeight: FontWeight.w600),
                      ),
                      ScreenUtil().setHorizontalSpacing(4),
                      const GradientIcon(
                        iconName: AppIcons.verify,
                        size: 20,
                      ),
                    ],
                  ),
                  ScreenUtil().setVerticalSpacing(6.h),
                  Text(
                    widget.specialist.job ?? "--",
                    style: Styles.descSubtitle.copyWith(color: grey),
                  ),
                  ScreenUtil().setVerticalSpacing(12.h),
                  BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                    builder: (context, doctorState) {
                      if (doctorState is DoctorProfileLoading) {
                        return Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: const WShimmer(
                            width: 136,
                            height: 34,
                          ),
                        );
                      } else if (doctorState is DoctorProfileSuccess) {
                        context.read<SubscriptionBloc>().add(SetSubscribedOrNot(doctorState.doctor!.isWorking));
                        return BlocConsumer<SubscriptionBloc, SubscriptionState>(
                          listener: (context, state) {
                            if (state is SubscriptionFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(UiTools.failurefailureSnackBar(title: 'Oh snap', message: state.failure));
                            } else if (state is SubscriptionSuccess) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     UiTools.noInternetSnackbar(
                              //         'Successfully subcribed.'));
                              context.read<DoctorProfileBloc>().add(UpdateDoctorSubscription(state.isSubscribed));
                              // context.read<UserSubscriptionsBloc>().add(InsertSubscription(state.isSubscribed));
                            }
                          },
                          builder: (context, state) {
                            return FollowButton(
                              isFollowing: state.isSubscribed,
                              onTap: state is SubscriptionLoading
                                  ? null
                                  : () {
                                      if (!state.isSubscribed) {
                                        context.read<SubscriptionBloc>().add(
                                              UnSubscribeToDrEvent(doctorState.doctor?.id.toString() ?? "0"),
                                            );
                                      } else {
                                        context.read<SubscriptionBloc>().add(
                                              SubscribeToDrEvent(doctorState.doctor?.id.toString() ?? "0"),
                                            );
                                      }
                                    },
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  ScreenUtil().setVerticalSpacing(24.h),
                  BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                    builder: (context, state) {
                      if (state is DoctorProfileSuccess) {
                        debugPrint("============>>>>>>>>>>>>. NImaga bilmima");
                        return DoctorInfoItem(
                          doctor: state.doctor ?? DoctorProfileModel(),
                        );
                      } else if (state is DoctorProfileLoading) {
                        return Shimmer.fromColors(
                          baseColor: mainBlue.withOpacity(0.2),
                          highlightColor: mainBlue.withOpacity(0.4),
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
                        // FIXME:
                        // Navigator.of(context).pushNamed(AppRoutes.services, arguments: state.doctor?.id ?? "_");
                      },
                    ),
                  ),
                  if (state.doctor == null && state.doctor?.phone == null)
                    Row(
                      children: [
                        ScreenUtil().setHorizontalSpacing(16.w),
                        IconGradientButton(
                          icon: AppIcons.call,
                          onPressed: () => Caller.makePhoneCall(state.doctor?.phone ?? "__"),
                        )
                      ],
                    )
                ],
              ),
              crossFadeState: state is DoctorProfileSuccess ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),
      ),
    );
  }
}

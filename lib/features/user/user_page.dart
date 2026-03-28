import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/user/presentation/pages/terms_of_use_view.dart';
import 'package:mpd_client/features/user/presentation/widgets/language_sheet.dart';
import 'package:mpd_client/features/user/presentation/widgets/logout_sheet.dart';
import 'package:mpd_client/features/user/presentation/widgets/user_name_surname_part.dart';
import 'package:mpd_client/features/user/presentation/widgets/user_number_part.dart';
import 'package:mpd_client/provider/local_provider.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'presentation/widgets/user_avatar_part.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UserSubscriptionsBloc>().add(
      const GetUserSubscriptionsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(height: 254.h),
                BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                    if (state.isBackChanged && state.userBackImage != null) {
                      return Image.file(
                        state.userBackImage!,
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: double.maxFinite,
                      );
                    }
                    return CachedNetworkImage(
                      imageUrl: state.userInfo?.backgroundImage ?? "",
                      fit: BoxFit.cover,
                      height: 200.h,
                      width: double.maxFinite,
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(32),
                        child: Image.asset(AppImages.logo),
                      ),
                    );
                  },
                ),
                const UserAvatarPart(),
                Positioned(
                  right: 16,
                  top: 164.h,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => BottomSheetWidget(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.l10n.my_qr_code,
                                    style: Styles.emptyboldTitle,
                                  ),
                                  const CloseButton(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: MediaQuery.sizeOf(context).width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CreateQRCode(
                                    text:
                                        context
                                            .read<UserInfoBloc>()
                                            .state
                                            .userInfo
                                            ?.qrcode ??
                                        context.l10n.notAvailable,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 32,
                      child: AppIcons.scanBarcode.svg(
                        color: const Color(0xFF677294),
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ScreenUtil().setVerticalSpacing(8.h),
            const UserNameSurnamePart(),
            const UserNumberPart(),
            ScreenUtil().setVerticalSpacing(8.h),
            BlocConsumer<UserInfoBloc, UserInfoState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  debugPrint(
                    '✅ User info yangilandi: ${state.userInfo?.lastname}',
                  );
                }
              },
              buildWhen: (previous, current) {
                // Faqat kerakli o'zgarishlarda rebuild qilish
                return previous.userInfo != current.userInfo ||
                    previous.status != current.status;
              },
              builder: (context, state) {
                final disabled = state.status.isInProgress;
                return ListTile(
                  leading: AppIcons.user.svg(
                    color: !disabled
                        ? context.color.black
                        : context.color.black.withValues(alpha: 0.5),
                  ),
                  horizontalTitleGap: 0,
                  title: Text(
                    context.l10n.profile_personal_info,
                    style: Styles.headline5,
                  ),
                  onTap: disabled
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.userInfo,
                            arguments: state.userInfo,
                          );
                        },
                );
              },
            ),

            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state.userInfo?.phone == '998909098108') {
                  return const SizedBox();
                }
                final disabled = state.status.isInProgress ? true : false;
                return ListTile(
                  leading: AppIcons.likeDislike.svg(
                    color: !disabled
                        ? context.color.black
                        : context.color.black.withValues(alpha: 0.5),
                  ),
                  horizontalTitleGap: 0,
                  title: Text(
                    context.l10n.personalPosts,
                    style: Styles.headline5,
                  ),
                  onTap: state.status.isInProgress || state.status.isFailure
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.postUser,
                            arguments: state.userInfo?.username ?? "",
                          );
                        },
                );
              },
            ),
            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state.userInfo?.phone == '998909098108') {
                  return const SizedBox();
                }
                final disabled = state.status.isInProgress ? true : false;
                return ListTile(
                  leading: AppIcons.userAdd.svg(
                    color: !disabled
                        ? context.color.black
                        : context.color.black.withValues(alpha: 0.5),
                  ),
                  horizontalTitleGap: 0,
                  title: Text(
                    context.l10n.profile_following_doctors,
                    style: Styles.headline5,
                  ),
                  subtitle: BlocBuilder<UserSubscriptionsBloc, UserSubscriptionsState>(
                    builder: (context, state) {
                      if (state is! UserSubscriptionsSuccess) {
                        return SizedBox(
                          width: 80,
                          child: Shimmer.fromColors(
                            baseColor: context.color.baseColor,
                            highlightColor: context.color.highlightColor,
                            child: Text(
                              '${context.l10n.profile_following_doctors_doctor}...',
                              style: Styles.descSubtitle.copyWith(
                                color: !disabled
                                    ? context.color.mainBlue
                                    : context.color.mainBlue.withValues(
                                        alpha: 0.5,
                                      ),
                              ),
                            ),
                          ),
                        );
                      }
                      final doctorsCount = context
                          .read<UserSubscriptionsBloc>()
                          .subscriptionCount;
                      return Text(
                        '$doctorsCount ${context.l10n.profile_following_doctors_doctor.toLowerCase()}',
                        style: Styles.descSubtitle.copyWith(
                          color: !disabled
                              ? context.color.mainBlue
                              : context.color.mainBlue.withValues(alpha: 0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                  onTap: state.status.isInProgress
                      ? null
                      : () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.userFollowing);
                        },
                );
              },
            ),
            ListTile(
              leading: AppIcons.languageCircle.svg(color: context.color.black),
              horizontalTitleGap: 0,
              title: Text(
                context.l10n.profile_language,
                style: Styles.headline5,
              ),
              subtitle: Text(
                lang,
                style: Styles.descSubtitle.copyWith(
                  color: context.color.mainBlue,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => const LanguageSheet(),
                );
              },
            ),
            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state.userInfo?.phone == '998909098108') {
                  return const SizedBox();
                }
                final disabled = state.status.isInProgress ? true : false;
                return ListTile(
                  leading: AppIcons.receipt.svg(
                    color: disabled
                        ? context.color.black.withValues(alpha: .5)
                        : context.color.black,
                  ),
                  horizontalTitleGap: 0,
                  title: Text(
                    context.l10n.records_title,
                    style: Styles.headline5,
                  ),
                  onTap: state.status.isInProgress
                      ? null
                      : () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.recordsPage);
                        },
                );
              },
            ),

            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                Log.wtf(state.userInfo?.phone);
                if (state.userInfo?.phone == '998909098108') {
                  return const SizedBox();
                }
                return ListTile(
                  leading: AppIcons.briefcaseLite.svg(
                    color: context.color.black,
                  ),
                  horizontalTitleGap: 0,
                  title: Text(
                    state.specailistModel.isEmpty
                        ? context.l10n.doctorProfile
                        : context.l10n.mySpecialties,
                    style: Styles.headline5,
                  ),
                  onTap: () {
                    if (state.specailistModel.isEmpty) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => BottomSheetWidget(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              context.l10n.specialist_registration_title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              context.l10n.specialist_registration_description,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.color.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            LongButton(
                              height: 52,
                              buttonName:
                                  context.l10n.specialist_registration_agree,
                              onPress: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.registerSpecialist);
                              },
                            ),
                            const SizedBox(height: 12),
                            LongButton(
                              height: 52,
                              buttonName:
                                  context.l10n.specialist_registration_disagree,
                              color: context.color.red,
                              onPress: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    } else {
                      Navigator.of(context).pushNamed(AppRoutes.userSpecialist);
                    }
                  },
                );
              },
            ),
            ListTile(
              leading: AppIcons.scrollText.svg(),
              horizontalTitleGap: 0,
              title: Text(
                context.l10n.termsOfUseTitle,
                style: Styles.headline5,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TermsOfUseView(),
                  ),
                );
              },
            ),

            // BlocBuilder<UserInfoBloc, UserInfoState>(
            //   builder: (context, state) {
            //     if (state.userInfo?.phone == '998909098108') {
            //       return const SizedBox();
            //     }
            //     return ListTile(
            //       leading: AppIcons.warning.svg(color: context.color.red),
            //       horizontalTitleGap: 0,
            //       title: Text(
            //         context.l10n.sos,
            //         style: Styles.headline5.copyWith(color: context.color.red),
            //       ),
            //       onTap: () {
            //         showModalBottomSheet(
            //           backgroundColor: Colors.transparent,
            //           context: context,
            //           builder: (context) => const RequestEmergencyHelpSheet(),
            //         );
            //       },
            //     );
            //   },
            // ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const LottiPage(),
            //     ));
            //   },
            //   child: const Text("lotti"),
            // ),
            ListTile(
              leading: AppIcons.logOut.svg(color: context.color.red),
              horizontalTitleGap: 0,
              title: Text(
                context.l10n.profile_logout,
                style: Styles.headline5.copyWith(color: context.color.red),
              ),
              onTap: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AuthBloc>(context),
                    child: LogOutSheet(
                      onPress: () {
                        context.read<AuthBloc>().add(DeleteToken());
                        context.read<UserSubscriptionsBloc>().add(
                          CloseSubscriptionBloc(),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String get lang {
    final language = context.read<LocalProvider>().locale;
    switch (language.languageCode) {
      case 'uz':
        return context.l10n.profile_language_uz;
      case 'ru':
        return context.l10n.profile_language_ru;

      default:
        return context.l10n.profile_language_en;
    }
  }
}

class CreateQRCode extends StatelessWidget {
  const CreateQRCode({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(data: text, version: QrVersions.auto),
    );
  }
}

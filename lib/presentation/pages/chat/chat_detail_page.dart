import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/bottom_sheet_comp.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/component/easy_loading.dart';
import 'package:orient_motors/presentation/pages/chat/comp/send_message_comp.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/login_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late bool hasCarInfo;

  @override
  void initState() {
    hasCarInfo = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.backgroundScaffold,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: UserInfoWithIconsComp(onTap: () {
                  setState(() {
                    hasCarInfo = false;
                  });
                  showModalBottomSheet(
                      backgroundColor: colors.transparent,
                      context: context,
                      builder: (ctx) => BottomSheetComp(
                            firstItem: "call".tr(),
                            onTapFirst: () {},
                            secondItem: "complain".tr(),
                            onTapSecond: () {},
                            fourthItem: "delete_chat".tr(),
                            onTapFourth: () {
                              Navigator.pushAndRemoveUntil(context,
                                  AppRoutes.main(index: 3), (route) => false);
                              showDialog(
                                context: context,
                                builder: (context) => CustomDialogComponent(
                                  title: 'do_you_really_want_delete_chat'.tr(),
                                  leftButtonTitle: "cancel".tr(),
                                  rightButtonTitle: "delete".tr(),
                                  onRightButtonPressed: () async {
                                    Navigator.pop(context);
                                    await EasyLoading.showSuccess(
                                        "chat_successfully_deleted".tr());
                                  },
                                ),
                              );
                            },
                          )).whenComplete(() => setState(() {
                        hasCarInfo = true;
                      }));
                }),
              ),
            ];
          },
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (hasCarInfo) _carInfo(fonts: fonts, colors: colors),

                      24.verticalSpace,

                      /// TODO: Add chat messages
                      Opacity(
                        opacity: 0.50,
                        child: Text(
                          'today'.tr(),
                          style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                        ),
                      ),
                      16.verticalSpace,
                      _sellerMessage(fonts: fonts, colors: colors),
                      20.verticalSpace,
                      _customerMessage(fonts: fonts, colors: colors),
                    ],
                  ))),
        ),
        bottomNavigationBar: const SendMessageComp(),
      );
    });
  }

  Widget _sellerMessage(
      {required FontSet fonts, required CustomColorSet colors}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.50,
          child: Text(
            '17:07',
            style: fonts.headline1,
          ),
        ),
        16.horizontalSpace,
        Opacity(
          opacity: 0.60,
          child: Container(
            width: 260.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            decoration: ShapeDecoration(
              color: colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: colors.customGreyC3),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Здравствуйте! Где и когда можно посмотреть?',
              style: fonts.headline1,
            ),
          ),
        )
      ],
    );
  }

  Widget _customerMessage(
      {required FontSet fonts, required CustomColorSet colors}) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
        width: 260.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
        decoration: ShapeDecoration(
          color: colors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          'Здравствуйте, сегодня в 7 вечера, я отравлю вам адрем',
          style: fonts.headline1.copyWith(color: colors.white),
        ),
      ),
      16.horizontalSpace,
      Opacity(
        opacity: 0.50,
        child: Text(
          '17:08',
          style: fonts.headline1,
        ),
      ),
    ]);
  }

  Widget _carInfo({required FontSet fonts, required CustomColorSet colors}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CachedImageComponent(
            height: 50.w,
            width: 50.w,
            imageUrl: "",
            borderRadius: 5.r,
          ),
          title: Row(children: [
            Text(
              'TESLA ',
              style: fonts.headline2.copyWith(fontSize: 18.sp),
            ),
            SizedBox(
              width: 200.w,
              child: Opacity(
                opacity: 0.50,
                child: Text(
                  'MODEL 3 PERFORMANCE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: fonts.subtitle1,
                ),
              ),
            )
          ]),
          subtitle: Text(
            '742 362 119 UZS',
            style: fonts.headline2.copyWith(fontSize: 18.sp),
          ),
        ),
        Divider(color: colors.customGreyC3),
      ],
    );
  }
}

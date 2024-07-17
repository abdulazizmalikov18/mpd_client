import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/chat/comp/buy_sell_button_comp.dart';
import 'package:orient_motors/presentation/pages/chat/comp/chat_list_item_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

import '../../styles/theme_wrapper.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late bool isEmpty;

  @override
  void initState() {
    isEmpty = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return OnUnFocusTap(
          child: Scaffold(
            backgroundColor: colors.backgroundScaffold,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    backgroundColor: colors.white,
                    title: Text("chat".tr()),
                  )
                ];
              },
              body: isEmpty
                  ? _emptyChat(
                      onTap: () {
                        setState(() {
                          isEmpty = !isEmpty;
                        });
                      },
                      icons: icons,
                      fonts: fonts)
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const BuySellButtonComp(),
                            ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  ChatListItemComp(onTap: () {
                                Navigator.push(
                                    context, AppRoutes.getChatDetail());
                              }),
                              separatorBuilder: (context, index) =>
                                  8.verticalSpace,
                              itemCount: 10,
                            ),
                            80.verticalSpace,
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _emptyChat(
      {required VoidCallback onTap,
      required IconSet icons,
      required FontSet fonts}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationButtonEffect(
            onTap: onTap,
            child: Image.asset(icons.emptyCard, height: 140.w, width: 140.w),
          ),
          24.verticalSpace,
          Text(
            "no_messages".tr(),
            textAlign: TextAlign.center,
            style: fonts.subtitle2.copyWith(fontSize: 18.sp),
          ),
          80.verticalSpace
        ]);
  }
}

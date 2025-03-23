import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/authentication/domain/blocs/register/register_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          centerTitle: false,
          backgroundColor: context.color.white,
          titleSpacing: 0,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
            icon: SvgPicture.asset(
              AppIcons.back,
              colorFilter:  ColorFilter.mode(context.color.black, BlendMode.srcIn),
              height: 20.w,
              width: 20.w,
            ),
          ),
          title: Text(context.l10n.register_agree_privacy_and_policy, style: Styles.headline4.copyWith(
            color: context.color.black,)),
        ),
        bottomSheet: PinnedSheet(
          widget: BlocSelector<RegisterBloc, RegisterState, bool>(
            selector: (state) => state.isPrivacyReat,
            builder: (context, isReat) {
              return LongButton(
                  isDisable: !isReat,
                  buttonName: context.l10n.register_agree_privacy_and_policy,
                  onPress: () {
                    Navigator.pop(context);
                  });
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ScreenUtil().setVerticalSpacing(16.h),
                Text(
                    '1914 translation by H. Rackham "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
                    style: Styles.headline6),
                ScreenUtil().setVerticalSpacing(8.h),
                Text(
                    '1914 translation by H. Rackham "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
                    style: Styles.headline6),
                ScreenUtil().setVerticalSpacing(8.h),
                Text(
                    '1914 translation by H. Rackham "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
                    style: Styles.headline6),
                Row(
                  children: [
                    BlocSelector<RegisterBloc, RegisterState, bool>(
                      selector: (state) => state.isPrivacyReat,
                      builder: (context, isReat) {
                        return Checkbox(
                            side:  BorderSide(color: context.color.border),
                            value: isReat,
                            onChanged: (value) => context.read<RegisterBloc>().add(PrivacyReatPressed()),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)));
                      },
                    ),
                    Text(
                      context.l10n.register_terms_of_use,
                      style: Styles.headline7.copyWith(color: context.color.black),
                    ),
                  ],
                ),
                ScreenUtil().setVerticalSpacing(100.h),
              ],
            ),
          ),
        ));
  }
}

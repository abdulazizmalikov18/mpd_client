import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/pinput_theme.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/resend_verify_card/resend_verify_card_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/verify_card/verify_card_bloc.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../domain/blocs/my_cards_bloc/my_cards_bloc.dart';

class VerificationCardSheet extends StatefulWidget {
  final int id;
  const VerificationCardSheet({super.key, required this.id});

  @override
  State<VerificationCardSheet> createState() => _VerificationCardSheetState();
}

class _VerificationCardSheetState extends State<VerificationCardSheet> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    _btnController.stateStream.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(children: [
      ScreenUtil().setVerticalSpacing(40.h),
      Center(
        child: Text('Verification code',
            textAlign: TextAlign.center,
            style: Styles.boldTitle.copyWith(fontFamily: Styles.gilroyMedium)),
      ),
      ScreenUtil().setVerticalSpacing(8.h),
      SizedBox(
        height: 48.h,
        width: 281.w,
        child: Text('Please enter the 6 digit  code we sent you',
            textAlign: TextAlign.center,
            style: Styles.headline6.copyWith(color: context.color.grey)),
      ),
      ScreenUtil().setVerticalSpacing(32.h),
      BlocConsumer<VerifyCardBloc, VerifyCardState>(
        listener: (context, state) async {
          if (state is VerifyCardLoading) {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => const LoadingDialogWidget());
          } else if (state is VerifyCardFailure) {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<MyCardsBloc>().add(InsertCardToAllEvent(state.card!));
          }
        },
        builder: (context, state) {
          return Pinput(
            onCompleted: (code) {
              context
                  .read<VerifyCardBloc>()
                  .add(VerifyCard(cardId: widget.id, code: int.parse(code)));
            },
            autofocus: true,
            forceErrorState: state is VerifyCardFailure ? true : false,
            errorText: '',
            errorBuilder: (_, __) {
              return _builtError(context);
            },
            length: 6,
            cursor: Container(
              height: 17.h,
              width: 1.w,
              color: context.color.mainBlue,
            ),
            defaultPinTheme: PinPutThemes.defaultPinPutTheme(context),
            errorPinTheme: PinPutThemes.errorPinPutTheme(context),
            submittedPinTheme: PinPutThemes.submittedPinPutTheme(context),
          );
        },
      ),
      ScreenUtil().setVerticalSpacing(36.h),
      BlocConsumer<ResendVerifyCardBloc, ResendVerifyCardState>(
        listener: (context, state) {
          if (state is ResendVerifyCardSuccess) {
            _btnController.reset();
          }
        },
        builder: (context, state) {
          return IgnorePointer(
            ignoring: state.duration != '' && state.duration != '00:00',
            child: RoundedLoadingButton(
              color: context.color.mainBlue.withValues(alpha: 0.2),
              elevation: 0,
              height: 44.h,
              width: 120.w,
              controller: _btnController,
              valueColor: context.color.mainBlue,
              onPressed: () {
                context
                    .read<ResendVerifyCardBloc>()
                    .add(ResendVerifyCard(widget.id));
              },
              disabledColor: context.color.gradientRed,
              child: state.duration != '' && state.duration != '00:00'
                  ? Text(state.duration.toString())
                  : Text(
                      'Send again',
                      textAlign: TextAlign.center,
                      style: Styles.headline7,
                    ),
            ),
          );
        },
      ),
      ScreenUtil().setVerticalSpacing(22.h)
    ]);
  }

  Column _builtError(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScreenUtil().setVerticalSpacing(32.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: context.color.red,
              size: 21,
            ),
            ScreenUtil().setHorizontalSpacing(6.5.w),
            Text(
              'You have entered an invalid code, please try again!',
              style: Styles.descSubtitle.copyWith(color: context.color.red),
            )
          ],
        )
      ],
    );
  }
}

/*
Material(
        color: context.color.mainBlue.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: () {
            context.read<ResendPvcBloc>().add(ResendPvc(phone));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(100.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GradientText(
                  'Send again',
                  textAlign: TextAlign.center,
                  colors: const [
                    context.color.gradientBlueOpacity,
                    context.color.gradientBlue
                  ],
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  style: Styles.headline7,
                ),
              ],
            ),
          ),
        ),
      ),


 */

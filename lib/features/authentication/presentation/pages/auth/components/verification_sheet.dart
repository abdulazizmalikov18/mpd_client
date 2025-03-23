import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_routes.dart';

import 'package:mpd_client/features/authentication/domain/blocs/resend_pvc/resend_pvc_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/verification/verification_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';
import '../../../widgets/pinput_theme.dart';

class VerificationSheet extends StatefulWidget {
  final String phone;
  const VerificationSheet({super.key, required this.phone});

  @override
  State<VerificationSheet> createState() => _VerificationSheetState();
}

class _VerificationSheetState extends State<VerificationSheet> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    _btnController.stateStream.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      children: [
        ScreenUtil().setVerticalSpacing(40.h),
        Center(
          child: Text(
            context.l10n.register_verify_code,
            textAlign: TextAlign.center,
            style: Styles.boldTitle.copyWith(fontFamily: Styles.gilroyMedium),
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        SizedBox(
          width: 281.w,
          child: Text(
            '${context.l10n.register_verify_code_description}\n +998 ${widget.phone.substring(1, 3).replaceAll(')', '')}  *** **  ${widget.phone.substring(12)}',
            textAlign: TextAlign.center,
            style: Styles.headline6.copyWith(color: context.color.grey),
          ),
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        BlocConsumer<VerificationBloc, VerificationState>(
          listener: (context, state) async {
            // print(object)
            if (state.showLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingDialogWidget());
            } else {
              Navigator.pop(context);
              if (state.error != 'No') return;
              if (state.isNewUser) {
                await Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) => Navigator.pushNamed(
                        context, AppRoutes.registerDetail,
                        arguments: widget.phone));
              } else {
                await Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.mainPage, (route) => false));
              }
            }
          },
          builder: (context, state) {
            return Pinput(
              onCompleted: (code) {
                context
                    .read<VerificationBloc>()
                    .add(CheckCodeEvent(widget.phone, code));
              },
              autofocus: true,
              forceErrorState:
                  state.error != '' && state.error != 'No' ? true : false,
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
        BlocConsumer<ResendPvcBloc, ResendPvcState>(
          listener: (context, state) {
            if (state.buttonState == ResendButton.timing) {
              _btnController.reset();
            }
          },
          builder: (context, state) {
            return IgnorePointer(
              ignoring: state.duration != '' && state.duration != '00:00' ||
                  state.buttonState == ResendButton.submitting,
              child: RoundedLoadingButton(
                color: context.color.mainBlue.withValues(alpha: 0.2),
                elevation: 0,
                height: 44.h,
                width: 140.w,
                controller: _btnController,
                valueColor: context.color.mainBlue,
                onPressed: () {
                  context.read<ResendPvcBloc>().add(ResendPvc(widget.phone));
                },
                disabledColor: context.color.gradientRed,
                child: state.duration != '' && state.duration != '00:00'
                    ? Text(state.duration.toString())
                    : Text(
                        context.l10n.register_verify_code_sent_again,
                        textAlign: TextAlign.center,
                        style: Styles.headline7,
                      ),
              ),
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(22.h)
      ],
    );
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
              context.l10n.register_verify_code_error_code_write,
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

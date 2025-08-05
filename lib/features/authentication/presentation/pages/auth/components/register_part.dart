import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/locator.dart';
import 'package:mpd_client/core/utils/ticker.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';
import 'package:mpd_client/features/authentication/domain/blocs/register/register_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/resend_pvc/resend_pvc_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/verification/verification_bloc.dart';
import 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';
import 'package:mpd_client/features/authentication/presentation/pages/auth/components/verification_sheet.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/have_account_text_widget.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/input_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class RegisterPart extends StatefulWidget {
  const RegisterPart({super.key});

  @override
  State<RegisterPart> createState() => _RegisterPartState();
}

class _RegisterPartState extends State<RegisterPart> {
  final resendBloc = ResendPvcBloc(
    locator.get<AuthRepository>(),
    const Ticker(),
  );

  @override
  void dispose() {
    resendBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScreenUtil().setVerticalSpacing(24.h),
        Text(
          context.l10n.register_title,
          textAlign: TextAlign.center,
          style: Styles.boldTitle.copyWith(color: context.color.black),
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        BlocSelector<RegisterBloc, RegisterState, String>(
          selector: (state) => state.error,
          builder: (context, error) {
            return Form(
              key: context.read<RegisterBloc>().formKey,
              child: InputWidget(
                hasFormatter: true,
                textInputType: TextInputType.phone,
                inputformater: [
                  MaskTextInputFormatter(
                    mask: '(##) ###-##-##',
                    filter: {"#": RegExp(r'[0-9]')},
                  ),
                ],
                style: Styles.headline7Bold,
                controller: context.read<RegisterBloc>().phoneController,
                hintText: context.l10n.register_phone,
                errorText: error != '' && error != 'Well'
                    ? context.l10n.userExists
                    : null,
                validator: (value) => Validators.phone(value, context),
              ),
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        Row(
          children: [
            BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return Checkbox(
                  side: BorderSide(color: context.color.border),
                  value: state.isPrivacyReat,
                  onChanged: (value) =>
                      context.read<RegisterBloc>().add(PrivacyReatPressed()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.l10n.register_terms_of_use}  ',
                  style: Styles.headline7.copyWith(color: context.color.black),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.privacy),
                  child: Text(
                    context.l10n.register_agree_privacy_and_policy,
                    style: Styles.headline7.copyWith(
                      color: context.color.mainBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        BlocConsumer<RegisterBloc, RegisterState>(
          listenWhen: (previous, current) => previous.error != current.error,
          listener: (context, state) {
            if (state.error == 'Well') {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isDismissible: false,
                // useSafeArea: true,
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: resendBloc),
                    BlocProvider(
                      create: (context) =>
                          VerificationBloc(locator.get<AuthRepository>()),
                    ),
                  ],
                  child: VerificationSheet(
                    phone: context.read<RegisterBloc>().phoneController.text,
                  ),
                ),
                isScrollControlled: true,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: LongButton(
                loading: state.showLoading,
                isDisable: !state.isPrivacyReat,
                buttonName: context.l10n.register_register,
                onPress: () {
                  FocusScope.of(context).unfocus();
                  context.read<RegisterBloc>().add(RegisterButtonPressed());
                },
              ),
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(24.h),
        HaveAccountTextWidget(
          info: context.l10n.register_have_account,
          buttonText: context.l10n.login_enter,
          onPressed: () {
            AuthInheritedNotifier.of(context).notifier!.setAuthPage();
          },
        ),
      ],
    );
  }
}

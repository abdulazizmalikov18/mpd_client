import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';

import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/have_account_text_widget.dart';
import 'package:mpd_client/src/decorations/input_border.dart';
import 'package:mpd_client/src/tools/formatters.dart';
import 'package:mpd_client/src/widgets/input_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class LoginPart extends StatelessWidget {
  const LoginPart({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Column(
        children: [
          ScreenUtil().setVerticalSpacing(24.h),
          Text(
            context.l10n.login_text,
            textAlign: TextAlign.center,
            style: Styles.boldTitle,
          ),
          ScreenUtil().setVerticalSpacing(32.h),
          Form(
            key: context.read<AuthBloc>().formKey,
            child: Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: context.color.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextFormField(
                        style: Styles.descSubtitle,
                        validator: Validators.usernameOrPhone,
                        textInputAction: TextInputAction.next,
                        controller: context.read<AuthBloc>().phoneController,
                        onChanged: (value) => context
                            .read<AuthBloc>()
                            .add(ChangePhoneorUsername(value)),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [Formatters.phoneFormatter],
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 16.w, top: 16.h),
                          enabledBorder: Decorations.enabledBorder(context),
                          focusedBorder: Decorations.focusedBorder(context),
                          border: Decorations.enabledBorder(context),
                          errorText: state.error !=
                                  '[User with this credentials not found]'
                              ? null
                              : context.l10n.login_error,
                          hintText: context.l10n.login_phone,
                          hintStyle: Styles.descSubtitle
                              .copyWith(color: context.color.grey),
                        ),
                      ),
                    );
                  },
                ),
                // BlocSelector<AuthBloc, AuthState, String>(
                //   selector: (state) => state.error,
                //   builder: (context, error) {
                //     return InputWidget(
                //       hasFormatter: true,
                //       style: Styles.headline7Bold,
                //       controller: context.read<AuthBloc>().phoneController,
                //       hintText: 'Enter phone number',
                //       errorText: error != '[User with this credentials not found]'
                //           ? null
                //           : 'Incorrect phone number or password',
                //       validator: Validators.phone,
                //     );
                //   },
                // ),
                ScreenUtil().setVerticalSpacing(16.h),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return InputWidget(
                      textInputAction: TextInputAction.done,
                      hintText: context.l10n.login_password,
                      errorText: state.error !=
                              '[User with this credentials not found]'
                          ? null
                          : context.l10n.login_error,
                      obscure: state.obscureText,
                      validator: Validators.password,
                      onChanged: (value) => context
                          .read<AuthBloc>()
                          .add(PasswordTextFieldChanged(value)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(EyeIconPressed());
                        },
                        icon: Icon(
                          state.obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: context.color.blueBackground,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ScreenUtil().setVerticalSpacing(8.h),
          // Builder(
          //   builder: (context) {
          //     final notifier = AuthInheritedNotifier.of(context).notifier!;
          //     return ListTileTheme(
          //       horizontalTitleGap: 10.w,
          //       child: CheckboxListTile(
          //         dense: true,
          //         visualDensity: VisualDensity.compact,
          //         side: BorderSide(
          //           color: context.color.grey.withValues(alpha:0.5),
          //         ),
          //         checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          //         title: Text(context.l10n.login_rememberme, style: Styles.headline7),
          //         controlAffinity: ListTileControlAffinity.leading,
          //         value: notifier.remember,
          //         onChanged: (isChecked) => notifier.remember = isChecked!,
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          //       ),
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot password?",
                  style: Styles.bottomLabel
                      .copyWith(color: context.color.blueBackground),
                ),
              ),
            ),
          ),
          ScreenUtil().setVerticalSpacing(56.h),
          BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) => previous.error != current.error,
            listener: (context, state) {
              if (state.error == 'No') {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.mainPage, (route) => false);
              } else if (state.error != 'No' && state.error != '') {
                // ScaffoldMessenger.of(context).showSnackBar(UiTools.failSnackbar(title: Utils.errorFormat(state.error), context: context));
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: LongButton(
                  loading: state.showLoginButtonLoading,
                  buttonName: context.l10n.login_enter,
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    context.read<AuthBloc>().add(
                      LoginButtonPressed(
                        onError: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("User topilmadi"),
                              behavior: SnackBarBehavior.floating,
                              dismissDirection: DismissDirection.up,
                              backgroundColor: context.color.red,
                              margin: EdgeInsets.only(
                                bottom: MediaQuery.sizeOf(context).height - 150,
                                right: 16,
                                left: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ScreenUtil().setVerticalSpacing(16.h),
          HaveAccountTextWidget(
            info: context.l10n.login_register_account,
            buttonText: context.l10n.login_register,
            onPressed: () {
              AuthInheritedNotifier.of(context).notifier!.setAuthPage();
            },
          ),
          ScreenUtil().setVerticalSpacing(34.h),
        ],
      ),
    );
  }

  List<TextInputFormatter>? setFormat(
      PhoneOrUsername phoneOrUsername, String text) {
    switch (phoneOrUsername) {
      case PhoneOrUsername.phone:
        return [
          MaskTextInputFormatter(
            mask: '+998 (##) ###-##-##',
            filter: {'#': RegExp(r'[\+0-9]')},
            type: MaskAutoCompletionType.lazy,
          )
        ];
      case PhoneOrUsername.username:
        return [];

      default:
        return null;
    }
  }
}

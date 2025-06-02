import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/platform/platform_check.dart';
import 'package:mpd_client/core/validator/birthdate_validator.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/domain/blocs/create_user/create_user_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/decorations/input_border.dart';
import 'package:mpd_client/src/themes/styles.dart';

class SelectDateWidget extends StatelessWidget {
  final TextEditingController? _birthController;
  const SelectDateWidget({super.key, TextEditingController? birthController})
      : _birthController = birthController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: context.l10n.register_date_birth,
                  style:
                      Styles.boldTopHint.copyWith(color: context.color.black)),
              TextSpan(
                  text: '*',
                  style: Styles.boldTopHint.copyWith(color: context.color.red)),
            ]),
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextFormField(
              style: Styles.headline7.copyWith(color: context.color.black),
              validator: (value) => Validators.empty(value, context),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              controller: _birthController,
              inputFormatters: [
                // FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                LengthLimitingTextInputFormatter(10),
                DateFormatter(),
              ],
              decoration: InputDecoration(
                  suffixIconColor: context.color.grey,
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (!PlatformCheck.platform) {
                        showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDatePickerMode: DatePickerMode.day,
                          context: context,
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData().copyWith(
                                dialogTheme: DialogThemeData(
                                  backgroundColor: context.color.white,
                                ),
                                primaryColor: context.color.red,
                              ),
                              child: child!,
                            );
                          },
                          initialDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          firstDate: DateTime(19),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                        ).then((date) {
                          if (date != null) {
                            if (context.mounted) {
                              context
                                  .read<CreateUserBloc>()
                                  .add(SelectingBirthEvent(date));
                            }
                          }
                        });
                      }
                      if (PlatformCheck.platform) {
                        showCupertinoModalPopup<void>(
                            context: context,
                            builder: (ctx) {
                              return BlocProvider.value(
                                value: BlocProvider.of<CreateUserBloc>(context),
                                child: _builtCupertinoDatePicker(context),
                              );
                            });
                      }
                    },
                    icon: SvgPicture.asset(
                      AppIcons.arrowDown,
                      colorFilter:
                          ColorFilter.mode(context.color.grey, BlendMode.srcIn),
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 15),
                  enabledBorder: Decorations.enabledBorder(context),
                  focusedBorder: Decorations.focusedBorder(context),
                  border: Decorations.enabledBorder(context),
                  errorBorder: Decorations.errorBorder(context),
                  hintText: '01.01.2000',
                  hintStyle:
                      Styles.headline7.copyWith(color: context.color.grey))),
        )
      ],
    );
  }

  Container _builtCupertinoDatePicker(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        height: 216.h,
        padding: const EdgeInsets.only(top: 6.0),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (date) {
              context.read<CreateUserBloc>().add(SelectingBirthEvent(date));
            },
            initialDateTime: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            minimumYear: 1940,
            maximumYear: DateTime.now().year,
            minimumDate: DateTime(1940),
            maximumDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
          ),
        ));
  }
}

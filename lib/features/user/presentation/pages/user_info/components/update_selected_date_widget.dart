import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/platform/platform_check.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/decorations/input_border.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class UpdateSelectDateWidget extends StatelessWidget {
  final TextEditingController? _birthController;
  final ValueChanged? onChanged;
  const UpdateSelectDateWidget({
    super.key,
    TextEditingController? birthController,
    this.onChanged,
  }) : _birthController = birthController;

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
                  text: context.l10n.profile_birth,
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
              onChanged: onChanged,
              style: Styles.headline7.copyWith(color: context.color.black),
              validator: (value) => Validators.empty(value, context),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: _birthController,
              inputFormatters: [
                MaskTextInputFormatter(
                    mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')})
              ],
              decoration: InputDecoration(
                  suffixIconColor: context.color.grey,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (!PlatformCheck.platform) {
                        showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDatePickerMode: DatePickerMode.day,
                          context: context,
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData().copyWith(
                                dialogBackgroundColor: context.color.white,
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
                                  .read<UserInfoBloc>()
                                  .add(UpdateUserBirthEvent(date));
                            }
                          }
                        });
                      }
                      if (PlatformCheck.platform) {
                        showCupertinoModalPopup<void>(
                            context: context,
                            builder: (ctx) {
                              return BlocProvider.value(
                                value: BlocProvider.of<UserInfoBloc>(context),
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
    DateTime dateTime = DateTime.now();
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      height: 260.h,
      padding: const EdgeInsets.only(top: 6.0),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  context.read<UserInfoBloc>().add(UpdateUserBirthEvent(date));
                  dateTime = date;
                },
                initialDateTime: DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day),
                minimumYear: 1940,
                maximumYear: DateTime.now().year,
                minimumDate: DateTime(1940),
                maximumDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LongButton(
                buttonName: 'Saqlash',
                onPress: () {
                  _birthController!.text =
                      DateFormat("dd.MM.yyyy").format(dateTime.toLocal());
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

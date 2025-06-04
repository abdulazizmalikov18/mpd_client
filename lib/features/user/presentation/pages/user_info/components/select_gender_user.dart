import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/radio_button.dart';

class SelectGenderUser extends StatefulWidget {
  const SelectGenderUser({super.key, required this.isDisable});
  final bool isDisable;

  @override
  State<SelectGenderUser> createState() => _SelectGenderUserState();
}

class _SelectGenderUserState extends State<SelectGenderUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
          ),
          child: Text(
            context.l10n.profile_gender,
            style: Styles.boldTopHint.copyWith(color: context.color.black),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyCustomRadioButton(
                value: Gender.male,
                groupValue: UserInfo.of(context).gender,
                onChanged: (value) {
                  if (!widget.isDisable) {
                    setState(() {
                      UserInfo.of(context).gender = value;
                      context.read<UserInfoBloc>().add(const HasChangesEvent());
                    });
                  }
                },
                text: context.l10n.register_gender_man,
                isSelected: UserInfo.of(context).gender == Gender.male,
              ),
              ScreenUtil().setHorizontalSpacing(24.w),
              MyCustomRadioButton(
                value: Gender.female,
                groupValue: UserInfo.of(context).gender,
                onChanged: (value) {
                  if (!widget.isDisable) {
                    setState(() {
                      UserInfo.of(context).gender = value;
                      context.read<UserInfoBloc>().add(const HasChangesEvent());
                    });
                  }
                },
                text: context.l10n.register_gender_woman,
                isSelected: UserInfo.of(context).gender == Gender.female,
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/domain/blocs/create_user/create_user_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/radio_button.dart';

class SelectGenderWidget extends StatelessWidget {
  const SelectGenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            context.l10n.register_gender,
            style: Styles.boldTopHint.copyWith(color: context.color.black),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: BlocSelector<CreateUserBloc, CreateUserState, Gender>(
            selector: (state) => state.gender,
            builder: (context, state) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCustomRadioButton(
                    value: Gender.male,
                    groupValue: state,
                    onChanged: (value) {
                      context.read<CreateUserBloc>().add(
                        SelectingGenderEvent(value),
                      );
                    },
                    text: context.l10n.register_gender_man,
                    isSelected: Gender.male == state,
                  ),
                  ScreenUtil().setHorizontalSpacing(24.w),
                  MyCustomRadioButton(
                    value: Gender.female,
                    groupValue: state,
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();
                      context.read<CreateUserBloc>().add(
                        SelectingGenderEvent(value),
                      );
                    },
                    text: context.l10n.register_gender_woman,
                    isSelected: Gender.female == state,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/yandex_doctor/domain/blocs/specialist/specialist_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/filled_gradient_button.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.white,
        boxShadow: [
          BoxShadow(color: context.color.cardShadow, blurRadius: 20.r),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                context.read<SpecialistBloc>().add(SelectingCategory(-1));
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.color.transparentBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                minimumSize: Size.fromHeight(48.h),
              ),
              child: Text(
                context.l10n.search_filter_reset,
                style: Styles.headline5.copyWith(
                  fontSize: 16.sp,
                  color: context.color.grey,
                ),
              ),
            ),
          ),
          ScreenUtil().setHorizontalSpacing(20.w),
          Expanded(
            child: BlocBuilder<SpecialistBloc, SpecialistState>(
              builder: (context, state) {
                return FilledGradientButton(
                  height: 48,
                  isDisable: state.categoryId == -1,
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<SpecialistBloc>().add(
                      SelectingCategory(state.categoryId),
                    );
                  },
                  text: Text(
                    context.l10n.search_filter_apply,
                    style: Styles.headline5.copyWith(
                      fontSize: 16.sp,
                      color: context.color.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/yandex/filter_category/filter_category_bloc.dart';
import 'package:mpd_client/application/yandex/search_by_category/search_by_category_bloc.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_filled_gradient_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        boxShadow: [BoxShadow(color: cardShadow, blurRadius: 20.r)],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                context.read<FilterCategoryBloc>().add(const SelectedCategoryEvent(-1, ''));
              },
              style: OutlinedButton.styleFrom(side: BorderSide(color: transparentBorder), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)), minimumSize: Size.fromHeight(48.h)),
              child: Text(
                context.l10n.search_filter_reset,
                style: AppTheme.headlineMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ScreenUtil().setHorizontalSpacing(20.w),
          Expanded(
            child: BlocConsumer<FilterCategoryBloc, FilterCategoryState>(
              listener: (context, state) {},
              buildWhen: (previous, current) => previous.selectedCategoryId != current.selectedCategoryId,
              builder: (context, state) {
                return FilledGradientButton(
                  height: 48,
                  isDisable: state.selectedCategoryId == -1,
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<SearchByCategoryBloc>().add(GetSearchedByCategory(state.selectedCategoryId, state.selectedCategoryName));
                  },
                  text: Text(
                    context.l10n.search_filter_apply,
                    style: AppTheme.headlineMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

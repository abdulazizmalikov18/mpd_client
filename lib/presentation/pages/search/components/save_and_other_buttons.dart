import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:provider/provider.dart';

class SaveAndOtherButtonsComponent extends StatelessWidget {
  const SaveAndOtherButtonsComponent({
    super.key,
    required this.colors,
    required this.fonts,
    required this.isDisabled,
    required this.totalCars,
    required this.isSave,
  });

  final CustomColorSet colors;
  final FontSet fonts;
  final bool isDisabled;
  final bool isSave;
  final int totalCars;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomButton(
              verticalPadding: 16,
              haveBorder: false,
              backgroundColor: colors.customGreyC3,
              onPressed: () {
                context
                    .read<SearchBloc>()
                    .add(const SearchEvent.resetFilterValues());
              },
              title: "reset".tr(),
              titleStyle: fonts.subtitle1.copyWith(color: colors.customBlack),
            ),
          ),
          10.w.horizontalSpace,
          Expanded(
            flex: 5,
            child: CustomButton(
              verticalPadding: 16,
              horizontalPadding: 4,
              haveBorder: false,
              isDisabled: isDisabled,
              backgroundColor: colors.customRed,
              onPressed: () {
                if (isSave) {
                  context
                      .read<SearchBloc>()
                      .add(const SearchEvent.searchCreate());
                }

                Navigator.of(context)
                    .push(AppRoutes.goToResult(context))
                    .then((value) {
                  context.read<BottomNavBarController>().changeNavBar(true);
                });
              },
              titleWidget: SizedBox(
                height: 24.h,
                child: AnimatedFlipCounter(
                  duration: const Duration(seconds: 1),
                  value: totalCars,
                  suffix: "advertisements_are_waiting".tr(),
                  textStyle: fonts.subtitle1.copyWith(color: colors.white),
                ),
              ),
              title: "",
            ),
          )
        ],
      ),
    );
  }
}

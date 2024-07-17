import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/filter_dialog.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CarListFilterComp extends StatelessWidget {
  final ReviewController vmController;
  const CarListFilterComp({super.key, required this.vmController});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: colors.greySecondary),
            color: colors.white,
          ),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: colors.greySecondary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildTile(
                            title: state.brandValue ?? 'manufacturing_company'.tr(),
                            onTap: () {
                              Navigator.push(context, AppRoutes.getReviewBrands(context, vmController));
                            },
                            icons: icons),
                        const Divider(height: 0, thickness: .6),
                        _buildTile(
                            title: state.modelValue ?? 'model'.tr(),
                            onTap: state.brandValueId == null
                                ? null
                                : () {
                                    Navigator.push(context, AppRoutes.getReviewCarModel(context, vmController));
                                  },
                            icons: icons),
                        const Divider(height: 0, thickness: .6),
                        _buildTile(
                            title: (state.filterGenerationValue ?? []).isNotEmpty
                                ? state.filterGenerationValue?.first.value.toString() ?? 'series_number'.tr()
                                : 'series_number'.tr(),
                            onTap: state.modelValueId == null
                                ? null
                                : () {
                                    Navigator.push(context, AppRoutes.getReviewGeneration(context, vmController));
                                  },
                            icons: icons),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  AnimationButtonEffect(
                    onTap: () {
                      context.read<ReviewBloc>().add(ReviewEvent.getListFilter(
                            model: ReviewFilterReq(
                              (b) => b
                                ..bodyType = vmController.bodyTypeId.value
                                ..orderBy = vmController.orderValue.value
                                ..mark = state.brandValueId
                                ..model = state.modelValueId
                                ..generation = state.filterGenerationValue?.first.valueId,
                            ),
                          ));
                    },
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: colors.customRed,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text("search".tr(), style: Style.bold16(size: 12, color: colors.white)),
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  AnimationButtonEffect(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: context.read<ReviewBloc>(),
                            child: BlocProvider.value(
                              value: context.read<SearchBloc>(),
                              child: FilterDialog(vmController: vmController),
                            ),
                          );
                        },
                      );
                    },
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: colors.searchTextfieldColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: colors.greySecondary, width: 1.6),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icons.filterIc.svg(height: 12, color: colors.black),
                            8.horizontalSpace,
                            Text("filter".tr(), style: Style.bold16(size: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  _buildTile({required String title, required GestureTapCallback? onTap, required IconSet icons}) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Style.medium14(size: 12),
              ),
            ),
            icons.down.svg(height: 10),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class FilterDialog extends StatelessWidget {
  final ReviewController vmController;
  const FilterDialog({super.key, required this.vmController});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return CustomDialogComponent(
              title: "filter".tr(),
              leftButtonTitle: "reset".tr(),
              rightButtonTitle: "search".tr(),
              onRightButtonPressed: () {
                context.read<ReviewBloc>().add(
                      ReviewEvent.getListFilter(
                        model: ReviewFilterReq(
                          (b) => b
                            ..bodyType = vmController.bodyTypeId.value
                            ..orderBy = vmController.orderValue.value
                            ..mark = state.brandValueId
                            ..model = state.modelValueId
                            ..generation =
                                (state.filterGenerationValue ?? []).isNotEmpty
                                    ? state.filterGenerationValue?.first.valueId
                                    : null,
                        ),
                      ),
                    );
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Avtomobil turi".tr(), style: Style.bold16(size: 12)),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: BlocBuilder<ReviewBloc, ReviewState>(
                      builder: (context, state) {
                        return ValueListenableBuilder(
                            valueListenable: vmController.bodyTypeId,
                            builder: (context, orderId, child) {
                              return Wrap(
                                children: state.bodyTypeList
                                    .map(
                                      (item) => AnimationButtonEffect(
                                        onTap: () {
                                          vmController.bodyTypeId.value =
                                              item.id;
                                        },
                                        child: Container(
                                          decoration: ShapeDecoration(
                                              shape: CircleBorder(
                                                side: BorderSide(
                                                    color:
                                                        colors.greySecondary),
                                              ),
                                              color: orderId == item.id
                                                  ? colors.customRed
                                                  : colors.white),
                                          height: 64,
                                          width: 64,
                                          padding: const EdgeInsets.all(2),
                                          margin: const EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          child: Text(
                                            item.name ?? "",
                                            style: Style.medium14(
                                                size: 10,
                                                color: orderId == item.id
                                                    ? colors.white
                                                    : colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            });
                      },
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "sort_order".tr(),
                    style: Style.bold16(size: 12),
                  ),
                  4.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: vmController.orderValue,
                    builder: (BuildContext context, String orderValue,
                        Widget? child) {
                      return Column(
                        children: vmController.orderingBy
                            .asMap()
                            .entries
                            .map(
                              (item) => RadioListTile<String>(
                                value: item.value,
                                groupValue: orderValue,
                                onChanged: (value) {
                                  vmController.orderValue.value =
                                      value.toString();
                                },
                                title: Text(item.value.tr()),
                                activeColor: colors.customRed,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

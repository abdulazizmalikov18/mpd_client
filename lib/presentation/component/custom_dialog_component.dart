import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class CustomDialogComponent extends StatelessWidget {
  const CustomDialogComponent({
    super.key,
    required this.title,
    required this.leftButtonTitle,
    required this.rightButtonTitle,
    required this.onRightButtonPressed,
    this.child,
    this.content,
    this.onLeftButtonPressed,
    this.isRightPop = false,
  });

  final String title;
  final String? content;
  final String leftButtonTitle;
  final String rightButtonTitle;
  final VoidCallback onRightButtonPressed;
  final VoidCallback? onLeftButtonPressed;
  final bool isRightPop;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (
      context,
      colors,
      fonts,
      icons,
      controller,
    ) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 0,
        backgroundColor: colors.white,
        title: Text(
          title,
          style: fonts.headline3,
        ),
        content: content != null
            ? Text(
                content!,
                style: fonts.bodyText1.copyWith(color: colors.customBlack),
              )
            : child,
        actionsOverflowButtonSpacing: 0,
        actions: [
          Row(
            children: [
              SizedBox(
                width: 124.w,
                child: CustomButton(
                  borderColor: colors.transparent,
                  verticalPadding: 8.h,
                  titleStyle: fonts.bodyText1,
                  horizontalPadding: 8.w,
                  onPressed: () {
                    Navigator.pop(context);
                    if (onLeftButtonPressed != null) {
                      onLeftButtonPressed!();
                    }
                  },
                  title: leftButtonTitle,
                  backgroundColor: colors.customGreyC3,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              SizedBox(
                width: 144.w,
                child: CustomButton(
                  backgroundColor: colors.primary,
                  borderColor: colors.transparent,
                  verticalPadding: 8.h,
                  horizontalPadding: 8.w,
                  titleStyle: fonts.bodyText1.copyWith(color: colors.white),
                  onPressed: () {
                    if (isRightPop) {
                      Navigator.pop(context);
                    }
                    onRightButtonPressed();
                  },
                  title: rightButtonTitle,
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}

class ChangedPartDialog extends StatefulWidget {
  final int? selectedId;
  final String? description;

  const ChangedPartDialog({
    super.key,
    required this.indexPart,
    this.selectedId,
    this.description,
  });

  final int indexPart;

  @override
  State<ChangedPartDialog> createState() => _ChangedPartDialogState();
}

class _ChangedPartDialogState extends State<ChangedPartDialog> {
  int? selectedId;
  late TextEditingController _controller;

  @override
  void initState() {
    selectedId = widget.selectedId;
    _controller = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        CreateCarReq req = (state.createCarReq ?? CreateCarReq());

        List<ChangedPartReq> partList =
            List.from(req.changedPart?.toList() ?? []);
        int lastIndex = partList.lastIndexWhere((element) =>
            element.partId == state.changedPartsList?[widget.indexPart].id);

        return Unfocuser(
          child: Dialog(
            backgroundColor: colors.colorF5F5F5,
            surfaceTintColor: colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(15.0.r),
            )),
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        state.changedPartsList?[widget.indexPart].name ?? '',
                        textAlign: TextAlign.start,
                        style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                      ),
                      trailing: lastIndex != -1
                          ? TextButton(
                              onPressed: () {
                                if (lastIndex != -1) {
                                  if (partList[lastIndex].id != null) {
                                    context.read<AddCarBloc>().add(
                                        AddCarEvent.deleteChangedPartDraft(
                                            id: partList[lastIndex].id!));
                                  }
                                  partList.removeAt(lastIndex);
                                  context.read<AddCarBloc>().add(
                                      AddCarEvent.setFilterValue(
                                          createCarReq: req.rebuild((p0) => p0
                                            ..changedPart = partList
                                                .toBuiltList()
                                                .toBuilder()),
                                          filterType: FilterType.none));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                "delete".tr(),
                                style: fonts.subtitle1,
                              ),
                            )
                          : null,
                    ),
                    for (var index = 0;
                        index < (state.changedPartsQualityList?.length ?? 0);
                        index++)
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        value: selectedId ==
                            state.changedPartsQualityList?[index].id,
                        onChanged: (bool? val) {
                          if (val != null) {
                            setState(() {
                              selectedId =
                                  state.changedPartsQualityList?[index].id;
                            });
                          }
                        },
                        activeColor: colors.primary,
                        checkColor: colors.white,
                        side: BorderSide(width: 1.w, color: colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r)),
                        title: Text(
                          state.changedPartsQualityList?[index].name ?? "",
                          style: fonts.subtitle1.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    8.verticalSpace,
                    CustomTextField(
                      controller: _controller,
                      maxLines: 3,
                      hintText: "description".tr(),
                    ),
                    16.verticalSpace,
                    CustomButton(
                      onPressed: () {
                        if (selectedId != null) {
                          partList.add(ChangedPartReq((b) => b
                            ..id =
                                lastIndex != -1 ? partList[lastIndex].id : null
                            ..partId =
                                state.changedPartsList?[widget.indexPart].id
                            ..qualityId = selectedId
                            ..description = _controller.text.trim()));

                          if (lastIndex != -1) {
                            partList.removeAt(lastIndex);
                          }

                          context.read<AddCarBloc>().add(
                              AddCarEvent.setFilterValue(
                                  createCarReq: req.rebuild((p0) => p0
                                    ..changedPart =
                                        partList.toBuiltList().toBuilder()),
                                  filterType: FilterType.none));
                          Navigator.pop(context);
                        }
                      },
                      title: "save".tr(),
                      backgroundColor: colors.primary,
                      titleColor: colors.white,
                      verticalPadding: 10.h,
                    ),
                    8.verticalSpace,
                  ]),
            ),
          ),
        );
      });
    });
  }
}

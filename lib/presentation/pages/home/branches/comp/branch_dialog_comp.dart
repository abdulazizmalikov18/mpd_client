import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BrancheDialogComp extends StatelessWidget {
  final BranchModel param;
  BrancheDialogComp({super.key, required this.param});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (_, colors, fonts, icons, controller) {
      return AlertDialog(
        backgroundColor: colors.white,
        surfaceTintColor: colors.transparent,
        title: OnUnFocusTap(
          child: Column(
            children: [
              Row(children: [
                const Spacer(),
                AnimationButtonEffect(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: icons.clear.svg(color: colors.text, height: 20),
                ),
              ]),
              16.verticalSpace,
              Text(
                'complaints_and_suggestions_are_always_welcome'.tr(),
                textAlign: TextAlign.center,
                style: Style.medium14(size: 18.sp),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 130.h,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textController,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintStyle: fonts.headline1
                        .copyWith(color: colors.text.withOpacity(0.5)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
                      borderSide: BorderSide(color: colors.customGreyC3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
                      borderSide: BorderSide(color: colors.customGreyC3),
                    ),
                    filled: true,
                    fillColor: colors.white,
                    hintText: 'enter_text'.tr(),
                  ),
                ),
              ),
              16.verticalSpace,
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        context
                            .read<MainBloc>()
                            .add(MainEvent.postBranchComplaint(
                                request: BranchComplaintModel(
                              (b) => b
                                ..region = param.id
                                ..text = textController.text,
                            )));
                        Navigator.pop(context);
                      }
                    },
                    title: "send".tr(),
                    backgroundColor: colors.primary,
                    titleColor: colors.white,
                    verticalPadding: 10.h,
                  );
                },
              ),
              16.verticalSpace,
              Opacity(
                opacity: 0.5,
                child: Text(
                  'we_will_glad_see_your_every_comment'.tr(),
                  textAlign: TextAlign.center,
                  style: Style.medium14(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

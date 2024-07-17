import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_dropdown_menu_comp.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class WriteCommentWidget extends StatelessWidget {
  final ReviewController vmCtr;
  final int? id;
  const WriteCommentWidget({super.key, required this.vmCtr, required this.id});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colors.searchTextfieldColor,
            border: Border.all(
              width: 1,
              color: colors.greySecondary,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                height: 60,
                child: CustomDropDownMenuComp(
                  list: vmCtr.rateList.reversed.toList(),
                  onSelected: (value) {
                    vmCtr.rateValue = vmCtr.rateList.indexOf(value ?? "");
                  },
                ),
              ),
              SizedBox(
                height: 180,
                child: TextFormField(
                  controller: vmCtr.commentController,
                  expands: true,
                  maxLines: null,
                  maxLength: 300,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0.r),
                      ),
                      borderSide: BorderSide(
                        color: colors.customGreyC3,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0.r),
                      ),
                      borderSide: BorderSide(
                        color: colors.customGreyC3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0.r),
                      ),
                      borderSide: BorderSide(
                        color: colors.customGreyC3,
                      ),
                    ),
                    filled: true,
                    fillColor: colors.white,
                    hintText: 'leave_your_comment'.tr(),
                    hintStyle: fonts.headline1.copyWith(color: colors.text.withOpacity(0.5)),
                  ),
                ),
              ),
              16.verticalSpace,
              BlocBuilder<ReviewBloc, ReviewState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, stateProfile) {
                      return AnimationButtonEffect(
                        onTap: state.statusComment.isInProgress
                            ? null
                            : () {
                                if (stateProfile.profileParam == null) {
                                  showAuthModalSheet(context, () {
                                    vmCtr.onSave(context: context, id: id ?? 0);
                                  });
                                  return;
                                } else {
                                  vmCtr.onSave(context: context, id: id ?? 0);
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors.greySecondary,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: !state.statusComment.isInProgress
                              ? Text(stateProfile.profileParam != null ? "send".tr() : "registration".tr(), style: Style.bold16(size: 12))
                              : const ShimmerView(child: ShimmerContainer(height: 18, width: 82)),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

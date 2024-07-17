import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class AskTheSellerComp extends StatefulWidget {
  const AskTheSellerComp({super.key});

  @override
  State<AskTheSellerComp> createState() => _AskTheSellerCompState();
}

class _AskTheSellerCompState extends State<AskTheSellerComp> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocSelector<CarDetailBloc, CarDetailState, List<QuestionModel>>(
          selector: (state) => state.questionList,
          builder: (context, list) {
            return list.isEmpty
                ? const SizedBox.shrink()
                : ColoredBox(
                    color: colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Text(
                            'ask_the_seller_in_chat'.tr(),
                            style: fonts.bodyText2
                                .copyWith(fontSize: 14.sp, color: colors.text),
                          ),
                          14.verticalSpace,
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.w,
                            children: list
                                .map((item) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 8.h),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE2F0FB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                      ),
                                      child: Text(
                                        item.question ?? "",
                                        style: TextStyle(
                                          color: const Color(0xFF1A7BDF),
                                          fontSize: 14.sp,
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}

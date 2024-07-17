import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_checkbox.dart';
import 'package:orient_motors/presentation/component/custom_text_field.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/create/comp/bargaining_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class PriceWidget extends StatefulWidget {
  const PriceWidget({super.key});

  @override
  State<PriceWidget> createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        return OnUnFocusTap(
          child: Scaffold(
            backgroundColor: colors.backgroundColor,
            body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'price'.tr(),
                      textAlign: TextAlign.center,
                      style: fonts.subtitle2.copyWith(fontSize: 20.sp),
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.createCarReq != null)
                          Expanded(
                              flex: 5,
                              child: SizedBox(
                                child: CustomTextField(
                                  initialValue: state.createCarReq?.price
                                      ?.toString()
                                      .toCurrencyString(
                                        mantissaLength: 0,
                                        thousandSeparator:
                                            ThousandSeparator.Space,
                                      ),
                                  onChanged: (String text) {
                                    double? price = double.tryParse(
                                        text.replaceAll(" ", ""));
                                    if (price != null) {
                                      CreateCarReq req = (state.createCarReq ??
                                              CreateCarReq())
                                          .rebuild((p0) => p0..price = price);
                                      context.read<AddCarBloc>().add(
                                          AddCarEvent.setFilterValue(
                                              createCarReq: req,
                                              filterType: FilterType.none,
                                              isCheck: false));
                                    }
                                  },
                                  formatter: [
                                    CurrencyInputFormatter(
                                        mantissaLength: 0,
                                        thousandSeparator:
                                            ThousandSeparator.Space,
                                        useSymbolPadding: true)
                                  ],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: BorderSide(
                                        color: colors.customGreyC3, width: 0.8),
                                  ),
                                  validator: (String? text) {
                                    if (text == null || text.isEmpty) {
                                      return "please_enter_valid_price".tr();
                                    } else {
                                      return null;
                                    }
                                  },
                                  enableBorderColor: colors.customGreyC3,
                                  fillColor: colors.white,
                                ),
                              )),
                        8.horizontalSpace,
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: colors.customGreyC3,
                                  )),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: AnimationButtonEffect(
                                    onTap: () {
                                      CreateCarReq req = (state.createCarReq ??
                                              CreateCarReq())
                                          .rebuild((p0) => p0
                                            ..currency = listCurrency.first);
                                      context.read<AddCarBloc>().add(
                                          AddCarEvent.setFilterValue(
                                              createCarReq: req,
                                              filterType: FilterType.none,
                                              isCheck: false));
                                    },
                                    child: Container(
                                      height: 44.h,
                                      decoration: state
                                                  .createCarReq?.currency ==
                                              listCurrency.first
                                          ? BoxDecoration(
                                              color: colors.primary,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.r),
                                                  bottomLeft:
                                                      Radius.circular(20.r)),
                                            )
                                          : null,
                                      child: Center(
                                        child: Text(
                                          listCurrency.first.tr(),
                                          style: fonts.subtitle1.copyWith(
                                            color:
                                                state.createCarReq?.currency ==
                                                        listCurrency.first
                                                    ? colors.white
                                                    : colors.customGreyC3,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: AnimationButtonEffect(
                                    onTap: () {
                                      CreateCarReq req = (state.createCarReq ??
                                              CreateCarReq())
                                          .rebuild((p0) =>
                                              p0..currency = listCurrency.last);
                                      context.read<AddCarBloc>().add(
                                          AddCarEvent.setFilterValue(
                                              createCarReq: req,
                                              filterType: FilterType.none,
                                              isCheck: false));
                                    },
                                    child: Container(
                                      height: 44.h,
                                      decoration: state
                                                  .createCarReq?.currency ==
                                              listCurrency.last
                                          ? BoxDecoration(
                                              color: colors.primary,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.r),
                                                  bottomRight:
                                                      Radius.circular(20.r)),
                                            )
                                          : null,
                                      child: Center(
                                        child: Text(
                                          listCurrency.last.tr(),
                                          style: fonts.subtitle1.copyWith(
                                              fontSize: 12.sp,
                                              color: state.createCarReq
                                                          ?.currency ==
                                                      listCurrency.last
                                                  ? colors.white
                                                  : colors.customGreyC3),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ))
                      ],
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCheckBoxRectangleComponent(
                          isCheck: state.createCarReq?.barter ?? false,
                          horizontalMargin: 0,
                          onChanged: () {
                            CreateCarReq req =
                                (state.createCarReq ?? CreateCarReq()).rebuild(
                                    (p0) => p0..barter = !(p0.barter ?? true));
                            context.read<AddCarBloc>().add(
                                AddCarEvent.setFilterValue(
                                    createCarReq: req,
                                    filterType: FilterType.none,
                                    isCheck: false));
                          },
                        ),
                        8.horizontalSpace,
                        Text(
                          'exchange'.tr(),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle1
                              .copyWith(color: colors.customGreyC3),
                        ),
                        const Spacer(),
                        Text(
                          'average_price'.tr(),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle1,
                        ),
                        8.horizontalSpace,
                        Text(
                          '14 000\$',
                          textAlign: TextAlign.center,
                          style: fonts.subtitle2.copyWith(
                            color: colors.primary,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    Divider(color: colors.customGreyC3),
                    8.verticalSpace,
                    BargainingComp(
                      createCarReq: state.createCarReq,
                    ),
                    8.verticalSpace,
                    Divider(color: colors.customGreyC3),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    CreateCarReq req = (state.createCarReq ?? CreateCarReq());
                    context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                        createCarReq: req, filterType: FilterType.photography));
                  }
                },
                backgroundColor: colors.primary,
                title: "continue".tr(),
              ),
            ),
          ),
        );
      });
    });
  }
}

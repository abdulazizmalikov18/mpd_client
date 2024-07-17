import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/model_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ReviewCarModelPage extends StatelessWidget {
  final ReviewController vmController;
  const ReviewCarModelPage({super.key, required this.vmController});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocConsumer<SearchBloc, SearchState>(
          listenWhen: (previous, current) =>
              previous.next != current.next && current.next,
          listener: (context, state) {
            if (state.next) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: colors.white,
              appBar: AppBarComponent(
                title: "${state.brandValue}",
              ),
              body: SizedBox(
                width: double.infinity,
                child: ListView(
                  children: [
                    StickyHeader(
                      header: Container(
                        width: 1.sw,
                        color: colors.colorF5F5F5,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.h),
                        child: Text("popular".tr(), style: fonts.subtitle1),
                      ),
                      content: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.topModelList?.length ?? 0,
                        itemBuilder: (context, index) {
                          if (state.topModelList?[index].countOfCars == 0) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              ModelListItem(
                                colors: colors,
                                isSelected: state.topModelList?[index].id ==
                                    state.modelValueId,
                                fonts: fonts,
                                title: state.topModelList?[index].name ?? '',
                                count:
                                    "${state.topModelList?[index].countOfCars ?? 0}",
                                onTap: () {
                                  context.read<SearchBloc>().add(
                                      SearchEvent.setFilterValue(
                                          value:
                                              state.topModelList?[index].name ??
                                                  '',
                                          valueId:
                                              state.topModelList?[index].id,
                                          filtrType: FilterType.model));
                                },
                              ),
                              Divider(
                                color: colors.customGreyC3.withOpacity(0.3),
                                height: 1.h,
                                indent: 16.w,
                                endIndent: 16.w,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    16.verticalSpace,
                    StickyHeader(
                      header: Container(
                        width: 1.sw,
                        color: colors.colorF5F5F5,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.h),
                        child: Text("other_brand".tr(), style: fonts.subtitle1),
                      ),
                      content: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 120.h),
                        shrinkWrap: true,
                        itemCount: state.modelList?.length ?? 0,
                        itemBuilder: (context, index) {
                          if (state.modelList?[index].countOfCars == 0) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              ModelListItem(
                                colors: colors,
                                isSelected: state.modelList?[index].id ==
                                    state.modelValueId,
                                fonts: fonts,
                                title: state.modelList?[index].name ?? '',
                                count:
                                    "${state.modelList?[index].countOfCars ?? 0}",
                                onTap: () {
                                  context.read<SearchBloc>().add(
                                      SearchEvent.setFilterValue(
                                          value: state.modelList?[index].name ??
                                              '',
                                          valueId: state.modelList?[index].id,
                                          filtrType: FilterType.model));
                                },
                              ),
                              Divider(
                                color: colors.customGreyC3.withOpacity(0.3),
                                height: 1.h,
                                indent: 16.w,
                                endIndent: 16.w,
                              )
                            ],
                          );
                        },
                      ),
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

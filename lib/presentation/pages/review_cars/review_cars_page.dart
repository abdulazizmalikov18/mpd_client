import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/car_list_filter_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/vote_generation_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ReviewCarsPage extends StatelessWidget {
  final ReviewController vmController;
  const ReviewCarsPage({super.key, required this.vmController});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBarComponent(
            title: "review_of_cars_from".tr(),
            color: colors.white,
            titleRich: "Orient Motors",
            isBorder: true,
          ),
          body: ListView(
            children: [
              16.verticalSpace,
              CarListFilterComp(vmController: vmController),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, searchState) {
                  return BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (context, state) {
                      final list = state.listModel?.result?.toList() ?? [];
                      if (state.statusList == FormzSubmissionStatus.initial ||
                          state.statusList ==
                              FormzSubmissionStatus.inProgress) {
                        return const ReviewShimmerList();
                      }

                      if (list.isEmpty) {
                        if (state.listModel?.votingGeneration == null) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text("no_result_found".tr(),
                                  style: Style.medium16()),
                            ),
                          );
                        }

                        return VoteGenerationWidget(
                            model: ReviewFilterReq(
                          (b) => b
                            ..bodyType = vmController.bodyTypeId.value
                            ..orderBy = vmController.orderValue.value
                            ..mark = searchState.brandValueId
                            ..model = searchState.modelValueId
                            ..generation = searchState
                                .filterGenerationValue?.first.valueId,
                        ));
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (ctx, index) {
                          final item = list[index];
                          return _carCard(
                            last: index == list.length - 1,
                            colors: colors,
                            icons: icons,
                            item: item,
                            context: context,
                            vmController: vmController,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _carCard({
    required bool last,
    required CustomColorSet colors,
    required IconSet icons,
    required ReviewListModel item,
    required BuildContext context,
    required ReviewController vmController,
  }) {
    final title = "${item.carModel?.brand?.name} ${item.carModel?.name}";
    return AnimationButtonEffect(
      onTap: () {
        Navigator.push(
          context,
          AppRoutes.getReviewCarDetail(context, item, vmController),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        margin: EdgeInsets.only(
            left: 16.w, right: 16.w, top: 16.h, bottom: !last ? 0 : 46),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: colors.white,
          border: Border.all(color: colors.borderColor, width: 1),
          boxShadow: const [Style.bottomShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: Style.bold16(),
            ),
            8.verticalSpace,
            _buildAboutTitle(
                colors: colors,
                title: item.advantage?.title ?? "",
                icons: icons),
            4.verticalSpace,
            _buildAboutTitle(
                colors: colors,
                title: item.disadvantage?.title ?? "",
                isAdvantage: false,
                icons: icons),
            8.verticalSpace,
            StarsComp(starCount: item.orientMotorsOverallRating ?? 0),
            12.verticalSpace,
            Center(
                child: CachedNetworkImage(
                    imageUrl: item.photo ?? "",
                    fit: BoxFit.contain,
                    height: 110.h)),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTitle({
    required CustomColorSet colors,
    required String title,
    bool isAdvantage = true,
    required IconSet icons,
  }) {
    return Row(
      children: [
        ColoredBox(
          color: isAdvantage ? colors.customRed : colors.customGrey9A,
          child: SizedBox(
            height: 14,
            width: 14,
            child: Padding(
              padding: const EdgeInsets.all(1.6),
              child: isAdvantage
                  ? icons.plus.svg(color: colors.white)
                  : icons.minus.svg(color: colors.white),
            ),
          ),
        ),
        6.horizontalSpace,
        Text(
          title,
          textAlign: TextAlign.center,
          style: Style.medium14(size: 12.sp),
        ),
      ],
    );
  }
}

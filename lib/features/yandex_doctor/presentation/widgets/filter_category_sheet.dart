import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/popular_categories_model.dart';
import 'package:mpd_client/features/yandex_doctor/domain/blocs/specialist/specialist_bloc.dart';
import 'package:mpd_client/features/yandex_doctor/presentation/widgets/filter_buttons.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/widgets/search_field_widget.dart';
import 'package:shimmer/shimmer.dart';

class FilterCategorySheet extends StatefulWidget {
  const FilterCategorySheet({super.key});

  @override
  State<FilterCategorySheet> createState() => _FilterCategorySheetState();
}

class _FilterCategorySheetState extends State<FilterCategorySheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        maxChildSize: .97,
        initialChildSize: .7,
        builder: (context, controller) {
          return Stack(
            children: [
              BottomSheetWidget(children: [
                Expanded(
                  child: CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverAppBar(
                        titleSpacing: 0,
                        leadingWidth: 0,
                        pinned: true,
                        toolbarHeight: 112,
                        backgroundColor: context.color.white,
                        leading: const SizedBox(),
                        title: Column(
                          children: [
                            ScreenUtil().setVerticalSpacing(24.h),
                            Center(
                              child: Text(context.l10n.search_filter,
                                  style: Styles.title
                                      .copyWith(color: context.color.black)),
                            ),
                            ScreenUtil().setVerticalSpacing(12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: SearchFieldWidget(
                                // controller: context
                                //     .read<FilterCategoryBloc>()
                                //     .searchController,
                                controller: TextEditingController(),
                                searchHint: context.l10n.search_category,
                                onChanged: (query) {
                                  if (query.isEmpty || query.length % 3 == 0) {
                                    setState(() {});
                                  }
                                  // context.read<FilterCategoryBloc>().add(
                                  //     SearchCategoryEvent(
                                  //         query,
                                  //         Localizations.localeOf(context)
                                  //             .languageCode));
                                },
                              ),
                            ),
                            ScreenUtil().setVerticalSpacing(10.h),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Text(
                                context.l10n.search_filter_select_category,
                                style: Styles.semiboldTitle
                                    .copyWith(fontSize: 20.sp),
                              ),
                              const Spacer(),
                              BlocBuilder<SpecialistBloc, SpecialistState>(
                                builder: (context, state) {
                                  if (state.statusCategory.isSuccess) {
                                    return Text(
                                      '~${state.categories.length}',
                                      style: Styles.semiboldTitle.copyWith(
                                          fontSize: 18.sp,
                                          color: context.color.grey),
                                    );
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: context.color.baseColor,
                                    highlightColor:
                                        context.color.highlightColor,
                                    child: Text(
                                      context.l10n.search_filter_count,
                                      style: Styles.semiboldTitle
                                          .copyWith(fontSize: 20.sp),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<SpecialistBloc, SpecialistState>(
                        builder: (context, state) {
                          if (state.statusCategory.isSuccess) {
                            return SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              sliver: SliverGrid.builder(
                                itemCount: state.categories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 12.h,
                                  mainAxisExtent: 42.h,
                                ),
                                itemBuilder: (context, index) {
                                  Log.w(index);
                                  if (index >= state.categories.length) {
                                    return _buildShimmerItem(context, index);
                                  }
                                  return buildAnimatedItem(
                                    context,
                                    state.categories[index],
                                    state.categoryId,
                                  );
                                },
                              ),
                            );
                          }
                          return SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverGrid.builder(
                              itemCount: 20,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 12.h,
                                mainAxisExtent: 42.h,
                              ),
                              itemBuilder: _buildShimmerItem,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: FilterButtons(),
              )
            ],
          );
        });
  }

  Widget buildAnimatedItem(
    BuildContext context,
    PopularCategories category,
    int selectedCategoryId,
  ) =>
      // For example wrap with fade transition
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              BoxShadow(
                color: context.color.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ]),
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<SpecialistBloc>().add(SelectingCategory(category.id!));
          },
          color: category.id == selectedCategoryId
              ? context.color.mainBlue
              : context.color.white,
          shape: const StadiumBorder(),
          elevation: 0,
          child: Text(
            category.name ?? "--",
            style: Styles.postTitle.copyWith(
                color: category.id == selectedCategoryId
                    ? context.color.white
                    : context.color.black),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _buildShimmerItem(BuildContext context, int index) {
    return Shimmer.fromColors(
      baseColor: context.color.baseColor,
      highlightColor: context.color.highlightColor,
      child: Card(
        color: context.color.white,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}

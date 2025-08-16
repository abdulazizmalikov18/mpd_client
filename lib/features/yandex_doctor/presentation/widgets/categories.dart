import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/yandex_doctor/domain/blocs/specialist/specialist_bloc.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  final bool showDoctorInfo;
  final SpecialistState state;
  const Categories({
    super.key,
    required this.showDoctorInfo,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCirc,
      left: 0,
      right: 0,
      bottom: showDoctorInfo ? -100.h : 12.h,
      child: SizedBox(
        height: 47.h,
        child: CategoriesComponent(
          scrollController: ScrollController(),
          onScrollEnd: () {
            context.read<SpecialistBloc>().add(GetCategory());
          },
          state: state,
        ),
      ),
    );
  }
}

class CategoriesComponent extends StatelessWidget {
  final SpecialistState state;
  final VoidCallback onScrollEnd;
  final ScrollController scrollController;
  const CategoriesComponent({
    super.key,
    required this.state,
    required this.onScrollEnd,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (state.categories.isNotEmpty) {
      return ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: state.statusCategory.isInProgress
            ? state.categories.length + 20
            : state.categories.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          if (index >= state.categories.length) {
            return Shimmer.fromColors(
              baseColor: context.color.baseColor,
              highlightColor: context.color.highlightColor,
              child: Padding(
                padding: EdgeInsets.only(right: 8.w, bottom: 5.h),
                child: Card(
                  color: context.color.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SizedBox(width: 123.w),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(right: 8.w, bottom: 5.h),
            child: BlocConsumer<SpecialistBloc, SpecialistState>(
              listener: (_, state) {
                if (!state.status.isInProgress && state.specialist.isNotEmpty) {
                  context.read<YandexDoctorBloc>().add(
                    ClusterPlaceMarkEvent(
                      specialists: state.specialist,
                      context: context,
                    ),
                  );
                }
              },
              builder: (context, selectedState) {
                return ElevatedButton(
                  onPressed: () {
                    if (state.categories[index].id ==
                        selectedState.categoryId) {
                      Log.e(state.categories[index].id);
                      context.read<SpecialistBloc>().add(SelectingCategory(-1));
                      context.read<SpecialistBloc>().add(
                        GetSpecialist(
                          onSucces: (specialist) {
                            FocusScope.of(context).unfocus();
                            context.read<SearchBySpecialistBloc>().add(
                              CloseSuggessionsEvent(),
                            );

                            context.read<YandexDoctorBloc>().add(
                              AddSpecialistMap(
                                specialist: specialist ?? [],
                                context: context,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      context.read<SpecialistBloc>().add(
                        SelectingCategory(state.categories[index].id!),
                      );
                      context.read<SpecialistBloc>().add(
                        GetSpecialist(
                          jobId: state.categories[index].id!,
                          onSucces: (specialist) {
                            FocusScope.of(context).unfocus();
                            context.read<SearchBySpecialistBloc>().add(
                              CloseSuggessionsEvent(),
                            );

                            context.read<YandexDoctorBloc>().add(
                              AddSpecialistMap(
                                specialist: specialist ?? [],
                                context: context,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        state.categories[index].id == selectedState.categoryId
                        ? context.color.mainBlue.withValues(alpha: 0.8)
                        : context.color.white,
                    foregroundColor:
                        state.categories[index].id == selectedState.categoryId
                        ? context.color.white
                        : context.color.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    state.categories[index].name!,
                    style: Styles.postTitle.copyWith(
                      fontFamily: Styles.gilroyMedium,
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }
    return _buildLoadingList();
  }

  ListView _buildLoadingList() {
    return ListView.builder(
      itemCount: 20,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: context.color.baseColor,
          highlightColor: context.color.highlightColor,
          child: Padding(
            padding: EdgeInsets.only(right: 8.w, bottom: 5.h),
            child: Card(
              color: context.color.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: SizedBox(width: 123.w),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpd_client/application/yandex/filter_category/filter_category_bloc.dart';
import 'package:mpd_client/infrastructure/services/yandex_service.dart';
import 'package:mpd_client/presentation/pages/yandex_doctor/doctor_list_page.dart';
import 'package:mpd_client/presentation/router/app_routs.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../application/yandex/popular_categories/popular_categories_bloc.dart';
import '../../../application/yandex/search_by_category/search_by_category_bloc.dart';
import '../../../application/yandex/search_by_specialist/search_by_specialist_bloc.dart';
import '../../../application/yandex/yandex_doctor/yandex_doctor_bloc.dart';
import 'widgets/auto_complete.dart';
import 'widgets/categories.dart';
import 'widgets/current_location.dart';
import 'widgets/doctor_info.dart';
import 'widgets/search_field.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> with AutomaticKeepAliveClientMixin {
  final YandexService _yandexService = YandexService();
  late FToast fToast;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _yandexService.moveCameraPosition(_yandexService.initialPoint, zoom: 5);
    context.read<YandexDoctorBloc>().add(GetCurrentLocationEvent());
    context.read<FilterCategoryBloc>().add(GetFilterCategories(Localizations.localeOf(AppRouts.navigatorKey.currentContext!).languageCode));

    context.read<PopularCategoriesBloc>().add(GetPopularCategoriesEvent(Localizations.localeOf(AppRouts.navigatorKey.currentContext!).languageCode));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DoctorPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // BlocConsumer<UserInfoBloc, UserInfoState>(
          //   listener: (context, state) {
          //     if (state.userLocalInfo != null && state.status.isInitial) {
          //       final yandexState = context.read<YandexDoctorBloc>().state;
          //       if (yandexState.location != null) {
          //         context.read<YandexDoctorBloc>().add(PlaceImagetoLocationEvent(imageMemory: state.userLocalInfo!.image));
          //       }
          //     }
          //   },
          //   builder: (context, userstate) {
          //     return BlocConsumer<YandexDoctorBloc, YandexDoctorState>(
          //       listener: (context, state) {
          //         if (state.location != null) {
          //           _yandexService.moveCameraPosition(state.location!, zoom: state.zoom);
          //         }
          //         // if (userstate.userLocalInfo != null) {
          //         //   if (state.isMoved && state.location != null) {
          //         //     context.read<YandexDoctorBloc>().add(PlaceImagetoLocationEvent(imageMemory: userstate.userLocalInfo!.image));
          //         //   }
          //         // }
          //       },
          //       builder: (context, state) {
          //         return YandexMap(
          //           key: _yandexService.mapKey,
          //           mapObjects: state.mapObjects,
          //           onMapTap: (argument) {
          //             context.read<SearchBySpecialistBloc>().add(CloseSuggessionsEvent());
          //           },
          //           onCameraPositionChanged: (cameraPosition, reason, finished) {
          //             if (finished) {
          //               debugPrint('Placemarks ------------------- ${state.mapObjects.length}');
          //             }
          //           },
          //           onMapCreated: (YandexMapController yandexMapController) {
          //             _yandexService.yandexController.complete(yandexMapController);
          //           },
          //         );
          //       },
          //     );
          //   },
          // ),
         
         
          //? My location part
          BlocSelector<YandexDoctorBloc, YandexDoctorState, bool>(
            selector: (state) => state.showDoctorInfo,
            builder: (context, showDoctorInfo) {
              return CurrentLocation(showDoctorInfo: showDoctorInfo);
            },
          ),
          //? Categories part
          BlocSelector<YandexDoctorBloc, YandexDoctorState, bool>(
            selector: (state) => state.showDoctorInfo,
            builder: (context, showDoctorInfo) {
              return BlocConsumer<PopularCategoriesBloc, PopularCategoriesState>(
                listener: (context, state) {
                  if (state is PopularCategoriesFailure) {}
                },
                builder: (context, state) {
                  return Categories(showDoctorInfo: showDoctorInfo, state: state);
                },
              );
            },
          ),
          //? Doctor Info
          BlocSelector<SearchByCategoryBloc, SearchByCategoryState, String>(
            selector: (state) => state.selectedName,
            builder: (context, selectedName) {
              return BlocBuilder<YandexDoctorBloc, YandexDoctorState>(
                builder: (context, state) {
                  return DoctorInfo(job: selectedName, showDoctorInfo: state.showDoctorInfo, specialist: state.specialist);
                },
              );
            },
          ),
          //? Loading part
          Positioned(
            top: 85.h,
            left: 0,
            right: 0,
            child: SafeArea(child: BlocBuilder<SearchByCategoryBloc, SearchByCategoryState>(
              builder: (context, state) {
                if (state is SearchByCategorySuccess && !state.isLoading) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => DoctorListPage(
                          specialists: state.specialists,
                          title: state.selectedName,
                        ),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 20,
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.l10n.search_doctor_showing}: ${state.specialists.length}',
                            style: AppTheme.headlineMedium.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            state.selectedName,
                            style: AppTheme.headlineSmall.copyWith(
                              fontSize: 14,
                              color: mainBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is SearchByCategoryLoading) {
                  return Shimmer.fromColors(
                    baseColor: black.withOpacity(0.7),
                    highlightColor: white,
                    child: Text(
                      '${context.l10n.search_doctor_loading}...',
                      style: AppTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return const SizedBox();
              },
            )),
          ),
          //? Auto Complete part
          Positioned(
            left: 0,
            right: 0,
            top: 80.h,
            child: SafeArea(
              child: BlocBuilder<SearchBySpecialistBloc, SearchBySpecialistState>(
                builder: (context, state) {
                  if (state is SearchBySpecialistInitial) {
                    return const SizedBox();
                  }
                  return AutoComplete(state: state, oldcontext: context);
                },
              ),
            ),
          ),
          //? Search field part
          Positioned(
            left: 0,
            right: 0,
            top: 12.h,
            child: SearchField(controller: controller),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}







/*
  _searchSpecialist(String pattern) async {
    final result = await locator
        .get<MainRepository>()
        .getSearchedSpecialist(query: pattern);
    List<MapSpecialist>? searchedSpecialist;

    result.fold((l) => null, (r) => searchedSpecialist = r.results!);
    return searchedSpecialist;
  }


 SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 43.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: background,
                      ),
                      child: TypeAheadFormField<MapSpecialist>(
                        animationStart: 0,
                        hideKeyboardOnDrag: true,
                        keepSuggestionsOnLoading: false,
                        hideSuggestionsOnKeyboardHide: false,
                        loadingBuilder: (context) => const Text(
                          'Loading...',
                          textAlign: TextAlign.center,
                        ),
                        debounceDuration: const Duration(milliseconds: 500),
                        animationDuration: const Duration(seconds: 1),
                        textFieldConfiguration: TextFieldConfiguration(
                            textAlignVertical: TextAlignVertical.center,
                            style: Styles.headline7.copyWith(
                                color: mainBlue, fontSize: 16.sp),
                            decoration: InputDecoration(
                              prefixIconConstraints: const BoxConstraints(),
                              isCollapsed: true,
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  AppIcons.search,
                                  height: 20.h,
                                  width: 20.h,
                                  color: grey,
                                ),
                              ),
                              alignLabelWithHint: false,
                              hintText: 'Search your specialist',
                              hintStyle: Styles.cardReview.copyWith(
                                  color: grey, fontSize: 16.sp),
                              enabledBorder: InputBorder.none,
                              focusedBorder: Decorations.focusedBorder,
                            )),
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            elevation: 0,
                            constraints: BoxConstraints(
                                minWidth: 300.w,
                                maxHeight: 350.h,
                                maxWidth: MediaQuery.of(context).size.width),
                            color: white),
                        suggestionsCallback: (pattern) async {
                          return await _searchSpecialist(pattern);
                        },
                        itemBuilder: (context, sone) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Text('${sone.name!} ${sone.lastname!}'),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          final latitude =
                              suggestion.location!.latitude!.toDouble();
                          final longutude =
                              suggestion.location!.longitude!.toDouble();
                          context.read<YandexDoctorBloc>().add(
                              InsertSingleObjectEvent(suggestion.id!,
                                  latitude: latitude, longutude: longutude));
                        },
                      ),
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(8.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Material(
                      color: background,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 44.h,
                          width: 44.h,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/icons/setting-4.svg',
                            color: black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconCircleButton(
                  onPressed: () {
                    context
                        .read<YandexDoctorBloc>()
                        .add(GetCurrentLocationEvent());
                  },
                  icon: AppIcons.send),
              ScreenUtil().setVerticalSpacing(16.h),
              SizedBox(
                height: 47.h,
                child:
                    BlocBuilder<PopularCategoriesBloc, PopularCategoriesState>(
                  builder: (context, state) {
                    return CategoriesComponent(
                        scrollController: ScrollController(),
                        onScrollEnd: () {
                          context
                              .read<PopularCategoriesBloc>()
                              .add(GetPopularCategoriesEvent());
                        },
                        state: state);
                  },
                ),
              ),
              ScreenUtil().setVerticalSpacing(12.h)
            ],
          )


 */
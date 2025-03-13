import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
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

class _DoctorPageState extends State<DoctorPage>
    with AutomaticKeepAliveClientMixin {
  final YandexService _yandexService = YandexService();
  late FToast fToast;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _yandexService.moveCameraPosition(_yandexService.initialPoint, zoom: 5);
    context.read<YandexDoctorBloc>().add(GetCurrentLocationEvent());
    context.read<FilterCategoryBloc>().add(GetFilterCategories(
        Localizations.localeOf(AppRouts.navigatorKey.currentContext!)
            .languageCode));

    context.read<PopularCategoriesBloc>().add(GetPopularCategoriesEvent(
        Localizations.localeOf(AppRouts.navigatorKey.currentContext!)
            .languageCode));
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
          BlocConsumer<AccountsBloc, AccountsState>(
            listener: (context, user) {
              // if (state.userLocalInfo != null && state.status.isInitial) {
              final yandexState = context.read<YandexDoctorBloc>().state;
              if (yandexState.location != null) {
                context.read<YandexDoctorBloc>().add(
                    const PlaceImagetoLocationEvent(
                        imageMemory: null)); //user.userContainer.user.avatar
              }
              // }
            },
            builder: (context, userstate) {
              return BlocConsumer<YandexDoctorBloc, YandexDoctorState>(
                listener: (context, state) {
                  if (state.location != null) {
                    _yandexService.moveCameraPosition(state.location!,
                        zoom: state.zoom);
                  }
                  if (state.isMoved && state.location != null) {
                    context.read<YandexDoctorBloc>().add(
                        const PlaceImagetoLocationEvent(
                            imageMemory:
                                null)); //user.userContainer.user.avatar
                  }
                },
                builder: (context, state) {
                  if (userstate.userContainer.status.isInProgress) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: black,
                    );
                  }
                  return YandexMap(
                    key: _yandexService.mapKey,
                    mapObjects: state.mapObjects,
                    onMapTap: (argument) {
                      context
                          .read<SearchBySpecialistBloc>()
                          .add(CloseSuggessionsEvent());
                    },
                    onCameraPositionChanged:
                        (cameraPosition, reason, finished) {
                      if (finished) {
                        debugPrint(
                            'Placemarks ------------------- ${state.mapObjects.length}');
                      }
                    },
                    onMapCreated: (YandexMapController yandexMapController) {
                      _yandexService.yandexController
                          .complete(yandexMapController);
                    },
                  );
                },
              );
            },
          ),

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
              return BlocConsumer<PopularCategoriesBloc,
                  PopularCategoriesState>(
                listener: (context, state) {
                  if (state is PopularCategoriesFailure) {}
                },
                builder: (context, state) {
                  return Categories(
                      showDoctorInfo: showDoctorInfo, state: state);
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
                  return DoctorInfo(
                      job: selectedName,
                      showDoctorInfo: state.showDoctorInfo,
                      specialist: state.specialist);
                },
              );
            },
          ),
          //? Loading part
          Positioned(
            top: 85.h,
            left: 0,
            right: 0,
            child: SafeArea(
                child: BlocBuilder<SearchByCategoryBloc, SearchByCategoryState>(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
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
                    baseColor: black.withValues(alpha: 0.7),
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
              child:
                  BlocBuilder<SearchBySpecialistBloc, SearchBySpecialistState>(
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

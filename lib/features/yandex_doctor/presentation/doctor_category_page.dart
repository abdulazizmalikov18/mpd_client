import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/debounce.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/service_loading.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/service_pinned_sheet.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/service_success.dart';
import 'package:mpd_client/features/home/domain/blocs/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/features/yandex_doctor/domain/blocs/specialist/specialist_bloc.dart';
import 'package:mpd_client/features/yandex_doctor/presentation/widgets/doctor_card_iteam.dart';
import 'package:mpd_client/features/yandex_doctor/presentation/widgets/search_field.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/error_type_widget.dart';
import 'package:mpd_client/src/widgets/w_shimmer.dart';

class DoctorCategoryPage extends StatefulWidget {
  final TextEditingController controller;
  const DoctorCategoryPage({super.key, required this.controller});

  @override
  State<DoctorCategoryPage> createState() => _DoctorCategoryPageState();
}

class _DoctorCategoryPageState extends State<DoctorCategoryPage> {
  @override
  void initState() {
    context.read<SpecialistBloc>().add(GetSpecialist());
    context.read<SpecialistBloc>().add(GetCategory());
    context.read<ProductSpecalistBloc>().add(GetProductOfferingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Doctors"),
          centerTitle: false,
          elevation: 0,
          iconTheme: IconThemeData(color: context.color.black),
          backgroundColor: context.color.white,
          titleTextStyle: TextStyle(
            color: context.color.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleSpacing: 0,
          toolbarHeight: 56.h,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 64),
            child: Container(
              height: 50.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: context.color.background,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: TabBar(
                padding: const EdgeInsets.all(4),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: context.color.white,
                ),
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text(
                      "Doctors",
                      style: Styles.descSubtitle.copyWith(
                        color: context.color.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Maxsulotlar",
                      style: Styles.descSubtitle
                          .copyWith(color: context.color.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AllDoctorsView(widget: widget),
            const OfferingView(),
          ],
        ),
      ),
    );
  }
}

class AllDoctorsView extends StatelessWidget {
  const AllDoctorsView({
    super.key,
    required this.widget,
  });

  final DoctorCategoryPage widget;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 12.h),
              SearchField(
                controller: widget.controller,
                isMap: false,
                onChanged: (query) {
                  onDebounce(() {
                    context
                        .read<SpecialistBloc>()
                        .add(GetSpecialist(search: query));
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Categories",
                      style: TextStyle(
                        color: context.color.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See All"),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 100.h,
                child: BlocBuilder<SpecialistBloc, SpecialistState>(
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: state.categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          context.read<SpecialistBloc>().add(
                              SelectingCategory(state.categories[index].id!));
                          context.read<SpecialistBloc>().add(
                              GetSpecialistCategory(
                                  state.categories[index].id!));
                        },
                        child: SizedBox(
                          width: 78.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 76.h,
                                width: 76.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(76.h),
                                  color: state.categoryId ==
                                          state.categories[index].id
                                      ? context.color.mainBlue
                                      : context.color.background,
                                ),
                                child: state.categories[index].image != null
                                    ? state.categories[index].image!
                                            .endsWith(".svg")
                                        ? SvgPicture.network(
                                            state.categories[index].image!,
                                          )
                                        : Image.network(
                                            state.categories[index].image!,
                                          )
                                    : const SizedBox(),
                              ),
                              Text(
                                state.categories[index].name ?? "--",
                                style: TextStyle(
                                  color: context.color.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Doctors",
                      style: TextStyle(
                        color: context.color.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See All"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      body: BlocBuilder<SpecialistBloc, SpecialistState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => WShimmer(
                height: 158,
                width: double.infinity,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 12,
            );
          } else if (state.status.isFailure) {
            return Center(
              child: ErrorTypeWidget(
                errorIcon: AppIcons.serverError,
                errorSubtitle: context.l10n.error_internal_server_subtitle,
                errorTitle: context.l10n.error_internal_server_title,
                hasReturnButton: false,
                tryAgainPressed: () {
                  context.read<SpecialistBloc>().add(GetSpecialist());
                },
              ),
            );
          }
          if (state.specialist.isEmpty) {
            return const Center(child: Text("No data found"));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) => DoctorCardIteam(
              specialists: state.specialist[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: state.specialist.length,
          );
        },
      ),
    );
  }
}

class OfferingView extends StatelessWidget {
  const OfferingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const ServicePinnedSheet(specialistId: 0),
      body: BlocBuilder<ProductSpecalistBloc, ProductSpecalistState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            return ServiceSuccess(
              specialistProducts: state.specialistProducts,
              hasMoreToFetch: state.count > state.specialistProducts.length,
              fetchMoreFunction: () {
                context
                    .read<ProductSpecalistBloc>()
                    .add(GetProductOfferingEvent(isMore: true));
              },
              paginatorStatus: state.status,
              localProducts: state.localProducts,
            );
          } else if (state.status.isInProgress) {
            return const ServiceLoading();
          } else if (state.status.isFailure) {
            return Center(
              child: ErrorTypeWidget(
                errorIcon: AppIcons.serverError,
                errorSubtitle: context.l10n.error_internal_server_subtitle,
                errorTitle: context.l10n.error_internal_server_title,
                hasReturnButton: false,
                tryAgainPressed: () {
                  context
                      .read<ProductSpecalistBloc>()
                      .add(GetProductOfferingEvent());
                },
              ),
            );
          }
          return Center(
            child: ErrorTypeWidget(
              tryAgainPressed: () {
                context
                    .read<ProductSpecalistBloc>()
                    .add(GetProductOfferingEvent());
              },
              hasReturnButton: false,
              errorIcon: AppIcons.connectionLostError,
              errorSubtitle: context.l10n.error_connection_lost_subtitle,
              errorTitle: context.l10n.error_connection_lost_title,
            ),
          );
        },
      ),
    );
  }
}

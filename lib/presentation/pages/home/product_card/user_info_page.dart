import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/login_comp.dart';
import 'package:orient_motors/presentation/pages/search/components/result_car_info_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class UserInfoPage extends StatelessWidget {
  final Owner owner;

  const UserInfoPage({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (BuildContext context, CustomColorSet colors,
        FontSet fonts, IconSet icons, GlobalController controller) {
      return Scaffold(
        backgroundColor: colors.white,
        body: SafeArea(
          child: BlocBuilder<CarDetailBloc, CarDetailState>(
            builder: (ctx, state) {
              return ValueListenableBuilder(
                  valueListenable: DBService.listenable(),
                  builder: (ctx, box, child) {
                    final likes = DBService.likesListGlobal(box);
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          toolbarHeight: 100,
                          title: UserInfoComp(
                              onTap: () {}, owner: owner, asAppBar: true),
                          backgroundColor: colors.white,
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          titleSpacing: 0,
                          floating: true,
                          surfaceTintColor: colors.white,
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                                width: double.maxFinite,
                                child: ColoredBox(color: colors.colorF5F5F5),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "other_advertisements".tr(),
                                  style: Style.semiBold14(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverGrid(
                            delegate: state.statusUserCars.isInProgress ||
                                    state.statusUserCars.isInitial
                                ? SliverChildBuilderDelegate(
                                    (context, index) {
                                      return const ShimmerView(
                                        child: Column(
                                          children: [
                                            ShimmerContainer(height: 120),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 8),
                                                  ShimmerContainer(
                                                      height: 18, width: 120),
                                                  SizedBox(height: 8),
                                                  ShimmerContainer(height: 12),
                                                  SizedBox(height: 8),
                                                  ShimmerContainer(
                                                      height: 14, width: 130),
                                                  SizedBox(height: 8),
                                                  ShimmerContainer(
                                                      height: 12, width: 80),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    childCount: 10,
                                  )
                                : SliverChildBuilderDelegate(
                                    (context, index) {
                                      final item = state.userCarsList[index];
                                      return ResultCarInfoMinWidget(
                                        resultsModel: item,
                                        likes: likes,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              AppRoutes.getProductCard(
                                                  model: item));
                                        },
                                      );
                                    },
                                    childCount: state.userCarsList.length,
                                  ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: .68,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
        ),
      );
    });
  }
}

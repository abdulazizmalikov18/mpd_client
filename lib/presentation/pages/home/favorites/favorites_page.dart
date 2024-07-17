import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/infrastructure/apis/apis.dart';
import 'package:orient_motors/infrastructure/repositories/car_repo.dart';
import 'package:orient_motors/infrastructure/repositories/filter_repo.dart';
import 'package:orient_motors/infrastructure/repositories/services_repo.dart';
import 'package:orient_motors/infrastructure/repositories/specifications_repo.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/custom_tabbar_component.dart';
import 'package:orient_motors/presentation/pages/home/favorites/widget/announcement_widget.dart';
import 'package:orient_motors/presentation/pages/home/favorites/widget/viewed_widget.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

import 'widget/recently_search_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key, required this.index});

  final int index;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.index,
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return Scaffold(
            backgroundColor: colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  centerTitle: true,
                  surfaceTintColor: colors.white,
                  title: Text(
                    "favorites".tr(),
                    style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                  ),
                  floating: true,
                  pinned: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50.h),
                    child: CustomTabbarBlack(
                      index: widget.index,
                      leftTab: "ads".tr(),
                      middleTab: "searchs".tr(),
                      rightTab: "viewed".tr(),
                    ),
                  ),
                )
              ],
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const AnnouncementWidget(),
                  BlocProvider(
                    create: (context) => SearchBloc(
                      FilterRepository(
                          context.read<DBService>(), FilterService.create()),
                      CarRepository(context.read<DBService>(),
                          CarService.create(), UploadImage.create(), Dio()),
                      SpecificationsRepository(context.read<DBService>(),
                          SpecificationsService.create()),
                      ServicesRepository(
                          context.read<DBService>(), ServicesService.create()),
                    )..add(const SearchEvent.getSearchesList()),
                    child: const RecentlySearchWidget(),
                  ),
                  const ViewedWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

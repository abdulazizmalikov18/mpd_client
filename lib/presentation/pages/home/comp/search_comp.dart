import 'package:dio/dio.dart';
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
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SearchComp extends StatelessWidget {
  const SearchComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(
            FilterRepository(context.read<DBService>(), FilterService.create()),
            CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
            SpecificationsRepository(
              context.read<DBService>(),
              SpecificationsService.create(),
            ),
            ServicesRepository(
              context.read<DBService>(),
              ServicesService.create(),
            ),
          )
            ..add(const SearchEvent.getTotalCars())
            ..add(const SearchEvent.getChangedPartsQualityList())
            ..add(const SearchEvent.getOptionsList()),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return AnimationButtonEffect(
                onTap: () {
                  Navigator.push(context, AppRoutes.getSearch(count: state.totalCarsRes?.countOfCars ?? 2500)).then((value) {
                    context.read<BottomNavBarController>().changeNavBar(false);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: colors.grey.withOpacity(.2),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                          child: icons.search.svg(height: 24.h, color: colors.grey1),
                        ),
                      ),
                      8.w.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Поиск авто",
                            style: Style.semiBold16(size: 16.sp),
                          ),
                          Text(
                            "Поиск авто по марке и модели",
                            style: Style.semiBold14(size: 12.sp, color: colors.grey1),
                          ),
                        ],
                      ),
                      const Spacer(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.greySecondary,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child:  SizedBox(width: 2.w, height: 32.h),
                      ),
                      12.h.horizontalSpace,
                      icons.filterIc.svg(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:hive/hive.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/pages/search/components/filtered_search_shimmer_list.dart';
import 'package:orient_motors/presentation/pages/search/components/result_car_info_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({super.key});

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  late bool isEmpty;

  @override
  void initState() {
    isEmpty = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.statusSeenList.isInitial ||
                  state.statusSeenList.isInProgress
              ? const FilteredSearchSimmerList()
              : ValueListenableBuilder(
                  valueListenable: DBService.listenable(),
                  builder: (context, box, child) {
                    return DBService.seenListGlobal(box).isNotEmpty
                        ? _favList(colors, icons, fonts,
                            DBService.likesListGlobal(box), box)
                        : _empty(icons);
                  },
                );
        },
      );
    });
  }

  Widget _favList(CustomColorSet colors, IconSet icons, FontSet fonts,
      List<CarModel> likes, Box? box) {
    final items = DBService.seenListGlobal(box);
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(
          20.w, 16.h, 20.w, MediaQuery.of(context).padding.bottom + 56.h),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return ResultCarInfoWidget(
          onTap: () {
            Navigator.push(context, AppRoutes.getProductCard(model: item)).then(
              (value) => Future.delayed(
                  Duration.zero,
                  () => context
                      .read<BottomNavBarController>()
                      .changeNavBar(false)),
            );
          },
          resultsModel: item,
          likes: likes,
        );
      },
      separatorBuilder: (BuildContext context, int index) => 20.verticalSpace,
    );
  }

  Widget _empty(IconSet icons) {
    return Column(
      children: [
        24.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Image.asset(icons.viewedImage),
        ),
        ContentComp(
          spacing: 0,
          title: "viewed".tr(),
          subTitle:
              "here_you_can_save_the_ads_you_like_so_you_can_quickly_access_them_at_any_time"
                  .tr(),
        )
      ],
    );
  }
}

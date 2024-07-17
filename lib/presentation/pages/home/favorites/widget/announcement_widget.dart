import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
import 'package:orient_motors/presentation/pages/search/components/result_car_info_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.statusLikedList.isInitial ||
                    state.statusLikedList.isInProgress
                ? _empty(icons)
                : ValueListenableBuilder(
                    valueListenable: DBService.listenable(),
                    builder: (context, box, child) {
                      return DBService.likesListGlobal(box).isNotEmpty
                          ? _favList(colors, icons, fonts,
                              DBService.likesListGlobal(box), box)
                          : _empty(icons);
                    },
                  );
          },
        );
      },
    );
  }

  Widget _favList(CustomColorSet colors, IconSet icons, FontSet fonts,
      List<CarModel> items, Box? box) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 86),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return ResultCarInfoWidget(
          onTap: () {
            Navigator.push(context, AppRoutes.getProductCard(model: item))
                .then((value) => Future.delayed(Duration.zero, () {
                      context
                          .read<BottomNavBarController>()
                          .changeNavBar(false);
                    }));
          },
          resultsModel: item,
          isLikePage: true,
          likes: DBService.likesListGlobal(box),
        );
      },
      separatorBuilder: (BuildContext context, int index) => 20.verticalSpace,
    );
  }

  Widget _empty(IconSet icons) {
    return Column(
      children: [
        44.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0.w),
          child: Image.asset(icons.favImage),
        ),
        ContentComp(
            spacing: 0,
            title: "ads".tr(),
            subTitle: "here_you_can_save_the_ads_you_like".tr())
      ],
    );
  }
}

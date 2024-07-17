import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/home/home.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/home_service_grid_comp.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class HomeItemsComp extends StatefulWidget {
  const HomeItemsComp({super.key});

  @override
  State<HomeItemsComp> createState() => _HomeItemsCompState();
}

class _HomeItemsCompState extends State<HomeItemsComp> {
  List<HomeItemEntity> params(IconSet icons) => [
        HomeItemEntity(icon: icons.judge, title: "Аукцион", subtitle: "Получайте лучшие предложения"),
        HomeItemEntity(icon: icons.calculator, title: "Оценка авто", subtitle: "Рыночная стоимость машины"),
        HomeItemEntity(icon: icons.carIc, title: "Мой гараж", subtitle: "Вся информация о вашем авто"),
        HomeItemEntity(icon: icons.percentage, title: "Автокредит", subtitle: "Кредитование автопокупок"),
        HomeItemEntity(icon: icons.wrech, title: "Запчасти", subtitle: "Поиск и покупка запчастей"),
        HomeItemEntity(icon: icons.grid, title: "Все сервисы", subtitle: "Больше функций и сервисов"),
      ];

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return GridView.builder(
          itemCount: params(icons).length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.98,
          ),
          itemBuilder: (context, index) {
            final param = params(icons)[index];
            return HomeServiceGridComp(param: param, isBordered: index == params(icons).length - 1);
          },
        );
      },
    );
  }
}

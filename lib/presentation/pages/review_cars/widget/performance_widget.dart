// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
// import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
// import 'package:orient_motors/presentation/pages/review_cars/comp/content_comp.dart';
// import 'package:orient_motors/presentation/pages/review_cars/comp/image_part_comp.dart';
// import 'package:orient_motors/presentation/pages/review_cars/comp/share_button_comp.dart';
// import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
// import 'package:orient_motors/presentation/styles/style.dart';
// import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

// class PerformanceWidget extends StatefulWidget {
//   const PerformanceWidget({super.key});

//   @override
//   State<PerformanceWidget> createState() => _PerformanceWidgetState();
// }

// class _PerformanceWidgetState extends State<PerformanceWidget> with TickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ThemeWrapper(
//       builder: (context, colors, fonts, icons, controller) {
//         return SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               16.verticalSpace,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: StarsComp(
//                   starCount: model?.ratedByOrientMotors ?? 0,
//                   title: "design".tr(),
//                 ),
//               ),
//               TabBar.secondary(
//                   onTap: (index) {
//                     _tabController.animateTo(index);
//                     _tabController.index = index;
//                     setState(() {});
//                   },
//                   indicatorWeight: 1,
//                   controller: _tabController,
//                   indicatorColor: _tabController.index == 0 ? colors.primary : colors.black,
//                   tabs: [
//                     Tab(
//                         child: Text(
//                       'advantages'.tr(),
//                       textAlign: TextAlign.center,
//                       style: Style.medium14(color: _tabController.index == 0 ? colors.primary : colors.primary.withOpacity(0.5)),
//                     )),
//                     Tab(
//                         child: Text(
//                       'flaws'.tr(),
//                       textAlign: TextAlign.center,
//                       style: Style.medium14(color: _tabController.index == 1 ? colors.black : colors.black.withOpacity(0.5)),
//                     )),
//                   ]),
//               SizedBox(
//                 height: 160.h,
//                 child: TabBarView(
//                   controller: _tabController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: <Widget>[
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _starPart(title: "economy".tr(), icon: icons.starBlack1),
//                         Container(
//                           height: 60.h,
//                           width: 1.w,
//                           color: colors.customGreyC3,
//                         ),
//                         _starPart(title: "continuously_variable_transmission".tr(), icon: icons.starBlack1),
//                       ],
//                     ),
//                     _starPart(title: "silence".tr(), icon: icons.starBlack0),
//                   ],
//                 ),
//               ),

//               ///
//               ColoredBox(
//                 color: colors.white,
//                 child: const ShareButtonComp(),
//               ),
//               16.verticalSpace,
//               ContentComp(
//                   title: "direct_driving".tr(),
//                   subTitle:
//                       "«Хорошо созревший Smartstream G1.6» Есть два силовых агрегата, бензиновый и LPi. Будущие турбо и гибриды также выстраиваются в очередь. Большую часть продаж составляют бензиновые модели Smart Stream. Он может похвастаться хорошей эффективностью, расходуя 15,4 км на литре. Вместо этого вывод по спецификациям был скорее регрессирован. Максимальная мощность составляет 123 лошадиные силы, а максимальный крутящий момент всего 15,7 кгс·м. С точки зрения цифр, он находится на том же уровне, что и Avante HD. Здесь была установлена ​​​​бесступенчатая трансмиссия под названием IVT, чтобы сломать ожидание работы. Кажется, это подразумевает, что «если вы собираетесь бежать, купите линию N, которая выйдет в будущем» как фигуру."),
//               ContentComp(
//                   title: "curved_driving".tr(),
//                   subTitle:
//                       "«Высокоуровневая настройка нижней части кузова. Комфорт при езде на низких скоростях разочаровывает» В новом Avante применяется платформа 3-го поколения. Это платформа нового поколения, которая снижает центр тяжести и оптимизирует положение нижней части тела. Оно отличается от первого впечатления. Когда вы садитесь на водительское сиденье, опущенное сиденье впечатляет. Производительность упражнений на наклонах также значительно улучшилась. Чон Сан Хён, главный редактор журнала Enka Magazine, похвалил его, сказав: «Я равномерно использую сцепление на всех четырех колесах». Особенно при обходе изогнутого угла движения тела не слишком раздуты. Переживать не о чем, ведь заднее колесо цепко держится за дорогу. Преимущество новой модели в том, что каждый может получить удовольствие от вождения, если скорость хорошо контролируется. Несмотря на то, что двигатель слабоват, он показывает хорошее движение в поворотах."),
//               16.verticalSpace,
//               const ReviewCarsComp(),
//               const PolicyComp(),
//               36.verticalSpace,
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _starPart({required String title, required String icon}) {
//     return Expanded(
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [Text(title, textAlign: TextAlign.center, style: Style.medium14()), 8.verticalSpace, SvgPicture.asset(icon)]),
//     );
//   }
// }

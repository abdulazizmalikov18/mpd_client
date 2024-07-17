import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/specification_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/comments_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/design_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/link_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/review_price_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/size_widget.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/grade_widget.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:provider/provider.dart';
import 'comp/car_review_types.dart';

class ReviewCarDetailPage extends StatefulWidget {
  final ReviewListModel item;
  final ReviewController vmController;
  const ReviewCarDetailPage(
      {super.key, required this.item, required this.vmController});

  @override
  State<ReviewCarDetailPage> createState() => _ReviewCarDetailPageState();
}

class _ReviewCarDetailPageState extends State<ReviewCarDetailPage>
    with SingleTickerProviderStateMixin {
  late ScrollController scrollController;

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    tabController =
        TabController(length: CarReviewTypes.values.length, vsync: this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carModel = widget.item.carModel;
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        body: SafeArea(
          child: NotificationListener(
            onNotification: (t) {
              final ScrollDirection direction =
                  scrollController.position.userScrollDirection;

              if (direction == ScrollDirection.forward) {
                Future.delayed(Duration.zero, () {
                  context.read<BottomNavBarController>().changeNavBar(false);
                });
              } else if (direction == ScrollDirection.reverse) {
                Future.delayed(Duration.zero, () {
                  context.read<BottomNavBarController>().changeNavBar(true);
                });
              }
              return true;
            },
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    title: AppBarComponent(
                      title: "${carModel?.brand?.name} ${carModel?.name}",
                      color: colors.white,
                      isBorder: true,
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight - 24),
                      child: _buildTabBar(colors),
                    ),
                    centerTitle: false,
                    surfaceTintColor: colors.white,
                  ),
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: _buildListView(),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTabBar(CustomColorSet colors) {
    return TabBar(
      controller: tabController,
      tabAlignment: TabAlignment.start,
      tabs: CarReviewTypes.values.map((e) => Tab(text: e.name.tr())).toList(),
      isScrollable: true,
      padding: EdgeInsets.zero,
      labelColor: colors.customRed,
      indicatorColor: colors.customRed,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  List<Widget> _buildListView() {
    return [
      GradeWidget(
          vmController: widget.vmController, tabController: tabController),
      const DesignWidget(),
      const SizeWidget(),
      const SpecificationWidget(),
      const ReviewPriceWidget(),
      const LinkWidget(),
      CommentsWidget(vmController: widget.vmController),
    ];
  }
}

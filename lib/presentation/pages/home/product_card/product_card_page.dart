import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/login_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/app_bar.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/contact_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/description_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/info_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/price_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/recommended_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/record_book_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/see_review_comp.dart';
import 'package:orient_motors/presentation/pages/home/product_card/comp/short_info_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/gallery_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ProductCardPage extends StatefulWidget {
  final CarModel model;
  const ProductCardPage({super.key, required this.model});

  @override
  State<ProductCardPage> createState() => _ProductCardPageState();
}

class _ProductCardPageState extends State<ProductCardPage> {
  late ScrollController scrollController;
  late bool isTop;
  late bool toTop;

  @override
  void initState() {
    isTop = true;
    toTop = true;
    final dbService = context.read<DBService>();
    if (!dbService.seenList.map((e) => e.id).contains(widget.model.id)) {
      dbService.addSeen(widget.model);
      context
          .read<ProfileBloc>()
          .add(ProfileEvent.patchSeen(id: widget.model.id ?? 0));
    }

    scrollController = ScrollController();
    Future.delayed(Duration.zero, () {
      context.read<BottomNavBarController>().changeNavBar(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return BlocConsumer<CarDetailBloc, CarDetailState>(
            listener: (BuildContext context, CarDetailState state) {
              debugPrint('WORKING!!!');

              context.read<ReviewBloc>().add(ReviewEvent.getId(
                      model: ReviewFilterReq(
                    (b) => b
                      ..mark = state.carDetailRes?.brand?.id
                      ..model = state.carDetailRes?.carModel?.id
                      ..generation = state.carDetailRes?.generation?.id,
                  )));
            },
            listenWhen: (previous, current) =>
                previous.carDetailRes != current.carDetailRes &&
                current.carDetailRes != null,
            builder: (context, state) {
              return Scaffold(
                backgroundColor: colors.white,
                body: SafeArea(
                  bottom: false,
                  child: NotificationListener(
                    onNotification: (t) {
                      if (scrollController.position.pixels > 450) {
                        if (isTop) {
                          setState(() {});
                          isTop = false;
                        }
                      } else {
                        if (!isTop) {
                          setState(() {});
                          isTop = true;
                        }
                        if (!toTop) {
                          setState(() {});
                          toTop = true;
                        }
                      }

                      final ScrollDirection direction =
                          scrollController.position.userScrollDirection;

                      if (direction == ScrollDirection.reverse) {
                        if (toTop) {
                          setState(() {
                            toTop = false;
                          });
                        }
                      } else if (direction == ScrollDirection.forward) {
                        if (!toTop) {
                          setState(() {
                            toTop = true;
                          });
                        }
                      }

                      return true;
                    },
                    child: CustomScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              48.verticalSpace,
                              GalleryComp(
                                bottomGap: 0,
                                images: state.carDetailRes?.photos?.toList(),
                                onTap: () {
                                  List<ImagesModel> images =
                                      state.carDetailRes?.photos?.toList() ??
                                          [];
                                  if (images.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        AppRoutes.getGalleryDetail(
                                            images: images));
                                  }
                                },
                              ),
                              const ShortInfoComp(),
                              const InfoComp(),
                              Divider(
                                color: colors.backgroundScaffold,
                                thickness: 8.h,
                              ),
                              16.verticalSpace,
                              const RecordBookComp(),
                              16.verticalSpace,
                              Divider(
                                color: colors.backgroundScaffold,
                                thickness: 8.h,
                              ),
                              const DescriptionComp(),
                              16.verticalSpace,
                              Divider(
                                color: colors.backgroundScaffold,
                                thickness: 8.h,
                              ),
                              const PriceComp(),
                              Divider(
                                color: colors.backgroundScaffold,
                                thickness: 8.h,
                              ),
                              16.verticalSpace,
                              const SeeReviewComp(),
                              16.verticalSpace,
                              Divider(
                                  color: colors.backgroundScaffold,
                                  thickness: 8.h),
                              state.carDetailRes?.owner == null
                                  ? const UserInfoCompShimmer()
                                  : UserInfoComp(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          AppRoutes.getUserInfo(
                                            owner: state.carDetailRes?.owner ??
                                                Owner(),
                                            context: context,
                                          ),
                                        ).then((value) {
                                          context
                                              .read<BottomNavBarController>()
                                              .changeNavBar(true);
                                        });
                                      },
                                      owner:
                                          state.carDetailRes?.owner ?? Owner(),
                                    ),
                              Divider(
                                  color: colors.backgroundScaffold,
                                  thickness: 8.h),
                              RecommendedComp(
                                  hideNavBar: true,
                                  genId:
                                      state.carDetailRes?.generation?.id ?? -1),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).padding.bottom +
                                          16.h)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                floatingActionButton: SizedBox(
                  height: 1.sh - MediaQuery.of(context).padding.top + 400.h,
                  child: Column(
                    children: [
                      ProductDetailAppBar(
                        data: state.carDetailRes,
                        isTop: isTop,
                        toTop: toTop,
                        model: widget.model,
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 160.h + MediaQuery.of(context).padding.bottom,
                        width: 1.sw,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              top: toTop ? 0 : 160.h,
                              duration: const Duration(milliseconds: 240),
                              child: SizedBox(
                                height: 120.h,
                                width: 1.sw,
                                child: ContactComp(
                                  function: () {
                                    scrollController.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.bounceIn);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniCenterTop,
              );
            },
          );
        },
      ),
    );
  }
}

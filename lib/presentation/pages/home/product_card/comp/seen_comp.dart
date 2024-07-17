import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SeenComp extends StatefulWidget {
  final bool hideNavBar;
  const SeenComp({super.key, required this.hideNavBar});

  @override
  State<SeenComp> createState() => _SeenCompState();
}

class _SeenCompState extends State<SeenComp> {
  bool liked = true;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ColoredBox(
          color: colors.white,
          child: ValueListenableBuilder(
            valueListenable: DBService.listenable(),
            builder: (context, box, child) {
              return DBService.seenListGlobal(box).isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'last_viewed_cars'.tr(),
                            style: Style.semiBold16(size: 20.sp),
                          ),
                        ),
                        _lastSeenList(colors, icons, controller),
                      ],
                    )
                  : const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }

  Widget _lastSeenList(
    CustomColorSet colors,
    IconSet icons,
    GlobalController controller,
  ) {
    return SizedBox(
      height: 180.h,
      width: 1.sw,
      child: ValueListenableBuilder(
        valueListenable: DBService.listenable(),
        builder: (context, box, child) {
          final likes = DBService.likesListGlobal(box);
          final seen = DBService.seenListGlobal(box);
          return ListView.builder(
            itemCount: seen.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              bool isFav() => likes.map((e) => e.id).contains(seen[index].id);
              final item = seen[index];
              return AnimationButtonEffect(
                onTap: () {
                  Navigator.push(
                      context,
                      AppRoutes.getProductCard(
                        model: item,
                      )).then((value) {
                    context
                        .read<BottomNavBarController>()
                        .changeNavBar(widget.hideNavBar);
                  });
                },
                child: Container(
                  width: 164.w,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16.0.w : 8.w,
                    right: index == 14 ? 16.0.w : 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// image
                      Container(
                        height: 90.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        alignment: Alignment.topRight,
                        child: Stack(
                          children: [
                            CachedImageComponent(
                              fit: BoxFit.cover,
                              height: 90.h,
                              borderRadius: 10.r,
                              width: double.infinity,
                              imageUrl: (item.photos?.isEmpty ?? false)
                                  ? ""
                                  : item.photos?.first.url ?? "",
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: AnimationButtonEffect(
                                onTap: () {
                                  context.read<ProfileBloc>().add(
                                      ProfileEvent.patchLike(id: item.id ?? 0));
                                  final dbService = context.read<DBService>();

                                  if (!isFav()) {
                                    dbService.addLike(item);
                                  } else {
                                    dbService.removeLike(item);
                                  }

                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  margin: EdgeInsets.all(8.sp),
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    color: colors.text,
                                  ),
                                  child: likes
                                          .map((e) => e.id)
                                          .contains(item.id)
                                      ? icons.favoriteFill
                                          .svg(color: colors.white, height: 16)
                                      : icons.favorite
                                          .svg(color: colors.white, height: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          12.verticalSpace,
                          Text(
                            "${item.brand?.name ?? ''} ${item.carModel?.name ?? ''}",
                            style: Style.medium16(size: 12.sp),
                          ),
                          4.verticalSpace,
                          Opacity(
                            opacity: 0.5,
                            child: IntrinsicHeight(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      "${item.year ?? ''}${"y".tr()}",
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                    VerticalDivider(color: colors.text),
                                    Text(
                                      "${item.mileage ?? ''}${"km".tr()}",
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                    VerticalDivider(color: colors.text),
                                    Text(
                                      item.fuelType?.name ?? '',
                                      style: Style.medium14(size: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            item.price?.toFormattedCurrency(
                                    dbService: context.read<DBService>(),
                                    currencyS: item.currency) ??
                                "",
                            style: Style.bold16(size: 14.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/extensions/extension.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:provider/provider.dart';

class ProductDetailAppBar extends StatelessWidget {
  final CarModel? data;
  final CarModel? model;
  final bool isTop;
  final bool toTop;

  const ProductDetailAppBar(
      {super.key,
      this.data,
      required this.isTop,
      required this.toTop,
      this.model});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: toTop ? 48.h : 0,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            color: colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(icons.back, height: 18),
                ),
                Row(
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      return ValueListenableBuilder(
                          valueListenable: DBService.listenable(),
                          builder: (ctx, box, child) {
                            late bool liked;
                            final likes = DBService.likesListGlobal(box);
                            liked = likes.map((e) => e.id).contains(model?.id);
                            return IconButton(
                              onPressed: () {
                                liked = !liked;
                                context.read<ProfileBloc>().add(
                                    ProfileEvent.patchLike(id: data?.id ?? 0));

                                final dbService = context.read<DBService>();
                                if (model != null) {
                                  if (liked) {
                                    dbService.addLike(model!);
                                  } else {
                                    dbService.removeLike(model!);
                                  }
                                }

                                setState(() {});
                              },
                              icon: liked
                                  ? icons.favoriteFill
                                      .svg(color: colors.customRed)
                                  : icons.favorite.svg(),
                            );
                          });
                    }),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          icons.shareBlack,
                          height: 18.h,
                          width: 18.w,
                        )),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: colors.transparent,
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet(
                                  model: model,
                                  data: data,
                                );
                              });
                        },
                        icon: SvgPicture.asset(
                          icons.horizontalDots,
                          height: 8.h,
                          width: 8.w,
                        )),
                    8.h.horizontalSpace
                  ],
                ),
              ],
            ),
          ),
          if (data != null)
            AnimatedContainer(
                height: data != null && !isTop ? 64.h : 0,
                decoration: BoxDecoration(
                    color: colors.white, boxShadow: const [Style.bottomShadow]),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                duration: const Duration(milliseconds: 200),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.h.verticalSpace,
                      Opacity(
                        opacity: 0.5,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                // '2023г',
                                "${data!.year?.toString() ?? "${DateTime.now().year}"}${"y".tr()}",
                                style: fonts.subtitle1,
                              ),
                              VerticalDivider(
                                  color: colors.text,
                                  indent: 4.h,
                                  endIndent: 4.h),
                              Text(
                                // '0км',
                                "${data!.mileage?.toString() ?? "0"}${"km".tr()}",
                                style: fonts.subtitle1,
                              ),
                              VerticalDivider(
                                  color: colors.text,
                                  indent: 4.h,
                                  endIndent: 4.h),
                              Text(
                                data!.fuelType?.name ?? '',
                                style: fonts.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      8.h.verticalSpace,
                      Text(
                        "${data!.price?.toFormattedCurrency(dbService: context.read<DBService>(), currencyS: data!.currency) ?? 0}",
                        style: fonts.subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      16.h.verticalSpace
                    ],
                  ),
                ))
        ],
      );
    });
  }
}

class ModalBottomSheet extends StatefulWidget {
  final CarModel? data;
  final CarModel? model;

  const ModalBottomSheet({super.key, this.data, this.model});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  late bool liked;

  @override
  void initState() {
    liked = context
        .read<DBService>()
        .likesList
        .map((e) => e.id)
        .contains(widget.model?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimationButtonEffect(
                      onTap: () {
                        liked = !liked;
                        context.read<ProfileBloc>().add(
                            ProfileEvent.patchLike(id: widget.data?.id ?? 0));

                        final dbService = context.read<DBService>();
                        if (widget.model != null) {
                          if (liked) {
                            dbService.addLike(widget.model!);
                          } else {
                            dbService.removeLike(widget.model!);
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                        child: Text(
                          liked
                              ? 'remove_from_favorites'.tr()
                              : 'add_to_favorites'.tr(),
                          style: Style.medium14(size: 18.sp),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: colors.customGreyC3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      child: Text(
                        'share'.tr(),
                        style: Style.medium14(size: 18.sp),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: colors.customGreyC3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      child: Text(
                        'copy_link'.tr(),
                        style: Style.medium14(size: 18.sp),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: colors.customGreyC3,
                    ),
                    AnimationButtonEffect(
                      onTap: () {
                        Navigator.pushReplacement(
                            context, AppRoutes.getComplaint());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                        child: Text(
                          'complain'.tr(),
                          style: Style.medium14(
                              size: 18.sp, color: colors.primary),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AnimationButtonEffect(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    color: colors.text,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Center(
                    child: Text(
                      'cancel'.tr(),
                      style: Style.medium20(size: 18.sp, color: colors.white),
                    ),
                  ),
                ),
              ),
            ),
            16.verticalSpace
          ],
        ),
      );
    });
  }
}

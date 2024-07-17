import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({super.key});

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'photography'.tr(),
                  textAlign: TextAlign.center,
                  style: fonts.subtitle2.copyWith(fontSize: 20.sp),
                ),
                8.verticalSpace,
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'the_first_photo_will_cover_ad'.tr(),
                    style: Style.medium14(),
                  ),
                ),
                16.verticalSpace,
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 8.w, mainAxisSpacing: 8.w, childAspectRatio: 16 / 9),
                    itemCount: imageTypes.length,
                    itemBuilder: (context, index) {
                      if (imageTypes[index] == imageTypes.last) {
                        List? list = state.pickedImagePath[imageTypes[index]] as List?;
                        int realIndex = index - imageTypes.indexOf(imageTypes.last);
                        if (list != null && list.length > realIndex) {
                          return _ImageWidget(
                            data: list[realIndex],
                            colors: colors,
                            onDelete: () {
                              BlocProvider.of<AddCarBloc>(context).add(AddCarEvent.removeImage(index: realIndex, type: imageTypes[index]));
                            },
                          );
                        } else if ((list?.length ?? 0) == realIndex) {
                          return _AddImageWidget(
                            colors: colors,
                            fonts: fonts,
                            index: index,
                            onTap: () {
                              context.read<AddCarBloc>().add(AddCarEvent.pickImage(context: context, type: imageTypes[index]));
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      } else {
                        if (state.pickedImagePath.containsKey(imageTypes[index])) {
                          return _ImageWidget(
                            data: state.pickedImagePath[imageTypes[index]],
                            colors: colors,
                            onDelete: () {
                              BlocProvider.of<AddCarBloc>(context).add(AddCarEvent.removeImage(index: index, type: imageTypes[index]));
                            },
                          );
                        }
                        return _AddImageWidget(
                          colors: colors,
                          fonts: fonts,
                          index: index,
                          onTap: () {
                            context.read<AddCarBloc>().add(AddCarEvent.pickImage(context: context, type: imageTypes[index]));
                          },
                        );
                      }
                    }),
                (32.h * (state.pickedImagePath["general.length"] ?? 0) / 3).verticalSpace,
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CustomButton(
              onPressed: () {
                context.read<AddCarBloc>().add(
                    AddCarEvent.setFilterValue(createCarReq: state.createCarReq ?? CreateCarReq(), filterType: FilterType.description));
              },
              backgroundColor: colors.primary,
              title: "continue".tr(),
            ),
          ),
        );
      });
    });
  }
}

class _AddImageWidget extends StatelessWidget {
  final int index;
  final CustomColorSet colors;
  final FontSet fonts;
  final VoidCallback onTap;

  const _AddImageWidget({required this.index, required this.colors, required this.fonts, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: colors.text.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              icons.plus.svg(color: colors.customGreyC3),
              Text(
                imageTypes[index].tr(),
                style: fonts.caption.copyWith(color: colors.customGreyC3),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final dynamic data;
  final CustomColorSet colors;
  final Function onDelete;

  const _ImageWidget({
    required this.data,
    required this.colors,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Stack(
          children: [
            if (data is String)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: FileImage(File(data)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (data is ImagesModel)
              CachedImageComponent(
                borderRadius: 8.r,
                height: double.infinity,
                width: double.infinity,
                imageUrl: (data as ImagesModel).url ?? "",
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimationButtonEffect(
                onTap: () {
                  onDelete();
                },
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  padding: const EdgeInsets.all(6),
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(color: colors.customGreyC3, shape: BoxShape.circle),
                  child: icons.delete.svg(color: colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

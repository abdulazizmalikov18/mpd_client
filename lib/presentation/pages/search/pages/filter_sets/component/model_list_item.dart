import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ModelListItem extends StatelessWidget {
  const ModelListItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.fonts,
      required this.colors,
      required this.count,
      this.isSelected = false,
      this.imageUrl,
      this.disabled = false});

  final String title;
  final String count;
  final VoidCallback onTap;
  final FontSet fonts;
  final CustomColorSet colors;
  final bool isSelected;
  final String? imageUrl;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          onTap: onTap,
          leading: imageUrl != null
              ? Padding(
                  padding: const EdgeInsets.all(2),
                  child: CachedImageComponent(
                    height: 40.w,
                    width: 40.w,
                    imageUrl: imageUrl!,
                  ),
                )
              : null,
          title: Text(
            title,
            style: fonts.subtitle1.copyWith(fontSize: 16.sp),
          ),
          trailing: isSelected
              ? icons.check.svg(
                  color: colors.primary,
                  height: 14,
                )
              : Text(
                  count,
                  style: fonts.subtitle1.copyWith(
                      fontSize: 14.sp,
                      color: colors.customBlack.withOpacity(0.5)),
                ),
        );
      },
    );
  }
}

class ModelListItemYear extends StatelessWidget {
  const ModelListItemYear({
    super.key,
    required this.title,
    required this.onTap,
    required this.fonts,
    required this.colors,
    required this.count,
    required this.model,
    this.selectedYear,
  });

  final String title;
  final String count;
  final Function(int value) onTap;
  final FontSet fonts;
  final CustomColorSet colors;
  final int? selectedYear;
  final GenerationModel model;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(
                height: 4,
                thickness: 1,
                color: colors.customGreyC3,
              ),
            );
          },
          itemCount: ((model.yearStop ?? DateTime.now().year) -
              (model.yearStart ?? 1999) +
              1),
          itemBuilder: (context, index) {
            int currentYear = (model.yearStop ?? DateTime.now().year) - index;
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              onTap: () {
                onTap(currentYear);
              },
              title: Text(
                "$currentYear",
                style: fonts.subtitle1.copyWith(fontSize: 16.sp),
              ),
              trailing: selectedYear == currentYear
                  ? icons.check.svg(
                      color: colors.primary,
                      height: 24.w,
                    )
                  : Text(
                      count,
                      style: fonts.subtitle1.copyWith(
                          fontSize: 14.sp,
                          color: colors.customBlack.withOpacity(0.5)),
                    ),
            );
          },
        );
      },
    );
  }
}

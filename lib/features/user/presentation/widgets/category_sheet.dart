import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';

class CategorySheet extends StatefulWidget {
  const CategorySheet({
    super.key,
    required this.specialistCategory,
    this.selection,
    required this.onPress,
  });
  final List<SpecialistCategoryModel> specialistCategory;
  final SpecialistCategoryModel? selection;
  final Function(SpecialistCategoryModel value) onPress;

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      children: [
        ScreenUtil().setVerticalSpacing(32.h),
        Center(
          child: Text(
            context.l10n.register_profession_title,
            textAlign: TextAlign.center,
            style: Styles.boldTitle.copyWith(
              color: context.color.black,
              fontSize: 24.sp,
              fontFamily: Styles.gilroyMedium,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(24.h),
        Expanded(
          child: ListView.builder(
            itemCount: widget.specialistCategory.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                widget.onPress(widget.specialistCategory[index]);
                Navigator.pop(context);
              },
              title: Text(widget.specialistCategory[index].name),
              trailing: (widget.selection?.id ?? 0) ==
                      widget.specialistCategory[index].id
                  ? AppIcons.tickCircle.svg()
                  : AppIcons.tickCircleOff.svg(),
            ),
          ),
        ),
      ],
    );
  }
}

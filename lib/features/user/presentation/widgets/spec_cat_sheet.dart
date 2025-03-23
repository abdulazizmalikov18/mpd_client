import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';

class SpecCatSheet extends StatefulWidget {
  const SpecCatSheet({
    super.key,
    required this.specialistCat,
    required this.onPress,
    required this.selection,
  });
  final List<SpecialistCatModel> specialistCat;
  final SpecialistCatModel? selection;
  final Function(SpecialistCatModel value) onPress;

  @override
  State<SpecCatSheet> createState() => _SpecCatSheetState();
}

class _SpecCatSheetState extends State<SpecCatSheet> {
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
            itemCount: widget.specialistCat.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                widget.onPress(widget.specialistCat[index]);
                Navigator.pop(context);
              },
              title: Text(
                "${widget.specialistCat[index].name}/${widget.specialistCat[index].specialistCount}",
              ),
              trailing:
                  (widget.selection?.id ?? 0) == widget.specialistCat[index].id
                      ? AppIcons.tickCircle.svg()
                      : AppIcons.tickCircleOff.svg(),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/user/data/models/specialist_position_model.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';

class PositionSheet extends StatefulWidget {
  const PositionSheet({
    super.key,
    required this.specialistPosition,
    this.selection,
    required this.onPress,
  });
  final List<SpecialistPositionModel> specialistPosition;
  final SpecialistPositionModel? selection;
  final Function(SpecialistPositionModel value) onPress;

  @override
  State<PositionSheet> createState() => _PositionSheetState();
}

class _PositionSheetState extends State<PositionSheet> {
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
            itemCount: widget.specialistPosition.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                widget.onPress(widget.specialistPosition[index]);
                Navigator.pop(context);
              },
              title: Text(widget.specialistPosition[index].name),
              trailing: (widget.selection?.id ?? 0) ==
                      widget.specialistPosition[index].id
                  ? AppIcons.tickCircle.svg()
                  : AppIcons.tickCircleOff.svg(),
            ),
          ),
        ),
      ],
    );
  }
}

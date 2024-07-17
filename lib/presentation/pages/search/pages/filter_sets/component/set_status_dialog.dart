import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SetStatusDialog extends StatefulWidget {
  final bool? isNew;
  final Function(bool isNew) onChanged;
  const SetStatusDialog(
      {super.key, required this.onChanged, required this.isNew});

  @override
  State<SetStatusDialog> createState() => _SetStatusDialogState();
}

class _SetStatusDialogState extends State<SetStatusDialog> {
  late bool? isNew;

  @override
  void initState() {
    isNew = widget.isNew;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AlertDialog(
        title: Text(
          'status'.tr(),
          style: fonts.headline1,
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<bool>(
                title: Text(
                  "new".tr(),
                  style: fonts.subtitle1,
                ),
                value: true,
                groupValue: isNew,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      isNew = true;
                    });
                    widget.onChanged(isNew!);
                  }
                }),
            RadioListTile<bool>(
                title: Text(
                  "used".tr(),
                  style: fonts.subtitle1,
                ),
                value: false,
                groupValue: isNew,
                onChanged: (bool? value) {
                  setState(() {
                    isNew = false;
                  });
                  widget.onChanged(isNew!);
                }),
            16.verticalSpace
          ],
        ),
      );
    });
  }
}

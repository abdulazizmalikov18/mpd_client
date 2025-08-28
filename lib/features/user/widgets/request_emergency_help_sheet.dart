import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class RequestEmergencyHelpSheet extends StatefulWidget {
  const RequestEmergencyHelpSheet({super.key});

  @override
  State<RequestEmergencyHelpSheet> createState() =>
      _RequestEmergencyHelpSheetState();
}

class _RequestEmergencyHelpSheetState extends State<RequestEmergencyHelpSheet> {
  List<String> lists = [];
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lists = [
      context.l10n.accident,
      context.l10n.dtp,
      context.l10n.firstAid,
      context.l10n.fainted,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      children: [
        const SizedBox(height: 12),
        Text(
          context.l10n.requestEmergencyHelp,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Text(
          context.l10n.emergencyOnly,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: context.color.grey,
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(
          lists.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _listTile(context, lists[index], index == selectedIndex, () {
              setState(() {
                selectedIndex = index;
              });
            }),
          ),
        ),
        const SizedBox(height: 20),
        LongButton(
          height: 52,
          buttonName: context.l10n.sos,
          color: context.color.red,
          onPress: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Container _listTile(
    BuildContext context,
    String title,
    bool isSelected,
    Function() onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: context.color.cardShadow, blurRadius: 8.r),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: isSelected
              ? TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.color.mainBlue,
                )
              : TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class TableComp extends StatelessWidget {
  final List<List<String>> children;
  const TableComp({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Table(
          border: TableBorder.all(color: colors.customGreyC3, width: 1),
          columnWidths: const <int, TableColumnWidth>{
            0: FractionColumnWidth(0.60),
            1: FractionColumnWidth(0.40),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children:
              children.map((e) => _buildRow([e[0], e[1]], colors)).toList(),
        );
      },
    );
  }
}

TableRow _buildRow(List<String> data, CustomColorSet colors) {
  List<Widget> list = [];
  for (int i = 0; i < data.length; i++) {
    list.add(
      ColoredBox(
        color: i == 1 ? colors.white : const Color(0xFFF6F6F8),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Center(
            child: Text(
              data[i],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Style.medium14(),
            ),
          ),
        ),
      ),
    );
  }
  return TableRow(
      decoration: BoxDecoration(color: colors.colorF5F5F5), children: list);
}

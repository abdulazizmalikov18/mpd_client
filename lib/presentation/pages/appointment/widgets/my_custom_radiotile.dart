import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class MyCustomRadioTile<T> extends StatelessWidget {
  final T value;
  final ValueChanged onChanged;
  final T groupValue;
  final String? text;

  const MyCustomRadioTile({super.key, required this.text, required this.value, required this.onChanged, required this.groupValue});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onChanged(value),
      child: Row(
        children: [
          _buildRadio(context),
          const SizedBox(
            width: 8,
          ),
          _buildText(context)
        ],
      ),
    );
  }

  Widget _buildRadio(BuildContext context) {
    final bool isSelected = value == groupValue;
    return Container(
        alignment: Alignment.center,
        height: 22,
        width: 22,
        decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(color: isSelected ? mainBlue : grey, width: 1.5))),
        child: CircleAvatar(
          backgroundColor: isSelected ? mainBlue : white,
          radius: 7,
        ));
  }

  Widget _buildText(BuildContext context) {
    return Text(
      text!,
      style: Styles.descSubtitle.copyWith(color: grey),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class WCustomKeyboardNumber extends StatelessWidget {
  final void Function(int index) enteredNumber;
  final TextEditingController pinController;

  const WCustomKeyboardNumber({super.key, required this.enteredNumber, required this.pinController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.3),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (_, index) {
          if (index == 9) {
            if (pinController.text.length == 4) {
              return const SizedBox();

              // return IconButton(onPressed: () => enteredNumber(index), icon: const Icon(Icons.check_circle_rounded, color: black));
            } else {
              return const SizedBox();
            }
          } else if (index == 10) {
            return TextButton(
              onPressed: () => enteredNumber(index),
              child: Text(
                "0",
                style: context.textTheme.displayLarge!.copyWith(fontSize: 32, color: white),
              ),
            );
          } else if (index == 11) {
            return IconButton(
              onPressed: () => enteredNumber(index),
              icon: const Icon(Icons.backspace, color: white),
            );
          } else {
            return TextButton(
              onPressed: () => enteredNumber(index),
              child: Text(
                "${index + 1}",
                style: context.textTheme.displayLarge!.copyWith(fontSize: 32, color: white),
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class WErrorTextForTextField extends StatelessWidget {
  final ValueNotifier<String?> notifier;

  const WErrorTextForTextField({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return notifier.value != null
            ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.info,
                          color: red,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          value.toString(),
                          style: context.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              )
            : const SizedBox();
      },
    );
  }
}

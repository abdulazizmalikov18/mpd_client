import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class WVerificationSelectGender extends StatefulWidget {
  final bool isMale;
  final void Function(bool newValue) onChange;

  const WVerificationSelectGender({
    super.key,
    required this.isMale,
    required this.onChange,
  });

  @override
  State<WVerificationSelectGender> createState() => _WVerificationSelectGenderState();
}

class _WVerificationSelectGenderState extends State<WVerificationSelectGender> {
  late bool isActiveMale = widget.isMale;

  void selectGender(bool isMale) {
    setState(() {
      isActiveMale = isMale;
      widget.onChange(isActiveMale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jinsi',
          style: AppTheme.bodySmall.copyWith(
            color: white,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => selectGender(true),
                child: SizedBox(
                  height: 44,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isActiveMale ? primary : white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // (isActiveMale ? AppIcons.radioOn.svg() : AppIcons.radioOff.svg()),
                          const SizedBox(width: 8),
                          Text(
                            'Erkak',
                            style: AppTheme.bodySmall.copyWith(
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () => selectGender(false),
                child: SizedBox(
                  height: 44,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: !isActiveMale ? primary : white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // (!isActiveMale ? AppIcons.radioOn.svg() : AppIcons.radioOff.svg()),
                          const SizedBox(width: 8),
                          Text(
                            'Ayol',
                            style: AppTheme.bodySmall.copyWith(
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

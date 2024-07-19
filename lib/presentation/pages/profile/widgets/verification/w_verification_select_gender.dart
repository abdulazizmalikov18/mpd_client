import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

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
            InkWell(
              onTap: () => selectGender(true),
              child: SizedBox(
                width: 112,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 22,
                            width: 22,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: isActiveMale
                                      ? mainBlue
                                      : grey,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: isActiveMale
                                  ? mainBlue
                                  : background,
                              radius: 7,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.l10n.register_gender_man,
                            style: AppTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () => selectGender(false),
              child: SizedBox(
                width: 112,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(100),

                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 22,
                            width: 22,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: !isActiveMale
                                      ? mainBlue
                                      : grey,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: !isActiveMale
                                  ? mainBlue
                                  : background,
                              radius: 7,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.l10n.register_gender_woman,
                            style: AppTheme.bodySmall,
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

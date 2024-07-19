import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button_gradient.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';

class WVerificationPhone extends StatelessWidget {
  const WVerificationPhone({
    super.key,
  });

  void onPressEditNumber(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const EditNumberView(),));
    // context.pushNamed(AppRouteNames.editNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Telefon raqam',
          style: AppTheme.bodySmall.copyWith(color: black),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: WTextField(
                  onChanged: (_) {},
                  borderColor: secondaryBorderColor,
                  hintText: '+998 (90) 123 45 67',
                  readOnly: true,
                  hintStyle: AppTheme.labelSmall.copyWith(
                    color: black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: WButtonGradient(
                  onTap: () => onPressEditNumber(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AppIcons.icHome.svg(),
                      const SizedBox(width: 8),
                      Text(
                        'O’zgartirish',
                        style: AppTheme.labelSmall.copyWith(color: black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

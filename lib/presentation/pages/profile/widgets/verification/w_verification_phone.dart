import 'package:flutter/material.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/common/widgets/w_button_border_gradient.dart';
import 'package:dwed_client/features/common/widgets/w_textfield.dart';
import 'package:dwed_client/features/edit_number/presentation/view/edit_number_view.dart';

class WVerificationPhone extends StatelessWidget {
  const WVerificationPhone({
    super.key,
  });
  void onPressEditNumber(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditNumberView(),));
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
                      AppIcons.icHome.svg(),
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

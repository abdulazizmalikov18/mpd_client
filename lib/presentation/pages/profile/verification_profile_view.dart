import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/common/widgets/w_button.dart';
import 'package:dwed_client/features/common/widgets/w_button_border_gradient.dart';
import 'package:dwed_client/features/common/widgets/w_main_app_bar.dart';
import 'package:dwed_client/features/profile/presentation/widgets/verification/w_verification_phone.dart';
import 'package:dwed_client/features/profile/presentation/widgets/verification/w_verification_record_video.dart';
import 'package:dwed_client/features/profile/presentation/widgets/verification/w_verification_select_gender.dart';
import 'package:dwed_client/features/profile/presentation/widgets/verification/w_verification_textfield_with_title.dart';

class VerificationProfileView extends StatelessWidget {
  const VerificationProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: Scaffold(
        appBar: const WAppBar(title: Text('Profilni tasdiqlash')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WVerificationPhone(),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'ism',
                  hintText: 'Bobomurod',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'Familya',
                  hintText: 'Ganiev',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'Tug’ilgan sana',
                  hintText: '21.11.2000',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                WVerificationSelectGender(
                  isMale: false,
                  onChange: (bool newValue) {},
                ),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'Tumani',
                  hintText: 'Yakkasaroy tumani',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'Mutaxasisligi',
                  hintText: 'Doktor',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'Login',
                  hintText: 'Bobomurod',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                const WVerificationTextFieldWithTitle(
                  title: 'PINFL',
                  hintText: 'Label',
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                const WVerificationVideRecorder(),
                const SizedBox(height: 32),
                WButton(
                  onTap: () {
                    context.pop();
                  },
                  text: "O'zgarishlarni saqlash",
                ),
                const SizedBox(height: 12),
                WButtonGradient(
                  onTap: () {
                    context.pop();
                  },
                  text: "Bekor qilish",
                  textStyle: AppTheme.bodyLarge.copyWith(
                    color: black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/features/authentication/domain/blocs/register/register_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        centerTitle: false,
        backgroundColor: context.color.white,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
          icon: SvgPicture.asset(
            AppIcons.back,
            colorFilter: ColorFilter.mode(context.color.black, BlendMode.srcIn),
            height: 20.w,
            width: 20.w,
          ),
        ),
        title: Text(
          context.l10n.register_agree_privacy_and_policy,
          style: Styles.headline4.copyWith(color: context.color.black),
        ),
      ),
      bottomSheet: PinnedSheet(
        widget: BlocSelector<RegisterBloc, RegisterState, bool>(
          selector: (state) => state.isPrivacyReat,
          builder: (context, isReat) {
            return LongButton(
              isDisable: !isReat,
              buttonName: context.l10n.register_agree_privacy_and_policy,
              onPress: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.termsLastUpdated,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.termsIntroduction,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: context.l10n.termsAcceptanceTitle,
                content: context.l10n.termsAcceptanceContent,
              ),
              _buildSection(
                context,
                title: context.l10n.termsUserConductTitle,
                content: context.l10n.termsUserConductContent,
              ),
              _buildSection(
                context,
                title: context.l10n.termsContentPolicyTitle,
                content: context.l10n.termsContentPolicyContent,
              ),
              _buildSection(
                context,
                title: context.l10n.termsAccountTerminationTitle,
                content: context.l10n.termsAccountTerminationContent,
              ),
              _buildSection(
                context,
                title: context.l10n.termsDisclaimersTitle,
                content: context.l10n.termsDisclaimersContent,
              ),
              _buildSection(
                context,
                title: context.l10n.termsLimitationLiabilityTitle,
                content: context.l10n.termsLimitationLiabilityContent,
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.termsContactUs,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  BlocSelector<RegisterBloc, RegisterState, bool>(
                    selector: (state) => state.isPrivacyReat,
                    builder: (context, isReat) {
                      return Checkbox(
                        side: BorderSide(color: context.color.border),
                        value: isReat,
                        onChanged: (value) => context.read<RegisterBloc>().add(
                          PrivacyReatPressed(),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      );
                    },
                  ),
                  Text(
                    context.l10n.register_terms_of_use,
                    style: Styles.headline7.copyWith(
                      color: context.color.black,
                    ),
                  ),
                ],
              ),
              ScreenUtil().setVerticalSpacing(100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(content, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}

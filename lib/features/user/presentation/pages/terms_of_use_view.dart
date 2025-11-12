import 'package:flutter/material.dart';
import 'package:mpd_client/l10n/app_localizations.dart';

class TermsOfUseView extends StatefulWidget {
  const TermsOfUseView({super.key});

  @override
  State<TermsOfUseView> createState() => _TermsOfUseViewState();
}

class _TermsOfUseViewState extends State<TermsOfUseView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.termsOfUseTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.termsLastUpdated,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.termsIntroduction, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: l10n.termsAcceptanceTitle,
              content: l10n.termsAcceptanceContent,
            ),
            _buildSection(
              context,
              title: l10n.termsUserConductTitle,
              content: l10n.termsUserConductContent,
            ),
            _buildSection(
              context,
              title: l10n.termsContentPolicyTitle,
              content: l10n.termsContentPolicyContent,
            ),
            _buildSection(
              context,
              title: l10n.termsAccountTerminationTitle,
              content: l10n.termsAccountTerminationContent,
            ),
            _buildSection(
              context,
              title: l10n.termsDisclaimersTitle,
              content: l10n.termsDisclaimersContent,
            ),
            _buildSection(
              context,
              title: l10n.termsLimitationLiabilityTitle,
              content: l10n.termsLimitationLiabilityContent,
            ),
            const SizedBox(height: 24),
            Text(l10n.termsContactUs, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
          ],
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

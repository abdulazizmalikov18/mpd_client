import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/extension/context_ext.dart';

class ReportMessageDialog extends StatelessWidget {
  final Function(String) onReportSubmitted;

  const ReportMessageDialog({super.key, required this.onReportSubmitted});

  static Future<void> show(
    BuildContext context, {
    required Function(String) onReportSubmitted,
  }) async {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          ReportMessageDialog(onReportSubmitted: onReportSubmitted),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final reportReasons = [
      l10n.report_reason_spam,
      l10n.report_reason_nudity,
      l10n.report_reason_hate,
      l10n.report_reason_violence,
      l10n.report_reason_harassment,
      l10n.report_reason_copyright,
      l10n.report_reason_self_harm,
      l10n.report_reason_scam,
      l10n.report_reason_false_info,
      l10n.report_reason_other,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.report_title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.report_description,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reportReasons.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, thickness: 0.5),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                // leading: const Icon(Icons.report_problem, color: Colors.red),
                trailing: AppIcons.forward.svg(),
                title: Text(
                  reportReasons[index],
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onReportSubmitted(reportReasons[index]);
                },
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Text(
                l10n.report_cancel,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ReportConfirmationDialog extends StatelessWidget {
  const ReportConfirmationDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const ReportConfirmationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        l10n.report_success_title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.green, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.report_success_message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, height: 1.4),
          ),
        ],
      ),
      // actions: [
      //   Center(
      //     child: SizedBox(
      //       width: double.infinity,
      //       child: TextButton(
      //         onPressed: () => Navigator.pop(context),
      //         style: TextButton.styleFrom(
      //           backgroundColor: Colors.red,
      //           padding: const EdgeInsets.symmetric(vertical: 14),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //         ),
      //         child: Text(
      //           l10n.cancel_appointment,
      //           style: const TextStyle(color: Colors.white, fontSize: 16),
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}

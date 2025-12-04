import 'package:flutter/material.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/components/password_part.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/auth_ui_widget.dart';

// In register_detail_page.dart
class RegisterDetailPage extends StatefulWidget {
  final String phone;
  const RegisterDetailPage({super.key, required this.phone});

  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return AuthUIWidget(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            Navigator.of(context).pop();
          }
        },
        child: PasswordPart(
          phone: widget.phone,
          valueNotifier: ValueNotifier(0),
        ),
      ),
    );
  }
}

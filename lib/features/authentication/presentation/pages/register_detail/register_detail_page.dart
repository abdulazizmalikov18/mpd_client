import 'package:flutter/material.dart';
import 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/fullname_part.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/components/password_part.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/auth_ui_widget.dart';

class RegisterDetailPage extends StatefulWidget {
  final String phone;
  const RegisterDetailPage({super.key, required this.phone});

  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  ValueNotifier valueNotifier = ValueNotifier(0);
  // List<Widget> get _widgetOptions => [
  //       const PasswordPart(),
  //       FullnamePart(phone: phone),
  //       // const DoctorPart(),
  //       // const PassportStirPart(),
  //     ];
  @override
  Widget build(BuildContext context) {
    return AuthUIWidget(
      child: WillPopScope(
        onWillPop: () async {
          switch (AuthInheritedNotifier.of(context).notifier!.currentIndex) {
            case 1:
              AuthInheritedNotifier.of(context).notifier!.currentIndex = 0;
              return false;
            case 2:
              AuthInheritedNotifier.of(context).notifier!.currentIndex = 1;
              return false;
            case 3:
              AuthInheritedNotifier.of(context).notifier!.currentIndex = 2;
              return false;
            default:
              return true;
          }
        },
        child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, _, __) {
              return AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                reverseDuration: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: valueNotifier.value == 0
                    ? PasswordPart(valueNotifier: valueNotifier)
                    : FullnamePart(phone: widget.phone),
              );
            }),
      ),
    );
  }
}

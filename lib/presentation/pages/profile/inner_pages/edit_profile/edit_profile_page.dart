import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/comp/edit_appbar_comp.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/comp/edit_body_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return OnUnFocusTap(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(1.sw, 120.h),
              child: const EditAppBarComp(),
            ),
            backgroundColor: colors.backgroundScaffold,
            body: const EditBodyComp(),
          ),
        );
      },
    );
  }
}

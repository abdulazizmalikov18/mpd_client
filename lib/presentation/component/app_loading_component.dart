import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/theme.dart';
import '../styles/theme_wrapper.dart';

class AppLoadingComponent extends StatelessWidget {
  const AppLoadingComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, GlobalController controller) {
        return Scaffold(
            backgroundColor: colors.transparent,
            body: const Center(
              child: CupertinoActivityIndicator(),
            ));
      },
    );
  }
}

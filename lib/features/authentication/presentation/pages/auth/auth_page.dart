import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/core/locator.dart';
import 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';
import 'package:mpd_client/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:mpd_client/features/authentication/presentation/pages/auth/components/login_part.dart';
import 'package:mpd_client/features/authentication/presentation/pages/auth/components/register_part.dart';
import 'package:mpd_client/main.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<IAuthRepository>(
      create: (context) => locator<IAuthRepository>(),
      child: AuthInheritedNotifier(
        authNotifier: AuthNotifier(),
        child: Builder(
          builder: (context) {
            final notifier = AuthInheritedNotifier.of(context).notifier!;
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (!didPop) {
                  if (notifier.isSignIn) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  } else {
                    notifier.setAuthPage();
                  }
                }
              },
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(height: 352.h),
                          Image.asset(
                            'assets/images/topimage.png',
                            height: 290.h,
                            width: double.maxFinite,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 90.h,
                            left: 70.w,
                            right: 70.w,
                            child: Image.asset(
                              $appType.logoImage,
                              height: 55.h,
                              width: 250.w,
                              color: context.color.white,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 177.h,
                            left: 108.w,
                            right: 108.w,
                            child: Image.asset(
                              AppImages.doctorEntry,
                              height: 175.h,
                              width: 175.w,
                            ),
                          ),
                        ],
                      ),
                      Builder(
                        builder: (context) {
                          final notifier = AuthInheritedNotifier.of(
                            context,
                          ).notifier!;
                          return AnimatedCrossFade(
                            sizeCurve: Curves.easeInOut,
                            firstChild: const LoginPart(),
                            secondChild: const RegisterPart(),
                            crossFadeState: notifier.isSignIn
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/presentation/pages/auth/check_pin_view.dart';
import 'package:mpd_client/presentation/pages/auth/confirm_auth_data.dart';
import 'package:mpd_client/presentation/pages/auth/confirm_otp_view.dart';
import 'package:mpd_client/presentation/pages/auth/create_login_view.dart';
import 'package:mpd_client/presentation/pages/auth/create_password_view.dart';
import 'package:mpd_client/presentation/pages/auth/login_view.dart';
import 'package:mpd_client/presentation/pages/auth/registration_view.dart';
import 'package:mpd_client/presentation/pages/doctor/doctor_view.dart';
import 'package:mpd_client/presentation/pages/error/error_view.dart';
import 'package:mpd_client/presentation/pages/home/home_view.dart';
import 'package:mpd_client/presentation/pages/initial/language/language_page.dart';
import 'package:mpd_client/presentation/pages/initial/splash/splash_page.dart';
import 'package:mpd_client/presentation/pages/initial/tutorial/tutorial_page.dart';
import 'package:mpd_client/presentation/pages/main/main_view.dart';
import 'package:mpd_client/presentation/pages/profile/edit_profile_view.dart';
import 'package:mpd_client/presentation/pages/profile/profile_view.dart';
import 'package:mpd_client/presentation/pages/record/record_view.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';

sealed class AppRouts {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutePath.splash,
    // errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: [
      GoRoute(
        path: AppRoutePath.errorFound,
        name: AppRouteNames.errorFound,
        builder: (context, state) => ErrorDrawView(
          data: (state.extra as Map)["picture"] as Uint8List,
        ),
      ),
      GoRoute(
        path: AppRoutePath.splash,
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutePath.selectLang,
        name: AppRouteNames.selectLang,
        builder: (context, state) => const LanguagePage(),
      ),
      GoRoute(
        path: AppRoutePath.onBoarding,
        name: AppRouteNames.onBoarding,
        builder: (context, state) => const TutorialPage(),
      ),
      GoRoute(
        path: AppRoutePath.login,
        name: AppRouteNames.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutePath.registration,
        name: AppRouteNames.registration,
        builder: (context, state) => const RegistrationView(),
      ),
      GoRoute(
        path: AppRoutePath.checkPin,
        name: AppRouteNames.checkPin,
        builder: (context, state) => const CheckPinView(),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: AppRoutePath.editProfile,
        name: AppRouteNames.editProfile,
        builder: (context, state) => const EditProfileView(),
      ),

      GoRoute(
        path: AppRoutePath.authConfirmOtp,
        name: AppRouteNames.authConfirmOtp,
        builder: (context, state) => ConfirmOtpView(
          phone: (state.extra as Map)["phone"],
        ),
      ),
      GoRoute(
        path: AppRoutePath.createLogin,
        name: AppRouteNames.createLogin,
        builder: (context, state) => CreateLoginView(
          phone: (state.extra as Map)["phone"],
        ),
      ),
      GoRoute(
        path: AppRoutePath.createPassword,
        name: AppRouteNames.createPassword,
        builder: (context, state) => CreatePasswordView(
          phone: (state.extra as Map)["phone"],
          login: (state.extra as Map)["login"],
        ),
      ),
      GoRoute(
        path: AppRoutePath.confirmAuthData,
        name: AppRouteNames.confirmAuthData,
        builder: (context, state) => ConfirmAuthDataView(
          phone: (state.extra as Map)["phone"],
          login: (state.extra as Map)["login"],
          password: (state.extra as Map)["password"],
        ),
      ),
      mainView,
    ],
  );

  static final mainView = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainView(navigationShell: navigationShell);
    },
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutePath.home,
            name: AppRouteNames.home,
            builder: (context, state) => const HomeView(),
          )
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutePath.doctor,
            name: AppRouteNames.doctor,
            builder: (context, state) => const DoctorView(),
          ),
        ],
      ),
      // StatefulShellBranch(
      //   routes: [
      //     GoRoute(
      //       path: AppRoutePath.chat,
      //       name: AppRouteNames.chat,
      //       builder: (context, state) => const ChatView(),
      //     ),
      //   ],
      // ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutePath.record,
            name: AppRouteNames.record,
            builder: (context, state) => const RecordView(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutePath.profile,
            name: AppRouteNames.profile,
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],
  );
}

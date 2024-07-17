import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/presentation/pages/auth/check_pin_view.dart';
import 'package:mpd_client/presentation/pages/auth/login_view.dart';
import 'package:mpd_client/presentation/pages/auth/registration_view.dart';
import 'package:mpd_client/presentation/pages/error/error_view.dart';
import 'package:mpd_client/presentation/pages/profile/edit_password_view.dart';
import 'package:mpd_client/presentation/pages/profile/edit_profile_view.dart';
import 'package:mpd_client/presentation/pages/profile/verification_profile_view.dart';
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
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutePath.selectLang,
        name: AppRouteNames.selectLang,
        builder: (context, state) => const SelectLangView(),
      ),
      GoRoute(
        path: AppRoutePath.onBoarding,
        name: AppRouteNames.onBoarding,
        builder: (context, state) => const OnBoardingView(),
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
        path: AppRoutePath.verificationProfile,
        name: AppRouteNames.verificationProfile,
        builder: (context, state) => const VerificationProfileView(),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: AppRoutePath.editProfile,
        name: AppRouteNames.editProfile,
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: AppRoutePath.editNumber,
        name: AppRouteNames.editNumber,
        builder: (context, state) => const EditNumberView(),
      ),
      GoRoute(
        path: AppRoutePath.editNumberConfirmationOtp,
        name: AppRouteNames.editNumberConfirmationOtp,
        builder: (context, state) => const EditNumberConfirmationOtpView(),
      ),
      GoRoute(
        path: AppRoutePath.editPinCode,
        name: AppRouteNames.editPinCode,
        builder: (context, state) => const EditPasswordView(),
      ),
      GoRoute(
        path: AppRoutePath.inChats,
        name: AppRouteNames.inChats,
        builder: (context, state) => InChatView(parentContext: state.extra as BuildContext),
      ),
      GoRoute(
        path: AppRoutePath.createChat,
        name: AppRouteNames.createChat,
        builder: (context, state) => const CreateNewChatView(),
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
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: AppRoutePath.notification,
        name: AppRouteNames.notification,
        builder: (context, state) => const NotificationView(),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: AppRoutePath.quizCreate,
        builder: (context, state) => BlocProvider(
          create: (context) => QuizBloc(QuizRepoImpl(QuizService.create())),
          child: const QuizCreateView(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: AppRoutePath.stream,
        name: AppRouteNames.stream,
        builder: (context, state) => const StreamView(),
      ),
      GoRoute(
        path: AppRoutePath.viewerLiveStream,
        name: AppRouteNames.viewerLiveStream,
        builder: (context, state) {
          return ViewerView(
            meetId: state.uri.queryParameters["fid"],
          );
        },
      ),
      GoRoute(
        path: AppRoutePath.conference,
        name: AppRouteNames.conference,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => VCBloc(),
            child: ConferenceMeetingView(
              meetId: state.uri.queryParameters["fid"],
              isCreator: false,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutePath.createPost,
        name: AppRouteNames.createPost,
        builder: (context, state) {
          return const CreatePostView();
        },
      ),
      GoRoute(
        path: AppRoutePath.payment,
        name: AppRouteNames.payment,
        builder: (context, state) {
          return const PaymentView();
        },
      ),
      GoRoute(
        path: AppRoutePath.settings,
        name: AppRouteNames.settings,
        builder: (context, state) {
          return const SettingsView();
        },
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
            path: AppRoutePath.menu,
            name: AppRouteNames.menu,
            builder: (context, state) => const MenuView(),
          ),
          GoRoute(
            path: AppRoutePath.quiz,
            builder: (context, state) => const QuizView(),
          ),
          GoRoute(
            path: AppRoutePath.iqRating,
            name: AppRouteNames.iqRating,
            builder: (context, state) => const IqRatingView(),
          ),
          GoRoute(
            path: AppRoutePath.categoriesQiuz,
            name: AppRouteNames.categoriesQiuz,
            builder: (context, state) => const CategoryView(),
          ),
          GoRoute(
            path: AppRoutePath.quizProduct,
            name: AppRouteNames.quizProduct,
            builder: (context, state) => QuizProduuctView(goRouterState: state),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutePath.chat,
            name: AppRouteNames.chat,
            builder: (context, state) => const ChatView(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(path: AppRoutePath.cart, name: AppRouteNames.cart, builder: (context, state) => const CartView(), routes: [
            GoRoute(
              parentNavigatorKey: navigatorKey,
              path: AppRoutePath.mainCart,
              name: AppRouteNames.mainCart,
              builder: (context, state) => const MainCartView(),
              routes: [
                GoRoute(
                  parentNavigatorKey: navigatorKey,
                  path: AppRoutePath.cartSelectDate,
                  name: AppRouteNames.cartSelectDate,
                  builder: (context, state) => const SelectDateView(),
                ),
              ],
            ),
          ]),
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

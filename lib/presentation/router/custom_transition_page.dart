import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage customTransitionPage<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  // const begin = Offset(1.0, 0);
  // const end = Offset.zero;
  // const curve = Curves.ease;

  // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: CurvedAnimation(
        curve: const Interval(0, 1, curve: Curves.linear),
        parent: animation,
      ),
      child: child,
    ),
  );
}

PageRouteBuilder fade({required Widget page, RouteSettings? settings}) =>
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: CurvedAnimation(
          curve: const Interval(0, 1, curve: Curves.linear),
          parent: animation,
        ),
        child: child,
      ),
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
    );

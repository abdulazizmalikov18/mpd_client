import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mpd_client/app/app_pages.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/app/app_theme.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/locator.dart';
import 'package:mpd_client/core/platform/refresh_scroll_behavior.dart';
import 'package:mpd_client/core/utils/responsive.dart';
import 'package:mpd_client/features/appointment/data/repositories/appoinment_repository.dart';
import 'package:mpd_client/features/appointment/domain/blocs/appointment/appoinment_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/refresh_token/refreshtoken_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/register/register_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/repositories/doctor_profile_repository.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/add_to_cart/add_to_cart_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/doctor_profile/doctor_profile_bloc.dart';
import 'package:mpd_client/provider/language_database.dart';
import 'package:mpd_client/provider/local_provider.dart';
import 'package:provider/provider.dart';
import 'authentication/data/repositories/auth_repository.dart';
import 'home/domain/inherited/post_inhereted.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final $navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  final _appPages = AppPages();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final withmy = MediaQuery.of(context).size.width;
    debugPrint("=====>>> $withmy");
    return ScreenUtilInit(
      designSize: Responsive.isMediumScreen(context) ? const Size(820, 1180) : const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => locator<RefreshtokenBloc>()..add(GetRefreshToken())),
            BlocProvider(
              create: (context) => RegisterBloc(
                GetIt.instance.get<AuthRepository>(),
                GlobalKey<FormState>(),
                TextEditingController(),
              ),
            ),
            BlocProvider(
              create: (context) => AppoinmentsBloc(
                GetIt.instance.get<AppoinmentRepository>(),
              ),
            ),
            BlocProvider(create: (context) => DoctorProfileBloc(locator.get<DoctorProfileRepository>())),
            BlocProvider(create: (context) => AddToCartBloc(locator.get<DoctorProfileRepository>())),
          ],
          child: PostInheritedNotifier(
            postNotifier: PostNotifier(),
            child: ChangeNotifierProvider(
              create: (context) => LocalProvider(LanguageDatabase()),
              builder: (context, child) {
                final provider = Provider.of<LocalProvider>(context);
                return MaterialApp(
                  navigatorKey: $navigatorKey,
                  builder: (context, child) => ScrollConfiguration(
                    behavior: RefreshScrollBehavior(),
                    child: KeyboardDismisser(
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: child!,
                      ),
                    ),
                  ),
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    // RefreshLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  locale: provider.locale,
                  localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
                    return locale;
                  },
                  debugShowCheckedModeBanner: false,
                  initialRoute: AppRoutes.splash,
                  onGenerateRoute: _appPages.generateRoute,
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _appPages.dispose();
    super.dispose();
  }
}

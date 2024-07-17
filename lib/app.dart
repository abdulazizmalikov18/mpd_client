import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';
import 'package:mpd_client/presentation/router/app_routs.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider<ConnectionCubit>(create: (context) => ConnectionCubit()),
        BlocProvider<ShowPopUpBloc>(create: (context) => ShowPopUpBloc()),
        BlocProvider<AccountsBloc>(create: (context) => serviceLocator<AccountsBloc>()),
        BlocProvider<ChatBloc>(create: (context) => serviceLocator<ChatBloc>()..add(const GetGroupChat())),
        BlocProvider<PostBloc>(create: (context) => serviceLocator<PostBloc>()..add(const PostFetched())),
        BlocProvider<CommentBloc>(create: (context) => serviceLocator<CommentBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        bloc: serviceLocator<AuthBloc>(),
        listenWhen: (previous, current) => previous.authStatus != current.authStatus,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.unauthenticated) {
            AppRouts.router.pushReplacementNamed(AppRouteNames.login);
          }
          if (state.authStatus == AuthStatus.authenticated) {
            AppRouts.router.goNamed(AppRouteNames.checkPin);
          }
        },
        child: ChatVMController(
          scrollController: ScrollController(),
          messageController: TextEditingController(),
          child: MaterialApp.router(
            supportedLocales: Localization.supportedLocales,
            localizationsDelegates: Localization.localizationsDelegates,
            locale: const Locale("uz"),
            title: 'T-MED Client',
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme(),
            builder: (context, child) {
              return CustomScreen(
                child: child!,
              );
            },
            routerConfig: AppRouts.router,
          ),
        ),
      ),
    );
  }
}

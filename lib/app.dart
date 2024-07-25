import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/comment/comment_bloc.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/application/show_pop_up/show_pop_up_bloc.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/presentation/router/app_routs.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_custom_screen.dart';
import 'package:mpd_client/utils/l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountsBloc>(create: (context) => serviceLocator<AccountsBloc>()),
        BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider<ShowPopUpBloc>(create: (context) => ShowPopUpBloc()),
        // BlocProvider<ConnectionCubit>(create: (context) => ConnectionCubit()),
        BlocProvider<ChatBloc>(create: (context) => serviceLocator<ChatBloc>()),
        BlocProvider<PostBloc>(create: (context) => serviceLocator<PostBloc>()),
        // BlocProvider<CommentBloc>(create: (context) => serviceLocator<CommentBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        bloc: serviceLocator<AuthBloc>(),
        listenWhen: (previous, current) => previous.authStatus != current.authStatus,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.unauthenticated) {
            AppRouts.router.pushReplacementNamed(AppRouteNames.login);
          }
          if (state.authStatus == AuthStatus.authenticated) {
            AppRouts.router.goNamed(AppRouteNames.home);
          }
        },
        child: ChatVMController(
          scrollController: ScrollController(),
          messageController: TextEditingController(),
          child: MaterialApp.router(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
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

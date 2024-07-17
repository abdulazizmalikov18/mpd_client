import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/infrastructure/apis/apis.dart';
import 'package:orient_motors/infrastructure/repositories/auth_repo.dart';
import 'package:orient_motors/infrastructure/repositories/car_repo.dart';
import 'package:orient_motors/infrastructure/repositories/filter_repo.dart';
import 'package:orient_motors/infrastructure/repositories/main_repo.dart';
import 'package:orient_motors/infrastructure/repositories/services_repo.dart';
import 'package:orient_motors/infrastructure/repositories/specifications_repo.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/core/choose_language_page.dart';
import 'package:orient_motors/presentation/pages/core/no_connection.dart';
import 'package:orient_motors/presentation/pages/main/main_page.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/services/local_database/db_service.dart';
import '../../styles/theme.dart';

class MyApp extends StatelessWidget {
  final DBService dbService;
  final bool connectivityX;
  final Function(BuildContext context)? onGetContext;

  const MyApp({
    super.key,
    required this.dbService,
    required this.connectivityX,
    this.onGetContext,
  });

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalController.create(dbService)),
        ChangeNotifierProvider(create: (_) => BottomNavBarController.create()),
        Provider<DBService>(create: (_) => dbService),
      ],
      child: OnUnFocusTap(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: FlutterSmartDialog.init(),
          navigatorObservers: [FlutterSmartDialog.observer],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: Builder(builder: (context) {
            ScreenUtil.init(context, designSize: const Size(375, 812));
            if (onGetContext != null) {
              onGetContext!(context);
            }
            if (connectivityX) {
              bool? isSaved = context.read<DBService>().getLang;
              if (isSaved != null && isSaved) {
                return MultiProvider(
                  providers: [
                    Provider<ProfileBloc>(
                      create: (_) => ProfileBloc(AuthRepository(context.read<DBService>(), AuthService.create()),
                          CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()))
                        ..add(const ProfileEvent.getProfile())
                        ..add(const ProfileEvent.getOwnActualCars(isActive: "1"))
                        ..add(const ProfileEvent.getOwnActualCars(isActive: "0"))
                        ..add(const ProfileEvent.getDrafts())
                        ..add(const ProfileEvent.getLikedList())
                        ..add(
                          const ProfileEvent.getSeenList(),
                        ),
                    ),
                    Provider<MainBloc>(
                      create: (_) => MainBloc(MainRepository(context.read<DBService>(), MainService.create()))
                        ..add(const MainEvent.getNotificationsUnread())
                        ..add(const MainEvent.getCurrency()),
                    ),
                    BlocProvider<SearchBloc>(
                      create: (context) => SearchBloc(
                        FilterRepository(context.read<DBService>(), FilterService.create()),
                        CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
                        SpecificationsRepository(context.read<DBService>(), SpecificationsService.create()),
                        ServicesRepository(context.read<DBService>(), ServicesService.create()),
                      ),
                    ),
                  ],
                  child: const MainPage(index: 0),
                );
              } else {
                return const ChooseLanguagePage();
              }
            } else {
              return const NoConnection();
            }
          }),
        ),
      ),
    );
  }
}

import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/appointment/data/models/user_posts_arg.dart';
import 'package:mpd_client/features/home/domain/blocs/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/features/home/presentation/pages/user_account/user_posts_view.dart';
import 'package:mpd_client/features/user/data/models/user_info_model.dart';
import 'package:mpd_client/features/user/presentation/pages/user_post/user_post_view.dart';
import 'package:mpd_client/features/user/presentation/user_specialist_view.dart';
import 'package:mpd_client/features/user/specialist_register_page.dart';
import 'package:mpd_client/features/yandex_doctor/domain/blocs/specialist/specialist_bloc.dart';

class AppPages {
  late final _userInfoBloc = UserInfoBloc(GetIt.instance.get<UserRepository>());
  late final _userSubscriptionsBloc = UserSubscriptionsBloc(
      locator.get<UserRepository>(), TextEditingController());

  late final _timetableBloc =
      TimetableBloc(locator.get<DoctorProfileRepository>());

  late final _myCardsBloc = MyCardsBloc(locator.get<DoctorProfileRepository>());
  late final _postComentBloc = PostComentBloc(locator.get<HomeRepository>());
  late final _sendComentBloc =
      SendComentBloc(locator.get<HomeRepository>(), TextEditingController());

  late final _likeUnlikeBloc = LikeUnlikeBloc(locator.get<HomeRepository>());
  late final _postBloc = PostBloc(locator.get<HomeRepository>());
  late final _mediaControlBloc = MediaControlBloc(_postBloc);

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.yandexMap:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => YandexDoctorBloc(YandexService()),
              ),
              BlocProvider(
                create: (context) => SearchBySpecialistBloc(
                    locator.get<YandexDoctorRepository>(), FocusNode()),
              ),
            ],
            child: const DoctorPage(),
          ),
        );
      case AppRoutes.appointment:
        final args = settings.arguments as AppointmentArgModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    CancelAppointmentBloc(locator.get<AppoinmentRepository>()),
              ),
            ],
            child: BookAppoinment(
              appoinmentInfo: args.appoinmentInfo,
              appointment: args.appointment,
            ),
          ),
        );
      case AppRoutes.userInfo:
        final userLocalModel = settings.arguments as UserInfoModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    DistrictBloc(GetIt.instance.get<AuthRepository>()),
              ),
              BlocProvider(
                create: (context) => RegionBloc(
                  GetIt.instance.get<AuthRepository>(),
                  TextEditingController(),
                ),
              ),
              BlocProvider.value(value: _userInfoBloc),
              BlocProvider(
                create: (context) => ProfessionBloc(
                  locator.get<AuthRepository>(),
                  TextEditingController(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    SubProfessionsBloc(GetIt.instance.get<AuthRepository>()),
              ),
            ],
            child: UserInfo(userLocalModel: userLocalModel),
          ),
        );
      case AppRoutes.registerSpecialist:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _userInfoBloc),
              BlocProvider(
                create: (context) => ProfessionBloc(
                  locator.get<AuthRepository>(),
                  TextEditingController(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    SubProfessionsBloc(GetIt.instance.get<AuthRepository>()),
              ),
            ],
            child: const SpecialistRegisterPage(),
          ),
        );
      case AppRoutes.appointmentPayment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _myCardsBloc..add(GetMyCardsEvent()),
            child: const AppoinmentPayment(),
          ),
        );
      case AppRoutes.userSpecialist:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _userInfoBloc,
            child: const UserSpecialistView(),
          ),
        );
      case AppRoutes.userPage:
        final args = settings.arguments as UserPostsArg;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _sendComentBloc),
              BlocProvider.value(value: _postComentBloc),
              BlocProvider.value(value: _userInfoBloc),
              BlocProvider.value(value: _mediaControlBloc),
              BlocProvider.value(value: _likeUnlikeBloc),
            ],
            child: UserPostsView(
              postsUser: args.postsUser,
              index: args.index,
              name: args.name,
              avatar: args.avatar,
              bloc: args.bloc,
            ),
          ),
        );
      case AppRoutes.pdfViewer:
        final args = settings.arguments as PdfViewerModel;
        return MaterialPageRoute(
          builder: (_) => PdfViewerPage(url: args.pdfUrl, name: args.name),
        );
      case AppRoutes.appointmentReview:
        final id = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _timetableBloc),
              BlocProvider.value(value: _myCardsBloc),
              BlocProvider(
                create: (context) => CreateOrderBloc(
                  locator.get<DoctorProfileRepository>(),
                ),
              ),
            ],
            child: ReviewAppoinmentDetail(
              localProducts: id["product"],
              isOffering: id["isOffering"],
            ),
          ),
        );
      case AppRoutes.userFollowing:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _userSubscriptionsBloc,
            child: const UserFollowing(),
          ),
        );
      case AppRoutes.notification:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case AppRoutes.createPost:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CreatePostBloc(
              TextEditingController(),
              locator.get<HomeRepository>(),
            ),
            child: const CreatePostPage(),
          ),
        );
      case AppRoutes.helpCenter:
        return MaterialPageRoute(builder: (_) => const HelpCenter());
      case AppRoutes.userPayment:
        return MaterialPageRoute(builder: (_) => const UserPayment());
      case AppRoutes.mainPage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(
                  locator.get<AuthRepository>(),
                  GlobalKey<FormState>(),
                  TextEditingController(),
                  TextEditingController(),
                  FocusNode(),
                )..add(RefreshToken()),
              ),
              BlocProvider.value(value: _userSubscriptionsBloc),
              BlocProvider(create: (context) => _mediaControlBloc),
              // BlocProvider(
              //   create: (context) => CompletedAppointmentBloc(
              //       GetIt.instance.get<AppoinmentRepository>())
              //     ..add(
              //       const GetCompletedAppoinmentsEvent(),
              //     ),
              // ),
              // BlocProvider(
              //   create: (context) => CanceledAppointmentBloc(
              //       GetIt.instance.get<AppoinmentRepository>())
              //     ..add(
              //       const GetCanceledAppoinmentsEvent(),
              //     ),
              // ),
              BlocProvider.value(value: _userInfoBloc),
              BlocProvider(
                create: (context) => BannerBloc(
                  GetIt.instance.get<HomeRepository>(),
                  PageController(initialPage: 0),
                ),
              ),

              BlocProvider(
                create: (context) => YandexDoctorBloc(YandexService()),
              ),

              BlocProvider(
                create: (context) => SearchBySpecialistBloc(
                  locator.get<YandexDoctorRepository>(),
                  FocusNode(),
                ),
              ),
              BlocProvider(
                create: (context) => SpecialistBloc(
                  locator.get<YandexDoctorRepository>(),
                ),
              ),
              BlocProvider.value(value: _userInfoBloc),
              BlocProvider(create: (context) => _postComentBloc),
              BlocProvider(create: (context) => _sendComentBloc),
              BlocProvider(create: (context) => _likeUnlikeBloc),
              BlocProvider(
                create: (context) =>
                    AdverticementBloc(locator.get<HomeRepository>()),
              ),
              BlocProvider.value(value: _postBloc),
            ],
            child: const MainPage(),
          ),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.appointmentdt:
        final id = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _timetableBloc,
            child: AppoinmentDateTimePage(
              id: id["id"],
              localProducts: id["product"],
            ),
          ),
        );
      case AppRoutes.record:
        final record = settings.arguments as RecordModel;
        return MaterialPageRoute(builder: (_) => Record(record: record));
      case AppRoutes.splashLanguage:
        return MaterialPageRoute(builder: (_) => const LanguagePage());
      case AppRoutes.splashTutorial:
        return MaterialPageRoute(
          builder: (_) => TutorialInheritedNotifier(
            tutorialNotifier: TutorialNotifier(),
            child: const TutorialPage(),
          ),
        );
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(
              GetIt.instance.get<AuthRepository>(),
              GlobalKey<FormState>(),
              TextEditingController(),
              TextEditingController(),
              FocusNode(),
            )..add(RefreshToken()),
            child: const AuthPage(),
          ),
        );
      case AppRoutes.privacy:
        return MaterialPageRoute(builder: (_) => const PrivacyPage());
      case AppRoutes.recordsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RecordsBloc(
                GetIt.instance.get<UserRepository>(), TextEditingController())
              ..add(const GetRecordsEvent()),
            child: const RecordsPage(),
          ),
        );
      case AppRoutes.services:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ProductSpecalistBloc(locator.get<HomeRepository>()),
            child: ServicesPage(specialistId: id),
          ),
        );
      case AppRoutes.postUser:
        final username = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _postBloc),
              BlocProvider.value(value: _mediaControlBloc),
            ],
            child: UserPostView(
              username: username,
              avatar: _userInfoBloc.state.userInfo?.avatar ?? "",
            ),
          ),
        );

      case AppRoutes.drProfilebyid:
        final args = settings.arguments as SpecialistInfoModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _postBloc),
              BlocProvider(
                create: (context) =>
                    SubscriptionBloc(locator.get<DoctorProfileRepository>()),
              ),
              BlocProvider.value(value: _userSubscriptionsBloc),
            ],
            child: DrProfileByid(specialist: args),
          ),
        );
      case AppRoutes.postComent:
        final args = settings.arguments as ComentPageModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                  value: _postComentBloc
                    ..add(GetComentPostEvent(args.post.id!, false))),
              BlocProvider.value(value: _sendComentBloc),
              BlocProvider.value(value: _likeUnlikeBloc),
              BlocProvider.value(value: _mediaControlBloc),
              BlocProvider.value(value: _userInfoBloc),
            ],
            child: ComentPage(
                index: args.index,
                flickManager: args.flickManager,
                post: args.post),
          ),
        );
      case AppRoutes.registerDetail:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CreateUserBloc(
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController(),
                    locator.get<AuthRepository>(),
                    GlobalKey<FormState>()),
              ),
              // BlocProvider(
              //   create: (context) => ProfessionsBloc(
              //     GetIt.instance.get<AuthRepository>(),
              //     TextEditingController(),
              //   )..add(GetProffesionsEvent()),
              // ),
              BlocProvider(
                create: (context) => ProfessionBloc(
                    locator.get<AuthRepository>(), TextEditingController()),
              ),
              BlocProvider(
                create: (context) =>
                    SubProfessionsBloc(GetIt.instance.get<AuthRepository>()),
              ),
              BlocProvider(
                create: (context) => ChangePasswordBloc(
                    GetIt.instance.get<AuthRepository>(),
                    GlobalKey<FormState>(),
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController()),
              ),
              BlocProvider(
                create: (context) => PassportBloc(
                    GetIt.instance.get<AuthRepository>(),
                    GlobalKey<FormState>(),
                    TextEditingController()),
              ),
              BlocProvider(
                create: (context) =>
                    CheckUsernameBloc(GetIt.instance.get<AuthRepository>()),
              ),
              BlocProvider(
                create: (context) => RegionBloc(
                    GetIt.instance.get<AuthRepository>(),
                    TextEditingController()),
              ),
              BlocProvider(
                create: (context) =>
                    DistrictBloc(GetIt.instance.get<AuthRepository>()),
              ),
            ],
            child: AuthInheritedNotifier(
              authNotifier: AuthNotifier(),
              child: RegisterDetailPage(phone: args),
            ),
          ),
        );
      // case AppRoutes.search:
      //   return PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
      //       create: (context) =>
      //           SearchBloc(GetIt.instance.get<YandexDoctorRepository>()),
      //       child: const SearchPage(),
      //     ),
      //     transitionDuration: const Duration(milliseconds: 600),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      //         FadeTransition(opacity: animation, child: child),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }

  Future<void> dispose() async {
    _myCardsBloc.close();
    _timetableBloc.close();
    _userInfoBloc.close();
    _postBloc.close();
    _likeUnlikeBloc.close();
    _mediaControlBloc.close();
    _sendComentBloc.close();
  }
}

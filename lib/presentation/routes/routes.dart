import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/application/car_detail_bloc/car_detail_bloc.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/domain/models/util/filter_item_model.dart';
import 'package:orient_motors/infrastructure/apis/apis.dart';
import 'package:orient_motors/infrastructure/repositories/auth_repo.dart';
import 'package:orient_motors/infrastructure/repositories/car_repo.dart';
import 'package:orient_motors/infrastructure/repositories/filter_repo.dart';
import 'package:orient_motors/infrastructure/repositories/review_repo.dart';
import 'package:orient_motors/infrastructure/repositories/services_repo.dart';
import 'package:orient_motors/infrastructure/repositories/specifications_repo.dart';
import 'package:orient_motors/presentation/pages/auth/login/login_page.dart';
import 'package:orient_motors/presentation/pages/auth/login/resset_password_page.dart';
import 'package:orient_motors/presentation/pages/auth/sing_up/fill_info_page_page.dart';
import 'package:orient_motors/presentation/pages/auth/sing_up/fill_sms_page.dart';
import 'package:orient_motors/presentation/pages/auth/sing_up/sing_up_page.dart';
import 'package:orient_motors/presentation/pages/chat/chat_detail_page.dart';
import 'package:orient_motors/presentation/pages/core/intro_screen.dart';
import 'package:orient_motors/presentation/pages/create/add_car_page.dart';
import 'package:orient_motors/presentation/pages/home/branches/branch_detail_page.dart';
import 'package:orient_motors/presentation/pages/home/branches/branches_page.dart';
import 'package:orient_motors/presentation/pages/home/complaint/complaint_page.dart';
import 'package:orient_motors/presentation/pages/home/faq/faq_page.dart';
import 'package:orient_motors/presentation/pages/home/favorites/favorites_page.dart';
import 'package:orient_motors/presentation/pages/home/guarantee/guarantee_detail_page.dart';
import 'package:orient_motors/presentation/pages/home/guarantee/guarantee_page.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/menu_page.dart';
import 'package:orient_motors/presentation/pages/home/home_page.dart';
import 'package:orient_motors/presentation/pages/home/news/news_detail_page.dart';
import 'package:orient_motors/presentation/pages/home/news/news_page.dart';
import 'package:orient_motors/presentation/pages/home/notification/notification_page.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/premium_diagnostic_page.dart';
import 'package:orient_motors/presentation/pages/home/product_card/gallery_detail_page.dart';
import 'package:orient_motors/presentation/pages/home/product_card/product_card_page.dart';
import 'package:orient_motors/presentation/pages/home/product_card/user_info_page.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/signup_for_diagnostic_page.dart';
import 'package:orient_motors/presentation/pages/home/used_cars/used_cars_page.dart';
import 'package:orient_motors/presentation/pages/main/main_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/about_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/ads/my_ads_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/change_number/change_number_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/change_number/change_with_number_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/change_number/safety_code_enter_for_phone_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/change_password_profile_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/edit_profile_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/edit_profile/region_select_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/my_cards/my_cards_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/my_cards/payment_history_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/top_up_balance/card_adding_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/top_up_balance/safety_code_enter_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/top_up_balance/top_up_balance_page.dart';
import 'package:orient_motors/presentation/pages/profile/inner_pages/top_up_balance/topup_finish_page.dart';
import 'package:orient_motors/presentation/pages/profile/profile_page.dart';
import 'package:orient_motors/presentation/pages/review_cars/controller/review_controller.dart';
import 'package:orient_motors/presentation/pages/review_cars/review_brands_page.dart';
import 'package:orient_motors/presentation/pages/review_cars/review_car_detail_page.dart';
import 'package:orient_motors/presentation/pages/review_cars/review_car_model_page.dart';
import 'package:orient_motors/presentation/pages/review_cars/review_cars_page.dart';
import 'package:orient_motors/presentation/pages/review_cars/review_generation_page.dart';
import 'package:orient_motors/presentation/pages/review_cars/widget/vote_generation_widget.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/body_type_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/brand_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/color_select_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/fuel_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/generation_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/model_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/region_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/salesman_select_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/service_info_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/service_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/transmisson_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/year_of_issue_set_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/result_page.dart';
import 'package:orient_motors/presentation/pages/search/pages/search_list_page.dart';
import 'package:orient_motors/presentation/pages/search/search_page.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

import '../../infrastructure/services/local_database/db_service.dart';
import '../pages/core/app_widget.dart';
import '../pages/core/no_connection.dart';

class AppRoutes {
  static PageRoute getAppWidget(
    DBService dbService,
    bool connectivityResult,
  ) =>
      MaterialPageRoute(
        builder: (_) => MyApp(
          dbService: dbService,
          connectivityX: connectivityResult,
        ),
      );

  static PageRouteBuilder login({String? phoneNumber, Function()? onClose}) {
    return PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (_, __, ___) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: LoginPage(phoneNumber: phoneNumber, onClose: onClose)));
  }

  static MaterialPageRoute singUp({Function()? onClose}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: SingUpPhoneNumberPage(
              onClose: onClose,
            )));
  }

  /// fill sms code
  static PageRouteBuilder getFillSmsCode(
      {required String phoneNumber, required String? password, required String autofill, Function()? onClose}) {
    return PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (_, __, ___) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: FillSmsCodePage(
              onClose: onClose,
              phoneNumber: phoneNumber,
              password: password,
              autofill: autofill,
            )));
  }

  /// fill personal info
  static MaterialPageRoute getFillPersonalInfo({required String phoneNumber, Function()? onClose}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: FillPersonalInfoPage(phoneNumber: phoneNumber, onClose: onClose)));
  }

  /// reset password
  static MaterialPageRoute getResetPassword({String? phoneNumber}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: ResetPasswordPage(
              phoneNumber: phoneNumber,
            )));
  }

  static MaterialPageRoute getHome(ScrollController controller, BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: HomePage(scrollController: controller),
        ),
      );

  static MaterialPageRoute getNetworkNotFound() => MaterialPageRoute(
        builder: (_) => const NoConnection(),
      );

  /// main
  static MaterialPageRoute main({int? index}) => MaterialPageRoute(
        builder: (_) => BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(AuthRepository(context.read<DBService>(), AuthService.create()),
              CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()))
            ..add(const ProfileEvent.getProfile())
            ..add(const ProfileEvent.getOwnActualCars(isActive: "1"))
            ..add(const ProfileEvent.getOwnActualCars(isActive: "0"))
            ..add(const ProfileEvent.getDrafts())
            ..add(const ProfileEvent.getLikedList())
            ..add(const ProfileEvent.getSeenList()),
          child: BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
              FilterRepository(context.read<DBService>(), FilterService.create()),
              CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
              SpecificationsRepository(context.read<DBService>(), SpecificationsService.create()),
              ServicesRepository(context.read<DBService>(), ServicesService.create()),
            ),
            child: MainPage(index: index),
          ),
        ),
      );

  ///search pages
  ///set brand
  static MaterialPageRoute setBrand(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetBrandPage(),
        ),
      );

  ///set model
  static MaterialPageRoute setModel(BuildContext context, String id) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>()
            ..add(SearchEvent.getListModels(id: id, isUsed: 1, isTop: 1))
            ..add(SearchEvent.getListModels(id: id, isUsed: 1)),
          child: const SetModelPage(),
        ),
      );

  ///set mgeneratio
  static MaterialPageRoute setGeneration(BuildContext context, String id) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>()..add(SearchEvent.getListGenerations(id: id)),
          child: const SetGenerationPage(),
        ),
      );

  ///set years
  static MaterialPageRoute setYearOfIssue(BuildContext context, String selectedDate, [int? startYear, int? endYear]) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: SetYearOfIssuePage(
            selectedDate: selectedDate,
            startYear: startYear,
            endYear: endYear,
          ),
        ),
      );

  ///set Body Type
  static MaterialPageRoute setBodyType(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetBodyTypePage(),
        ),
      );

  ///set serice
  static MaterialPageRoute setService(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetServicePage(),
        ),
      );

  ///service info
  static MaterialPageRoute serviceInfo(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const ServiceInfoPage(),
        ),
      );

  ///set fuel
  static MaterialPageRoute setFuel(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetFuelPage(),
        ),
      );

  ///set transmision
  static MaterialPageRoute setTransmisson(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetTransmissionPage(),
        ),
      );

  ///set region
  static MaterialPageRoute setRegion(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetRegionPage(),
        ),
      );

  ///set color
  static MaterialPageRoute setColor(BuildContext context, List<FilterItemModel>? selectedItems) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: SetColorPage(
            selectedItems: selectedItems, // context.read<SearchBloc>().state.bodyTypeValue,
          ),
        ),
      );

  ///set color
  static MaterialPageRoute setSalesman(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: const SetSalesmanPage(),
        ),
      );

  ///result
  static MaterialPageRoute goToResult(BuildContext context, {int? index, int? generation}) {
    SearchBloc searchBloc = context.read<SearchBloc>();
    if (generation != null) {
      context.read<SearchBloc>()
        ..add(SearchEvent.setFilterValue(value: generation.toString(), valueId: generation, filtrType: FilterType.generation))
        ..add(const SearchEvent.makeReqToFilter(page: 1, pageSize: 20));
    }
    if (index != null) {
      searchBloc.add(SearchEvent.makeReqToSearch(pageSize: 20, page: 1, index: index));
    }
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: searchBloc,
        child: const ResultPage(),
      ),
    );
  }

  /// menu
  static MaterialPageRoute getMenu() => MaterialPageRoute(
        builder: (_) => const MenuPage(),
      );

  /// signup for diagnostic
  static MaterialPageRoute getSignupForDiagnostic() => MaterialPageRoute(
        builder: (_) => const SignupForDiagnosticPage(),
      );

  ///  review cars
  static MaterialPageRoute getReviewCars(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ReviewBloc>(),
          child: BlocProvider(
            create: (context) => SearchBloc(
              FilterRepository(context.read<DBService>(), FilterService.create()),
              CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
              SpecificationsRepository(
                context.read<DBService>(),
                SpecificationsService.create(),
              ),
              ServicesRepository(
                context.read<DBService>(),
                ServicesService.create(),
              ),
            ),
            child: ReviewCarsPage(vmController: ReviewController()),
          ),
        ),
      );

  static MaterialPageRoute getReviewBrands(BuildContext context, ReviewController vmController) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>()
            ..add(const SearchEvent.getListBrands())
            ..add(const SearchEvent.getListBrands(isTop: 1)),
          child: ReviewBrandsPage(vmController: vmController),
        ),
        fullscreenDialog: true,
      );

  static MaterialPageRoute getReviewCarModel(BuildContext context, ReviewController vmController) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>()
            ..add(
              SearchEvent.getListModels(id: context.read<SearchBloc>().state.brandValueId.toString()),
            ),
          child: ReviewCarModelPage(vmController: vmController),
        ),
        fullscreenDialog: true,
      );

  static MaterialPageRoute getReviewGeneration(BuildContext context, ReviewController vmController) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>()
            ..add(
              SearchEvent.getListGenerations(id: context.read<SearchBloc>().state.modelValueId.toString()),
            ),
          child: ReviewGenerationPage(vmController: vmController),
        ),
        fullscreenDialog: true,
      );

  ///  car detail
  static MaterialPageRoute getReviewCarDetail(BuildContext context, ReviewListModel item, ReviewController vmController) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (BuildContext context) => ReviewBloc(
            AuthRepository(context.read<DBService>(), AuthService.create()),
            ReviewRepository(context.read<DBService>(), ReviewService.create()),
            SpecificationsRepository(context.read<DBService>(), SpecificationsService.create()),
            CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
          )
            ..add(ReviewEvent.getDesign(id: item.id ?? 0))
            ..add(ReviewEvent.getSysthesis(id: item.id ?? 0))
            ..add(ReviewEvent.getFaq(id: item.id ?? 0))
            ..add(ReviewEvent.getSafetyConvenience(id: item.id ?? 0))
            ..add(ReviewEvent.getSizeSpace(id: item.id ?? 0))
            ..add(ReviewEvent.getSpecification(id: item.id ?? 0))
            ..add(ReviewEvent.getMaintenance(id: item.id ?? 0))
            ..add(ReviewEvent.getPrice(id: item.id ?? 0))
            ..add(ReviewEvent.getLink(id: item.id ?? 0))
            ..add(ReviewEvent.getComments(id: item.id ?? 0))
            ..add(const ReviewEvent.getListFilter()),
          child: ReviewCarDetailPage(
            item: item,
            vmController: vmController,
          ),
        ),
      );

  ///  premium diagnostic
  static MaterialPageRoute getPremiumDiagnostic() => MaterialPageRoute(
        builder: (_) => const PremiumDiagnosticPage(),
      );

  ///  branches
  static MaterialPageRoute getBranches(BuildContext context) => MaterialPageRoute(builder: (_) {
        return BlocProvider.value(
          value: context.read<MainBloc>(),
          child: const BranchesPage(),
        );
      });

  ///  branch detail
  static MaterialPageRoute getBranchDetail({required BranchModel param}) => MaterialPageRoute(
        builder: (_) => BranchDetailPage(param: param),
      );

  ///  news
  static MaterialPageRoute getNews(BuildContext context) => MaterialPageRoute(
        builder: (_) {
          return BlocProvider.value(
            value: context.read<MainBloc>(),
            child: const NewsPage(),
          );
        },
      );

  ///  news detail
  static MaterialPageRoute getNewsDetail({required NewsModel param}) => MaterialPageRoute(
        builder: (_) => NewsDetailPage(param: param),
      );

  ///  used cars
  static MaterialPageRoute getUsedCars() => MaterialPageRoute(
        builder: (_) => const UsedCarsPage(),
      );

  ///  favorites
  static MaterialPageRoute getFavorites({required int index}) => MaterialPageRoute(
        builder: (_) => FavoritesPage(index: index),
      );

  ///  add car
  // static MaterialPageRoute getAddCar() => MaterialPageRoute(
  //       builder: (_) => const AddCarPage(),
  //     );

  ///  product card
  static MaterialPageRoute getProductCard({required CarModel model}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<CarDetailBloc>(
        create: (context) => CarDetailBloc(
          CarRepository(
            context.read<DBService>(),
            CarService.create(),
            UploadImage.create(),
            Dio(),
          ),
          FilterRepository(
            context.read<DBService>(),
            FilterService.create(),
          ),
        )
          ..add(CarDetailEvent.getCarWithId(id: model.id ?? 0))
          ..add(const CarDetailEvent.getFaq()),
        child: BlocProvider(
          create: (context) => ReviewBloc(
            AuthRepository(context.read<DBService>(), AuthService.create()),
            ReviewRepository(context.read<DBService>(), ReviewService.create()),
            SpecificationsRepository(context.read<DBService>(), SpecificationsService.create()),
            CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
          ),
          child: ProductCardPage(model: model),
        ),
      ),
    );
  }

  ///  gallery detail
  static MaterialPageRoute getGalleryDetail({required List<ImagesModel> images}) => MaterialPageRoute(
        builder: (_) => GalleryDetailPage(images: images),
      );

  static MaterialPageRoute getVoteGeneration({required ReviewFilterReq model, required BuildContext context}) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ReviewBloc>(),
          child: VoteGenerationWidget(
            model: model,
            asPage: true,
          ),
        ),
      );

  ///  useer info
  static MaterialPageRoute getUserInfo({required Owner owner, required BuildContext context}) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CarDetailBloc>()..add(CarDetailEvent.getUserCars(id: owner.id ?? 0)),
          child: UserInfoPage(owner: owner),
        ),
      );

  ///  complaint
  static MaterialPageRoute getComplaint() => MaterialPageRoute(
        builder: (_) => const ComplaintPage(),
      );

  /// my ads
  static MaterialPageRoute getMyAds(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: const MyAdsPage(),
        ),
      );

  /// edit profile
  static MaterialPageRoute getEditProfile(BuildContext context) => MaterialPageRoute(
        settings: const RouteSettings(name: "EditProfilePage"),
        builder: (_) => BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: const EditProfilePage(),
        ),
      );

  /// get profile
  static MaterialPageRoute getProfile(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider<ProfileBloc>.value(
          value: context.read<ProfileBloc>(),
          child: const ProfilePage(),
        ),
      );

  /// select region
  static MaterialPageRoute getSelectRegion() => MaterialPageRoute(
        builder: (_) => const SelectRegionPage(),
      );

  /// my cards
  static MaterialPageRoute getMyCards() => MaterialPageRoute(
        builder: (_) => const MyCardsPage(),
      );

  /// payment history
  static MaterialPageRoute getPaymentHistory() => MaterialPageRoute(
        builder: (_) => const PaymentHistoryPage(),
      );

  /// top up balance
  static MaterialPageRoute getTopUpBalance() => MaterialPageRoute(
        builder: (_) => const TopUpBalancePage(),
      );

  /// card adding
  static MaterialPageRoute getCardAdding() => MaterialPageRoute(
        builder: (_) => const CardAddingPage(),
      );

  /// safety code enter
  static MaterialPageRoute getSafetyCodeEnter() => MaterialPageRoute(
        builder: (_) => const SafetyCodeEnterPage(),
      );

  /// top up finished
  static MaterialPageRoute getTopUpFinished() => MaterialPageRoute(
        builder: (_) => const TopUpFinishedPage(),
      );

  /// chat detail
  static MaterialPageRoute getChatDetail() => MaterialPageRoute(
        builder: (_) => const ChatDetailPage(),
      );

  /// guarantee
  static MaterialPageRoute getGuarantee() => MaterialPageRoute(
        builder: (_) => const GuaranteePage(),
      );

  /// guarantee detail
  static MaterialPageRoute getGuaranteeDetail() => MaterialPageRoute(
        builder: (_) => const GearanteeDetailPage(),
      );

  /// default settings
  // static MaterialPageRoute getDefaultSettings() => MaterialPageRoute(
  //       builder: (_) => const DefaultSettingsPage(),
  //     );

  /// car create
  static MaterialPageRoute getCreateCar({int? draftId, int? postId, required String phoneNumber, int? regionId}) => MaterialPageRoute(
        builder: (_) => BlocProvider<AddCarBloc>(
          create: (context) => AddCarBloc(
            CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
            SpecificationsRepository(
              context.read<DBService>(),
              SpecificationsService.create(),
            ),
          )
            ..add(const AddCarEvent.getListBrands(
              isTop: 1,
            ))
            ..add(AddCarEvent.getInitialValue(draftId: draftId, phoneNumber: phoneNumber, regionId: regionId, postId: postId)),
          child: const AddCarPage(),
        ),
      );

  /// notification
  static MaterialPageRoute getNotification(BuildContext context) {
    context.read<MainBloc>().add(const MainEvent.getNotificationsList());
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<MainBloc>(),
        child: const NotificationPage(),
      ),
    );
  }

  /// change number
  static MaterialPageRoute getChangeNumber({required ProfileRes profile}) => MaterialPageRoute(
        builder: (_) => ChangeNumberPage(
          profile: profile,
        ),
      );

  /// change with number
  static MaterialPageRoute getChangeWithNumber() => MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: const ChangeWithNumberPage()),
      );

  /// safety code enter for phone
  static MaterialPageRoute getSafetyCodeEnterForPhone({
    required String phoneNumber,
    required String autofill,
  }) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: SafetyCodeEnterForPhonePage(
              autofill: autofill,
              phoneNumber: phoneNumber,
            )),
      );

  /// change password profile
  static MaterialPageRoute getChangePasswordProfile() => MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) => AuthBloc(AuthRepository(
                  context.read<DBService>(),
                  AuthService.create(),
                )),
            child: const ChangePasswordProfilePage()),
      );

  /// search
  static MaterialPageRoute getSearch({required int count}) => MaterialPageRoute(
      builder: (_) => BlocProvider(
          create: (context) => SearchBloc(
                FilterRepository(context.read<DBService>(), FilterService.create()),
                CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
                SpecificationsRepository(
                  context.read<DBService>(),
                  SpecificationsService.create(),
                ),
                ServicesRepository(
                  context.read<DBService>(),
                  ServicesService.create(),
                ),
              )..add(const SearchEvent.makeReqToFilter(page: 1, pageSize: 20)),
          child: SearchPage(
            count: count,
          )));

  /// about
  static MaterialPageRoute getAbout() => MaterialPageRoute(builder: (_) => const AboutPage());

  /// faq
  static MaterialPageRoute getFAQ() => MaterialPageRoute(builder: (_) => const FAQPage());

  /// search list
  static MaterialPageRoute getSearchList(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SearchBloc>(),
          child: BlocProvider(
            create: (context) => SearchBloc(
              FilterRepository(context.read<DBService>(), FilterService.create()),
              CarRepository(context.read<DBService>(), CarService.create(), UploadImage.create(), Dio()),
              SpecificationsRepository(context.read<DBService>(), SpecificationsService.create()),
              ServicesRepository(context.read<DBService>(), ServicesService.create()),
            )..add(const SearchEvent.getSearchesList()),
            child: const SearchListPage(),
          ),
        ),
      );

  static MaterialPageRoute getIntro() => MaterialPageRoute(
        builder: (_) => const IntroScreen(),
      );
}

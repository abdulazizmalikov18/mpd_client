import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:orient_motors/domain/common/token.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/chat/chat.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/domain/models/services/services_model.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';
import 'package:orient_motors/domain/models/upload_image/upload_image.dart';
import 'package:orient_motors/domain/serializers/built_value_converter.dart';
import 'package:orient_motors/infrastructure/core/interceptors.dart';
import 'package:orient_motors/infrastructure/repositories/auth_repo.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/infrastructure/services/log_service.dart';
import 'package:orient_motors/utils/constants.dart';

part 'apis.chopper.dart';

//users
@ChopperApi(baseUrl: '/users/')
abstract class AuthService extends ChopperService {
  @Post(path: 'verification-code/send/')
  Future<Response<SuccessModel>> verificationSend({
    @Body() required VerificationSendReq request,
  });

  @Post(path: 'check')
  Future<Response<CheckAuthModel>> checkAuth({
    @Body() required VerificationSendReq request,
  });

  @Post(path: 'verification-code/verify/')
  Future<Response<LoginRes>> verificationVerify({
    @Body() required VerificationVerifyReq request,
  });

  @Put(path: 'registration/')
  Future<Response<SuccessModel>> registration({
    @Header('Authorization') required String token,
    @Body() required RegisterReq request,
  });

  @Post(path: 'login')
  Future<Response<LoginRes>> signIn({
    @Body() required SignInReq request,
  });

  @Put(path: 'password')
  Future<Response<SuccessModel>> updatePassword({
    @Header('Authorization') required String token,
    @Body() required ResetPasswordReq request,
  });

  @Post(path: 'forgot-password')
  Future<Response<LoginRes>> forgotPassword({
    @Body() required ForgotPasswordReqModel request,
  });

  @Patch(path: 'profile')
  Future<Response<SuccessModel>> updateProfile({
    @Header('Authorization') required String token,
    @Body() required ProfileModel request,
  });

  @Post(path: 'phone-update/')
  Future<Response<SuccessModel>> updatePhone({
    @Header('Authorization') required String token,
    @Body() required VerificationVerifyReq request,
  });

  @Post(path: 'verify/add-phone/')
  Future<Response<SuccessModel>> additionalNumberVerify({
    @Body() required VerificationVerifyReq request,
  });

  @Get(path: 'get/own-cars/{is_active}/')
  Future<Response<BuiltList<CarModel>>> getOwnCars({
    @Header('Authorization') required String token,
    @Path('is_active') required String isActive,
  });

  @Get(path: 'get/drafts')
  Future<Response<BuiltList<CarModel>>> getDrafts({
    @Header('Authorization') required String token,
  });

  @Get(path: 'profile')
  Future<Response<ProfileRes>> getProfile({
    @Header('Authorization') required String token,
  });

  @Delete(path: 'destroy')
  Future<Response<SuccessModel>> deleteProfile({
    @Header('Authorization') required String token,
  });

  @Get(path: 'liked/list')
  Future<Response<BuiltList<CarModel>>> getLikedList({
    @Header('Authorization') required String token,
  });

  @Patch(path: 'like/{id}/')
  Future<Response<SuccessModel>> patchLike({
    @Header('Authorization') required String token,
    @Path('id') required int id,
  });

  @Get(path: 'seen/list')
  Future<Response<BuiltList<CarModel>>> getSeenList({
    @Header('Authorization') required String token,
  });

  @Patch(path: 'seen/{id}')
  Future<Response<SuccessModel>> patchSeen({
    @Header('Authorization') required String token,
    @Path('id') required int id,
  });

  static AuthService create() =>
      _$AuthService(_Client(Constants.baseUrlP, true));
}

// token
//users
@ChopperApi(baseUrl: '/token/')
abstract class TokenService extends ChopperService {
  @Post(path: 'refresh/')
  Future<Response<LoginRes>> postRefreshToken({
    @Body() required LoginRes refresh,
  });

  static TokenService create() =>
      _$TokenService(_Client(Constants.baseUrlP, true));
}

//car
@ChopperApi(baseUrl: '/car/')
abstract class CarService extends ChopperService {
  @Get(path: 'brand/list/')
  Future<Response<BrandResResult>> getListBrand({
    @Query('page') required int? page,
    @Query('page_size') required int? pageSize,
    @Query("isUsed") int? isUsed,
    @Query("isTop") int? isTop,
  });

  @Post(path: 'complaint/post/')
  Future<Response<BuiltList<dynamic>>> postComplaint();

  @Get(path: 'complaint/reasons/')
  Future<Response<BuiltList<dynamic>>> getReasonsComplaint();

  @Get(path: 'faq')
  Future<Response<BuiltList<QuestionModel>>> getFaq();

  @Get(path: 'diagnosed-cars/')
  Future<Response<BuiltList<dynamic>>> getDiagnosedCars();

  @Get(path: 'generations/configurations/{id}/')
  Future<Response<BuiltList<GenerationsConfigurationsRes>>>
      getConfigurationsGenerations({
    @Path('id') required String id,
  });

  @Get(path: 'get/{id}/')
  Future<Response<CarModel>> getCarWithId({
    @Path('id') required int id,
  });

  @Get(path: 'list/')
  Future<Response<BuiltList<dynamic>>> getCarWithPage({
    @Query("page") required int page,
  });

  @Get(path: 'model/generations/{id}')
  Future<Response<BuiltList<GenerationModel>>> getGenerationsModel({
    @Path("id") required String id,
  });

  @Get(path: 'draft/{id}/')
  Future<Response<CarModel>> getDraft({
    @Path("id") required int id,
  });

  @Get(path: 'model/list/{id}?isUsed={isUsed}&isTop={isTop}')
  Future<Response<BuiltList<CarModel>>> getListModel({
    @Path("id") required String id,
    @Query("isUsed") int? isUsed,
    @Query("isTop") int? isTop,
  });

  @Get(path: 'owned-by-orient-motors/')
  Future<Response<dynamic>> getOwnedByOrientMotors({
    @Query("page") required int page,
  });

  @Get(path: 'premium-diagnosed-cars/')
  Future<Response<BuiltList<dynamic>>> getPremiumDiagnosedCars();

  @Post(path: '')
  Future<Response<dynamic>> createCar(
    @Body() CreateCarReq request,
    @Header('Authorization') String token,
  );

  @Post(path: 'draft/create')
  Future<Response<dynamic>> createDraftCar(
    @Body() CreateCarReq request,
    @Header('Authorization') String token,
  );

  @Put(path: 'status/{id}')
  Future<Response<dynamic>> putArchive(
      @Header('Authorization') String token, @Path('id') int id);

  @Delete(path: 'get/{id}/')
  Future<Response<dynamic>> deletePost(
      @Header('Authorization') String token, @Path('id') int id);

  @Patch(path: 'draft/update/{id}/')
  Future<Response<dynamic>> updateDraftCar(@Body() CreateCarReq request,
      @Header('Authorization') String token, @Path('id') int id);

  @Patch(path: 'update/{id}')
  Future<Response<dynamic>> editCar(@Body() CreateCarReq request,
      @Header('Authorization') String token, @Path('id') int id);

  @Delete(path: 'draft/img/{id}')
  Future<Response<dynamic>> deleteImageDraftCar(
      @Header('Authorization') String token, @Path('id') int id);

  @Delete(path: 'draft/additional-phone/{id}')
  Future<Response<dynamic>> deleteAdditionalPhoneDraftCar(
      @Header('Authorization') String token, @Path('id') int id);

  @Delete(path: 'draft/{id}/')
  Future<Response<dynamic>> deleteDraft(
      @Header('Authorization') String token, @Path('id') int id);

  @Get(path: 'get-cars/{id}/')
  Future<Response<CarResResult>> getUserCars({@Path('id') required int id});

  static CarService create() => _$CarService(_Client(Constants.baseUrlP, true));
}

// main
@ChopperApi(baseUrl: '/main/')
abstract class UploadImage extends ChopperService {
  @Post(path: 'key-gen')
  Future<Response<BuiltList<PreSignedUrlRes>>> generatePreSignedUrl(
    @Body() BuiltList<PreSignedUrlReq> request,
    @Header('Authorization') String token,
  );

  static UploadImage create() =>
      _$UploadImage(_Client(Constants.baseUrlP, true));
}

//filter
@ChopperApi(baseUrl: '/filter/')
abstract class FilterService extends ChopperService {
  @Get(path: '')
  Future<Response<FilterRes>> getFilter(
      {@Query('mark') String? mark,
      @Query('model') String? model,
      @Query('generations') String? generation,
      @Query('fuelType') String? fuelType,
      @Query('colors') String? color,
      @Query('bodyTypes') String? bodyType,
      @Query('transmissions') String? transmission,
      @Query('region') String? region,
      @Query('yearTo') String? yearTo,
      @Query('yearFrom') String? yearFrom,
      @Query('priceFrom') String? priceFrom,
      @Query('priceTo') String? priceTo,
      @Query('mileageFrom') String? mileageFrom,
      @Query('mileageTo') String? mileageTo,
      @Query('warranty') int? warranty,
      @Query('orientDiagnostics') int? orientDiagnostics,
      @Query('page') int? page,
      @Query('page_size') int? pageSize,
      @Query('currency') String? currency,
      @Query('order-by') String? orderBy,
      @Query('services') String? services,
      @Query('isUsed') int? isUsed});

  @Get(path: 'body-type/')
  Future<Response<BuiltList<NamedModel>>> getBodyTypes();

  @Get(path: 'color/')
  Future<Response<BuiltList<NamedModel>>> getColors();

  @Get(path: 'total-cars/')
  Future<Response<TotalCarsRes>> getTotalCars();

  @Post(path: 'search/create')
  Future<Response<FilterSearchReq>> searchCreate(
      {@Body() required FilterSearchReq request});

  @Get(path: 'searches/list')
  Future<Response<BuiltList<FilterSearchRes>>> getSearchesList(
    @Header('Authorization') String token,
  );

  @Delete(path: 'searches/{id}')
  Future<Response<dynamic>> deleteSearches({
    @Header('Authorization') required String token,
    @Path('id') required int id,
  });

  @Get(path: 'generations/{name}')
  Future<Response<BuiltList<SearchList>>> getSearchesGenerationList(
      @Path('name') String name);

  static FilterService create() =>
      _$FilterService(_Client(Constants.baseUrlP, true));
}

//specifications
@ChopperApi(baseUrl: '/specifications/')
abstract class SpecificationsService extends ChopperService {
  @Get(path: 'region/list/')
  Future<Response<BuiltList<NamedModel>>> getRegionList();

  @Get(path: 'transmission/list/')
  Future<Response<BuiltList<NamedModel>>> getTransmissionList();

  @Get(path: 'body-type/{id}')
  Future<Response<BuiltList<NamedModel>>> getBodyTypeList(
      {@Path("id") required String id});

  @Get(path: 'body-type/list/')
  Future<Response<BuiltList<NamedModel>>> getBodyTypes();

  @Get(path: 'fuel/list/')
  Future<Response<BuiltList<NamedModel>>> getFuelTypeList();

  @Get(path: 'color/list/')
  Future<Response<BuiltList<NamedModel>>> getColorList();

  @Get(path: 'drive-unit/list/')
  Future<Response<BuiltList<DriveUnitModel>>> getDriveUnitList();

  @Get(path: 'paint-condition/list/')
  Future<Response<BuiltList<DriveUnitModel>>> getPaintConditionList();

  @Get(path: 'options/{id}')
  Future<Response<OptionsRes>> getOptions({@Path('id') required String id});

  @Delete(path: 'changed-part-info/delete/{id}')
  Future<Response<dynamic>> deleteChangedPartInfo(
      {@Header('Authorization') required String token,
      @Path('id') required int id});

  @Get(path: 'options/list')
  Future<Response<OptionsRes>> getOptionsList();

  @Get(path: 'changed-parts/list')
  Future<Response<BuiltList<UzModel>>> getChangedPartsList();

  @Get(path: 'changed-parts-quality/list')
  Future<Response<BuiltList<NamedModel>>> getChangedPartsQualityList();

  static SpecificationsService create() =>
      _$SpecificationsService(_Client(Constants.baseUrlP, true));
}

//services
@ChopperApi(baseUrl: '/services/')
abstract class ServicesService extends ChopperService {
  @Get(path: 'list')
  Future<Response<BuiltList<ServicesRes>>> getServicesList();

  static ServicesService create() =>
      _$ServicesService(_Client(Constants.baseUrlP, true));
}

//services
@ChopperApi(baseUrl: '/main/')
abstract class MainService extends ChopperService {
  @Get(path: 'currency')
  Future<Response<CurrencyModel>> getCurrency();

  @Get(path: "branch-region/{id}/")
  Future<Response<BuiltList<BranchModel>>> getBranchList(
      {@Path("id") required int id});

  @Post(path: "branch/complaint/post/")
  Future<Response<BranchComplaintModel>> postBranchComplaint(
      {@Body() required BranchComplaintModel request});

  @Get(path: "news/list/")
  Future<Response<BuiltList<NewsModel>>> getNewsList(
      {@Query("type") required String type});

  @Get(path: "notifications/list/")
  Future<Response<BuiltList<NotificationModel>>> getNotificationsList(
      {@Header('Authorization') required String token});

  @Get(path: "notifications/unread/")
  Future<Response<UnreadModel>> getNotificationsUnread(
      {@Header('Authorization') required String token});

  @Patch(path: "notifications/unread/")
  Future<Response<SuccessModel>> patchNotificationsUnread(
      {@Header('Authorization') required String token});

  @Patch(path: "notifications/actions/{id}/")
  Future<Response<SuccessModel>> patchNotificationsActions({
    @Header('Authorization') required String token,
    @Path("id") required int id,
  });

  static MainService create() =>
      _$MainService(_Client(Constants.baseUrlP, true));
}

//services
@ChopperApi(baseUrl: '/review/')
abstract class ReviewService extends ChopperService {
  @Get(path: 'systhesis/{car_review_id}/')
  Future<Response<ReviewSysthesisModel>> getServicesList({
    @Path("car_review_id") required int carReviewId,
  });

  // @Get(path: 'list/')
  // Future<Response<BuiltList<ReviewListModel>>> getList();

  @Get(path: 'filter/')
  Future<Response<ReviewFilterEither>> getListFilter({
    @Query('mark') int? mark,
    @Query('model') int? model,
    @Query("generation") int? generation,
    @Query("body-type") int? bodyType,
    @Query("order-by") String? orderBy,
  });

  @Get(path: 'faq/{car_review_id}/')
  Future<Response<BuiltList<ReviewFaqModel>>> getFaq(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'design/{car_review_id}/')
  Future<Response<ReviewDesignModel>> getDesign(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'safety-convenience/{car_review_id}/')
  Future<Response<ReviewSafetyConvenienceModel>> getSafetyConvenience(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'size-space/{car_review_id}/')
  Future<Response<ReviewSizeSpaceModel>> getSizeSpace(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'maintenance/{car_review_id}/')
  Future<Response<ReviewMaintenanceModel>> getMaintenance(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'price/{car_review_id}/')
  Future<Response<ReviewPriceModel>> getPrice(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'specification/{car_review_id}/')
  Future<Response<ReviewSpecificationModel>> getSpecification(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'link/{car_review_id}')
  Future<Response<ReviewLinkModel>> getLink(
      {@Path("car_review_id") required int carReviewId});

  @Get(path: 'comments/{car_review_id}/')
  Future<Response<BuiltList<CommentsModel>>> getComments(
      {@Path("car_review_id") required int carReviewId});

  @Post(path: 'comment-post')
  Future<Response<CommentModel>> postComment(
      {@Body() required CommentModel request,
      @Header('Authorization') required String token});

  @Post(path: 'vote/generation/{id}')
  Future<Response<dynamic>> voteGeneration({
    @Path() required int id,
  });

  @Get(path: 'get-id')
  Future<Response<ReviewIdEither>> getId({
    @Query('mark') int? mark,
    @Query('model') int? model,
    @Query("generation") int? generation,
  });

  static ReviewService create() =>
      _$ReviewService(_Client(Constants.baseUrlP, true));
}

//Chat
@ChopperApi(baseUrl: '/chat/')
abstract class ChatService extends ChopperService {
  @Post(path: 'add-who-wrote')
  Future<Response<SuccessModel>> addWhoWrote(
      {@Body() required ChatWroteModel request});

  @Post(path: 'block-user')
  Future<Response<ChatBlockModel>> blockUser(
      {@Body() required ChatBlockModel request});

  @Post(path: 'change-user-status')
  Future<Response<SuccessModel>> changeUserStatus(
      {@Body() required UserStatusModel request});

  @Post(path: 'check-is-online')
  Future<Response<SuccessModel>> checkIsOnline(
      {@Body() required UserStatusModel request});

  @Get(path: 'contacts')
  Future<Response<BuiltList<ContactModel>>> getContacts(
      {@Header('Authorization') required String token});

  @Post(path: 'create-chat-message')
  Future<Response<SuccessModel>> createChatMessage(
      {@Body() required ChatMessageReq request});

  @Post(path: 'create-room')
  Future<Response<ChatRoomModel>> createRoom(
      {@Body() required ChatRoomModel request});

  @Get(path: 'get-room/{id}')
  Future<Response<ChatRoomModel>> getRoom(
      {@Path("id") required int id,
      @Header('Authorization') required String token});

  @Get(path: 'get-user/{id}')
  Future<Response<ChatUserModel>> getUser(
      {@Path("id") required int id,
      @Header('Authorization') required String token});

  @Get(path: 'messages')
  Future<Response<BuiltList<ChatMessageRes>>> getMessage({
    @Header('Authorization') required String token,
    @Query("room_id") required int roomId,
  });

  @Get(path: 'room-exist-check')
  Future<Response<RoomExistModel>> getRoomExistCheck({
    @Header('Authorization') required String token,
    @Query("sender_id") int? senderId,
    @Query("receiver_id") int? receiverId,
    @Query("announcement_id") int? announcementId,
  });

  static ChatService create() =>
      _$ChatService(_Client(Constants.baseUrlP, true));
}

base class _Client extends ChopperClient {
  _Client(String baseUrl, bool useInterceptors)
      : super(
          baseUrl: Uri.parse(baseUrl),
          interceptors: useInterceptors
              ? [
                  CoreInterceptor(),
                  HttpLoggingInterceptor(),
                  NetworkInterceptor(),
                  BackendInterceptor(),
                  CurlInterceptor(),
                ]
              : const [],
          converter: BuiltValueConverter(),
          errorConverter: ErrorMyConverter(),
          authenticator: MyAuthenticator(),
        );
}

class MyAuthenticator extends Authenticator {
  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    if (response.statusCode == 401) {
      final dbService = await DBService.create;

      try {
        final result = await AuthRepository.refreshToken(
            dbService.token.refreshToken ?? "");

        Map<String, String>? header;

        result.fold((error) {
          dbService.signOut();
        }, (data) {
          dbService.setToken(
              Token(accessToken: data.access, refreshToken: data.refresh));

          String? newToken = data.access;

          final Map<String, String> updatedHeaders =
              Map<String, String>.of(request.headers);

          newToken = 'Bearer $newToken';
          updatedHeaders.update('Authorization', (String _) => newToken!,
              ifAbsent: () => newToken!);

          header = updatedHeaders;
        });

        return request.copyWith(headers: header);
      } catch (e) {
        LogService.i(e.toString());

        dbService.signOut();
      }
    }
    return null;
  }
}

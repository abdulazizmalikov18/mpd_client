// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apis.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthService;

  @override
  Future<Response<SuccessModel>> verificationSend(
      {required VerificationSendReq request}) {
    final Uri $url = Uri.parse('/users/verification-code/send/');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<CheckAuthModel>> checkAuth(
      {required VerificationSendReq request}) {
    final Uri $url = Uri.parse('/users/check');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CheckAuthModel, CheckAuthModel>($request);
  }

  @override
  Future<Response<LoginRes>> verificationVerify(
      {required VerificationVerifyReq request}) {
    final Uri $url = Uri.parse('/users/verification-code/verify/');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<SuccessModel>> registration({
    required String token,
    required RegisterReq request,
  }) {
    final Uri $url = Uri.parse('/users/registration/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<LoginRes>> signIn({required SignInReq request}) {
    final Uri $url = Uri.parse('/users/login');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<SuccessModel>> updatePassword({
    required String token,
    required ResetPasswordReq request,
  }) {
    final Uri $url = Uri.parse('/users/password');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<LoginRes>> forgotPassword(
      {required ForgotPasswordReqModel request}) {
    final Uri $url = Uri.parse('/users/forgot-password');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<SuccessModel>> updateProfile({
    required String token,
    required ProfileModel request,
  }) {
    final Uri $url = Uri.parse('/users/profile');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<SuccessModel>> updatePhone({
    required String token,
    required VerificationVerifyReq request,
  }) {
    final Uri $url = Uri.parse('/users/phone-update/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<SuccessModel>> additionalNumberVerify(
      {required VerificationVerifyReq request}) {
    final Uri $url = Uri.parse('/users/verify/add-phone/');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<BuiltList<CarModel>>> getOwnCars({
    required String token,
    required String isActive,
  }) {
    final Uri $url = Uri.parse('/users/get/own-cars/${isActive}/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<CarModel>, CarModel>($request);
  }

  @override
  Future<Response<BuiltList<CarModel>>> getDrafts({required String token}) {
    final Uri $url = Uri.parse('/users/get/drafts');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<CarModel>, CarModel>($request);
  }

  @override
  Future<Response<ProfileRes>> getProfile({required String token}) {
    final Uri $url = Uri.parse('/users/profile');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ProfileRes, ProfileRes>($request);
  }

  @override
  Future<Response<SuccessModel>> deleteProfile({required String token}) {
    final Uri $url = Uri.parse('/users/destroy');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<BuiltList<CarModel>>> getLikedList({required String token}) {
    final Uri $url = Uri.parse('/users/liked/list');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<CarModel>, CarModel>($request);
  }

  @override
  Future<Response<SuccessModel>> patchLike({
    required String token,
    required int id,
  }) {
    final Uri $url = Uri.parse('/users/like/${id}/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<BuiltList<CarModel>>> getSeenList({required String token}) {
    final Uri $url = Uri.parse('/users/seen/list');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<CarModel>, CarModel>($request);
  }

  @override
  Future<Response<SuccessModel>> patchSeen({
    required String token,
    required int id,
  }) {
    final Uri $url = Uri.parse('/users/seen/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$TokenService extends TokenService {
  _$TokenService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = TokenService;

  @override
  Future<Response<LoginRes>> postRefreshToken({required LoginRes refresh}) {
    final Uri $url = Uri.parse('/token/refresh/');
    final $body = refresh;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginRes, LoginRes>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CarService extends CarService {
  _$CarService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CarService;

  @override
  Future<Response<BrandResResult>> getListBrand({
    required int? page,
    required int? pageSize,
    int? isUsed,
    int? isTop,
  }) {
    final Uri $url = Uri.parse('/car/brand/list/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
      'isUsed': isUsed,
      'isTop': isTop,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BrandResResult, BrandResResult>($request);
  }

  @override
  Future<Response<BuiltList<dynamic>>> postComplaint() {
    final Uri $url = Uri.parse('/car/complaint/post/');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<dynamic>, BuiltList<dynamic>>($request);
  }

  @override
  Future<Response<BuiltList<dynamic>>> getReasonsComplaint() {
    final Uri $url = Uri.parse('/car/complaint/reasons/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<dynamic>, BuiltList<dynamic>>($request);
  }

  @override
  Future<Response<BuiltList<QuestionModel>>> getFaq() {
    final Uri $url = Uri.parse('/car/faq');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<QuestionModel>, QuestionModel>($request);
  }

  @override
  Future<Response<BuiltList<dynamic>>> getDiagnosedCars() {
    final Uri $url = Uri.parse('/car/diagnosed-cars/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<dynamic>, BuiltList<dynamic>>($request);
  }

  @override
  Future<Response<BuiltList<GenerationsConfigurationsRes>>>
      getConfigurationsGenerations({required String id}) {
    final Uri $url = Uri.parse('/car/generations/configurations/${id}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<GenerationsConfigurationsRes>,
        GenerationsConfigurationsRes>($request);
  }

  @override
  Future<Response<CarModel>> getCarWithId({required int id}) {
    final Uri $url = Uri.parse('/car/get/${id}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CarModel, CarModel>($request);
  }

  @override
  Future<Response<BuiltList<dynamic>>> getCarWithPage({required int page}) {
    final Uri $url = Uri.parse('/car/list/');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BuiltList<dynamic>, BuiltList<dynamic>>($request);
  }

  @override
  Future<Response<BuiltList<GenerationModel>>> getGenerationsModel(
      {required String id}) {
    final Uri $url = Uri.parse('/car/model/generations/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<GenerationModel>, GenerationModel>($request);
  }

  @override
  Future<Response<CarModel>> getDraft({required int id}) {
    final Uri $url = Uri.parse('/car/draft/${id}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CarModel, CarModel>($request);
  }

  @override
  Future<Response<BuiltList<CarModel>>> getListModel({
    required String id,
    int? isUsed,
    int? isTop,
  }) {
    final Uri $url =
        Uri.parse('/car/model/list/${id}?isUsed={isUsed}&isTop={isTop}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isUsed': isUsed,
      'isTop': isTop,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BuiltList<CarModel>, CarModel>($request);
  }

  @override
  Future<Response<dynamic>> getOwnedByOrientMotors({required int page}) {
    final Uri $url = Uri.parse('/car/owned-by-orient-motors/');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BuiltList<dynamic>>> getPremiumDiagnosedCars() {
    final Uri $url = Uri.parse('/car/premium-diagnosed-cars/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<dynamic>, BuiltList<dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> createCar(
    CreateCarReq request,
    String token,
  ) {
    final Uri $url = Uri.parse('/car/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createDraftCar(
    CreateCarReq request,
    String token,
  ) {
    final Uri $url = Uri.parse('/car/draft/create');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putArchive(
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/status/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deletePost(
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/get/${id}/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateDraftCar(
    CreateCarReq request,
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/draft/update/${id}/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> editCar(
    CreateCarReq request,
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/update/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteImageDraftCar(
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/draft/img/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteAdditionalPhoneDraftCar(
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/draft/additional-phone/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteDraft(
    String token,
    int id,
  ) {
    final Uri $url = Uri.parse('/car/draft/${id}/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CarResResult>> getUserCars({required int id}) {
    final Uri $url = Uri.parse('/car/get-cars/${id}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CarResResult, CarResResult>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UploadImage extends UploadImage {
  _$UploadImage([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UploadImage;

  @override
  Future<Response<BuiltList<PreSignedUrlRes>>> generatePreSignedUrl(
    BuiltList<PreSignedUrlReq> request,
    String token,
  ) {
    final Uri $url = Uri.parse('/main/key-gen');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<BuiltList<PreSignedUrlRes>, PreSignedUrlRes>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FilterService extends FilterService {
  _$FilterService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FilterService;

  @override
  Future<Response<FilterRes>> getFilter({
    String? mark,
    String? model,
    String? generation,
    String? fuelType,
    String? color,
    String? bodyType,
    String? transmission,
    String? region,
    String? yearTo,
    String? yearFrom,
    String? priceFrom,
    String? priceTo,
    String? mileageFrom,
    String? mileageTo,
    int? warranty,
    int? orientDiagnostics,
    int? page,
    int? pageSize,
    String? currency,
    String? orderBy,
    String? services,
    int? isUsed,
  }) {
    final Uri $url = Uri.parse('/filter/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mark': mark,
      'model': model,
      'generations': generation,
      'fuelType': fuelType,
      'colors': color,
      'bodyTypes': bodyType,
      'transmissions': transmission,
      'region': region,
      'yearTo': yearTo,
      'yearFrom': yearFrom,
      'priceFrom': priceFrom,
      'priceTo': priceTo,
      'mileageFrom': mileageFrom,
      'mileageTo': mileageTo,
      'warranty': warranty,
      'orientDiagnostics': orientDiagnostics,
      'page': page,
      'page_size': pageSize,
      'currency': currency,
      'order-by': orderBy,
      'services': services,
      'isUsed': isUsed,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<FilterRes, FilterRes>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getBodyTypes() {
    final Uri $url = Uri.parse('/filter/body-type/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getColors() {
    final Uri $url = Uri.parse('/filter/color/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<TotalCarsRes>> getTotalCars() {
    final Uri $url = Uri.parse('/filter/total-cars/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TotalCarsRes, TotalCarsRes>($request);
  }

  @override
  Future<Response<FilterSearchReq>> searchCreate(
      {required FilterSearchReq request}) {
    final Uri $url = Uri.parse('/filter/search/create');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<FilterSearchReq, FilterSearchReq>($request);
  }

  @override
  Future<Response<BuiltList<FilterSearchRes>>> getSearchesList(String token) {
    final Uri $url = Uri.parse('/filter/searches/list');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<FilterSearchRes>, FilterSearchRes>($request);
  }

  @override
  Future<Response<dynamic>> deleteSearches({
    required String token,
    required int id,
  }) {
    final Uri $url = Uri.parse('/filter/searches/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BuiltList<SearchList>>> getSearchesGenerationList(
      String name) {
    final Uri $url = Uri.parse('/filter/generations/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<SearchList>, SearchList>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SpecificationsService extends SpecificationsService {
  _$SpecificationsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SpecificationsService;

  @override
  Future<Response<BuiltList<NamedModel>>> getRegionList() {
    final Uri $url = Uri.parse('/specifications/region/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getTransmissionList() {
    final Uri $url = Uri.parse('/specifications/transmission/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getBodyTypeList(
      {required String id}) {
    final Uri $url = Uri.parse('/specifications/body-type/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getBodyTypes() {
    final Uri $url = Uri.parse('/specifications/body-type/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getFuelTypeList() {
    final Uri $url = Uri.parse('/specifications/fuel/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getColorList() {
    final Uri $url = Uri.parse('/specifications/color/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }

  @override
  Future<Response<BuiltList<DriveUnitModel>>> getDriveUnitList() {
    final Uri $url = Uri.parse('/specifications/drive-unit/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<DriveUnitModel>, DriveUnitModel>($request);
  }

  @override
  Future<Response<BuiltList<DriveUnitModel>>> getPaintConditionList() {
    final Uri $url = Uri.parse('/specifications/paint-condition/list/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<DriveUnitModel>, DriveUnitModel>($request);
  }

  @override
  Future<Response<OptionsRes>> getOptions({required String id}) {
    final Uri $url = Uri.parse('/specifications/options/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<OptionsRes, OptionsRes>($request);
  }

  @override
  Future<Response<dynamic>> deleteChangedPartInfo({
    required String token,
    required int id,
  }) {
    final Uri $url =
        Uri.parse('/specifications/changed-part-info/delete/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<OptionsRes>> getOptionsList() {
    final Uri $url = Uri.parse('/specifications/options/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<OptionsRes, OptionsRes>($request);
  }

  @override
  Future<Response<BuiltList<UzModel>>> getChangedPartsList() {
    final Uri $url = Uri.parse('/specifications/changed-parts/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<UzModel>, UzModel>($request);
  }

  @override
  Future<Response<BuiltList<NamedModel>>> getChangedPartsQualityList() {
    final Uri $url = Uri.parse('/specifications/changed-parts-quality/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<NamedModel>, NamedModel>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ServicesService extends ServicesService {
  _$ServicesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ServicesService;

  @override
  Future<Response<BuiltList<ServicesRes>>> getServicesList() {
    final Uri $url = Uri.parse('/services/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<ServicesRes>, ServicesRes>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MainService extends MainService {
  _$MainService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MainService;

  @override
  Future<Response<CurrencyModel>> getCurrency() {
    final Uri $url = Uri.parse('/main/currency');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CurrencyModel, CurrencyModel>($request);
  }

  @override
  Future<Response<BuiltList<BranchModel>>> getBranchList({required int id}) {
    final Uri $url = Uri.parse('/main/branch-region/${id}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<BranchModel>, BranchModel>($request);
  }

  @override
  Future<Response<BranchComplaintModel>> postBranchComplaint(
      {required BranchComplaintModel request}) {
    final Uri $url = Uri.parse('/main/branch/complaint/post/');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BranchComplaintModel, BranchComplaintModel>($request);
  }

  @override
  Future<Response<BuiltList<NewsModel>>> getNewsList({required String type}) {
    final Uri $url = Uri.parse('/main/news/list/');
    final Map<String, dynamic> $params = <String, dynamic>{'type': type};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BuiltList<NewsModel>, NewsModel>($request);
  }

  @override
  Future<Response<BuiltList<NotificationModel>>> getNotificationsList(
      {required String token}) {
    final Uri $url = Uri.parse('/main/notifications/list/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<BuiltList<NotificationModel>, NotificationModel>($request);
  }

  @override
  Future<Response<UnreadModel>> getNotificationsUnread(
      {required String token}) {
    final Uri $url = Uri.parse('/main/notifications/unread/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<UnreadModel, UnreadModel>($request);
  }

  @override
  Future<Response<SuccessModel>> patchNotificationsUnread(
      {required String token}) {
    final Uri $url = Uri.parse('/main/notifications/unread/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<SuccessModel>> patchNotificationsActions({
    required String token,
    required int id,
  }) {
    final Uri $url = Uri.parse('/main/notifications/actions/${id}/');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ReviewService extends ReviewService {
  _$ReviewService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ReviewService;

  @override
  Future<Response<ReviewSysthesisModel>> getServicesList(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/systhesis/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ReviewSysthesisModel, ReviewSysthesisModel>($request);
  }

  @override
  Future<Response<ReviewFilterEither>> getListFilter({
    int? mark,
    int? model,
    int? generation,
    int? bodyType,
    String? orderBy,
  }) {
    final Uri $url = Uri.parse('/review/filter/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mark': mark,
      'model': model,
      'generation': generation,
      'body-type': bodyType,
      'order-by': orderBy,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ReviewFilterEither, ReviewFilterEither>($request);
  }

  @override
  Future<Response<BuiltList<ReviewFaqModel>>> getFaq(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/faq/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<ReviewFaqModel>, ReviewFaqModel>($request);
  }

  @override
  Future<Response<ReviewDesignModel>> getDesign({required int carReviewId}) {
    final Uri $url = Uri.parse('/review/design/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ReviewDesignModel, ReviewDesignModel>($request);
  }

  @override
  Future<Response<ReviewSafetyConvenienceModel>> getSafetyConvenience(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/safety-convenience/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ReviewSafetyConvenienceModel,
        ReviewSafetyConvenienceModel>($request);
  }

  @override
  Future<Response<ReviewSizeSpaceModel>> getSizeSpace(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/size-space/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ReviewSizeSpaceModel, ReviewSizeSpaceModel>($request);
  }

  @override
  Future<Response<ReviewMaintenanceModel>> getMaintenance(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/maintenance/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<ReviewMaintenanceModel, ReviewMaintenanceModel>($request);
  }

  @override
  Future<Response<ReviewPriceModel>> getPrice({required int carReviewId}) {
    final Uri $url = Uri.parse('/review/price/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ReviewPriceModel, ReviewPriceModel>($request);
  }

  @override
  Future<Response<ReviewSpecificationModel>> getSpecification(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/specification/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<ReviewSpecificationModel, ReviewSpecificationModel>($request);
  }

  @override
  Future<Response<ReviewLinkModel>> getLink({required int carReviewId}) {
    final Uri $url = Uri.parse('/review/link/${carReviewId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ReviewLinkModel, ReviewLinkModel>($request);
  }

  @override
  Future<Response<BuiltList<CommentsModel>>> getComments(
      {required int carReviewId}) {
    final Uri $url = Uri.parse('/review/comments/${carReviewId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<CommentsModel>, CommentsModel>($request);
  }

  @override
  Future<Response<CommentModel>> postComment({
    required CommentModel request,
    required String token,
  }) {
    final Uri $url = Uri.parse('/review/comment-post');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<CommentModel, CommentModel>($request);
  }

  @override
  Future<Response<dynamic>> voteGeneration({required int id}) {
    final Uri $url = Uri.parse('/review/vote/generation/${id}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ReviewIdEither>> getId({
    int? mark,
    int? model,
    int? generation,
  }) {
    final Uri $url = Uri.parse('/review/get-id');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mark': mark,
      'model': model,
      'generation': generation,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ReviewIdEither, ReviewIdEither>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ChatService extends ChatService {
  _$ChatService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ChatService;

  @override
  Future<Response<SuccessModel>> addWhoWrote(
      {required ChatWroteModel request}) {
    final Uri $url = Uri.parse('/chat/add-who-wrote');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<ChatBlockModel>> blockUser(
      {required ChatBlockModel request}) {
    final Uri $url = Uri.parse('/chat/block-user');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ChatBlockModel, ChatBlockModel>($request);
  }

  @override
  Future<Response<SuccessModel>> changeUserStatus(
      {required UserStatusModel request}) {
    final Uri $url = Uri.parse('/chat/change-user-status');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<SuccessModel>> checkIsOnline(
      {required UserStatusModel request}) {
    final Uri $url = Uri.parse('/chat/check-is-online');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<BuiltList<ContactModel>>> getContacts(
      {required String token}) {
    final Uri $url = Uri.parse('/chat/contacts');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ContactModel>, ContactModel>($request);
  }

  @override
  Future<Response<SuccessModel>> createChatMessage(
      {required ChatMessageReq request}) {
    final Uri $url = Uri.parse('/chat/create-chat-message');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<ChatRoomModel>> createRoom({required ChatRoomModel request}) {
    final Uri $url = Uri.parse('/chat/create-room');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ChatRoomModel, ChatRoomModel>($request);
  }

  @override
  Future<Response<ChatRoomModel>> getRoom({
    required int id,
    required String token,
  }) {
    final Uri $url = Uri.parse('/chat/get-room/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ChatRoomModel, ChatRoomModel>($request);
  }

  @override
  Future<Response<ChatUserModel>> getUser({
    required int id,
    required String token,
  }) {
    final Uri $url = Uri.parse('/chat/get-user/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ChatUserModel, ChatUserModel>($request);
  }

  @override
  Future<Response<BuiltList<ChatMessageRes>>> getMessage({
    required String token,
    required int roomId,
  }) {
    final Uri $url = Uri.parse('/chat/messages');
    final Map<String, dynamic> $params = <String, dynamic>{'room_id': roomId};
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<BuiltList<ChatMessageRes>, ChatMessageRes>($request);
  }

  @override
  Future<Response<RoomExistModel>> getRoomExistCheck({
    required String token,
    int? senderId,
    int? receiverId,
    int? announcementId,
  }) {
    final Uri $url = Uri.parse('/chat/room-exist-check');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sender_id': senderId,
      'receiver_id': receiverId,
      'announcement_id': announcementId,
    };
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<RoomExistModel, RoomExistModel>($request);
  }
}

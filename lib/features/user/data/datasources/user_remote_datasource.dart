import 'package:dio/dio.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/error_handle.dart';
import 'package:mpd_client/core/pagination/models/generic_pagination.dart';
import 'package:mpd_client/features/user/data/models/spec_add_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_position_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_update_model.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';

import '../models/user_image_update_model.dart';

abstract class IUserRemoteDataSource {
  Future<UserInfoModel> getUserInfo();
  Future<List<SpecialistModel>> getSpecialist();
  Future<UserInfoUpdateModel> updateUserInfo({
    required UserInfoUpdateModel userInfoUpdateModel,
  });

  Future<UserImageUpdate> updateUserImage({
    required UserImageUpdate userImageUpdate,
  });
  Future<UserImageUpdate> updateUserBackImage({
    required UserImageUpdate userImageUpdate,
  });

  Future<UserSubscriptionsModel> getUserSubscriptions({
    required int limit,
    required int offset,
    String? query,
  });

  Future<UserRecordModel> getUserRecords({
    int? limit,
    int? offset,
    String? query,
  });
  Future<GenericPagination<SpecialistPositionModel>> getSpecialistPosition();
  Future<GenericPagination<SpecialistCatModel>> getSpecialistCat();
  Future<GenericPagination<SpecialistCategoryModel>> getSpecialistCategory();
  Future<bool> postSpecialist(SpecAddModel model);
  Future<int> isAddedSpecialist();
  // Future<Subscription>> subscribeToDr(String username);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final Dio _client;
  final ErrorHandle _handle = ErrorHandle();

  UserRemoteDataSource(this._client);

  @override
  Future<UserInfoModel> getUserInfo() async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/UMS/api/v1.0/account/",
          options: Options(
            headers: <String, dynamic>{
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return UserInfoModel.fromJson(response);
      },
    );
  }

  @override
  Future<UserInfoUpdateModel> updateUserInfo({
    required UserInfoUpdateModel userInfoUpdateModel,
  }) async {
    final data = FormData.fromMap(userInfoUpdateModel.toJson());
    return _handle.apiControl(
      request: () {
        return _client.patch(
          "/UMS/api/v1.0/account/",
          data: data,
          options: Options(
            headers: <String, dynamic>{
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return UserInfoUpdateModel.fromJson(response);
      },
    );
  }

  @override
  Future<UserImageUpdate> updateUserImage({
    required UserImageUpdate userImageUpdate,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/UMS/api/v1.0/account/media/avatars/",
          data: userImageUpdate.toJson(false),
          options: Options(
            headers: <String, dynamic>{
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return UserImageUpdate.fromJson(response);
      },
    );
  }

  @override
  Future<UserImageUpdate> updateUserBackImage({
    required UserImageUpdate userImageUpdate,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/UMS/api/v1.0/account/media/background/",
          data: userImageUpdate.toJson(true),
          options: Options(
            headers: <String, dynamic>{
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return UserImageUpdate.fromJson(response);
      },
    );
  }

  @override
  Future<UserSubscriptionsModel> getUserSubscriptions({
    int? limit,
    required int? offset,
    String? query,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/SMMS/api/v1.0/public/subscriptions/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: {
            if (query == null) "limit": limit,
            if (query == null) "offset": offset,
            if (query != null) "search": query,
          },
        );
      },
      body: (response) {
        return UserSubscriptionsModel.fromJson(response);
      },
    );
  }

  @override
  Future<UserRecordModel> getUserRecords({
    int? limit,
    int? offset,
    String? query,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/OMS/api/v1.0/public/order_conclusions/",
          queryParameters: {
            if (query == null) "limit": limit,
            if (query == null) "offset": offset,
            if (query != null) "search": query,
          },
          options: Options(
            headers: <String, dynamic>{
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return UserRecordModel.fromJson(response);
      },
    );
  }

  @override
  Future<GenericPagination<SpecialistCatModel>> getSpecialistCat() {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/BMS/api/v1.0/public/org/mpd/specialist_cat/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return GenericPagination.fromJson(
          response,
          (p0) => SpecialistCatModel.fromJson(p0 as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<GenericPagination<SpecialistPositionModel>> getSpecialistPosition() {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/BMS/api/v1.0/public/org/mpd/specialist_position/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return GenericPagination.fromJson(
          response,
          (p0) => SpecialistPositionModel.fromJson(p0 as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<GenericPagination<SpecialistCategoryModel>> getSpecialistCategory() {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/BMS/api/v1.0/public/org/mpd/specialist/category/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return GenericPagination.fromJson(
          response,
          (p0) => SpecialistCategoryModel.fromJson(p0 as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<bool> postSpecialist(SpecAddModel model) {
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/BMS/api/v1.0/public/org/mpd/specialist-add/",
          data: model.toJsonDocument,
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return true;
      },
    );
  }

  @override
  Future<int> isAddedSpecialist() {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/BMS/api/v1.0/public/specialist/status/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return response['status'];
      },
    );
  }

  @override
  Future<List<SpecialistModel>> getSpecialist() {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/UMS/api/v1.0/account/specialists/statuses/",
          // queryParameters: {"include_all_statuses": true},
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        final data = response as List<dynamic>;
        final list = data.map((e) => SpecialistModel.fromJson(e)).toList();
        return list;
      },
    );
  }

  // @override
  // Future<Subscription>> subscribeToDr(String username) async {
  //   final map = FormData.fromMap({"to_user": username});
  //   Subscription? subscription;

  //   try {
  //     final Response result =
  //         await _client.post("/SMMS/api/v1.0/public/subscriptions/", data: map);

  //     if (result.data is! List) {
  //       subscription = Subscription.fromJson(result.data);
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception custom occurred: $error stacktrace: $stacktrace");
  //     return ResponseHandler()
  //       ..setException(ServerError.withError(error: error as DioException));
  //   }
  //   return ResponseHandler()..data = subscription;
  // }
}

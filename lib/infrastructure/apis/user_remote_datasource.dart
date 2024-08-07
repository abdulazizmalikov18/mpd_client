import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

abstract class IUserRemoteDataSource {
  Future<UserSubscriptionsModel> getUserSubscriptions({required int limit, required int offset, String? query});

  Future<UserRecordModel> getUserRecords({int? limit, int? offset, String? query});
  Future<Subscription?> subscribeToDr(String username);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final ErrorHandle _handle = ErrorHandle();

  UserRemoteDataSource();

  @override
  Future<UserSubscriptionsModel> getUserSubscriptions({int? limit, required int? offset, String? query}) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "/SMMS/api/v1.0/public/subscriptions/",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
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
  Future<UserRecordModel> getUserRecords({int? limit, int? offset, String? query}) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "/OMS/api/v1.0/public/order_conclusions/",
          queryParameters: {
            if (query == null) "limit": limit,
            if (query == null) "offset": offset,
            if (query != null) "search": query,
          },
          options: Options(
            headers: <String, dynamic>{if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'},
          ),
        );
      },
      body: (response) {
        return UserRecordModel.fromJson(response);
      },
    );
  }

  @override
  Future<Subscription?> subscribeToDr(String username) async {
    final map = FormData.fromMap({"to_user": username});
    return _handle.apiCantrol(
      request: (client) {
        return client.post("/SMMS/api/v1.0/public/subscriptions/", data: map);
      },
      body: (response) {
        if (response is! List) {
          return Subscription.fromJson(response);
        }
        return null;
      },
    );
  }
}

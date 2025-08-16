import 'package:dio/dio.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/error_handle.dart';

import '../models/appoinment_model.dart';
import '../models/pagination_model.dart';

abstract class IAppoinmentRemoteDataSource {
  Future<AppointmentModel> getUserAppoinments(PaginationModel paginationModel);
  Future<Map<String, dynamic>> cancelAppoinment({
    required String productid,
    required String cancelInfo,
  });
}

class AppoinmentRemoteDataSource implements IAppoinmentRemoteDataSource {
  final Dio _client;
  final ErrorHandle _handle = ErrorHandle();

  AppoinmentRemoteDataSource(this._client);

  @override
  Future<AppointmentModel> getUserAppoinments(
    PaginationModel paginationModel,
  ) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          '/OMS/api/v1.0/public/order-product/?limit=${paginationModel.limit}&offset=${paginationModel.offset}&status=${paginationModel.status}',
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: {'org_slug': 'mpd'},
        );
      },
      body: (response) {
        return AppointmentModel.fromJson(response);
      },
    );
  }

  @override
  Future<Map<String, dynamic>> cancelAppoinment({
    required String productid,
    required String cancelInfo,
  }) async {
    return _handle.apiControl(
      request: () {
        final body = {"cancel_info": cancelInfo};
        return _client.patch(
          '/OMS/api/v1.0/public/order-product/$productid/cancel/',
          data: body,
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
        return response;
      },
    );
  }
}

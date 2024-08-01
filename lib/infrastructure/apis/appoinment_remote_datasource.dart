import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

abstract class IAppoinmentRemoteDataSource {
  Future<AppointmentModel> getUserAppoinments(PaginationModel paginationModel);
  Future<Map<String, dynamic>> cancelAppoinment({required String productid, required String cancelInfo});
}

class AppoinmentRemoteDataSource implements IAppoinmentRemoteDataSource {

  final ErrorHandle _handle = ErrorHandle();

  AppoinmentRemoteDataSource();

  @override
  Future<AppointmentModel> getUserAppoinments(PaginationModel paginationModel) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          '/OMS/api/v1.0/public/order-product/?limit=${paginationModel.limit}&offset=${paginationModel.offset}&status=${paginationModel.status}',
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return AppointmentModel.fromJson(response);
      },
    );
  }

  @override
  Future<Map<String, dynamic>> cancelAppoinment({required String productid, required String cancelInfo}) async {
    return _handle.apiCantrol(
      request: (client) {
        final body = {"cancel_info": cancelInfo};
        return client.patch(
          '/OMS/api/v1.0/public/order-product/$productid/cancel/',
          data: body,
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return response;
      },
    );
  }
}

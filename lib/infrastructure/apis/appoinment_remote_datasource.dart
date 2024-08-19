import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';

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
          '/OMS/api/v1.0/public/order-product/',
          queryParameters: {
            'limit': paginationModel.limit,
            'offset': paginationModel.offset,
            'status': paginationModel.status,
            'org_slug': 'mpd',
          },
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
        return client.patch(
          '/OMS/api/v1.0/public/order-product/$productid/cancel/',
          data: {"cancel_info": cancelInfo},
        );
      },
      body: (response) {
        return response;
      },
    );
  }
}

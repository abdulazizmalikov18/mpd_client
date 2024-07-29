import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/yandex/popular_categories_model.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/domain/models/yandex/top_specialists_model.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';


abstract class IYandexDoctorRemoteDataSource {
  Future<PopularCategoriesModel> getPopularCategories({required int limit, required int offset, String? query, String? langCode});

  Future<TopSpecialistsModel> getTopSpecialists({required int limit, required int offset, CancelToken? cancelToken});

  Future<MapSpecialistModel> getSearchedSpecialist({required String query});

  Future<MapSpecialistModel> getSpecialistByCategory({required int id});
}

class YandexDoctorRemoteDataSource implements IYandexDoctorRemoteDataSource {
  final ErrorHandle _handle = ErrorHandle();

  YandexDoctorRemoteDataSource();

  @override
  Future<PopularCategoriesModel> getPopularCategories({int? limit, int? offset, String? query, String? langCode}) async {
    final baseUrl = StringBuffer("/BMS/api/v1.0/public/category/");
    if (query == null) baseUrl.write('?limit=$limit&offset=$offset&parent=5');
    if (query != null) baseUrl.write('?search=$query&parent=5');
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "/BMS/api/v1.0/public/org/mpd/specialist/category/",
          queryParameters: {
            if (query != null) 'search': query,
          },
          options: Options(
            headers: {'Accept-Language': langCode, if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'},
          ),
        );
      },
      body: (response) {
        return PopularCategoriesModel.fromJson(response);
      },
    );
  }

  @override
  Future<TopSpecialistsModel> getTopSpecialists({required int limit, required int offset, String? query, CancelToken? cancelToken}) async {
    final baseUrl = StringBuffer('http://213.230.125.177/BMS/api/v1.0/public/cluster/mpd/specialist/?limit=$limit&offset=$offset&bff_price=true');
    if (query != null) baseUrl.write('&search=$query');
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          baseUrl.toString(),
          cancelToken: cancelToken,
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return TopSpecialistsModel.fromJson(response);
      },
    );
  }

  @override
  Future<MapSpecialistModel> getSearchedSpecialist({required String query}) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "/BMS/api/v1.0/public/cluster/mpd/specialist/?search=$query",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return MapSpecialistModel.fromJson(response);
      },
    );
  }

  @override
  Future<MapSpecialistModel> getSpecialistByCategory({required int id}) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          '/BMS/api/v1.0/public/cluster/mpd/specialist/location/?job=$id&bff_price=true',
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return MapSpecialistModel.fromJson(response);
      },
    );
  }
}

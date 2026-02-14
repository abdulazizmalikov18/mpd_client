import 'package:dio/dio.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/error_handle.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';

import '../models/popular_categories_model.dart';

abstract class IYandexDoctorRemoteDataSource {
  Future<PopularCategoriesModel> getPopularCategories({
    required int limit,
    required int offset,
    String? query,
    String? langCode,
  });

  Future<TopSpecialistsModel> getTopSpecialists({
    required int limit,
    required int offset,
    CancelToken? cancelToken,
  });

  Future<MapSpecialistModel> getSearchedSpecialist({required String query});

  Future<MapSpecialistModel> getSpecialistByCategory({required int id});
  Future<SpecialistProductModel> getProducts(ProductFilterModel model);
}

class YandexDoctorRemoteDataSource implements IYandexDoctorRemoteDataSource {
  final Dio _client;
  final ErrorHandle _handle = ErrorHandle();

  YandexDoctorRemoteDataSource(this._client);

  @override
  Future<SpecialistProductModel> getProducts(ProductFilterModel model) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/PMS/api/v1.0/public/product_org/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: model.toJson(),
        );
      },
      body: (response) {
        return SpecialistProductModel.fromJson(response);
      },
    );
  }

  @override
  Future<PopularCategoriesModel> getPopularCategories({
    int? limit,
    int? offset,
    String? query,
    String? langCode,
  }) async {
    final baseUrl = StringBuffer("/BMS/api/v1.0/public/category/");
    if (query == null) baseUrl.write('?limit=$limit&offset=$offset&parent=5');
    if (query != null) baseUrl.write('?search=$query&parent=5');
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/BMS/api/v1.0/public/org/mpd/specialist/category/",
          queryParameters: {'search': ?query},
          options: Options(
            headers: {
              'Accept-Language': langCode,
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return PopularCategoriesModel.fromJson(response);
      },
    );
  }

  @override
  Future<TopSpecialistsModel> getTopSpecialists({
    required int limit,
    required int offset,
    String? query,
    CancelToken? cancelToken,
  }) async {
    final baseUrl = StringBuffer(
      'http://213.230.125.177/BMS/api/v1.0/public/cluster/mpd/specialist/?limit=$limit&offset=$offset&bff_price=true',
    );
    if (query != null) baseUrl.write('&search=$query');
    return _handle.apiControl(
      request: () {
        return _client.get(
          baseUrl.toString(),
          cancelToken: cancelToken,
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
        return TopSpecialistsModel.fromJson(response);
      },
    );
  }

  @override
  Future<MapSpecialistModel> getSearchedSpecialist({
    required String query,
    int? jobId,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/BMS/api/v1.0/public/cluster/mpd/specialist/?search=$query",
          queryParameters: {'job': ?jobId},
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
        return MapSpecialistModel.fromJson(response);
      },
    );
  }

  @override
  Future<MapSpecialistModel> getSpecialistByCategory({required int id}) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          '/BMS/api/v1.0/public/cluster/mpd/specialist/location/?job=$id&bff_price=true',
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
        return MapSpecialistModel.fromJson(response);
      },
    );
  }
}

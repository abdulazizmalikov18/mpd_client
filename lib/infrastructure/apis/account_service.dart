import 'package:dio/dio.dart';
import 'package:mpd_client/domain/entity/account/popular_category_filter.dart';
import 'package:mpd_client/domain/models/account/profession_model.dart';
import 'package:mpd_client/domain/models/account/region_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/services/api_service.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

abstract interface class AccountService {

  factory AccountService.create() => AccountServiceImpl();
  
  Future<GenericPagination<RegionModel>> getRegion(Filter param);

  Future<GenericPagination<ProfessionModel>> getProfession(Filter param);
}

class AccountServiceImpl implements AccountService {
  final dio = serviceLocator<DioSettings>().dio;

  @override
  Future<GenericPagination<RegionModel>> getRegion(Filter param) async {
    try {
      final response = await dio.get(
        'GMS/api/v1.0/public/region/',
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty ? {'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'} : {},
        ),
        queryParameters: param.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => RegionModel.fromJson(p0 as Map<String, dynamic>),
        );
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<ProfessionModel>> getProfession(Filter param) async {
    try {
      final response = await dio.get(
        'CDMS/api/v1.0/business/category/',
        queryParameters: {"parent": param.parent, "search": param.search},
        options: Options(
          headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty ? {'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'} : {},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => ProfessionModel.fromJson(p0 as Map<String, dynamic>),
        );
      }

      throw ServerException(
        statusCode: response.statusCode ?? 0,
        errorMessage: response.statusMessage ?? "",
      );
    } on ServerException {
      rethrow;
    } on DioError catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}

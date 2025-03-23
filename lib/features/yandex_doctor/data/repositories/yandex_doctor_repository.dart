import 'package:dio/dio.dart';
import 'package:mpd_client/core/connection/connection_info.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/popular_categories_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/searched_specialist_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/top_specialists_model.dart';

import '../../domain/repositories/i_yandex_doctor_repository.dart';
import '../datasources/yandex_doctor_remote_datasources.dart';

class YandexDoctorRepository implements IYandexDoctorRepository {
  final YandexDoctorRemoteDataSource _remoteDataSource;

  final ConnectionInfo _connectionInfo;

  const YandexDoctorRepository(
      {required YandexDoctorRemoteDataSource remoteDataSource,
      required ConnectionInfo connectionInfo})
      : _remoteDataSource = remoteDataSource,
        _connectionInfo = connectionInfo;

  @override
  Future<Either<Failure, SpecialistProductModel>> getProducts(
      ProductFilterModel model) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getProducts(model);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PopularCategoriesModel>> getPopularCategories(
      {int? limit, int? offset, String? query, String? langCode}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getPopularCategories(
          offset: offset, limit: limit, query: query, langCode: langCode);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TopSpecialistsModel>> getTopSpecialists(
      {required int limit,
      required int offset,
      String? query,
      bool isPagination = false,
      CancelToken? cancelToken}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getTopSpecialists(
          offset: offset, limit: limit, query: query, cancelToken: cancelToken);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, MapSpecialistModel>> getSearchedSpecialist({
    required String query,
    int? jobId,
  }) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getSearchedSpecialist(
        query: query,
        jobId: jobId,
      );
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, MapSpecialistModel>> getSpecialistByCategory(
      {required int id}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getSpecialistByCategory(id: id);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}

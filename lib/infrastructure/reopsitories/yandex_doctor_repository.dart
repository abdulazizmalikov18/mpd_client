import 'package:dio/dio.dart';
import 'package:mpd_client/domain/abstract_repo/i_yandex_doctor_repository.dart';
import 'package:mpd_client/domain/models/yandex/popular_categories_model.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/domain/models/yandex/top_specialists_model.dart';
import 'package:mpd_client/infrastructure/apis/yandex_doctor_remote_datasources.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class YandexDoctorRepository implements IYandexDoctorRepository {
  final YandexDoctorRemoteDataSource _remoteDataSource;

  const YandexDoctorRepository({required YandexDoctorRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, PopularCategoriesModel>> getPopularCategories({int? limit, int? offset, String? query, String? langCode}) async {
    try {
      final response = await _remoteDataSource.getPopularCategories(offset: offset, limit: limit, query: query, langCode: langCode);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage.toString(), statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TopSpecialistsModel>> getTopSpecialists({required int limit, required int offset, String? query, bool isPagination = false, CancelToken? cancelToken}) async {
    try {
      final response = await _remoteDataSource.getTopSpecialists(offset: offset, limit: limit, query: query, cancelToken: cancelToken);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage.toString(), statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, MapSpecialistModel>> getSearchedSpecialist({required String query}) async {
    try {
      final response = await _remoteDataSource.getSearchedSpecialist(query: query);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage.toString(), statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, MapSpecialistModel>> getSpecialistByCategory({required int id}) async {
    try {
      final response = await _remoteDataSource.getSpecialistByCategory(id: id);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage.toString(), statusCode: e.statusCode));
    }
  }
}

import 'package:dio/dio.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/services/api_service.dart';
import 'package:mpd_client/infrastructure/services/service_locator.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

class GlobalRequestRepository {
  final dio = serviceLocator<DioSettings>().dioForAuth;

  Future<Either<Failure, S>> getSingle<S>({
    required S Function(Map<String, dynamic>) fromJson,
    required String endpoint,
    Map<String, dynamic>? query,
    bool sendToken = true,
  }) async {
    try {
      final result = await dio.get(
        endpoint,
        queryParameters: query,
        options: sendToken ? Options(headers: {'Authorization': "Bearer ${StorageRepository.getString('token')}"}) : null,
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return Right(fromJson(result.data));
      } else {
        return Left(const ServerFailure(errorMessage: '', statusCode: 141));
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: 141, errorMessage: '$e'));
    }
  }

  Future<Either<Failure, S>> putSingle<S>({
    required S Function(Map<String, dynamic>) fromJson,
    required String endpoint,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    bool sendToken = true,
  }) async {
    try {
      final result = await dio.put(endpoint, queryParameters: query, data: data, options: Options(headers: {'Authorization': "Bearer ${StorageRepository.getString('token')}"}));
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return Right(fromJson(result.data));
      } else {
        return Left(const ServerFailure(errorMessage: '', statusCode: 141));
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: 141, errorMessage: '$e'));
    }
  }

  ///Request for any kind of GET request for retrieving List of models,not a single model
  Future<Either<Failure, List<S>>> getList<S>(
      {required String endpoint,
      Map<String, dynamic>? query,
      required S Function(
        Map<String, dynamic>,
      ) fromJson,
      String? responseDataKey,
      bool sendToken = true}) async {
    try {
      final result = await dio.get(endpoint, queryParameters: query, options: Options(headers: sendToken ? {'Authorization': "Bearer ${StorageRepository.getString('token', defValue: '')}"} : {}));

      List<S> list = [];

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        if (responseDataKey != null && responseDataKey.isNotEmpty) {
          final data = result.data[responseDataKey] as List<dynamic>;
          list = data.map((e) => fromJson(e)).toList();
        } else {
          final data = result.data as List<dynamic>;
          list = data.map((e) => fromJson(e)).toList();
        }

        return Right(list);
      } else {
        return Left(const ServerFailure(errorMessage: '', statusCode: 141));
      }
    } catch (e) {
      return Left(const ServerFailure(statusCode: 141, errorMessage: ''));
    }
  }

  /// Use for any kind of post map endpoint that retrieves response with single model , not a list
  Future<Either<Failure, S>> postAndSingle<S>({
    required S Function(Map<String, dynamic>) fromJson,
    required String endpoint,
    Map<String, dynamic>? query,
    FormData? formData,
    String? responseDataKey,
    Map<String, dynamic>? data,
    String? errorKey,
    bool sendToken = true,
  }) async {
    try {
      final result = await dio.post(endpoint, queryParameters: query, data: formData ?? data, options: Options(headers: sendToken ? {'Authorization': "Bearer ${StorageRepository.getString('token', defValue: '')}"} : {}));
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        if (responseDataKey != null && responseDataKey.isNotEmpty) {
          return Right(fromJson(result.data[responseDataKey]));
        } else {
          if (result.data.toString().isEmpty) {
            return Right('' as S);
          }
          return Right(fromJson(result.data));
        }
      } else {
        if (result.data is List && (result.data as List).isNotEmpty) {
          return Left(ServerFailure(errorMessage: (result.data as List).first.toString(), statusCode: 141));
        }
        var data = result.data[errorKey ?? 'detail'] ?? '';
        if (data.isEmpty) {
          data = result.data.toString();
        }

        return Left(ServerFailure(errorMessage: data, statusCode: 141));
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: 141, errorMessage: e.toString()));
    }
  }

  /// Use for any kind of post map endpoint that retrieves response with single model , not a list
  Future<Either<Failure, S>> patchAndSingle<S>({
    required S Function(Map<String, dynamic>) fromJson,
    required String endpoint,
    Map<String, dynamic>? query,
    FormData? formData,
    String? responseDataKey,
    Map<String, dynamic>? data,
    String? errorKey,
    bool sendToken = true,
  }) async {
    try {
      final result = await dio.patch(endpoint, queryParameters: query, data: formData ?? data, options: Options(headers: sendToken ? {'Authorization': "Bearer ${StorageRepository.getString('token', defValue: '')}"} : {}));
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        if (responseDataKey != null && responseDataKey.isNotEmpty) {
          return Right(fromJson(result.data[responseDataKey]));
        } else {
          if (result.data.toString().isEmpty) {
            return Right('' as S);
          }
          return Right(fromJson(result.data));
        }
      } else {
        if (result.data is List && (result.data as List).isNotEmpty) {
          return Left(ServerFailure(errorMessage: (result.data as List).first.toString(), statusCode: 141));
        }
        var data = result.data[errorKey ?? 'detail'] ?? '';
        if (data.isEmpty) {
          data = result.data.toString();
        }

        return Left(ServerFailure(errorMessage: data, statusCode: 141));
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: 141, errorMessage: e.toString()));
    }
  }

  /// Use for any kind of post map endpoint that retrieves response List of Model , not a single model
  Future<Either<Failure, List<S>>> postAndList<S>({
    required String endpoint,
    required S Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? responseDataKey,
    bool sendToken = true,
  }) async {
    try {
      final result = await dio.post(endpoint, queryParameters: query, data: data, options: Options(headers: sendToken ? {'Authorization': "Bearer ${StorageRepository.getString('token', defValue: '')}"} : {}));
      var list = <S>[];

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        if (responseDataKey != null && responseDataKey.isNotEmpty) {
          final data = result.data[responseDataKey] as List<dynamic>;
          list = data.map((e) => fromJson(e)).toList();
        } else {
          final data = result.data as List<dynamic>;
          list = data.map((e) => fromJson(e)).toList();
        }

        return Right(list);
      } else {
        return Left(const ServerFailure(errorMessage: '', statusCode: 141));
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: 141, errorMessage: e.toString()));
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_form_model.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_model.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/data/models/token_model.dart';
import 'package:mpd_client/features/authentication/data/models/update_personal_data_model.dart';
import 'package:mpd_client/features/authentication/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, TokenModel>> login({
    String? phone,
    String? username,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final result = await remoteDataSource.login(
        phone: phone,
        username: username,
        password: password,
      );
      if (rememberMe) {
        debugPrint("Acces TOken: ${result.access!}");
        await StorageRepository.putString(StorageKeys.TOKEN, result.access!);
        await StorageRepository.putString(StorageKeys.REFRESH, result.refresh!);
      }
      return Right(result);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> register(String phone) async {
    try {
      final response = await remoteDataSource.register(phone);
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
  Future<Either<Failure, TokenModel>> verification(
    String phone,
    String code,
  ) async {
    try {
      final response = await remoteDataSource.verification(phone, code);
      if (response.access != null) {
        await StorageRepository.putString(StorageKeys.TOKEN, response.access!);
        await StorageRepository.putString(
          StorageKeys.REFRESH,
          response.refresh!,
        );
      }
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
  Future<Either<Failure, ProfessionModel>> getProfessions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  }) async {
    try {
      final response = await remoteDataSource.getProffesions(
        limit: limit,
        offset: offset,
        parent: parent,
        query: query,
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
  Future<Either<Failure, CreateUserModel>> createUser(
    CreateUserFormModel user,
  ) async {
    try {
      final response = await remoteDataSource.createUser(userModel: user);
      await StorageRepository.putString(StorageKeys.TOKEN, response.access!);
      await StorageRepository.putString(StorageKeys.REFRESH, response.refresh!);
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
  Future<Either<Failure, bool>> changePassword(
    String password, {
    String? oldPassword,
  }) async {
    try {
      final response = await remoteDataSource.changePassword(
        password: password,
        oldPassword: oldPassword,
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
  Future<Either<Failure, UpdatePersonalDataModel>> updatePersonalData({
    required String passportSTIR,
    String? filePath,
  }) async {
    try {
      final response = await remoteDataSource.updatePersonalData(
        passportSTIR: passportSTIR,
        filePath: filePath,
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
  Future<Either<Failure, bool>> checkUsername(String username) async {
    try {
      final response = await remoteDataSource.checkUsername(username);
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
  Future<Either<Failure, bool>> checkPassword(String password) async {
    try {
      final response = await remoteDataSource.checkPassword(password: password);
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
  Future<Either<Failure, RegionsModel>> getRegions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  }) async {
    try {
      final response = await remoteDataSource.getRegions(
        limit: limit,
        offset: offset,
        parent: parent,
        query: query,
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
  Future<Either<Failure, TokenModel>> refreshToken() async {
    try {
      final response = await remoteDataSource.refreshToken();
      await StorageRepository.putString(StorageKeys.TOKEN, response.access!);
      await StorageRepository.putString(StorageKeys.REFRESH, response.refresh!);
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
  Future<Either<Failure, bool>> disabledAccount() async {
    try {
      final response = await remoteDataSource.disabledAccount();
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
  Future<Either<Failure, bool>> requestPasswordReset(String phone) async {
    try {
      final response = await remoteDataSource.requestPasswordReset(phone);
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
  Future<Either<Failure, bool>> verifyPasswordResetCode(
    String phone,
    String pvc,
  ) async {
    try {
      final response = await remoteDataSource.verifyPasswordResetCode(
        phone,
        pvc,
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
  Future<Either<Failure, bool>> completePasswordReset({
    required String phone,
    required String pvc,
    required String password1,
    required String password2,
  }) async {
    try {
      final response = await remoteDataSource.completePasswordReset(
        phone: phone,
        pvc: pvc,
        password1: password1,
        password2: password2,
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
}

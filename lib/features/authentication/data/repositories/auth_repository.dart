import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mpd_client/core/connection/connection_info.dart';
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
  final AuthRemoteDataSource _remoteDataSource;
  final ConnectionInfo _connectionInfo;

  const AuthRepository(
      {required AuthRemoteDataSource remoteDataSource,
      required ConnectionInfo connectionInfo})
      : _remoteDataSource = remoteDataSource,
        _connectionInfo = connectionInfo;

  @override
  Future<Either<Failure, TokenModel>> login(
      {String? phone,
      String? username,
      required String password,
      required bool rememberMe}) async {
    if (!await _connectionInfo.isConnected) {
      debugPrint("${await _connectionInfo.isConnected}");
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final result = await _remoteDataSource.login(
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
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.register(phone);
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
      String phone, String code) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.verification(phone, code);
      if (response.access != null) {
        await StorageRepository.putString(StorageKeys.TOKEN, response.access!);
        await StorageRepository.putString(
            StorageKeys.REFRESH, response.refresh!);
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
  Future<Either<Failure, ProfessionModel>> getProfessions(
      {int? limit, int? offset, int? parent, String? query}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getProffesions(
          limit: limit, offset: offset, parent: parent, query: query);
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
      CreateUserFormModel user) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.createUser(userModel: user);
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
  Future<Either<Failure, bool>> changePassword(String password,
      {String? oldPassword}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.changePassword(
          password: password, oldPassword: oldPassword);
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
  Future<Either<Failure, UpdatePersonalDataModel>> updatePersonalData(
      {required String passportSTIR, String? filePath}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.updatePersonalData(
          passportSTIR: passportSTIR, filePath: filePath);
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
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.checkUsername(username);
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
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response =
          await _remoteDataSource.checkPassword(password: password);
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
  Future<Either<Failure, RegionsModel>> getRegions(
      {int? limit, int? offset, int? parent, String? query}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.getRegions(
          limit: limit, offset: offset, parent: parent, query: query);
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
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.refreshToken();
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
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _remoteDataSource.disabledAccount();
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

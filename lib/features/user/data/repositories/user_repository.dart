import 'package:dio/dio.dart';
import 'package:mpd_client/core/connection/connection_info.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/pagination/models/generic_pagination.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/user/data/datasources/user_remote_datasource.dart';
import 'package:mpd_client/features/user/data/models/spec_add_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_position_model.dart';
import 'package:mpd_client/features/user/data/models/user_image_update_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_update_model.dart';
import 'package:mpd_client/features/user/data/models/user_records_model.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';
import 'package:mpd_client/features/user/domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final ConnectionInfo _connectionInfo;
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepository({required UserRemoteDataSource mainRemoteDataSource, required ConnectionInfo connectionInfo})
      : _connectionInfo = connectionInfo,
        _userRemoteDataSource = mainRemoteDataSource;

  @override
  Future<Either<Failure, UserInfoModel>> getUserInfo() async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getUserInfo();
      if (response.id != null) {
        await StorageRepository.putInt(StorageKeys.USERID, response.id ?? 0);
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
  Future<Either<Failure, UserInfoUpdateModel>> updateUserInfo(UserInfoUpdateModel userInfoUpdateModel) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.updateUserInfo(userInfoUpdateModel: userInfoUpdateModel);
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
  Future<Either<Failure, UserImageUpdate>> updateUserImage(UserImageUpdate userImageUpdate) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.updateUserImage(userImageUpdate: userImageUpdate);
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
  Future<Either<Failure, UserImageUpdate>> updateUserBackImage(UserImageUpdate userImageUpdate) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.updateUserBackImage(userImageUpdate: userImageUpdate);
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
  Future<Either<Failure, UserSubscriptionsModel>> getUserSubscriptions({int? limit, int? offset, String? query}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getUserSubscriptions(limit: limit, offset: offset, query: query);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  // @override
  // Future<Either<Failure, Subscription>> subscribeToDoctor(String username) async{
  //    if (!await _connectionInfo.isConnected) {
  //     return Left( NetworkFailure(message: 'Connection failure'));
  //   }
  //   final response = await _userRemoteDataSource.subscribeToDr(username);
  //   print('Response ------------------------ ${response.data}');
  //   if (response.data != null) {
  //     return Right(response.data!);
  //   } else {
  //     return Left(
  //   response.getException()?.getErrorFailure() ?? NetworkFailure("Ishlamayoti"),
  // );
  //   }
  // }

  @override
  Future<Either<Failure, UserRecordModel>> getUserRecords({int? limit, int? offset, String? query}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getUserRecords(limit: limit, offset: offset, query: query);
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
  Future<Either<Failure, GenericPagination<SpecialistCatModel>>> getSpecialistCat() async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getSpecialistCat();
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
  Future<Either<Failure, GenericPagination<SpecialistPositionModel>>> getSpecialistPosition() async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getSpecialistPosition();
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
  Future<Either<Failure, GenericPagination<SpecialistCategoryModel>>> getSpecialistCategory() async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getSpecialistCategory();
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
  Future<Either<Failure, bool>> postSpecialist(SpecAddModel model) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.postSpecialist(model);
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
  Future<Either<Failure, int>> isAddedSpecialist() async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.isAddedSpecialist();
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
  Future<Either<Failure, List<SpecialistModel>>> getSpecialist() async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _userRemoteDataSource.getSpecialist();
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

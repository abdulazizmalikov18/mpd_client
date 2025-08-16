import 'package:dio/dio.dart';
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
  final UserRemoteDataSource remoteDataSource;

  UserRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserInfoModel>> getUserInfo() async {
    try {
      final response = await remoteDataSource.getUserInfo();
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
  Future<Either<Failure, UserInfoUpdateModel>> updateUserInfo(
    UserInfoUpdateModel userInfoUpdateModel,
  ) async {
    try {
      final response = await remoteDataSource.updateUserInfo(
        userInfoUpdateModel: userInfoUpdateModel,
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
  Future<Either<Failure, UserImageUpdate>> updateUserImage(
    UserImageUpdate userImageUpdate,
  ) async {
    try {
      final response = await remoteDataSource.updateUserImage(
        userImageUpdate: userImageUpdate,
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
  Future<Either<Failure, UserImageUpdate>> updateUserBackImage(
    UserImageUpdate userImageUpdate,
  ) async {
    try {
      final response = await remoteDataSource.updateUserBackImage(
        userImageUpdate: userImageUpdate,
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
  Future<Either<Failure, UserSubscriptionsModel>> getUserSubscriptions({
    int? limit,
    int? offset,
    String? query,
  }) async {
    try {
      final response = await remoteDataSource.getUserSubscriptions(
        limit: limit,
        offset: offset,
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

  // @override
  // Future<Either<Failure, Subscription>> subscribeToDoctor(String username) async{
  //    if (!await _connectionInfo.isConnected) {
  //     return Left( NetworkFailure(message: 'Connection failure'));
  //   }
  //   final response = await remoteDataSource.subscribeToDr(username);
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
  Future<Either<Failure, UserRecordModel>> getUserRecords({
    int? limit,
    int? offset,
    String? query,
  }) async {
    try {
      final response = await remoteDataSource.getUserRecords(
        limit: limit,
        offset: offset,
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
  Future<Either<Failure, GenericPagination<SpecialistCatModel>>>
  getSpecialistCat() async {
    try {
      final response = await remoteDataSource.getSpecialistCat();
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
  Future<Either<Failure, GenericPagination<SpecialistPositionModel>>>
  getSpecialistPosition() async {
    try {
      final response = await remoteDataSource.getSpecialistPosition();
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
  Future<Either<Failure, GenericPagination<SpecialistCategoryModel>>>
  getSpecialistCategory() async {
    try {
      final response = await remoteDataSource.getSpecialistCategory();
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
    try {
      final response = await remoteDataSource.postSpecialist(model);
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
    try {
      final response = await remoteDataSource.isAddedSpecialist();
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
    try {
      final response = await remoteDataSource.getSpecialist();
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

import 'package:dio/dio.dart';
import 'package:mpd_client/domain/abstract_repo/i_user_repository.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/apis/user_remote_datasource.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class UserRepository implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepository({required UserRemoteDataSource mainRemoteDataSource}) : _userRemoteDataSource = mainRemoteDataSource;

  @override
  Future<Either<Failure, UserSubscriptionsModel>> getUserSubscriptions({int? limit, int? offset, String? query}) async {
    try {
      final response = await _userRemoteDataSource.getUserSubscriptions(limit: limit, offset: offset, query: query);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  Future<Either<Failure, Subscription>> subscribeToDoctor(String username) async {
    final response = await _userRemoteDataSource.subscribeToDr(username);
    if (response != null) {
      return Right(response);
    } else {
      return Left(
        response?.getException()?.getErrorFailure() ?? const NetworkFailure(errorMessage: "Ishlamayoti"),
      );
    }
  }

  @override
  Future<Either<Failure, UserRecordModel>> getUserRecords({int? limit, int? offset, String? query}) async {
    try {
      final response = await _userRemoteDataSource.getUserRecords(limit: limit, offset: offset, query: query);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}

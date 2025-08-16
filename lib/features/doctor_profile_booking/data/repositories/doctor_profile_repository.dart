import 'package:dio/dio.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/datasources/doctor_profile_remote_datasource.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/card_remote_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/card_local_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/cart_remote_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/timetable_by_day.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/repositories/i_doctor_profile_repository.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';

class DoctorProfileRepository implements IDoctorProfileRepository {
  final DoctorProfileRemoteDataSource remoteDataSource;

  const DoctorProfileRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, DoctorProfileModel>> getDoctorInfobyId(
    String username,
  ) async {
    try {
      final response = await remoteDataSource.getDoctorInfo(username);
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
  Future<Either<Failure, TimetableByDateModel>> getTimetable({
    required String date,
    required int id,
  }) async {
    try {
      final response = await remoteDataSource.getTimetable(date: date, id: id);
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
  Future<Either<Failure, Subscription>> subscribeToDoctor(
    String usernmae,
  ) async {
    try {
      final response = await remoteDataSource.subscribeToDoctor(usernmae);
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
  Future<Either<Failure, List<CartRemoteModel>>> addToCart(
    List<Map<String, dynamic>> carts,
  ) async {
    try {
      final response = await remoteDataSource.addToCart(carts);
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
  Future<Either<Failure, CardRemoteModel>> insertCard(
    CardLocalModel card,
  ) async {
    try {
      final response = await remoteDataSource.insertCard(card);
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
  Future<Either<Failure, CardRemoteModel>> verifyCard({
    required int code,
    required int cardId,
  }) async {
    try {
      final response = await remoteDataSource.verifyCard(
        code: code,
        cardId: cardId,
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
  Future<Either<Failure, Map<String, dynamic>>> resendverifyCode({
    required int cardId,
  }) async {
    try {
      final response = await remoteDataSource.resendVerifyCode(cardId: cardId);
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
  Future<Either<Failure, List<CardRemoteModel>>> getMyCards() async {
    try {
      final response = await remoteDataSource.getMyCards();
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
  Future<Either<Failure, Map<String, dynamic>>> deleteSubscription(
    String username,
  ) async {
    try {
      final response = await remoteDataSource.deleteSubscription(username);
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
  Future<Either<Failure, Map<String, dynamic>>> createOrder({
    required List<Map<String, dynamic>> carts,
    int? payment,
    required String action,
  }) async {
    try {
      final response = await remoteDataSource.createOrder(
        carts: carts,
        action: action,
        payment: payment,
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

import 'package:dio/dio.dart';
import 'package:mpd_client/domain/abstract_repo/i_doctor_profile_repository.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_local_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_remote_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/cart_remote_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/timetable_by_day.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/apis/doctor_profile_remote_datasource.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class DoctorProfileRepository implements IDoctorProfileRepository {
  final DoctorProfileRemoteDataSource _remoteDataSource;

  const DoctorProfileRepository({required DoctorProfileRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, DoctorProfileModel>> getDoctorInfobyId(String username) async {
    try {
      final response = await _remoteDataSource.getDoctorInfo(username);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TimetableByDateModel>> getTimetable({required String date, required int id}) async {
    try {
      final response = await _remoteDataSource.getTimetable(date: date, id: id);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Subscription>> subscribeToDoctor(String usernmae) async {
    try {
      final response = await _remoteDataSource.subscribeToDoctor(usernmae);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CartRemoteModel>>> addToCart(List<Map<String, dynamic>> carts) async {
    try {
      final response = await _remoteDataSource.addToCart(carts);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CardRemoteModel>> insertCard(CardLocalModel card) async {
    try {
      final response = await _remoteDataSource.insertCard(card);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CardRemoteModel>> verifyCard({required int code, required int cardId}) async {
    try {
      final response = await _remoteDataSource.verifyCard(code: code, cardId: cardId);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resendverifyCode({required int cardId}) async {
    try {
      final response = await _remoteDataSource.resendVerifyCode(cardId: cardId);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CardRemoteModel>>> getMyCards() async {
    try {
      final response = await _remoteDataSource.getMyCards();
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteSubscription(String username) async {
    try {
      final response = await _remoteDataSource.deleteSubscription(username);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createOrder({required List<Map<String, dynamic>> carts, int? payment, required String action}) async {
    try {
      final response = await _remoteDataSource.createOrder(carts: carts, action: action, payment: payment);
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

import 'package:mpd_client/domain/models/doctor_booking/card_local_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_remote_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/cart_remote_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/timetable_by_day.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class IDoctorProfileRepository {
  Future<Either<Failure, DoctorProfileModel>> getDoctorInfobyId(String username);
  Future<Either<Failure, TimetableByDateModel>> getTimetable({required String date, required int id});
  Future<Either<Failure, Subscription>> subscribeToDoctor(String username);
  Future<Either<Failure, List<CartRemoteModel>>> addToCart(List<Map<String, dynamic>> carts);

  Future<Either<Failure, CardRemoteModel>> insertCard(CardLocalModel card);
  Future<Either<Failure, CardRemoteModel>> verifyCard({required int code, required int cardId});
  Future<Either<Failure, Map<String, dynamic>>> resendverifyCode({required int cardId});
  Future<Either<Failure, List<CardRemoteModel>>> getMyCards();
  Future<Either<Failure, Map<String, dynamic>>> deleteSubscription(String username);
  Future<Either<Failure, Map<String, dynamic>>> createOrder({required List<Map<String, dynamic>> carts, int? payment, required String action});
}

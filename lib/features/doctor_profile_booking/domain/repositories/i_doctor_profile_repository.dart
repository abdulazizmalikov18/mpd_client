import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/card_local_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/card_remote_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/cart_remote_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/timetable_by_day.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';

abstract class IDoctorProfileRepository {
  Future<Either<Failure, DoctorProfileModel>> getDoctorInfobyId(
    String username,
  );
  Future<Either<Failure, TimetableByDateModel>> getTimetable({
    required String date,
    required int id,
  });
  Future<Either<Failure, Subscription>> subscribeToDoctor(String username);
  Future<Either<Failure, List<CartRemoteModel>>> addToCart(
    List<Map<String, dynamic>> carts,
  );

  Future<Either<Failure, CardRemoteModel>> insertCard(CardLocalModel card);
  Future<Either<Failure, CardRemoteModel>> verifyCard({
    required int code,
    required int cardId,
  });
  Future<Either<Failure, Map<String, dynamic>>> resendverifyCode({
    required int cardId,
  });
  Future<Either<Failure, List<CardRemoteModel>>> getMyCards();
  Future<Either<Failure, Map<String, dynamic>>> deleteSubscription(
    String username,
  );
  Future<Either<Failure, Map<String, dynamic>>> createOrder({
    required List<Map<String, dynamic>> carts,
    int? payment,
    required String action,
  });
}

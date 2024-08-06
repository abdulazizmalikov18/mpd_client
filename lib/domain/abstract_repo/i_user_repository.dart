import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserSubscriptionsModel>> getUserSubscriptions({required int limit, required int offset, String? query});
  Future<Either<Failure, UserRecordModel>> getUserRecords({int? limit, int? offset, String? query});
}

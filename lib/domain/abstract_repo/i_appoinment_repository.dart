import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class IAppoinmentRepository {
  Future<Either<Failure, AppointmentModel>> getUserAppoinments(PaginationModel paginationModel);

  Future<Either<Failure, Map<String, dynamic>>> cancelAppoinment({required String productid, required String cancelInfo});
}

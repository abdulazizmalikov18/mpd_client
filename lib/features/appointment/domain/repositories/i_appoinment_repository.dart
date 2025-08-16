import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';
import 'package:mpd_client/features/appointment/data/models/pagination_model.dart';

abstract class IAppoinmentRepository {
  Future<Either<Failure, AppointmentModel>> getUserAppoinments(
    PaginationModel paginationModel,
  );

  Future<Either<Failure, Map<String, dynamic>>> cancelAppoinment({
    required String productid,
    required String cancelInfo,
  });
}

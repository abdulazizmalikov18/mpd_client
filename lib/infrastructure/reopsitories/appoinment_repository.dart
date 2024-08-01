import 'package:dio/dio.dart';
import 'package:mpd_client/domain/abstract_repo/i_appoinment_repository.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/apis/appoinment_remote_datasource.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class AppoinmentRepository implements IAppoinmentRepository {
  final AppoinmentRemoteDataSource _appoinmentRemoteDataSource;
  const AppoinmentRepository({required AppoinmentRemoteDataSource appoinmentRemoteDataSource}) : _appoinmentRemoteDataSource = appoinmentRemoteDataSource;
  @override
  Future<Either<Failure, AppointmentModel>> getUserAppoinments(PaginationModel paginationModel) async {
    try {
      final response = await _appoinmentRemoteDataSource.getUserAppoinments(paginationModel);
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
  Future<Either<Failure, Map<String, dynamic>>> cancelAppoinment({required String productid, required String cancelInfo}) async {
    try {
      final response = await _appoinmentRemoteDataSource.cancelAppoinment(cancelInfo: cancelInfo, productid: productid);
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

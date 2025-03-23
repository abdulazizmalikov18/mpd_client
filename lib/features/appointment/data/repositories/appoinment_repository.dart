import 'package:dio/dio.dart';
import 'package:mpd_client/core/connection/connection_info.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';

import 'package:mpd_client/features/appointment/data/datasources/appoinment_remote_datasource.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';

import 'package:mpd_client/features/appointment/domain/repositories/i_appoinment_repository.dart';

import '../models/pagination_model.dart';

class AppoinmentRepository implements IAppoinmentRepository {
  final ConnectionInfo _connectionInfo;
  final AppoinmentRemoteDataSource _appoinmentRemoteDataSource;
  const AppoinmentRepository(
      {required AppoinmentRemoteDataSource appoinmentRemoteDataSource,
      required ConnectionInfo connectionInfo})
      : _appoinmentRemoteDataSource = appoinmentRemoteDataSource,
        _connectionInfo = connectionInfo;
  @override
  Future<Either<Failure, AppointmentModel>> getUserAppoinments(
      PaginationModel paginationModel) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response =
          await _appoinmentRemoteDataSource.getUserAppoinments(paginationModel);
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
  Future<Either<Failure, Map<String, dynamic>>> cancelAppoinment(
      {required String productid, required String cancelInfo}) async {
    if (!await _connectionInfo.isConnected) {
      return Left(const NetworkFailure(message: 'Connection failure'));
    }
    try {
      final response = await _appoinmentRemoteDataSource.cancelAppoinment(
          cancelInfo: cancelInfo, productid: productid);
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

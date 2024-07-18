import 'package:dio/dio.dart';
import 'package:mpd_client/domain/abstract_repo/account_repository.dart';
import 'package:mpd_client/domain/entity/account/popular_category_filter.dart';
import 'package:mpd_client/domain/entity/account/profession_entity.dart';
import 'package:mpd_client/domain/entity/account/region_entity.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/apis/account_service.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountService service;

  AccountRepositoryImpl(this.service);

  @override
  Future<Either<Failure, GenericPagination<RegionEntity>>> getRegion(Filter param) async {
    try {
      final result = await service.getRegion(param: param.toJson());
      return Right(result);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
        errorMessage: e.errorMessage,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<ProfessionEntity>>> getProfession(Filter id) async {
    try {
      final result = await service.getProfession(parent: id.parent, search: id.search);
      return Right(result);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
        errorMessage: e.errorMessage,
        statusCode: e.statusCode,
      ));
    }
  }
}

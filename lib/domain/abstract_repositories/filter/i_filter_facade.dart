import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';

abstract class IFilterFacade {
  Future<Either<ResponseFailure, FilterRes>> getFilter(
      {String? mark,
      String? model,
      List<String>? generation,
      List<String>? fuelType,
      List<String>? color,
      List<String>? bodyType,
      List<String>? transmission,
      List<String>? region,
      String? yearTo,
      String? yearFrom,
      String? priceFrom,
      String? priceTo,
      String? mileageFrom,
      String? mileageTo,
      int? warranty,
      int? orientDiagnostics,
      int? page,
      int? pageSize,
      String? currency,
      List<String>? service,
      String? orderBy,
      int? isUsed});

  Future<Either<ResponseFailure, List<NamedModel>>> getBodyTypes();

  Future<Either<ResponseFailure, TotalCarsRes>> getTotalCars();

  Future<Either<ResponseFailure, FilterSearchReq>> searchCreate(
      {required FilterSearchReq request});

  Future<Either<ResponseFailure, List<FilterSearchRes>>> getSearchList();

  Future<Either<ResponseFailure, dynamic>> deleteSearches({required int id});

  Future<Either<ResponseFailure, List<SearchList>>> getSearchesGenerationList(
      String name);
}

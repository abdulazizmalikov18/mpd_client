// ignore_for_file: unused_field

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orient_motors/domain/abstract_repositories/filter/i_filter_facade.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/common/token_ext.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/infrastructure/apis/apis.dart';
import 'package:orient_motors/infrastructure/core/exceptions.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/infrastructure/services/log_service.dart';

class FilterRepository implements IFilterFacade {
  final DBService _dbService;
  final FilterService _service;

  FilterRepository(
    this._dbService,
    this._service,
  );

  @override
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
      int? isUsed}) async {
    try {
      final res = await _service.getFilter(
          currency: currency,
          mark: mark,
          model: model,
          generation: generation?.toString(),
          fuelType: fuelType?.toString(),
          color: color?.toString(),
          bodyType: bodyType?.toString(),
          transmission: transmission?.toString(),
          region: region?.toString(),
          yearTo: yearTo,
          yearFrom: yearFrom,
          priceFrom: priceFrom,
          priceTo: priceTo,
          mileageFrom: mileageFrom,
          mileageTo: mileageTo,
          warranty: warranty,
          orientDiagnostics: orientDiagnostics,
          page: page,
          pageSize: pageSize,
          services: service?.toString(),
          orderBy: orderBy,
          isUsed: isUsed);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, List<NamedModel>>> getBodyTypes() async {
    try {
      final res = await _service.getBodyTypes();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, TotalCarsRes>> getTotalCars() async {
    try {
      final res = await _service.getTotalCars();
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, FilterSearchReq>> searchCreate(
      {required FilterSearchReq request}) async {
    try {
      final res = await _service.searchCreate(request: request);

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, List<FilterSearchRes>>> getSearchList() async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _service.getSearchesList(_dbService.token.toToken);

      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteSearches(
      {required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _service.deleteSearches(
          token: _dbService.token.toToken, id: id);

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, List<SearchList>>> getSearchesGenerationList(
      String name) async {
    try {
      final res = await _service.getSearchesGenerationList(name);

      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }
}

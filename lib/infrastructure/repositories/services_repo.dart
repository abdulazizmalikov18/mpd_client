// ignore_for_file: unused_field

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orient_motors/domain/abstract_repositories/services/i_services_facade.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/services/services_model.dart';
import 'package:orient_motors/infrastructure/core/exceptions.dart';
import 'package:orient_motors/infrastructure/services/log_service.dart';

import '../apis/apis.dart';
import '../services/local_database/db_service.dart';

class ServicesRepository implements IServicesFacade {
  final DBService _dbService;
  final ServicesService _service;

  ServicesRepository(
    this._dbService,
    this._service,
  );

  @override
  Future<Either<ResponseFailure, List<ServicesRes>>> getServicesList() async {
    try {
      final res = await _service.getServicesList();
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

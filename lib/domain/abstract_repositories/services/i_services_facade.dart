import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/services/services_model.dart';

abstract class IServicesFacade {
  Future<Either<ResponseFailure, List<ServicesRes>>> getServicesList();
}

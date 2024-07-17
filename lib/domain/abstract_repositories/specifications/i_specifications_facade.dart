import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';

abstract class ISpecificationsFacade {
  Future<Either<ResponseFailure, List<NamedModel>>> getRegionList();

  Future<Either<ResponseFailure, List<NamedModel>>> getTransmissionList();

  Future<Either<ResponseFailure, List<NamedModel>>> getBodyTypeList(
      {required int id});
  Future<Either<ResponseFailure, List<NamedModel>>> getBodyTypes();

  Future<Either<ResponseFailure, List<NamedModel>>> getFuelTypeList();

  Future<Either<ResponseFailure, List<NamedModel>>> getColorList();

  Future<Either<ResponseFailure, List<DriveUnitModel>>> getDriveUnitList();

  Future<Either<ResponseFailure, List<DriveUnitModel>>> getPaintConditionList();

  Future<Either<ResponseFailure, OptionsRes>> getOptions(String id);

  Future<Either<ResponseFailure, OptionsRes>> getOptionsList();

  Future<Either<ResponseFailure, List<UzModel>>> getChangedPartsList();

  Future<Either<ResponseFailure, List<NamedModel>>>
      getChangedPartsQualityList();

  Future<Either<ResponseFailure, dynamic>> deleteChangedPart(int id);
}

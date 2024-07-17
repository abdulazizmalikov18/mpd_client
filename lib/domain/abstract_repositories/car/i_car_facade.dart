import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/upload_image/upload_image.dart';

abstract class ICarFacade {
  Future<Either<ResponseFailure, BrandResResult>> getListBrand({int? page, int? pageSize, int? isUsed, int? isTop});

  Future<Either<ResponseFailure, List<dynamic>>> getDiagnosedCars();

  Future<Either<ResponseFailure, List<GenerationsConfigurationsRes>>> getConfigurationsGenerations({required String id});

  Future<Either<ResponseFailure, CarModel>> getCarWithId({required int id});

  Future<Either<ResponseFailure, List<dynamic>>> getCarWithPage({required int page});

  Future<Either<ResponseFailure, List<GenerationModel>>> getGenerationsModel({required String id});

  Future<Either<ResponseFailure, List<CarModel>>> getListModel({required String id, int? isUsed, int? isTop});

  Future<Either<ResponseFailure, dynamic>> getOwnedByOrientMotors({required int page});

  Future<Either<ResponseFailure, List<dynamic>>> getPremiumDiagnosedCars();

  Future<Either<ResponseFailure, dynamic>> createCar({required CreateCarReq request});

  Future<Either<ResponseFailure, List<PreSignedUrlRes>>> generatePreSignedUrl({required List<PreSignedUrlReq> request});

  Future<Either<ResponseFailure, List<String>>> uploadToS3({required List<String> pickedImagePath, required List<PreSignedUrlRes> data});

  Future<Either<ResponseFailure, dynamic>> createDraftCar({required CreateCarReq request});

  Future<Either<ResponseFailure, CarModel>> getDraft({required int id});

  Future<Either<ResponseFailure, dynamic>> updateDraftCar({required CreateCarReq request, required int id});

  Future<Either<ResponseFailure, dynamic>> deleteImageDraftCar({required int id});

  Future<Either<ResponseFailure, dynamic>> deleteAdditionalPhoneDraftCar({required int id});

  Future<Either<ResponseFailure, dynamic>> deleteDraft({required int id});

  Future<Either<ResponseFailure, CarResResult>> getUserCars({required int id});

  Future<Either<ResponseFailure, dynamic>> putArchive({required int id});

  Future<Either<ResponseFailure, dynamic>> deletePost({required int id});

  Future<Either<ResponseFailure, dynamic>> editCar({required CreateCarReq request, required int id});

  Future<Either<ResponseFailure, List<QuestionModel>>> getFaq();
}

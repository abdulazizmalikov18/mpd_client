import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http_parser/http_parser.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/common/token_ext.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/upload_image/upload_image.dart';
import 'package:orient_motors/infrastructure/core/exceptions.dart';
import 'package:orient_motors/infrastructure/services/log_service.dart';
import 'package:orient_motors/utils/constants.dart';

import '../../domain/abstract_repositories/car/i_car_facade.dart';
import '../apis/apis.dart';
import '../services/local_database/db_service.dart';

class CarRepository implements ICarFacade {
  final DBService _dbService;
  final CarService _service;
  final UploadImage _uploadImage;
  final Dio _dio;

  CarRepository(
    this._dbService,
    this._service,
    this._uploadImage,
    this._dio,
  );

  @override
  Future<Either<ResponseFailure, BrandResResult>> getListBrand(
      {int? page, int? pageSize, int? isUsed, int? isTop}) async {
    try {
      final res = await _service.getListBrand(
          page: page, pageSize: pageSize, isUsed: isUsed, isTop: isTop);
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
  Future<Either<ResponseFailure, List>> getDiagnosedCars() async {
    try {
      final res = await _service.getDiagnosedCars();
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
  Future<Either<ResponseFailure, List<GenerationsConfigurationsRes>>>
      getConfigurationsGenerations({required String id}) async {
    try {
      final res = await _service.getConfigurationsGenerations(id: id);
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
  Future<Either<ResponseFailure, CarModel>> getCarWithId(
      {required int id}) async {
    try {
      final res = await _service.getCarWithId(id: id);
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
  Future<Either<ResponseFailure, List>> getCarWithPage(
      {required int page}) async {
    try {
      final res = await _service.getCarWithPage(page: page);
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
  Future<Either<ResponseFailure, List<GenerationModel>>> getGenerationsModel(
      {required String id}) async {
    try {
      final res = await _service.getGenerationsModel(id: id);
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
  Future<Either<ResponseFailure, CarModel>> getDraft({required int id}) async {
    try {
      final res = await _service.getDraft(id: id);
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
  Future<Either<ResponseFailure, List<CarModel>>> getListModel(
      {required String id, int? isUsed, int? isTop}) async {
    try {
      final res =
          await _service.getListModel(id: id, isTop: isTop, isUsed: isUsed);
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
  Future<Either<ResponseFailure, dynamic>> getOwnedByOrientMotors(
      {required int page}) async {
    try {
      final res = await _service.getOwnedByOrientMotors(page: page);
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
  Future<Either<ResponseFailure, List>> getPremiumDiagnosedCars() async {
    try {
      final res = await _service.getPremiumDiagnosedCars();
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
  Future<Either<ResponseFailure, dynamic>> createCar(
      {required CreateCarReq request}) async {
    final String token = _dbService.token.toToken;
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _service.createCar(request, "Bearer $token");
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
  Future<Either<ResponseFailure, dynamic>> createDraftCar(
      {required CreateCarReq request}) async {
    final String token = _dbService.token.toToken;
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _service.createDraftCar(request, "Bearer $token");
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
  Future<Either<ResponseFailure, dynamic>> updateDraftCar(
      {required CreateCarReq request, required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    final String token = _dbService.token.toToken;
    try {
      final res = await _service.updateDraftCar(request, "Bearer $token", id);
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
  Future<Either<ResponseFailure, dynamic>> editCar(
      {required CreateCarReq request, required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    final String token = _dbService.token.toToken;
    try {
      final res = await _service.editCar(request, "Bearer $token", id);
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
  Future<Either<ResponseFailure, dynamic>> deleteImageDraftCar(
      {required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    final String token = _dbService.token.toToken;
    try {
      final res = await _service.deleteImageDraftCar("Bearer $token", id);
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
  Future<Either<ResponseFailure, dynamic>> deleteAdditionalPhoneDraftCar(
      {required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }

    final String token = _dbService.token.toToken;
    try {
      final res =
          await _service.deleteAdditionalPhoneDraftCar("Bearer $token", id);
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
  Future<Either<ResponseFailure, dynamic>> deleteDraft(
      {required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    final String token = _dbService.token.toToken;
    try {
      final res = await _service.deleteDraft("Bearer $token", id);
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
  Future<Either<ResponseFailure, dynamic>> putArchive({required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    final String token = _dbService.token.toToken;
    try {
      final res = await _service.putArchive("Bearer $token", id);
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
  Future<Either<ResponseFailure, dynamic>> deletePost({required int id}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }

    final String token = _dbService.token.toToken;
    try {
      final res = await _service.deletePost("Bearer $token", id);
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
  Future<Either<ResponseFailure, List<PreSignedUrlRes>>> generatePreSignedUrl(
      {required List<PreSignedUrlReq> request}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }

    final String token = _dbService.token.toToken;
    try {
      final res = await _uploadImage.generatePreSignedUrl(
          request.toBuiltList(), "Bearer $token");
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
  Future<Either<ResponseFailure, List<String>>> uploadToS3(
      {required List<String> pickedImagePath,
      required List<PreSignedUrlRes> data}) async {
    try {
      List<String> urls = [];
      for (int index = 0; index < data.length; index++) {
        Map<String, dynamic> map = {
          "file": await MultipartFile.fromFile(pickedImagePath[index],
              filename: data[index].fileName,
              contentType: MediaType.parse(
                  data[index].fields?.contentType ?? "image/png"))
        };
        map.addAll(data[index].fields?.toMap() ?? {});
        FormData formData = FormData.fromMap(map);
        var response = await _dio.post(data[index].url ?? "", data: formData);
        LogService.i(response.statusCode.toString());
        if (response.statusCode == 204) {
          urls.add(Constants.awsRegion == 'us-east-1'
              ? "https://s3.amazonaws.com/${Constants.awsBucketName}/${data[index].fields?.key}"
              : "https://${Constants.awsBucketName}.s3.${Constants.awsRegion}.amazonaws.com/${data[index].fields?.key}");
        }
      }
      return Right(urls);
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
  Future<Either<ResponseFailure, CarResResult>> getUserCars(
      {required int id}) async {
    try {
      final res = await _service.getUserCars(id: id);
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
  Future<Either<ResponseFailure, List<QuestionModel>>> getFaq() async {
    try {
      final res = await _service.getFaq();
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

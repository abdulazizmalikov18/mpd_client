import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/auth/create_user_model.dart';
import 'package:mpd_client/domain/models/auth/specialist.dart';
import 'package:mpd_client/domain/models/auth/token_model.dart';
import 'package:mpd_client/domain/models/auth/user.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/exceptions.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/global_request_repo.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

class AuthRepository {
  static final _repo = GlobalRequestRepository();

  const AuthRepository();

  Future<Either<Failure, TokenModel>> login({
    required String login,
    required String password,
  }) async {
    bool isLoginPhone = login.contains("998") && login.length >= 9;
    try {
      final result = await _repo.postAndSingle<TokenModel>(
        endpoint: 'UMS/api/v1.0/account/auth/',
        query: {
          "login_params": isLoginPhone ? "phone_password" : "username_password",
        },
        fromJson: TokenModel.fromJson,
        sendToken: false,
        data: {
          (isLoginPhone ? 'phone' : 'username'): login,
          'password': password,
        },
      );
      if (result.isRight) {
        await StorageRepository.putString(StorageKeys.USERID, result.right.username);
        await StorageRepository.putString(StorageKeys.TOKEN, result.right.access);
        await StorageRepository.putString(StorageKeys.REFRESH, result.right.refresh);
        return Right(result.right);
      } else {
        return Left(result.left);
      }
    } on ServerException {
      rethrow;
    } on DioException {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: '$e catch error');
    }
  }

  Future<Either<Failure, TokenModel>> refreshToken() async {
    try {
      final result = await _repo.postAndSingle(
        endpoint: 'UMS/api/v1.0/account/refresh-token/',
        fromJson: TokenModel.fromJson,
        sendToken: false,
        data: {
          'refresh': StorageRepository.getString(StorageKeys.REFRESH, defValue: ''),
        },
      );
      if (result.isRight) {
        await StorageRepository.putString(StorageKeys.TOKEN, result.right.access);
        await StorageRepository.putString(StorageKeys.REFRESH, result.right.refresh);
        return Right(result.right);
      } else {
        return Left(result.left);
      }
    } catch (e, s) {
      Log.e(e.toString());
      Log.e(s.toString());
      return Left(const DioFailure());
    }
  }

  Future<Either<Failure, UserModel>> getUser() async {
    final result = await _repo.getSingle(
      endpoint: 'UMS/api/v1.0/account/',
      fromJson: UserModel.fromJson,
    );
    return result;
  }

  Future<Either<Failure, List<MySpecialistModel>>> getSpecialists() async {
    final result = await _repo.getList(
      endpoint: 'UMS/api/v1.0/account/specialists/',
      fromJson: MySpecialistModel.fromJson,
    );
    return result;
  }

  Future<Either<Failure, UserModel>> putUser({required int id, required String cardNumber}) async {
    final result = await _repo.putSingle(
      endpoint: 'employee/$id',
      fromJson: UserModel.fromJson,
      data: {"card_number": cardNumber},
    );
    return result;
  }

  Future<Either<Failure, bool>> checkUser(String phone) async {
    return await _repo.postAndSingle(
      sendToken: false,
      fromJson: (p0) => p0["status"] as bool,
      endpoint: "/UMS/api/v1.0/account/check-user/?login_params=phone",
      data: {'phone': phone},
    );
  }

  Future<Either<Failure, bool>> sendPvc(String phone) async {
    return await _repo.postAndSingle(
      sendToken: false,
      fromJson: (p0) => p0["message"] == "Pvc sent",
      endpoint: "/UMS/api/v1.0/account/send-pvc/",
      data: {'phone': phone},
    );
  }

  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword, String newRepeatPassword) async {
    return await _repo.postAndSingle(
      sendToken: false,
      fromJson: (p0) => p0["message"] == "Pvc sent",
      endpoint: "/UMS/api/v1.0/account/change-password/",
      data: {
        "old_password": oldPassword,
        "pvc": "000000",
        "password1": newPassword,
        "password2": newRepeatPassword,
      },
    );
  }

  Future<Either<Failure, bool>> confirmPvc(String phone, String pvc) async {
    return await _repo.postAndSingle(
      sendToken: false,
      fromJson: (p0) {
        if (p0.containsKey("is_confirmed")) {
          return p0["is_confirmed"] as bool;
        }
        return false;
      },
      endpoint: "/UMS/api/v1.0/account/confirm-pvc/",
      data: {'phone': phone, "pvc": pvc},
    );
  }

  Future<Either<Failure, bool>> checkLogin(String login) async {
    return await _repo.getSingle(
      sendToken: false,
      fromJson: (p0) {
        if (p0.containsKey("is_existed")) {
          return p0["is_existed"] as bool;
        }
        return false;
      },
      endpoint: "/UMS/api/v1.0/account/check-login/$login/",
    );
  }

  Future<Either<Failure, CreateUserModel>> createUser(CreateUser user, String? avatar) async {
    final data = FormData.fromMap(user.toJson());
    if (avatar != null) {
      data.files.add(
        MapEntry(
          "avatar",
          MultipartFile.fromFileSync(
            avatar,
            filename: avatar.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    final result = await _repo.postAndSingle(
      sendToken: false,
      fromJson: CreateUserModel.fromJson,
      endpoint: "/UMS/api/v1.0/account/create/",
      formData: data,
    );
    return result;
  }

  Future<Either<Failure, bool>> updateUser(UserModel user, String? avatar) async {
    final data = FormData.fromMap({
      "main": true,
      "business_ava": true,
    });
    if (avatar != null) {
      data.files.add(
        MapEntry(
          "image",
          MultipartFile.fromFileSync(
            avatar,
            filename: avatar.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    await _repo.postAndSingle(
      sendToken: true,
      fromJson: (p0) {},
      endpoint: "/UMS/api/v1.0/account/media/avatars/",
      formData: data,
    );
    final result = await _repo.patchAndSingle(
      sendToken: true,
      fromJson: (p0) {
        return p0.containsKey("name");
      },
      endpoint: "/UMS/api/v1.0/account/",
      data: user.toJson(),
    );
    return result;
  }
}

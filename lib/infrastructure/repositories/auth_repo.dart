import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/common/token_ext.dart';
import 'package:orient_motors/domain/failurs/auth/auth_failure.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';
import 'package:orient_motors/infrastructure/services/log_service.dart';
import 'package:orient_motors/utils/constants.dart';

import '../../domain/common/token.dart';
import '../../domain/failurs/auth/i_auth_facade.dart';
import '../../domain/models/auth/auth.dart';
import '../apis/apis.dart';
import '../core/exceptions.dart';
import '../services/local_database/db_service.dart';

class AuthRepository implements IAuthFacade {
  final DBService _dbService;
  final AuthService _authService;

  AuthRepository(
    this._dbService,
    this._authService,
  );

  /// Get user
  @override
  Option<AuthFailure> checkUser() {
    final Token token = _dbService.token;
    return optionOf(token.hasFailure);
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>> registration(
      {required RegisterReq request}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }

    try {
      final res = await _authService.registration(
        token: "Bearer ${_dbService.token.accessToken}",
        request: request,
      );
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
  Future<Either<ResponseFailure, SuccessModel>> verificationSend(
      {required VerificationSendReq request}) async {
    try {
      final res = await _authService.verificationSend(request: request);
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
  Future<Either<ResponseFailure, CheckAuthModel>> checkUserFromBackend(
      {required VerificationSendReq request}) async {
    try {
      final res = await _authService.checkAuth(request: request);
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
  Future<Either<ResponseFailure, LoginRes>> verificationVerify(
      {required VerificationVerifyReq request}) async {
    try {
      final res = await _authService.verificationVerify(request: request);
      if (res.isSuccessful) {
        _dbService.setToken(Token(
            accessToken: res.body?.access, refreshToken: res.body?.refresh));
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
  Future<Either<ResponseFailure, LoginRes>> signIn(
      {required SignInReq request}) async {
    try {
      final res = await _authService.signIn(request: request);
      if (res.isSuccessful) {
        _dbService.setToken(Token(
            accessToken: res.body?.access, refreshToken: res.body?.refresh));
        return right(res.body!);
      }
      // else if(res.statusCode == 404){
      //   return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      // }
      else {
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
  Future<Either<ResponseFailure, SuccessModel>> updatePassword(
      {required ResetPasswordReq request}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.updatePassword(
        token: "Bearer ${_dbService.token.accessToken}",
        request: request,
      );
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
  Future<Either<ResponseFailure, LoginRes>> forgotPassword(
      {required ForgotPasswordReqModel request}) async {
    try {
      final res = await _authService.forgotPassword(
        request: request,
      );
      if (res.isSuccessful) {
        _dbService.setToken(Token(
            accessToken: res.body?.access, refreshToken: res.body?.refresh));
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
  Future<Either<ResponseFailure, SuccessModel>> updatePhone(
      {required VerificationVerifyReq request}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.updatePhone(
        token: "Bearer ${_dbService.token.accessToken}",
        request: request,
      );
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
  Future<Either<ResponseFailure, SuccessModel>> additionalNumberVerify(
      {required VerificationVerifyReq request}) async {
    try {
      final res = await _authService.additionalNumberVerify(request: request);
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
  Future<Either<ResponseFailure, List<CarModel>>> getOwnCars(
      {required String isActive}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.getOwnCars(
        token: "Bearer ${_dbService.token.accessToken}",
        isActive: isActive,
      );
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
  Future<Either<ResponseFailure, List<CarModel>>> getDrafts() async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.getDrafts(
        token: "Bearer ${_dbService.token.accessToken}",
      );
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
  Future<Either<ResponseFailure, ProfileRes>> getProfile() async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.getProfile(
        token: "Bearer ${_dbService.token.accessToken}",
      );
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
  Future<Either<ResponseFailure, SuccessModel>> deleteProfile() async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.deleteProfile(
        token: "Bearer ${_dbService.token.accessToken}",
      );
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
  Future<Either<ResponseFailure, SuccessModel>> updateProfile(
      {required ProfileModel request}) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }

    try {
      final res = await _authService.updateProfile(
        token: "Bearer ${_dbService.token.accessToken}",
        request: request,
      );
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

  static Future<Either<ResponseFailure, LoginRes>> refreshToken(
      String refresh) async {
    try {
      final response = await Dio().post(
        "${Constants.baseUrlP}/token/refresh/",
        data: {'refresh': refresh},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return right(LoginRes(
          (b) => b
            ..refresh = response.data['refresh']
            ..access = response.data['access'],
        ));
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
  Future<Either<ResponseFailure, List<CarModel>>> getLikedList() async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.getLikedList(
        token: "Bearer ${_dbService.token.accessToken}",
      );
      if (res.isSuccessful) {
        _dbService.removeLikes();
        for (CarModel item in res.body?.toList() ?? []) {
          await _dbService.addLike(item);
        }
        return right(_dbService.likesList);
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
  Future<Either<ResponseFailure, SuccessModel>> patchLike(int id) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.patchLike(
          token: "Bearer ${_dbService.token.accessToken}", id: id);
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
  Future<Either<ResponseFailure, List<CarModel>>> getSeenList() async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.getSeenList(
        token: "Bearer ${_dbService.token.accessToken}",
      );
      if (res.isSuccessful) {
        _dbService.removeSeens();
        for (CarModel item in res.body?.toList() ?? []) {
          await _dbService.addSeen(item);
        }

        return right(_dbService.seenList);
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
  Future<Either<ResponseFailure, SuccessModel>> patchSeen(int id) async {
    if (_dbService.token.accessToken == null) {
      return left(InvalidCredentials(message: 'invalid_credential'.tr()));
    }
    try {
      final res = await _authService.patchSeen(
          token: "Bearer ${_dbService.token.accessToken}", id: id);
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
}

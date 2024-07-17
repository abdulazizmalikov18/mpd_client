import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';

import 'auth_failure.dart';

abstract class IAuthFacade {
  Option<AuthFailure> checkUser();

  Future<Either<ResponseFailure, SuccessModel>> registration({
    required RegisterReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> verificationSend({
    required VerificationSendReq request,
  });

  Future<Either<ResponseFailure, CheckAuthModel>> checkUserFromBackend(
      {required VerificationSendReq request});

  Future<Either<ResponseFailure, LoginRes>> verificationVerify({
    required VerificationVerifyReq request,
  });

  Future<Either<ResponseFailure, LoginRes>> signIn({
    required SignInReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> updatePassword({
    required ResetPasswordReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> updateProfile(
      {required ProfileModel request});

  Future<Either<ResponseFailure, SuccessModel>> updatePhone(
      {required VerificationVerifyReq request});

  Future<Either<ResponseFailure, List<CarModel>>> getOwnCars(
      {required String isActive});

  Future<Either<ResponseFailure, SuccessModel>> additionalNumberVerify(
      {required VerificationVerifyReq request});
  Future<Either<ResponseFailure, List<CarModel>>> getDrafts();
  Future<Either<ResponseFailure, ProfileRes>> getProfile();
  Future<Either<ResponseFailure, SuccessModel>> deleteProfile();

  Future<Either<ResponseFailure, List<CarModel>>> getLikedList();
  Future<Either<ResponseFailure, SuccessModel>> patchLike(int id);
  Future<Either<ResponseFailure, LoginRes>> forgotPassword(
      {required ForgotPasswordReqModel request});

  Future<Either<ResponseFailure, List<CarModel>>> getSeenList();
  Future<Either<ResponseFailure, SuccessModel>> patchSeen(int id);
}

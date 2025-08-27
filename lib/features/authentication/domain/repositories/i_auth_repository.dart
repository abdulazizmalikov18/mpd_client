import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_form_model.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_model.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/data/models/token_model.dart';
import 'package:mpd_client/features/authentication/data/models/update_personal_data_model.dart';

abstract class IAuthRepository {
  Future<Either<Failure, TokenModel>> login({
    String? phone,
    String? username,
    required String password,
    required bool rememberMe,
  });

  Future<Either<Failure, bool>> register(String phone);
  Future<Either<Failure, TokenModel>> verification(String phone, String code);
  Future<Either<Failure, ProfessionModel>> getProfessions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  });
  Future<Either<Failure, RegionsModel>> getRegions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  });
  Future<Either<Failure, bool>> checkUsername(String username);
  Future<Either<Failure, bool>> checkPassword(String password);

  Future<Either<Failure, CreateUserModel>> createUser(CreateUserFormModel user);
  Future<Either<Failure, bool>> changePassword(
    String password, {
    String? oldPassword,
  });

  Future<Either<Failure, UpdatePersonalDataModel>> updatePersonalData({
    required String passportSTIR,
    String? filePath,
  });

  Future<Either<Failure, TokenModel>> refreshToken();
  Future<Either<Failure, bool>> disabledAccount();

  // Forgot password flow
  Future<Either<Failure, bool>> requestPasswordReset(String phone);
  Future<Either<Failure, bool>> verifyPasswordResetCode(String phone, String pvc);
  Future<Either<Failure, bool>> completePasswordReset({
    required String phone,
    required String pvc,
    required String password1,
    required String password2,
  });
}

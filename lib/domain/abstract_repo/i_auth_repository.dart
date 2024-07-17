import 'package:mpd_client/domain/models/auth/create_user_form_model.dart';
import 'package:mpd_client/domain/models/auth/create_user_model.dart';
import 'package:mpd_client/domain/models/auth/token_model.dart';
import 'package:mpd_client/domain/models/auth/update_personal_data_model.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class IAuthRepository {
  Future<Either<Failure, TokenModel>> login({String? phone, String? username, required String password, required bool rememberMe});

  Future<Either<Failure, bool>> register(String phone);

  Future<Either<Failure, TokenModel>> verification(String phone, String code);

  Future<Either<Failure, bool>> checkUsername(String username);

  Future<Either<Failure, bool>> checkPassword(String password);

  Future<Either<Failure, CreateUserModel>> createUser(CreateUserFormModel user);

  Future<Either<Failure, bool>> changePassword(String password, {String? oldPassword});

  Future<Either<Failure, UpdatePersonalDataModel>> updatePersonalData({required String passportSTIR, String? filePath});

// Future<TokenModel> refreshToken(String refreshToken);
}

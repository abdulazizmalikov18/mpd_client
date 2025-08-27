import 'package:dio/dio.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/error_handle.dart';

import 'package:mpd_client/core/network/dio_settings.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_form_model.dart';
import 'package:mpd_client/features/authentication/data/models/create_user_model.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/data/models/token_model.dart';
import 'package:mpd_client/features/authentication/data/models/update_personal_data_model.dart';

abstract class IAuthRemoteDataSource {
  Future<TokenModel> login({
    String? phone,
    String? username,
    required String password,
  });

  Future<bool> register(String phone);

  Future<TokenModel> refreshToken();
  Future<bool> disabledAccount();

  Future<TokenModel> verification(String phone, String code);

  Future<ProfessionModel> getProffesions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  });

  Future<RegionsModel> getRegions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  });

  Future<bool> checkUsername(String username);

  Future<CreateUserModel> createUser({required CreateUserFormModel userModel});

  Future<bool> changePassword({required String password, String oldPassword});

  Future<bool> checkPassword({required String password});

  Future<UpdatePersonalDataModel> updatePersonalData({
    required String passportSTIR,
    String? filePath,
  });

  // Forgot password flow
  Future<bool> requestPasswordReset(String phone);
  Future<bool> verifyPasswordResetCode(String phone, String pvc);
  Future<bool> completePasswordReset({
    required String phone,
    required String pvc,
    required String password1,
    required String password2,
  });
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  Dio get _client => locator<DioSettings>().dioForAuth;
  final ErrorHandle _handle = ErrorHandle();

  AuthRemoteDataSource();

  @override
  Future<TokenModel> login({
    String? phone,
    String? username,
    required String password,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          '/UMS/api/v1.0/account/auth/',
          queryParameters: {
            'login_params': phone != null
                ? 'phone_password'
                : 'username_password',
          },
          data: FormData.fromMap({
            if (phone != null) 'phone': phone else 'username': username,
            'password': password,
          }),
        );
      },
      body: (response) {
        return TokenModel(
          access: response['access'],
          refresh: response['refresh'],
        );
      },
    );
  }

  @override
  Future<bool> requestPasswordReset(String phone) async {
    return _handle.apiControl<dynamic, bool>(
      request: () => _client.post(
        '/UMS/api/v1.0/account/enter-to-account-by-pvc',
        data: {'phone': phone},
      ),
      body: (_) => true,
    );
  }

  @override
  Future<bool> verifyPasswordResetCode(String phone, String pvc) async {
    return _handle.apiControl<dynamic, bool>(
      request: () => _client.post(
        '/UMS/api/v1.0/account/forget-password/',
        data: {'phone': phone, 'pvc': pvc},
      ),
      body: (_) => true,
    );
  }

  @override
  Future<bool> completePasswordReset({
    required String phone,
    required String pvc,
    required String password1,
    required String password2,
  }) async {
    return _handle.apiControl<dynamic, bool>(
      request: () => _client.post(
        '/UMS/api/v1.0/account/forget-password-complete/',
        data: {
          'phone': phone,
          'pvc': pvc,
          'password1': password1,
          'password2': password2,
        },
      ),
      body: (_) => true,
    );
  }

  @override
  Future<TokenModel> refreshToken() async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          '/UMS/api/v1.0/account/refresh-token/',
          data: {"refresh": StorageRepository.getString(StorageKeys.REFRESH)},
        );
      },
      body: (response) {
        return TokenModel(
          access: response['access'],
          refresh: response['refresh'],
        );
      },
    );
  }

  @override
  Future<bool> register(String phone) async {
    final data = FormData.fromMap({'phone': phone});
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/UMS/api/v1.0/account/check-user/?login_params=phone",
          data: data,
        );
      },
      body: (response) {
        return response['status'];
      },
    );
  }

  @override
  Future<TokenModel> verification(String phone, String code) async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          'UMS/api/v1.0/account/confirm-pvc/',
          options: Options(
            headers: StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty
                ? {
                    'Authorization':
                        'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
                  }
                : {},
          ),
          data: {"phone": phone.substring(1), "pvc": code},
        );
      },
      body: (response) {
        return TokenModel(
          access: response['access'],
          refresh: response['refresh'],
        );
      },
    );
  }

  @override
  Future<ProfessionModel> getProffesions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          '/CDMS/api/v1.0/public/category/',
          queryParameters: {
            "hide_from_users": false,
            if (limit == null) "limit": limit,
            if (offset == null) "offset": offset,
            if (parent == null) "parent": parent ?? 0,
            if (parent == null) "search": query,
          },
        );
      },
      body: (response) {
        return ProfessionModel.fromJson(response);
      },
    );
  }

  @override
  Future<CreateUserModel> createUser({
    required CreateUserFormModel userModel,
  }) async {
    final data = FormData.fromMap(userModel.toJson());
    return _handle.apiControl(
      request: () {
        return _client.post("/UMS/api/v1.0/account/create/", data: data);
      },
      body: (response) {
        return CreateUserModel.fromJson(response);
      },
    );
  }

  //  -------------------- CHANGE PASSWORD --------------------------  //

  @override
  Future<bool> changePassword({
    required String password,
    String? oldPassword,
  }) async {
    final data = FormData.fromMap({
      "old_password": oldPassword,
      "password1": password,
      "password2": password,
    });
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/UMS/api/v1.0/account/change-password/",
          data: data,
        );
      },
      body: (response) {
        return true;
      },
    );
  }

  @override
  Future<UpdatePersonalDataModel> updatePersonalData({
    required String passportSTIR,
    String? filePath,
  }) async {
    final data = FormData.fromMap({
      "passport_scan": await MultipartFile.fromFile(filePath!),
      "passport_stir": passportSTIR,
    });
    return _handle.apiControl(
      request: () {
        return _client.patch(
          "/UMS/api/v1.0/account/personal_data/",
          data: data,
        );
      },
      body: (response) {
        return UpdatePersonalDataModel.fromJson(response);
      },
    );
  }

  @override
  Future<bool> checkUsername(String username) async {
    return _handle.apiControl(
      request: () {
        return _client.get("/UMS/api/v1.0/account/check-username/$username/");
      },
      body: (response) {
        return response['is_existed'];
      },
    );
  }

  @override
  Future<bool> checkPassword({required String password}) async {
    final data = FormData.fromMap({"password": password});

    return _handle.apiControl(
      request: () {
        return _client.post(
          "/UMS/api/v1.0/account/check-password/",
          data: data,
        );
      },
      body: (response) {
        return response['is_correct'];
      },
    );
  }

  @override
  Future<RegionsModel> getRegions({
    int? limit,
    int? offset,
    int? parent,
    String? query,
  }) async {
    final baseUrl = StringBuffer(
      '/GMS/api/v1.0/public/region/?parent=${parent ?? 1}',
    );
    // if (parent != null) baseUrl.write('&parent=$parent');

    if (query != null) baseUrl.write('&search=$query');

    return _handle.apiControl(
      request: () {
        return _client.get(baseUrl.toString());
      },
      body: (response) {
        return RegionsModel.fromJson(response);
      },
    );
  }

  @override
  Future<bool> disabledAccount() async {
    return _handle.apiControl(
      request: () {
        return _client.post('/UMS/api/v1.0/account/deactivate-user/');
      },
      body: (response) {
        return true;
      },
    );
  }
}

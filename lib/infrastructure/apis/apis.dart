import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:mpd_client/domain/models/account/profession_model.dart';
import 'package:mpd_client/domain/models/account/region_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/domain/models/lenta/post_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/auth_repository.dart';
import 'package:mpd_client/infrastructure/serializers/json_serializable_converter.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';

sealed class ReadGeneric {
  // AccountService
  static GenericPagination<ProfessionModel> professionGeneric(Map<String, dynamic> json) => GenericPagination.fromJson(json, (p0) => ProfessionModel.fromJson(p0 as Map<String, dynamic>));
  static GenericPagination<RegionModel> regionsGeneric(Map<String, dynamic> json) => GenericPagination.fromJson(json, (p0) => RegionModel.fromJson(p0 as Map<String, dynamic>));
  static GenericPagination<PostModel> genericLenta(Map<String, dynamic> json) => GenericPagination.fromJson(json, (p0) => PostModel.fromJson(p0 as Map<String, dynamic>));

  // 
}

const converter = JsonSerializableConverter({
  GenericPagination<RegionModel>: ReadGeneric.regionsGeneric,
  GenericPagination<ProfessionModel>: ReadGeneric.professionGeneric,
  GenericPagination<PostModel>: ReadGeneric.genericLenta,
});
final clientChopper = _Client("http://82.215.78.34", true);

// AccountService
base class _Client extends ChopperClient {
  _Client(String baseUrl, bool useInterceptors)
      : super(
          baseUrl: Uri.parse(baseUrl),
          interceptors: useInterceptors
              ? [
                  // CoreInterceptor(),
                  HttpLoggingInterceptor(),
                  // NetworkInterceptor(),
                  // BackendInterceptor(),
                  CurlInterceptor(),
                  PrettyChopperLogger()
                ]
              : const [],
          converter: converter,
          errorConverter: converter,
          authenticator: MyAuthenticator(),
        );
}

class MyAuthenticator extends Authenticator {
  @override
  FutureOr<Request?> authenticate(Request request, Response response, [Request? originalRequest]) async {
    if (response.statusCode == 401) {
      try {
        final result = await const AuthRepository().refreshToken();

        Map<String, String>? header;

        result.fold((error) {
          Log.w(error.toString());
        }, (data) {
          String? newToken = data.access;

          final Map<String, String> updatedHeaders = Map<String, String>.of(request.headers);

          newToken = 'Bearer $newToken';
          updatedHeaders.update('Authorization', (String _) => newToken!, ifAbsent: () => newToken!);

          header = updatedHeaders;
        });

        return request.copyWith(headers: header);
      } catch (e) {
        LogService.i(e.toString());
      }
    }
    return null;
  }
}

import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:mpd_client/domain/entity/account/popular_category_filter.dart';
import 'package:mpd_client/domain/models/account/region_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/core/interceptors.dart';
import 'package:mpd_client/infrastructure/serializers/json_serializable_converter.dart';
import 'package:mpd_client/main.dart';

part 'apis.chopper.dart';

const converter = JsonSerializableConverter({
  RegionModel: RegionModel.fromJsonFactory,
});

// Account
@ChopperApi(baseUrl: '/token/')
abstract class AccountService extends ChopperService {
  @Get(path: 'GMS/api/v1.0/public/region/')
  Future<GenericPagination<RegionModel>> getRegion({
    @Query() required Filter param,
    // @Header('Authorization') required String token,
  });

  static AccountService create() => _$AccountService(_Client($baseUrlHttp, true));
}

base class _Client extends ChopperClient {
  _Client(String baseUrl, bool useInterceptors)
      : super(
          baseUrl: Uri.parse(baseUrl),
          interceptors: useInterceptors
              ? [
                  CoreInterceptor(),
                  HttpLoggingInterceptor(),
                  NetworkInterceptor(),
                  BackendInterceptor(),
                  CurlInterceptor(),
                ]
              : const [],
          // converter: BuiltValueConverter(),
          // errorConverter: ErrorMyConverter(),
          // authenticator: MyAuthenticator(),
        );
}

// class MyAuthenticator extends Authenticator {
//   @override
//   FutureOr<Request?> authenticate(Request request, Response response,
//       [Request? originalRequest]) async {
//     if (response.statusCode == 401) {
//       final dbService = await DBService.create;
//
//       try {
//         final result = await AuthRepository.refreshToken(
//             dbService.token.refreshToken ?? "");
//
//         Map<String, String>? header;
//
//         result.fold((error) {
//           dbService.signOut();
//         }, (data) {
//           dbService.setToken(
//               TokenModel(accessToken: data.access, refreshToken: data.refresh));
//
//           String? newToken = data.access;
//
//           final Map<String, String> updatedHeaders =
//           Map<String, String>.of(request.headers);
//
//           newToken = 'Bearer $newToken';
//           updatedHeaders.update('Authorization', (String _) => newToken!,
//               ifAbsent: () => newToken!);
//
//           header = updatedHeaders;
//         });
//
//         return request.copyWith(headers: header);
//       } catch (e) {
//         LogService.i(e.toString());
//
//         dbService.signOut();
//       }
//     }
//     return null;
//   }
// }

//
// @override
// Future<> getRegion() async {
//   try {
//     final response = await dio.get(
//       'GMS/api/v1.0/public/region/',
//       options: Options(
//         headers: StorageRepository
//             .getString(StorageKeys.TOKEN)
//             .isNotEmpty
//             ? {
//           'Authorization':
//           'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
//         }
//             : {},
//       ),
//       queryParameters: param.toJson(),
//     );
//     if (response.statusCode! >= 200 && response.statusCode! < 300) {
//       return GenericPagination.fromJson(
//         response.data,
//             (p0) => RegionModel.fromJson(p0 as Map<String, dynamic>),
//       );
//     }
//
//     throw ServerException(
//       statusCode: response.statusCode ?? 0,
//       errorMessage: response.statusMessage ?? "",
//     );
//   } on ServerException {
//     rethrow;
//   } on DioError catch (e) {
//     throw DioException(requestOptions: e.requestOptions);
//   } on Exception catch (e) {
//     throw ParsingException(errorMessage: e.toString());
//   }
// }
//
// @override
// Future<GenericPagination<ProfessionModel>> getProfession(Filter param) async {
//   try {
//     final response = await dio.get(
//       'CDMS/api/v1.0/business/category/',
//       queryParameters: {"parent": param.parent, "search": param.search},
//       options: Options(
//         headers: StorageRepository
//             .getString(StorageKeys.TOKEN)
//             .isNotEmpty
//             ? {
//           'Authorization':
//           'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'
//         }
//             : {},
//       ),
//     );
//     if (response.statusCode! >= 200 && response.statusCode! < 300) {
//       return GenericPagination.fromJson(
//         response.data,
//             (p0) => ProfessionModel.fromJson(p0 as Map<String, dynamic>),
//       );
//     }
//
//     throw ServerException(
//       statusCode: response.statusCode ?? 0,
//       errorMessage: response.statusMessage ?? "",
//     );
//   } on ServerException {
//     rethrow;
//   } on DioError catch (e) {
//     throw DioException(requestOptions: e.requestOptions);
//   } on Exception catch (e) {
//     throw ParsingException(errorMessage: e.toString());
//   }
// }

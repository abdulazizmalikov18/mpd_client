// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AccountService extends AccountService {
  _$AccountService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AccountService;

  @override
  Future<GenericPagination<RegionModel>> getRegion({
    String? token,
    required dynamic param,
  }) async {
    final Uri $url = Uri.parse('GMS/api/v1.0/public/region/');
    final Map<String, dynamic> $params = param;
    final Map<String, String> $headers = {
      if (token != null) 'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    final Response $response = await client
        .send<GenericPagination<RegionModel>, RegionModel>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<GenericPagination<ProfessionModel>> getProfession({
    String? token,
    required dynamic parent,
    required dynamic search,
  }) async {
    final Uri $url = Uri.parse('CDMS/api/v1.0/business/category/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'parent': parent,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (token != null) 'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    final Response $response = await client
        .send<GenericPagination<ProfessionModel>, ProfessionModel>($request);
    return $response.bodyOrThrow;
  }
}

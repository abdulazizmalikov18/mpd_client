import 'package:dio/dio.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/error_handle.dart';
import 'package:mpd_client/features/home/data/models/adverts_model.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';
import 'package:mpd_client/features/home/data/models/upload_post_model.dart';
import 'package:mpd_client/features/home/data/models/user_account_model.dart';

abstract class IHomeRemoteDataSource {
  Future<SpecialistProductModel> getSpecialistProducts(
    ProductFilterModel model,
  );
  Future<Map<String, dynamic>> createPost(UploadPost post);
  Future<AdvertsModel> getAdverts({required int limit, required int offset});
  Future<PostsModel> getBanners({
    required int limit,
    required int offset,
    required String username,
  });
  Future<ComentModel> getPostComments({
    required int limit,
    required int offset,
    required int postId,
  });
  Future<Coment> sendPostComment({required String text, required int postId});
  Future<bool> deletePost({required int postId});
  Future<UserAccountModel> getUser({required String username});
  Future<Map<String, dynamic>> sendLikeOrUnlike({required int postId});
  Future<bool> reportPost({required int postId, required String reason});
  Future<bool> blockUser({required String username});
}

class HomeRemoteDataSource implements IHomeRemoteDataSource {
  final Dio _client;
  final ErrorHandle _handle = ErrorHandle();

  HomeRemoteDataSource(this._client);

  @override
  Future<ComentModel> getPostComments({
    required int limit,
    required int offset,
    required int postId,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          '/SMMS/api/v1.0/public/post/$postId/comment/?limit=$limit&offset=$offset',
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return ComentModel.fromJson(response);
      },
    );
  }

  @override
  Future<Coment> sendPostComment({
    required String text,
    required int postId,
  }) async {
    final data = FormData.fromMap({'text': text});
    return _handle.apiControl(
      request: () {
        return _client.post(
          '/SMMS/api/v1.0/public/post/$postId/comment/',
          data: data,
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return Coment.fromJson(response);
      },
    );
  }

  @override
  Future<Map<String, dynamic>> sendLikeOrUnlike({required int postId}) async {
    return _handle.apiControl(
      request: () {
        return _client.patch(
          '/SMMS/api/v1.0/public/post/$postId/like/',
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return response;
      },
    );
  }

  @override
  Future<AdvertsModel> getAdverts({
    required int limit,
    required int offset,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          '/SMMS/api/v1.0/admin/advert-post/?limit=$limit&offset=$offset',
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return AdvertsModel.fromJson(response);
      },
    );
  }

  @override
  Future<PostsModel> getBanners({
    required int limit,
    required int offset,
    required String username,
  }) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/SMMS/api/v1.0/public/post/?limit=$limit&offset=$offset",
          queryParameters: username.isEmpty ? {} : {"author_user": username},
          options: Options(
            headers: {
              'content-Type': 'application/x-www-form-urlencoded',
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return PostsModel.fromJson(response);
      },
    );
  }

  @override
  Future<SpecialistProductModel> getSpecialistProducts(
    ProductFilterModel model,
  ) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/PMS/api/v1.0/public/product_org/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
          queryParameters: model.toJson(),
        );
      },
      body: (response) {
        return SpecialistProductModel.fromJson(response);
      },
    );
  }

  @override
  Future<Map<String, dynamic>> createPost(UploadPost post) async {
    final data = FormData.fromMap(post.toJson());
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/SMMS/api/v1.0/public/post/",
          data: data,
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return response;
      },
    );
  }

  @override
  Future<bool> deletePost({required int postId}) async {
    return _handle.apiControl(
      request: () {
        return _client.delete(
          "/SMMS/api/v1.0/public/post/$postId/",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return true;
      },
    );
  }

  @override
  Future<UserAccountModel> getUser({required String username}) async {
    return _handle.apiControl(
      request: () {
        return _client.get(
          "/UMS/api/v1.0/account/get-data/$username",
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return UserAccountModel.fromJson(response);
      },
    );
  }

  @override
  Future<bool> reportPost({required int postId, required String reason}) async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/SMMS/api/v1.0/public/post/$postId/report/",
          data: FormData.fromMap({'reason': reason}),
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return true;
      },
    );
  }

  @override
  Future<bool> blockUser({required String username}) async {
    return _handle.apiControl(
      request: () {
        return _client.post(
          "/UMS/api/v1.0/account/block-user/",
          data: FormData.fromMap({'username': username}),
          options: Options(
            headers: {
              if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty)
                'Authorization':
                    'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}',
            },
          ),
        );
      },
      body: (response) {
        return true;
      },
    );
  }
}

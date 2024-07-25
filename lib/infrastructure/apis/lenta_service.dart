import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mpd_client/domain/entity/generic_entity.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
import 'package:mpd_client/domain/entity/lenta/create_post_param.dart';
import 'package:mpd_client/domain/entity/lenta/post_entity.dart';
import 'package:mpd_client/domain/entity/lenta/send_comment_post_entity.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/domain/models/lenta/adverst_model.dart';
import 'package:mpd_client/domain/models/lenta/comment_model.dart';
import 'package:mpd_client/domain/models/lenta/post_model.dart';
import 'package:mpd_client/domain/models/lenta/specialist_product_model.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';
import 'package:mpd_client/infrastructure/services/response_handler.dart';

abstract class LentaService {
  factory LentaService.create() => LentaServiceImpl();
  Future<ResponseHandler<SpecialistProductModel>> getSpecialistProducts(GenericEntity<int> params);

  Future<ResponseHandler<AdvertsModel>> getAdverts(GenericEntity params);

  Future<ResponseHandler<GenericPagination<PostEntity>>> getBanners(GenericEntity params);

  Future<ResponseHandler<GenericPagination<CommentEntity>>> getPostComments(GenericEntity<int> params);

  Future<ResponseHandler<CommentEntity>> sendPostComment(SendCommentPostEntity params);

  Future<ResponseHandler<Map<String, dynamic>>> sendLikeOrUnlike({required int postId});

  Future<ResponseHandler<PostEntity>> createPost(CreatePostParam post);
}

class LentaServiceImpl implements LentaService {
  final ErrorHandle _handle = ErrorHandle();

  LentaServiceImpl();

  @override
  Future<ResponseHandler<GenericPagination<CommentEntity>>> getPostComments(GenericEntity<int> params) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.get(
          '/SMMS/api/v1.0/public/post/${params.data}/comment/',
          queryParameters: params.query(
            ordering: false,
            search: false,
          ),
        );
      },
      body: (response) {
        return ResponseHandler()
          ..setData(GenericPagination.fromJson(response, (x) {
            return CommentModel.fromJson(x as Map<String, dynamic>);
          }));
      },
    );
  }

  @override
  Future<ResponseHandler<CommentEntity>> sendPostComment(SendCommentPostEntity params) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.post(
          '/SMMS/api/v1.0/public/post/${params.postId}/comment/',
          data: {'text': params.message},
        );
      },
      body: (response) {
        return ResponseHandler()..data = CommentModel.fromJson(response);
      },
    );
  }

  @override
  Future<ResponseHandler<Map<String, dynamic>>> sendLikeOrUnlike({required int postId}) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.patch('/SMMS/api/v1.0/public/post/$postId/like/');
      },
      body: (response) {
        return ResponseHandler()..data = response;
      },
    );
  }

  @override
  Future<ResponseHandler<AdvertsModel>> getAdverts(GenericEntity params) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.get(
          '/SMMS/api/v1.0/admin/advert-post/',
          queryParameters: params.query(
            ordering: false,
            search: false,
          ),
        );
      },
      body: (response) {
        return ResponseHandler()..data = AdvertsModel.fromJson(response);
      },
    );
  }

  @override
  Future<ResponseHandler<GenericPagination<PostEntity>>> getBanners(GenericEntity params) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.get(
          "/SMMS/api/v1.0/public/post/",
          queryParameters: params.query(
            ordering: false,
            search: false,
          ),
          options: Options(
            headers: {
              'content-Type': 'application/x-www-form-urlencoded',
            },
          ),
        );
      },
      body: (response) {
        return ResponseHandler()..setData(GenericPagination.fromJson(response, (p0) => PostModel.fromJson(jsonDecode(jsonEncode(p0)))));
      },
    );
  }

  @override
  Future<ResponseHandler<SpecialistProductModel>> getSpecialistProducts(GenericEntity<int> params) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.get(
          "/PMS/api/v1.0/public/product_org/",
          queryParameters: params.query(
            ordering: false,
            search: false,
            additional: {
              if (params.data != null) "specialist": params.data,
            },
          ),
        );
      },
      body: (response) {
        return ResponseHandler()..data = SpecialistProductModel.fromJson(response);
      },
    );
  }

  @override
  Future<ResponseHandler<PostEntity>> createPost(CreatePostParam post) async {
    return await _handle.apiCantrol(
      request: (Dio client) async {
        return await client.post(
          "/SMMS/api/v1.0/public/post/",
          data: await post.body,
        );
      },
      body: (response) {
        return ResponseHandler()..data = const PostConverter().fromJson(response);
      },
    );
  }
}

import 'package:mpd_client/domain/abstract_repo/lenta_repository.dart';
import 'package:mpd_client/domain/entity/generic_entity.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
import 'package:mpd_client/domain/entity/lenta/create_post_param.dart';
import 'package:mpd_client/domain/entity/lenta/post_entity.dart';
import 'package:mpd_client/domain/entity/lenta/send_comment_post_entity.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/domain/models/lenta/adverst_model.dart';
import 'package:mpd_client/domain/models/lenta/specialist_product_model.dart';
import 'package:mpd_client/infrastructure/apis/lenta_service.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

class LentaRepositoryImpl implements LentaRepository {
  final LentaService _remoteDataSource;

  const LentaRepositoryImpl({required LentaService remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SpecialistProductModel>> getSpecialistProducts(GenericEntity<int> params) async {
    try {
      final response = await _remoteDataSource.getSpecialistProducts(params);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(CreatePostParam post) async {
    try {
      final response = await _remoteDataSource.createPost(post);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<PostEntity>>> getBanners(GenericEntity params) async {
    try {
      final response = await _remoteDataSource.getBanners(params);

      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<CommentEntity>>> getPostComments(GenericEntity<int> params) async {
    try {
      final response = await _remoteDataSource.getPostComments(params);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentEntity>> sendPostComment(SendCommentPostEntity params) async {
    try {
      final response = await _remoteDataSource.sendPostComment(params);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendLikeOrUnlike({required int postId}) async {
    try {
      final response = await _remoteDataSource.sendLikeOrUnlike(postId: postId);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AdvertsModel>> getAdverts(GenericEntity params) async {
    try {
      final response = await _remoteDataSource.getAdverts(params);
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(response.getException()!.getErrorFailure());
      }
    } catch (e) {
      return Left(DioFailure(errorMessage: e.toString()));
    }
  }
}

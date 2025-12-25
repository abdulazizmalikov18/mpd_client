import 'package:dio/dio.dart';
import 'package:mpd_client/core/exceptions/exceptions.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/home/data/models/adverts_model.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';
import 'package:mpd_client/features/home/data/datasources/home_remote_datasource.dart';
import 'package:mpd_client/features/home/data/models/upload_post_model.dart';
import 'package:mpd_client/features/home/data/models/user_account_model.dart';
import 'package:mpd_client/features/home/domain/repositories/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, SpecialistProductModel>> getSpecialistProducts(
    ProductFilterModel model,
  ) async {
    try {
      final response = await remoteDataSource.getSpecialistProducts(model);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createPost(
    UploadPost post,
  ) async {
    try {
      final response = await remoteDataSource.createPost(post);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  // @override
  // Stream getBanners({required int limit, required int offset}) async* {
  //   yield postLocalDataSource.getLocals().last;
  //   yield await remoteDataSource.getBanners(offset: offset, limit: limit);
  // }

  @override
  Future<Either<Failure, PostsModel>> getBanners({
    int limit = 5,
    int offset = 0,
    String username = "",
  }) async {
    try {
      final response = await remoteDataSource.getBanners(
        offset: offset,
        limit: limit,
        username: username,
      );
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ComentModel>> getPostComents({
    required int limit,
    required int offset,
    required int postId,
  }) async {
    try {
      final response = await remoteDataSource.getPostComments(
        offset: offset,
        limit: limit,
        postId: postId,
      );
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Coment>> sendPostComent({
    required String text,
    required int postId,
  }) async {
    try {
      final response = await remoteDataSource.sendPostComment(
        text: text,
        postId: postId,
      );
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendLikeOrUnlike({
    required int postId,
  }) async {
    try {
      final response = await remoteDataSource.sendLikeOrUnlike(postId: postId);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AdvertsModel>> getAdverts({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await remoteDataSource.getAdverts(
        limit: limit,
        offset: offset,
      );
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost({required int postId}) async {
    try {
      final response = await remoteDataSource.deletePost(postId: postId);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserAccountModel>> getUser({
    required String username,
  }) async {
    try {
      final response = await remoteDataSource.getUser(username: username);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> reportPost({
    required int postId,
    required String reason,
  }) async {
    try {
      final response = await remoteDataSource.reportPost(
        postId: postId,
        reason: reason,
      );
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> blockUser({
    required String username,
  }) async {
    try {
      final response = await remoteDataSource.blockUser(username: username);
      return Right(response);
    } on DioException {
      return Left(const DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}

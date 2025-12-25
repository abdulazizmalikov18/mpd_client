import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/home/data/models/adverts_model.dart';
import 'package:mpd_client/features/home/data/models/coment_model.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';
import 'package:mpd_client/features/home/data/models/upload_post_model.dart';
import 'package:mpd_client/features/home/data/models/user_account_model.dart';

abstract class IHomeRepository {
  Future<Either<Failure, SpecialistProductModel>> getSpecialistProducts(
    ProductFilterModel model,
  );

  Future<Either<Failure, Map<String, dynamic>>> createPost(UploadPost post);

  Future<Either<Failure, PostsModel>> getBanners({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, AdvertsModel>> getAdverts({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, ComentModel>> getPostComents({
    required int limit,
    required int offset,
    required int postId,
  });

  Future<Either<Failure, Coment>> sendPostComent({
    required String text,
    required int postId,
  });

  Future<Either<Failure, bool>> deletePost({required int postId});
  Future<Either<Failure, UserAccountModel>> getUser({required String username});

  Future<Either<Failure, Map<String, dynamic>>> sendLikeOrUnlike({
    required int postId,
  });

  Future<Either<Failure, bool>> reportPost({
    required int postId,
    required String reason,
  });

  Future<Either<Failure, bool>> blockUser({
    required String username,
  });
}

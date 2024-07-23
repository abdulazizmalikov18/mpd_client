import 'package:mpd_client/domain/entity/generic_entity.dart';
import 'package:mpd_client/domain/entity/lenta/comment_entity.dart';
import 'package:mpd_client/domain/entity/lenta/create_post_param.dart';
import 'package:mpd_client/domain/entity/lenta/post_entity.dart';
import 'package:mpd_client/domain/entity/lenta/send_comment_post_entity.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/domain/models/lenta/adverst_model.dart';
import 'package:mpd_client/domain/models/lenta/specialist_product_model.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class LentaRepository {
 Future<Either<Failure, SpecialistProductModel>> getSpecialistProducts(GenericEntity<int> params);

  Future<Either<Failure, PostEntity>> createPost(CreatePostParam post);

  Future<Either<Failure, GenericPagination<PostEntity>>> getBanners(GenericEntity params);

  Future<Either<Failure, AdvertsModel>> getAdverts(GenericEntity params);

  Future<Either<Failure, GenericPagination<CommentEntity>>> getPostComments(GenericEntity<int> params);

  Future<Either<Failure, CommentEntity>> sendPostComment(SendCommentPostEntity params);

  Future<Either<Failure, Map<String, dynamic>>> sendLikeOrUnlike({required int postId});
}

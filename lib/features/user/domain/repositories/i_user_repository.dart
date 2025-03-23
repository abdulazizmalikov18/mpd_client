import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/pagination/models/generic_pagination.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/user/data/models/spec_add_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_cat_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_category_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_model.dart';
import 'package:mpd_client/features/user/data/models/specialist_position_model.dart';
import 'package:mpd_client/features/user/data/models/user_image_update_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_model.dart';
import 'package:mpd_client/features/user/data/models/user_info_update_model.dart';
import 'package:mpd_client/features/user/data/models/user_records_model.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserInfoModel>> getUserInfo();
  Future<Either<Failure, List<SpecialistModel>>> getSpecialist();
  Future<Either<Failure, bool>> postSpecialist(SpecAddModel model);
  Future<Either<Failure, GenericPagination<SpecialistPositionModel>>> getSpecialistPosition();
  Future<Either<Failure, GenericPagination<SpecialistCatModel>>> getSpecialistCat();
  Future<Either<Failure, GenericPagination<SpecialistCategoryModel>>> getSpecialistCategory();
  Future<Either<Failure, UserInfoUpdateModel>> updateUserInfo(UserInfoUpdateModel userInfoUpdateModel);
  Future<Either<Failure, UserImageUpdate>> updateUserImage(UserImageUpdate userImageUpdate);
  Future<Either<Failure, UserImageUpdate>> updateUserBackImage(UserImageUpdate userImageUpdate);
  Future<Either<Failure, UserSubscriptionsModel>> getUserSubscriptions({required int limit, required int offset, String? query});
  Future<Either<Failure, UserRecordModel>> getUserRecords({int? limit, int? offset, String? query});
  Future<Either<Failure, int>> isAddedSpecialist();
}

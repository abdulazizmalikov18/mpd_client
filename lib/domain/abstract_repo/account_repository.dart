import 'package:mpd_client/domain/entity/account/popular_category_filter.dart';
import 'package:mpd_client/domain/entity/account/profession_entity.dart';
import 'package:mpd_client/domain/entity/account/region_entity.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class AccountRepository {
  Future<Either<Failure, GenericPagination<RegionEntity>>> getRegion(Filter param);

  Future<Either<Failure, GenericPagination<ProfessionEntity>>> getProfession(Filter id);
}

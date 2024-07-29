import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/yandex/popular_categories_model.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/domain/models/yandex/top_specialists_model.dart';
import 'package:mpd_client/infrastructure/core/either.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';

abstract class IYandexDoctorRepository {
  Future<Either<Failure, PopularCategoriesModel>> getPopularCategories({required int limit, required int offset, String? query, String? langCode});
  Future<Either<Failure, TopSpecialistsModel>> getTopSpecialists({required int limit, required int offset, String? query, CancelToken? cancelToken});
  Future<Either<Failure, MapSpecialistModel>> getSearchedSpecialist({required String query});
  Future<Either<Failure, MapSpecialistModel>> getSpecialistByCategory({required int id});
}

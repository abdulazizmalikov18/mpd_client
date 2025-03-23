import 'package:dio/dio.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/popular_categories_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/searched_specialist_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/top_specialists_model.dart';

abstract class IYandexDoctorRepository {
  Future<Either<Failure, PopularCategoriesModel>> getPopularCategories(
      {required int limit,
      required int offset,
      String? query,
      String? langCode});
  Future<Either<Failure, TopSpecialistsModel>> getTopSpecialists(
      {required int limit,
      required int offset,
      String? query,
      CancelToken? cancelToken});

  Future<Either<Failure, MapSpecialistModel>> getSearchedSpecialist(
      {required String query});
  Future<Either<Failure, MapSpecialistModel>> getSpecialistByCategory(
      {required int id});
  Future<Either<Failure, SpecialistProductModel>> getProducts(
    ProductFilterModel model,
  );
}

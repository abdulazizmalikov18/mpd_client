import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';

abstract class IReviewFacade {
  Future<Either<ResponseFailure, ReviewSysthesisModel>> getSysthesisList(
      {required int id});

  // Future<Either<ResponseFailure, List<ReviewListModel>>> getList();

  Future<Either<ResponseFailure, ReviewFilterEither>> getListFilter(
      ReviewFilterReq model);

  Future<Either<ResponseFailure, List<ReviewFaqModel>>> getFaq(
      {required int id});

  Future<Either<ResponseFailure, ReviewDesignModel>> getDesign(
      {required int id});

  Future<Either<ResponseFailure, ReviewSafetyConvenienceModel>>
      getSafetyConvenience({required int id});

  Future<Either<ResponseFailure, ReviewSizeSpaceModel>> getSizeSpace(
      {required int id});

  Future<Either<ResponseFailure, ReviewMaintenanceModel>> getMaintenance(
      {required int id});

  Future<Either<ResponseFailure, ReviewPriceModel>> getPrice({required int id});

  Future<Either<ResponseFailure, ReviewSpecificationModel>> getSpecification(
      {required int id});

  Future<Either<ResponseFailure, ReviewLinkModel>> getLink({required int id});

  Future<Either<ResponseFailure, List<CommentsModel>>> getComments(
      {required int id});

  Future<Either<ResponseFailure, CommentModel>> postComments(
      {required CommentModel request});

  Future<Either<ResponseFailure, dynamic>> voteGeneration({required int id});

  Future<Either<ResponseFailure, ReviewIdEither>> getId(
      {required ReviewFilterReq model});
}

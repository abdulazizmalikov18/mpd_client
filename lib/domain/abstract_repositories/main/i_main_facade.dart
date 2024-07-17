import 'package:dartz/dartz.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';

abstract class IMainFacade {
  Future<Either<ResponseFailure, CurrencyModel>> getCurrency();

  Future<Either<ResponseFailure, List<BranchModel>>> getBranchList(
      {required int id});

  Future<Either<ResponseFailure, BranchComplaintModel>> postBranchComplaint(
      {required BranchComplaintModel request});

  Future<Either<ResponseFailure, List<NewsModel>>> getNewsList(
      {required String type});

  Future<Either<ResponseFailure, List<NotificationModel>>>
      getNotificationsList();

  Future<Either<ResponseFailure, UnreadModel>> getNotificationsUnread();

  Future<Either<ResponseFailure, SuccessModel>> patchNotificationsUnread();

  Future<Either<ResponseFailure, SuccessModel>> patchNotificationsActions(
      {required int id});
}

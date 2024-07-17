// ignore_for_file: unused_field

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orient_motors/domain/abstract_repositories/main/i_main_facade.dart';
import 'package:orient_motors/domain/common/failure.dart';
import 'package:orient_motors/domain/common/token_ext.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';
import 'package:orient_motors/infrastructure/core/exceptions.dart';
import 'package:orient_motors/infrastructure/services/log_service.dart';

import '../apis/apis.dart';
import '../services/local_database/db_service.dart';

class MainRepository implements IMainFacade {
  final DBService _dbService;
  final MainService _service;

  MainRepository(
    this._dbService,
    this._service,
  );

  @override
  Future<Either<ResponseFailure, CurrencyModel>> getCurrency() async {
    try {
      final res = await _service.getCurrency();
      if (res.isSuccessful) {
        _dbService.setCurrencyAmount(res.body!);
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, List<BranchModel>>> getBranchList(
      {required int id}) async {
    try {
      final res = await _service.getBranchList(id: id);
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, BranchComplaintModel>> postBranchComplaint(
      {required BranchComplaintModel request}) async {
    try {
      final res = await _service.postBranchComplaint(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, List<NewsModel>>> getNewsList(
      {required String type}) async {
    try {
      final res = await _service.getNewsList(type: type);
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, List<NotificationModel>>>
      getNotificationsList() async {
    try {
      if (_dbService.token.accessToken == null) {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
      final String token = _dbService.token.toToken;
      final res = await _service.getNotificationsList(token: "Bearer $token");

      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, UnreadModel>> getNotificationsUnread() async {
    try {
      if (_dbService.token.accessToken == null) {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
      final String token = _dbService.token.toToken;
      final res = await _service.getNotificationsUnread(token: "Bearer $token");

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>> patchNotificationsActions(
      {required int id}) async {
    try {
      if (_dbService.token.accessToken == null) {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
      final String token = _dbService.token.toToken;
      final res = await _service.patchNotificationsActions(
          token: "Bearer $token", id: id);

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>>
      patchNotificationsUnread() async {
    try {
      if (_dbService.token.accessToken == null) {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
      final String token = _dbService.token.toToken;
      final res =
          await _service.patchNotificationsUnread(token: "Bearer $token");

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      if (e is NetworkException) {
        return left(NetworkFailure(message: 'network_error'.tr()));
      } else if (e is UnimplementedError) {
        return left(Unknown(message: e.message ?? 'unknown_error'.tr()));
      } else {
        return left(Unknown(message: 'unknown_error'.tr()));
      }
    }
  }
}

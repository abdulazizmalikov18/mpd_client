import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_local_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_remote_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/cart_remote_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/domain/models/doctor_booking/timetable_by_day.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/services/error_handle.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

abstract class IDoctorProfileRemoteDataSource {
  Future<DoctorProfileModel> getDoctorInfo(String username);

  Future<Subscription> subscribeToDoctor(String username);

  Future<TimetableByDateModel> getTimetable({required String date, required int id});

  Future<List<CartRemoteModel>> addToCart(List<Map<String, dynamic>> carts);

  Future<CardRemoteModel> insertCard(CardLocalModel card);

  Future<CardRemoteModel> verifyCard({required int code, required int cardId});

  Future<Map<String, dynamic>> resendVerifyCode({required int cardId});

  Future<List<CardRemoteModel>> getMyCards();

  Future<Map<String, dynamic>> deleteSubscription(String username);

  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> carts,
    int? payment,
    required String action,
  });
}

class DoctorProfileRemoteDataSource implements IDoctorProfileRemoteDataSource {
  final ErrorHandle _handle = ErrorHandle();

  DoctorProfileRemoteDataSource();

  @override
  Future<DoctorProfileModel> getDoctorInfo(String username) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "/BMS/api/v1.0/public/cluster/mpd/specialist/$username/",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return DoctorProfileModel.fromMap(response);
      },
    );
  }

  @override
  Future<TimetableByDateModel> getTimetable({required String date, required int id}) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "/BMS/api/v1.0/public/org/mpd/specialist/$id/timetable/$date/",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return TimetableByDateModel.fromJson(response);
      },
    );
  }

  @override
  Future<Subscription> subscribeToDoctor(String username) async {
    final data = FormData.fromMap({"to_user": username});
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.post(
          "/SMMS/api/v1.0/public/subscriptions/",
          data: data,
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return Subscription.fromJson(response);
      },
    );
  }

  @override
  Future<List<CartRemoteModel>> addToCart(List<Map<String, dynamic>> carts) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.post(
          "/OMS/api/v1.0/public/carts/",
          data: jsonEncode(carts),
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return (response as List).map((e) => CartRemoteModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<CardRemoteModel> insertCard(CardLocalModel card) async {
    final data = FormData.fromMap(card.toJson());
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.post(
          "http://192.168.1.53:4000/PMM/api/v1.0/public/paycom-subscriptions/",
          data: data,
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return CardRemoteModel.fromJson(response);
      },
    );
  }

  @override
  Future<CardRemoteModel> verifyCard({required int code, required int cardId}) async {
    final data = FormData.fromMap({"code": code});
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.patch(
          "http://192.168.1.53:4000/PMM/api/v1.0/public/paycom-subscriptions/$cardId/verify/",
          data: data,
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return CardRemoteModel.fromJson(response);
      },
    );
  }

  @override
  Future<Map<String, dynamic>> resendVerifyCode({required int cardId}) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "http://192.168.1.53:4000/PMM/api/v1.0/public/paycom-subscriptions/$cardId/resend_verify_code/",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return response;
      },
    );
  }

  @override
  Future<List<CardRemoteModel>> getMyCards() async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.get(
          "http://192.168.1.53:4000/PMM/api/v1.0/public/paycom-subscriptions/",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return (response['results'] as List).map((e) => CardRemoteModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Map<String, dynamic>> deleteSubscription(String username) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.delete(
          "/SMMS/api/v1.0/public/subscriptions/$username/",
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return {'message': true};
      },
    );
  }

  @override
  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> carts,
    int? payment,
    required String action,
  }) async {
    return _handle.apiCantrol(
      request: (Dio client) {
        return client.post(
          "/OMS/api/v1.0/public/order/create/",
          data: {"cart_products": carts, "payment": payment, "action": action},
          options: Options(headers: {if (StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty) 'Authorization': 'Bearer ${StorageRepository.getString(StorageKeys.TOKEN)}'}),
        );
      },
      body: (response) {
        return response;
      },
    );
  }
}

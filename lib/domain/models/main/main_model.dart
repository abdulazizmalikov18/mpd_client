import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:orient_motors/domain/serializers/serializer.dart';

part 'main_model.g.dart';

abstract class CurrencyModel
    implements Built<CurrencyModel, CurrencyModelBuilder> {
  CurrencyModel._();

  factory CurrencyModel([Function(CurrencyModelBuilder b) updates]) =
      _$CurrencyModel;

  @BuiltValueField(wireName: 'amount')
  double? get amount;

  String toJson() {
    return json
        .encode(serializers.serializeWith(CurrencyModel.serializer, this));
  }

  static CurrencyModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        CurrencyModel.serializer, json.decode(jsonString));
  }

  static Serializer<CurrencyModel> get serializer => _$currencyModelSerializer;
}

abstract class BranchModel implements Built<BranchModel, BranchModelBuilder> {
  BranchModel._();

  factory BranchModel([Function(BranchModelBuilder b) updates]) = _$BranchModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'photos')
  BuiltList<String>? get photos;
  @BuiltValueField(wireName: 'address')
  String? get address;
  @BuiltValueField(wireName: 'contact')
  String? get contact;
  @BuiltValueField(wireName: 'working_time')
  String? get workingTime;
  @BuiltValueField(wireName: 'lat')
  double? get lat;
  @BuiltValueField(wireName: 'long')
  double? get long;

  static Serializer<BranchModel> get serializer => _$branchModelSerializer;
}

abstract class BranchComplaintModel
    implements Built<BranchComplaintModel, BranchComplaintModelBuilder> {
  BranchComplaintModel._();

  factory BranchComplaintModel(
          [Function(BranchComplaintModelBuilder b) updates]) =
      _$BranchComplaintModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'region')
  int? get region;
  @BuiltValueField(wireName: 'text')
  String? get text;

  static Serializer<BranchComplaintModel> get serializer =>
      _$branchComplaintModelSerializer;
}

abstract class NewsModel implements Built<NewsModel, NewsModelBuilder> {
  NewsModel._();

  factory NewsModel([Function(NewsModelBuilder b) updates]) = _$NewsModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'famous')
  bool? get famous;
  @BuiltValueField(wireName: 'photos')
  BuiltList<String>? get photos;

  static Serializer<NewsModel> get serializer => _$newsModelSerializer;
}

abstract class NotificationModel
    implements Built<NotificationModel, NotificationModelBuilder> {
  NotificationModel._();

  factory NotificationModel([Function(NotificationModelBuilder b) updates]) =
      _$NotificationModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'type')
  String? get type;
  @BuiltValueField(wireName: 'photo')
  String? get photo;
  @BuiltValueField(wireName: 'read')
  bool? get read;

  static Serializer<NotificationModel> get serializer =>
      _$notificationModelSerializer;
}

abstract class UnreadModel implements Built<UnreadModel, UnreadModelBuilder> {
  UnreadModel._();

  factory UnreadModel([Function(UnreadModelBuilder b) updates]) = _$UnreadModel;

  @BuiltValueField(wireName: 'count')
  int? get count;

  static Serializer<UnreadModel> get serializer => _$unreadModelSerializer;
}

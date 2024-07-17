import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:orient_motors/domain/serializers/serializer.dart';

part 'specifications.g.dart';

abstract class TransmissionModel
    implements Built<TransmissionModel, TransmissionModelBuilder> {
  TransmissionModel._();

  factory TransmissionModel([Function(TransmissionModelBuilder b) updates]) =
      _$TransmissionModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'translations')
  TranslationsModel? get translations;

  @BuiltValueField(wireName: 'icon')
  String? get icon;

  static Serializer<TransmissionModel> get serializer =>
      _$transmissionModelSerializer;
}

abstract class TranslationsModel
    implements Built<TranslationsModel, TranslationsModelBuilder> {
  TranslationsModel._();

  factory TranslationsModel([Function(TranslationsModelBuilder b) updates]) =
      _$TranslationsModel;

  @BuiltValueField(wireName: 'ru')
  RuModel? get ru;

  @BuiltValueField(wireName: 'uz')
  UzModel? get uz;

  static Serializer<TranslationsModel> get serializer =>
      _$translationsModelSerializer;
}

abstract class UzModel implements Built<UzModel, UzModelBuilder> {
  UzModel._();

  factory UzModel([Function(UzModelBuilder b) updates]) = _$UzModel;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'id')
  int? get id;

  static Serializer<UzModel> get serializer => _$uzModelSerializer;
}

abstract class RuModel implements Built<RuModel, RuModelBuilder> {
  RuModel._();

  factory RuModel([Function(RuModelBuilder b) updates]) = _$RuModel;

  @BuiltValueField(wireName: 'name')
  String? get name;

  static Serializer<RuModel> get serializer => _$ruModelSerializer;
}

abstract class DriveUnitModel
    implements Built<DriveUnitModel, DriveUnitModelBuilder> {
  DriveUnitModel._();

  factory DriveUnitModel([Function(DriveUnitModelBuilder b) updates]) =
      _$DriveUnitModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'value')
  bool? get value;

  @BuiltValueField(wireName: 'icon')
  String? get icon;

  @BuiltValueField(wireName: 'image')
  String? get image;

  @BuiltValueField(wireName: 'description')
  String? get description;

  static Serializer<DriveUnitModel> get serializer =>
      _$driveUnitModelSerializer;
}

abstract class OptionsRes implements Built<OptionsRes, OptionsResBuilder> {
  OptionsRes._();

  factory OptionsRes([Function(OptionsResBuilder b) updates]) = _$OptionsRes;

  @BuiltValueField(wireName: 'external_body_kit')
  BuiltList<DriveUnitModel>? get externalBodyKit;

  @BuiltValueField(wireName: 'salon')
  BuiltList<DriveUnitModel>? get salon;

  @BuiltValueField(wireName: 'optics')
  BuiltList<DriveUnitModel>? get optics;

  @BuiltValueField(wireName: 'vehicle_options')
  BuiltList<DriveUnitModel>? get vehicleOptions;

  @BuiltValueField(wireName: 'media_tools')
  BuiltList<DriveUnitModel>? get mediaTools;

  String toJson() {
    return json.encode(serializers.serializeWith(OptionsRes.serializer, this));
  }

  static OptionsRes? fromJson(String jsonString) {
    return serializers.deserializeWith(
        OptionsRes.serializer, json.decode(jsonString));
  }

  static Serializer<OptionsRes> get serializer => _$optionsResSerializer;
}

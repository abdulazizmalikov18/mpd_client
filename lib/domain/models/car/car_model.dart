library add_brand_req;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/domain/serializers/serializer.dart';

part 'car_model.g.dart';

abstract class BrandReq implements Built<BrandReq, BrandReqBuilder> {
  BrandReq._();

  factory BrandReq([Function(BrandReqBuilder b) updates]) = _$BrandReq;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'icon')
  String? get icon;

  static Serializer<BrandReq> get serializer => _$brandReqSerializer;
}

//

abstract class BrandResResult
    implements Built<BrandResResult, BrandResResultBuilder> {
  BrandResResult._();

  factory BrandResResult([Function(BrandResResultBuilder b) updates]) =
      _$BrandResResult;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'next')
  String? get next;

  @BuiltValueField(wireName: 'previous')
  String? get previous;

  @BuiltValueField(wireName: 'results')
  BuiltList<Brands>? get results;

  static Serializer<BrandResResult> get serializer =>
      _$brandResResultSerializer;
}

abstract class GenerationsConfigurationsRes
    implements
        Built<GenerationsConfigurationsRes,
            GenerationsConfigurationsResBuilder> {
  GenerationsConfigurationsRes._();

  factory GenerationsConfigurationsRes(
          [Function(GenerationsConfigurationsResBuilder b) updates]) =
      _$GenerationsConfigurationsRes;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'api_configuration_id')
  String? get apiConfigurationId;

  @BuiltValueField(wireName: 'doors_count')
  int? get doorsCount;

  @BuiltValueField(wireName: 'body_type')
  String? get bodyType;

  @BuiltValueField(wireName: 'notice')
  String? get notice;

  @BuiltValueField(wireName: 'modification')
  BuiltList<ModificationModel>? get modification;

  static Serializer<GenerationsConfigurationsRes> get serializer =>
      _$generationsConfigurationsResSerializer;
}

abstract class ModificationModel
    implements Built<ModificationModel, ModificationModelBuilder> {
  ModificationModel._();

  factory ModificationModel([Function(ModificationModelBuilder b) updates]) =
      _$ModificationModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'api_modification_id')
  String? get apiModificationId;

  @BuiltValueField(wireName: 'configuration')
  int? get configuration;

  @BuiltValueField(wireName: 'offers_price_from')
  double? get offersPriceFrom;

  @BuiltValueField(wireName: 'offers_price_to')
  double? get offersPriceTo;

  @BuiltValueField(wireName: 'group_name')
  String? get groupName;

  @BuiltValueField(wireName: 'options')
  BuiltList<OptionsModelCarDetail> get optionsModelCarDetail;

  @BuiltValueField(wireName: 'specifications')
  BuiltList<SpecificationsModel>? get specifications;

  static Serializer<ModificationModel> get serializer =>
      _$modificationModelSerializer;
}

abstract class SpecificationsModel
    implements Built<SpecificationsModel, SpecificationsModelBuilder> {
  SpecificationsModel._();

  factory SpecificationsModel(
      [Function(SpecificationsModelBuilder b) updates]) = _$SpecificationsModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'horse_power')
  double? get horsePower;

  @BuiltValueField(wireName: 'engine_type')
  String? get engineType;

  @BuiltValueField(wireName: 'transmission')
  String? get transmission;

  @BuiltValueField(wireName: 'drive')
  String? get drive;

  @BuiltValueField(wireName: 'volume')
  double? get volume;

  @BuiltValueField(wireName: 'time_to_100')
  double? get timeTo100;

  @BuiltValueField(wireName: 'max_speed')
  double? get maxSpeed;

  @BuiltValueField(wireName: 'diameter')
  double? get diameter;

  @BuiltValueField(wireName: 'petrol_type')
  String? get petrolType;

  @BuiltValueField(wireName: 'weight')
  double? get weight;

  @BuiltValueField(wireName: 'height')
  double? get height;

  @BuiltValueField(wireName: 'width')
  double? get width;

  @BuiltValueField(wireName: 'length')
  double? get length;

  @BuiltValueField(wireName: 'fuel_tank_capacity')
  double? get fuelTankCapacity;

  @BuiltValueField(wireName: 'volume_litres')
  double? get volumeLitres;

  @BuiltValueField(wireName: 'safety_rating')
  double? get safetyRating;

  @BuiltValueField(wireName: 'safety_grade')
  double? get safetyGrade;

  @BuiltValueField(wireName: 'modification')
  double? get modification;

  static Serializer<SpecificationsModel> get serializer =>
      _$specificationsModelSerializer;
}

////////////////////////////////////////

/// create car

abstract class CreateCarReq
    implements Built<CreateCarReq, CreateCarReqBuilder> {
  CreateCarReq._();

  factory CreateCarReq([Function(CreateCarReqBuilder b) updates]) =
      _$CreateCarReq;

  @BuiltValueField(wireName: 'brand')
  int? get brand;

  @BuiltValueField(wireName: 'car_model')
  int? get carModel;

  @BuiltValueField(wireName: 'generation')
  int? get generation;

  @BuiltValueField(wireName: 'configuration')
  int? get configuration;

  @BuiltValueField(wireName: 'body_type')
  int? get bodyType;

  @BuiltValueField(wireName: 'fuel_type')
  int? get fuelType;

  @BuiltValueField(wireName: 'region')
  int? get region;

  @BuiltValueField(wireName: 'transmission')
  int? get transmission;

  @BuiltValueField(wireName: 'number_of_owners')
  String? get numberOfOwners;

  @BuiltValueField(wireName: 'color')
  int? get color;

  @BuiltValueField(wireName: 'year')
  int? get year;

  @BuiltValueField(wireName: 'mileage')
  double? get mileage;

  @BuiltValueField(wireName: 'price')
  double? get price;

  @BuiltValueField(wireName: 'currency')
  String? get currency;

  @BuiltValueField(wireName: 'engine_size')
  String? get engineSize;

  @BuiltValueField(wireName: 'horsepower')
  String? get horsepower;

  @BuiltValueField(wireName: 'used_car')
  bool? get usedCar;

  @BuiltValueField(wireName: 'description')
  String? get description;

  @BuiltValueField(wireName: 'paint_condition')
  int? get paintCondition;

  @BuiltValueField(wireName: 'photos')
  BuiltList<ImagesModel>? get photos;

  @BuiltValueField(wireName: 'changed_part')
  BuiltList<ChangedPartReq>? get changedPart;

  @BuiltValueField(wireName: 'external_body_kit')
  BuiltList<int>? get externalBodyKit;

  @BuiltValueField(wireName: 'salon')
  BuiltList<int>? get salon;

  @BuiltValueField(wireName: 'additional_phones')
  BuiltList<AdditionalPhones>? get additionalPhones;

  @BuiltValueField(wireName: 'time24')
  bool? get time24;

  @BuiltValueField(wireName: 'time_from')
  String? get timeFrom;

  @BuiltValueField(wireName: 'time_to')
  String? get timeTo;

  @BuiltValueField(wireName: 'media_tools')
  BuiltList<int>? get mediaTools;

  @BuiltValueField(wireName: 'modification')
  int? get modification;

  @BuiltValueField(wireName: 'optics')
  BuiltList<int>? get optics;

  @BuiltValueField(wireName: 'barter')
  bool? get barter;

  @BuiltValueField(wireName: 'is_cheaper')
  bool? get isCheaper;

  String toJson() {
    return json
        .encode(serializers.serializeWith(CreateCarReq.serializer, this));
  }

  static Serializer<CreateCarReq> get serializer => _$createCarReqSerializer;
}

abstract class CreateCarRes
    implements Built<CreateCarRes, CreateCarResBuilder> {
  CreateCarRes._();

  factory CreateCarRes([Function(CreateCarResBuilder b) updates]) =
      _$CreateCarRes;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'number_of_owners')
  int? get numberOfOwners;

  @BuiltValueField(wireName: 'year')
  int? get year;

  @BuiltValueField(wireName: 'mileage')
  int? get mileage;

  @BuiltValueField(wireName: 'price')
  int? get price;

  @BuiltValueField(wireName: 'currency')
  String? get currency;

  @BuiltValueField(wireName: 'engine_size')
  int? get engineSize;

  @BuiltValueField(wireName: 'horsepower')
  int? get horsepower;

  @BuiltValueField(wireName: 'rated')
  int? get rated;

  @BuiltValueField(wireName: 'active')
  bool? get active;

  @BuiltValueField(wireName: 'used_car')
  bool? get usedCar;

  @BuiltValueField(wireName: 'avtoritet_diagnostics')
  bool? get avtoritetDiagnostics;

  @BuiltValueField(wireName: 'orient_motors_warranty')
  bool? get orientMotorsWarranty;

  @BuiltValueField(wireName: 'owned_by_orient_motors')
  bool? get ownedByOrientMotors;

  @BuiltValueField(wireName: 'avtoritet_premium_diagnostics')
  bool? get avtoritetPremiumDiagnostics;

  @BuiltValueField(wireName: 'description')
  String? get description;

  @BuiltValueField(wireName: 'time24')
  bool? get time24;

  @BuiltValueField(wireName: 'time_from')
  String? get timeFrom;

  @BuiltValueField(wireName: 'time_to')
  String? get timeTo;

  @BuiltValueField(wireName: 'posted_at')
  String? get postedAt;

  @BuiltValueField(wireName: 'brand')
  int? get brand;

  @BuiltValueField(wireName: 'car_model')
  int? get carModel;

  @BuiltValueField(wireName: 'generation')
  int? get generation;

  @BuiltValueField(wireName: 'modification')
  int? get modification;

  @BuiltValueField(wireName: 'owner')
  int? get owner;

  @BuiltValueField(wireName: 'body_type')
  int? get bodyType;

  @BuiltValueField(wireName: 'fuel_type')
  int? get fuelType;

  @BuiltValueField(wireName: 'region')
  int? get region;

  @BuiltValueField(wireName: 'transmission')
  int? get transmission;

  @BuiltValueField(wireName: 'color')
  int? get color;

  @BuiltValueField(wireName: 'drive_unit')
  int? get driveUnit;

  @BuiltValueField(wireName: 'paint_condition')
  int? get paintCondition;

  @BuiltValueField(wireName: 'liked_by')
  BuiltList<int>? get likedBy;

  @BuiltValueField(wireName: 'media_tools')
  BuiltList<int>? get mediaTools;

  @BuiltValueField(wireName: 'optics')
  BuiltList<int>? get optics;

  @BuiltValueField(wireName: 'external_body_kit')
  BuiltList<int>? get externalBodyKit;

  @BuiltValueField(wireName: 'salon')
  BuiltList<int>? get salon;

  @BuiltValueField(wireName: 'vehicle_options')
  BuiltList<int>? get vehicleOptions;

  @BuiltValueField(wireName: 'changed_part')
  BuiltList<int>? get changedPart;

  static Serializer<CreateCarRes> get serializer => _$createCarResSerializer;
}

////////////////////////////////////////////////////////////////////
///car detail model

abstract class CarModel implements Built<CarModel, CarModelBuilder> {
  CarModel._();

  factory CarModel([Function(CarModelBuilder b) updates]) = _$CarModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'additional_phones')
  BuiltList<AdditionalPhones>? get additionalPhones;

  @BuiltValueField(wireName: 'brand')
  Brands? get brand;

  @BuiltValueField(wireName: 'car_model')
  CarModel? get carModel;

  @BuiltValueField(wireName: 'generation')
  GenerationModel? get generation;

  @BuiltValueField(wireName: 'modification')
  ModificationModel? get modification;

  @BuiltValueField(wireName: 'owner')
  Owner? get owner;

  @BuiltValueField(wireName: 'body_type')
  NamedModel? get bodyType;

  @BuiltValueField(wireName: 'fuel_type')
  NamedModel? get fuelType;

  @BuiltValueField(wireName: 'region')
  NamedModel? get region;

  @BuiltValueField(wireName: 'transmission')
  NamedModel? get transmission;

  @BuiltValueField(wireName: 'color')
  NamedModel? get color;

  @BuiltValueField(wireName: 'drive_unit')
  NamedModel? get driveUnit;

  @BuiltValueField(wireName: 'number_of_owners')
  int? get numberOfOwners;

  @BuiltValueField(wireName: 'year')
  int? get year;

  @BuiltValueField(wireName: 'mileage')
  double? get mileage;

  @BuiltValueField(wireName: 'price')
  double? get price;

  @BuiltValueField(wireName: 'currency')
  String? get currency;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  @BuiltValueField(wireName: 'engine_size')
  double? get engineSize;

  @BuiltValueField(wireName: 'horsepower')
  double? get horsepower;

  @BuiltValueField(wireName: 'rated')
  double? get rated;

  @BuiltValueField(wireName: 'active')
  bool? get active;

  @BuiltValueField(wireName: 'used_car')
  bool? get usedCar;

  @BuiltValueField(wireName: 'avtoritet_diagnostics')
  bool? get avtoritetDiagnostics;

  @BuiltValueField(wireName: 'orient_motors_warranty')
  bool? get orientMotorsWarranty;

  @BuiltValueField(wireName: 'posted_at')
  String? get postedAt;

  @BuiltValueField(wireName: 'owned_by_orient_motors')
  bool? get ownedByOrientMotors;

  @BuiltValueField(wireName: 'avtoritet_premium_diagnostics')
  bool? get avtoritetPremiumDiagnostics;

  @BuiltValueField(wireName: 'description')
  String? get description;

  @BuiltValueField(wireName: 'liked_by')
  bool? get likedBy;

  @BuiltValueField(wireName: 'photos')
  BuiltList<ImagesModel>? get photos;

  @BuiltValueField(wireName: 'paint_condition')
  PaintCondition? get paintCondition;

  @BuiltValueField(wireName: 'media_tools')
  BuiltList<DriveUnitModel>? get mediaTools;

  @BuiltValueField(wireName: 'optics')
  BuiltList<DriveUnitModel>? get optics;

  @BuiltValueField(wireName: 'external_body_kit')
  BuiltList<DriveUnitModel>? get externalBodyKit;

  @BuiltValueField(wireName: 'salon')
  BuiltList<DriveUnitModel>? get salon;

  @BuiltValueField(wireName: 'vehicle_options')
  BuiltList<DriveUnitModel>? get vehicleOptions;

  @BuiltValueField(wireName: 'time24')
  bool? get time24;

  @BuiltValueField(wireName: 'time_from')
  String? get timeFrom;

  @BuiltValueField(wireName: 'time_to')
  String? get timeTo;

  @BuiltValueField(wireName: 'barter')
  bool? get barter;

  @BuiltValueField(wireName: 'is_cheaper')
  bool? get isCheaper;

  @BuiltValueField(wireName: 'changed_part')
  BuiltList<ChangedPart>? get changedPart;

  @BuiltValueField(wireName: 'total_likes')
  int? get totalLikes;

  @BuiltValueField(wireName: 'total_views')
  int? get totalViews;

  String toJson() {
    return json.encode(serializers.serializeWith(CarModel.serializer, this));
  }

  static CarModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        CarModel.serializer, json.decode(jsonString));
  }

  static Serializer<CarModel> get serializer => _$carModelSerializer;
}

abstract class Owner implements Built<Owner, OwnerBuilder> {
  Owner._();

  factory Owner([Function(OwnerBuilder b) updates]) = _$Owner;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'username')
  String? get username;

  @BuiltValueField(wireName: 'full_name')
  String? get fullName;

  @BuiltValueField(wireName: 'profile_pic')
  String? get profilePic;

  static Serializer<Owner> get serializer => _$ownerSerializer;
}

abstract class AdditionalPhones
    implements Built<AdditionalPhones, AdditionalPhonesBuilder> {
  AdditionalPhones._();

  factory AdditionalPhones([Function(AdditionalPhonesBuilder b) updates]) =
      _$AdditionalPhones;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'number')
  String? get number;

  @BuiltValueField(wireName: 'car')
  int? get car;

  static Serializer<AdditionalPhones> get serializer =>
      _$additionalPhonesSerializer;
}

abstract class OptionsModelCarDetail
    implements Built<OptionsModelCarDetail, OptionsModelCarDetailBuilder> {
  OptionsModelCarDetail._();

  factory OptionsModelCarDetail(
          [Function(OptionsModelCarDetailBuilder b) updates]) =
      _$OptionsModelCarDetail;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'electro_mirrors')
  bool? get electroMirrors;

  @BuiltValueField(wireName: 'airbag_side')
  bool? get airbagSide;

  @BuiltValueField(wireName: 'hatch')
  bool? get hatch;

  @BuiltValueField(wireName: 'led_light')
  bool? get ledLight;

  @BuiltValueField(wireName: 'rain_sensor')
  bool? get rainSensor;

  @BuiltValueField(wireName: 'aux')
  bool? get aux;

  @BuiltValueField(wireName: 'modification')
  int? get modification;

  static Serializer<OptionsModelCarDetail> get serializer =>
      _$optionsModelCarDetailSerializer;
}

abstract class PaintCondition
    implements Built<PaintCondition, PaintConditionBuilder> {
  PaintCondition._();

  factory PaintCondition([Function(PaintConditionBuilder b) updates]) =
      _$PaintCondition;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  static Serializer<PaintCondition> get serializer =>
      _$paintConditionSerializer;
}

abstract class ChangedPart implements Built<ChangedPart, ChangedPartBuilder> {
  ChangedPart._();

  factory ChangedPart([Function(ChangedPartBuilder b) updates]) = _$ChangedPart;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'description')
  String? get description;

  @BuiltValueField(wireName: 'changed_part')
  NamedModel? get changedPart;

  @BuiltValueField(wireName: 'changed_part_quality')
  NamedModel? get changedPartQuality;

  static Serializer<ChangedPart> get serializer => _$changedPartSerializer;
}

abstract class ChangedPartReq
    implements Built<ChangedPartReq, ChangedPartReqBuilder> {
  ChangedPartReq._();

  factory ChangedPartReq([Function(ChangedPartReqBuilder b) updates]) =
      _$ChangedPartReq;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'part_id')
  int? get partId;

  @BuiltValueField(wireName: 'quality_id')
  int? get qualityId;

  @BuiltValueField(wireName: 'description')
  String? get description;

  static Serializer<ChangedPartReq> get serializer =>
      _$changedPartReqSerializer;
}

abstract class CarResResult
    implements Built<CarResResult, CarResResultBuilder> {
  CarResResult._();

  factory CarResResult([Function(CarResResultBuilder b) updates]) =
      _$CarResResult;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'next')
  String? get next;

  @BuiltValueField(wireName: 'previous')
  String? get previous;

  @BuiltValueField(wireName: 'results')
  BuiltList<CarModel>? get results;

  static Serializer<CarResResult> get serializer => _$carResResultSerializer;
}

abstract class QuestionModel
    implements Built<QuestionModel, QuestionModelBuilder> {
  QuestionModel._();

  factory QuestionModel([Function(QuestionModelBuilder b) updates]) =
      _$QuestionModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'question')
  String? get question;

  static Serializer<QuestionModel> get serializer => _$questionModelSerializer;
}

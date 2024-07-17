import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/services/services_model.dart';
import 'package:orient_motors/domain/serializers/serializer.dart';

part 'filter.g.dart';

abstract class FilterRes implements Built<FilterRes, FilterResBuilder> {
  FilterRes._();

  factory FilterRes([Function(FilterResBuilder b) updates]) = _$FilterRes;

  @BuiltValueField(wireName: 'cars')
  Cars? get cars;

  @BuiltValueField(wireName: 'regions')
  BuiltList<NamedModel>? get regions;

  @BuiltValueField(wireName: 'brands')
  BuiltList<Brands>? get brands;

  @BuiltValueField(wireName: 'fuel_types')
  BuiltList<NamedModel>? get fuelTypes;

  @BuiltValueField(wireName: 'colors')
  BuiltList<NamedModel>? get colors;

  @BuiltValueField(wireName: 'transmissions')
  BuiltList<NamedModel>? get transmissions;

  @BuiltValueField(wireName: 'body_types')
  BuiltList<NamedModel>? get bodyTypes;

  @BuiltValueField(wireName: 'services')
  BuiltList<ServicesRes>? get services;

  @BuiltValueField(wireName: 'condition')
  BuiltList<Condition>? get condition;

  static Serializer<FilterRes> get serializer => _$filterResSerializer;
}

abstract class Cars implements Built<Cars, CarsBuilder> {
  Cars._();

  factory Cars([Function(CarsBuilder b) updates]) = _$Cars;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'next')
  String? get next;

  @BuiltValueField(wireName: 'previous')
  String? get previous;

  @BuiltValueField(wireName: 'total_page_count')
  int? get totalPageCount;

  @BuiltValueField(wireName: 'results')
  BuiltList<CarModel>? get results;

  static Serializer<Cars> get serializer => _$carsSerializer;
}

//
abstract class NamedModel implements Built<NamedModel, NamedModelBuilder> {
  NamedModel._();

  factory NamedModel([Function(NamedModelBuilder b) updates]) = _$NamedModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  @BuiltValueField(wireName: 'code')
  String? get code;

  String toJson() {
    return json.encode(serializers.serializeWith(NamedModel.serializer, this));
  }

  static NamedModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        NamedModel.serializer, json.decode(jsonString));
  }

  static Serializer<NamedModel> get serializer => _$namedModelSerializer;
}

//
abstract class Brands implements Built<Brands, BrandsBuilder> {
  Brands._();

  factory Brands([Function(BrandsBuilder b) updates]) = _$Brands;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'car_models')
  BuiltList<CarModels>? get carModels;

  @BuiltValueField(wireName: 'icon')
  String? get icon;

  @BuiltValueField(wireName: 'top')
  bool? get top;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  static Serializer<Brands> get serializer => _$brandsSerializer;
}

//
abstract class Condition implements Built<Condition, ConditionBuilder> {
  Condition._();

  factory Condition([Function(ConditionBuilder b) updates]) = _$Condition;

  @BuiltValueField(wireName: 'is_used')
  bool? get isUsed;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  static Serializer<Condition> get serializer => _$conditionSerializer;
}
// inner models

abstract class CarModels implements Built<CarModels, CarModelsBuilder> {
  CarModels._();

  factory CarModels([Function(CarModelsBuilder b) updates]) = _$CarModels;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'top')
  bool? get top;

  @BuiltValueField(wireName: 'generations')
  BuiltList<NamedModel>? get generations;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  static Serializer<CarModels> get serializer => _$carModelsSerializer;
}

abstract class GenerationModel
    implements Built<GenerationModel, GenerationModelBuilder> {
  GenerationModel._();

  factory GenerationModel([Function(GenerationModelBuilder b) updates]) =
      _$GenerationModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'name')
  String? get name;

  @BuiltValueField(wireName: 'year_start')
  int? get yearStart;

  @BuiltValueField(wireName: 'year_stop')
  int? get yearStop;

  @BuiltValueField(wireName: 'isrestyle')
  bool? get isrestyle;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  @BuiltValueField(wireName: 'api_generation_id')
  String? get apiGenerationId;

  @BuiltValueField(wireName: 'car_model')
  int? get carModel;

  static Serializer<GenerationModel> get serializer =>
      _$generationModelSerializer;
}

abstract class ImagesModel implements Built<ImagesModel, ImagesModelBuilder> {
  ImagesModel._();

  factory ImagesModel([Function(ImagesModelBuilder b) updates]) = _$ImagesModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'url')
  String? get url;

  @BuiltValueField(wireName: 'type')
  String? get type;

  @BuiltValueField(wireName: 'car')
  int? get car;

  static Serializer<ImagesModel> get serializer => _$imagesModelSerializer;
}
//

abstract class TotalCarsRes
    implements Built<TotalCarsRes, TotalCarsResBuilder> {
  TotalCarsRes._();

  factory TotalCarsRes([Function(TotalCarsResBuilder b) updates]) =
      _$TotalCarsRes;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  @BuiltValueField(wireName: 'count_in_24')
  int? get countIn24;

  static Serializer<TotalCarsRes> get serializer => _$totalCarsResSerializer;
}

abstract class OwnerModel implements Built<OwnerModel, OwnerModelBuilder> {
  OwnerModel._();

  factory OwnerModel([Function(OwnerModelBuilder b) updates]) = _$OwnerModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'password')
  String? get password;

  @BuiltValueField(wireName: 'last_login')
  String? get lastLogin;

  @BuiltValueField(wireName: 'is_superuser')
  bool? get isSuperuser;

  @BuiltValueField(wireName: 'username')
  String? get username;

  @BuiltValueField(wireName: 'first_name')
  String? get firstName;

  @BuiltValueField(wireName: 'last_name')
  String? get lastName;

  @BuiltValueField(wireName: 'email')
  String? get email;

  @BuiltValueField(wireName: 'is_staff')
  bool? get isStaff;

  @BuiltValueField(wireName: 'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: 'date_joined')
  String? get dateJoined;

  @BuiltValueField(wireName: 'full_name')
  String? get fullName;

  @BuiltValueField(wireName: 'sellertype')
  String? get sellertype;

  @BuiltValueField(wireName: 'groups')
  BuiltList<dynamic>? get groups;

  @BuiltValueField(wireName: 'user_permissions')
  BuiltList<dynamic>? get userPermissions;

  static Serializer<OwnerModel> get serializer => _$ownerModelSerializer;
}

abstract class FilterSearchReq
    implements Built<FilterSearchReq, FilterSearchReqBuilder> {
  FilterSearchReq._();

  factory FilterSearchReq([Function(FilterSearchReqBuilder b) updates]) =
      _$FilterSearchReq;

  @BuiltValueField(wireName: 'year_from')
  int? get yearFrom;
  @BuiltValueField(wireName: 'year_to')
  int? get yearTo;
  @BuiltValueField(wireName: 'price_from')
  int? get priceFrom;
  @BuiltValueField(wireName: 'price_to')
  int? get priceTo;
  @BuiltValueField(wireName: 'currency')
  String? get currency;
  @BuiltValueField(wireName: 'mileage_from')
  int? get mileageFrom;
  @BuiltValueField(wireName: 'mileage_to')
  int? get mileageTo;
  @BuiltValueField(wireName: 'condition')
  int? get condition;
  @BuiltValueField(wireName: 'user')
  int? get user;
  @BuiltValueField(wireName: 'brand')
  int? get brand;
  @BuiltValueField(wireName: 'car_model')
  int? get carModel;
  @BuiltValueField(wireName: 'generation')
  BuiltList<int>? get generation;
  @BuiltValueField(wireName: 'region')
  BuiltList<int>? get region;
  @BuiltValueField(wireName: 'services')
  BuiltList<int>? get services;
  @BuiltValueField(wireName: 'fuel')
  BuiltList<int>? get fuel;
  @BuiltValueField(wireName: 'color')
  BuiltList<int>? get color;
  @BuiltValueField(wireName: 'transmission')
  BuiltList<int>? get transmission;
  @BuiltValueField(wireName: 'body_type')
  BuiltList<int>? get bodyType;

  static Serializer<FilterSearchReq> get serializer =>
      _$filterSearchReqSerializer;
}

abstract class FilterSearchRes
    implements Built<FilterSearchRes, FilterSearchResBuilder> {
  FilterSearchRes._();

  factory FilterSearchRes([Function(FilterSearchResBuilder b) updates]) =
      _$FilterSearchRes;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'brand')
  Brands get brand;
  @BuiltValueField(wireName: 'car_model')
  CarModel? get carModel;
  @BuiltValueField(wireName: 'generation')
  BuiltList<GenerationModel>? get generation;
  @BuiltValueField(wireName: 'region')
  BuiltList<Region>? get region;
  @BuiltValueField(wireName: 'services')
  BuiltList<Services>? get services;

  @BuiltValueField(wireName: 'fuel')
  BuiltList<Region>? get fuel;

  @BuiltValueField(wireName: 'color')
  BuiltList<NamedModel>? get color;

  @BuiltValueField(wireName: 'body_type')
  BuiltList<BodyType>? get bodyType;
  @BuiltValueField(wireName: 'transmission')
  BuiltList<Region>? get transmission;
  @BuiltValueField(wireName: 'year_from')
  int? get yearFrom;
  @BuiltValueField(wireName: 'year_to')
  int? get yearTo;
  @BuiltValueField(wireName: 'price_from')
  int? get priceFrom;
  @BuiltValueField(wireName: 'price_to')
  int? get priceTo;
  @BuiltValueField(wireName: 'currency')
  String? get currency;
  @BuiltValueField(wireName: 'mileage_from')
  int? get mileageFrom;
  @BuiltValueField(wireName: 'mileage_to')
  int? get mileageTo;
  @BuiltValueField(wireName: 'condition')
  int? get condition;
  @BuiltValueField(wireName: 'user')
  int? get user;

  static Serializer<FilterSearchRes> get serializer =>
      _$filterSearchResSerializer;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FilterSearchRes.serializer, this));
  }

  static FilterSearchRes? fromJson(String jsonString) {
    return serializers.deserializeWith(
        FilterSearchRes.serializer, json.decode(jsonString));
  }
}

abstract class Region implements Built<Region, RegionBuilder> {
  Region._();

  factory Region([Function(RegionBuilder b) updates]) = _$Region;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;

  static Serializer<Region> get serializer => _$regionSerializer;
}

abstract class Services implements Built<Services, ServicesBuilder> {
  Services._();

  factory Services([Function(ServicesBuilder b) updates]) = _$Services;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'description')
  String? get description;

  static Serializer<Services> get serializer => _$servicesSerializer;
}

abstract class BodyType implements Built<BodyType, BodyTypeBuilder> {
  BodyType._();

  factory BodyType([Function(BodyTypeBuilder b) updates]) = _$BodyType;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'icon')
  String? get icon;

  static Serializer<BodyType> get serializer => _$bodyTypeSerializer;
}

abstract class SearchList implements Built<SearchList, SearchListBuilder> {
  SearchList._();

  factory SearchList([Function(SearchListBuilder b) updates]) = _$SearchList;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'brand')
  String? get brand;
  @BuiltValueField(wireName: 'car_model')
  String? get carModel;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'year_start')
  int? get yearStart;
  @BuiltValueField(wireName: 'year_stop')
  int? get yearStop;
  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;
  @BuiltValueField(wireName: 'brand_id')
  int? get brandId;
  @BuiltValueField(wireName: 'car_model_id')
  int? get carModelId;

  static Serializer<SearchList> get serializer => _$searchListSerializer;
}

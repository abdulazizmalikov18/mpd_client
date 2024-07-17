// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BrandReq> _$brandReqSerializer = new _$BrandReqSerializer();
Serializer<BrandResResult> _$brandResResultSerializer =
    new _$BrandResResultSerializer();
Serializer<GenerationsConfigurationsRes>
    _$generationsConfigurationsResSerializer =
    new _$GenerationsConfigurationsResSerializer();
Serializer<ModificationModel> _$modificationModelSerializer =
    new _$ModificationModelSerializer();
Serializer<SpecificationsModel> _$specificationsModelSerializer =
    new _$SpecificationsModelSerializer();
Serializer<CreateCarReq> _$createCarReqSerializer =
    new _$CreateCarReqSerializer();
Serializer<CreateCarRes> _$createCarResSerializer =
    new _$CreateCarResSerializer();
Serializer<CarModel> _$carModelSerializer = new _$CarModelSerializer();
Serializer<Owner> _$ownerSerializer = new _$OwnerSerializer();
Serializer<AdditionalPhones> _$additionalPhonesSerializer =
    new _$AdditionalPhonesSerializer();
Serializer<OptionsModelCarDetail> _$optionsModelCarDetailSerializer =
    new _$OptionsModelCarDetailSerializer();
Serializer<PaintCondition> _$paintConditionSerializer =
    new _$PaintConditionSerializer();
Serializer<ChangedPart> _$changedPartSerializer = new _$ChangedPartSerializer();
Serializer<ChangedPartReq> _$changedPartReqSerializer =
    new _$ChangedPartReqSerializer();
Serializer<CarResResult> _$carResResultSerializer =
    new _$CarResResultSerializer();
Serializer<QuestionModel> _$questionModelSerializer =
    new _$QuestionModelSerializer();

class _$BrandReqSerializer implements StructuredSerializer<BrandReq> {
  @override
  final Iterable<Type> types = const [BrandReq, _$BrandReq];
  @override
  final String wireName = 'BrandReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, BrandReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BrandReq deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrandReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$BrandResResultSerializer
    implements StructuredSerializer<BrandResResult> {
  @override
  final Iterable<Type> types = const [BrandResResult, _$BrandResResult];
  @override
  final String wireName = 'BrandResResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, BrandResResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.next;
    if (value != null) {
      result
        ..add('next')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.previous;
    if (value != null) {
      result
        ..add('previous')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.results;
    if (value != null) {
      result
        ..add('results')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Brands)])));
    }
    return result;
  }

  @override
  BrandResResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrandResResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'next':
          result.next = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'previous':
          result.previous = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'results':
          result.results.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Brands)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GenerationsConfigurationsResSerializer
    implements StructuredSerializer<GenerationsConfigurationsRes> {
  @override
  final Iterable<Type> types = const [
    GenerationsConfigurationsRes,
    _$GenerationsConfigurationsRes
  ];
  @override
  final String wireName = 'GenerationsConfigurationsRes';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GenerationsConfigurationsRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.apiConfigurationId;
    if (value != null) {
      result
        ..add('api_configuration_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.doorsCount;
    if (value != null) {
      result
        ..add('doors_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.notice;
    if (value != null) {
      result
        ..add('notice')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ModificationModel)])));
    }
    return result;
  }

  @override
  GenerationsConfigurationsRes deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GenerationsConfigurationsResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'api_configuration_id':
          result.apiConfigurationId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'doors_count':
          result.doorsCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'body_type':
          result.bodyType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'notice':
          result.notice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'modification':
          result.modification.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ModificationModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ModificationModelSerializer
    implements StructuredSerializer<ModificationModel> {
  @override
  final Iterable<Type> types = const [ModificationModel, _$ModificationModel];
  @override
  final String wireName = 'ModificationModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ModificationModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'options',
      serializers.serialize(object.optionsModelCarDetail,
          specifiedType: const FullType(
              BuiltList, const [const FullType(OptionsModelCarDetail)])),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.apiModificationId;
    if (value != null) {
      result
        ..add('api_modification_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.configuration;
    if (value != null) {
      result
        ..add('configuration')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offersPriceFrom;
    if (value != null) {
      result
        ..add('offers_price_from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.offersPriceTo;
    if (value != null) {
      result
        ..add('offers_price_to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.groupName;
    if (value != null) {
      result
        ..add('group_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.specifications;
    if (value != null) {
      result
        ..add('specifications')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(SpecificationsModel)])));
    }
    return result;
  }

  @override
  ModificationModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ModificationModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'api_modification_id':
          result.apiModificationId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'configuration':
          result.configuration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offers_price_from':
          result.offersPriceFrom = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'offers_price_to':
          result.offersPriceTo = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'group_name':
          result.groupName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'options':
          result.optionsModelCarDetail.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(OptionsModelCarDetail)
              ]))! as BuiltList<Object?>);
          break;
        case 'specifications':
          result.specifications.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SpecificationsModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$SpecificationsModelSerializer
    implements StructuredSerializer<SpecificationsModel> {
  @override
  final Iterable<Type> types = const [
    SpecificationsModel,
    _$SpecificationsModel
  ];
  @override
  final String wireName = 'SpecificationsModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, SpecificationsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.horsePower;
    if (value != null) {
      result
        ..add('horse_power')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.engineType;
    if (value != null) {
      result
        ..add('engine_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.drive;
    if (value != null) {
      result
        ..add('drive')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.volume;
    if (value != null) {
      result
        ..add('volume')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.timeTo100;
    if (value != null) {
      result
        ..add('time_to_100')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.maxSpeed;
    if (value != null) {
      result
        ..add('max_speed')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.diameter;
    if (value != null) {
      result
        ..add('diameter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.petrolType;
    if (value != null) {
      result
        ..add('petrol_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.weight;
    if (value != null) {
      result
        ..add('weight')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.height;
    if (value != null) {
      result
        ..add('height')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.width;
    if (value != null) {
      result
        ..add('width')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.length;
    if (value != null) {
      result
        ..add('length')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.fuelTankCapacity;
    if (value != null) {
      result
        ..add('fuel_tank_capacity')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.volumeLitres;
    if (value != null) {
      result
        ..add('volume_litres')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.safetyRating;
    if (value != null) {
      result
        ..add('safety_rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.safetyGrade;
    if (value != null) {
      result
        ..add('safety_grade')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  SpecificationsModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SpecificationsModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'horse_power':
          result.horsePower = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'engine_type':
          result.engineType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'transmission':
          result.transmission = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'drive':
          result.drive = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'volume':
          result.volume = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'time_to_100':
          result.timeTo100 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'max_speed':
          result.maxSpeed = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'diameter':
          result.diameter = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'petrol_type':
          result.petrolType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'weight':
          result.weight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'length':
          result.length = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'fuel_tank_capacity':
          result.fuelTankCapacity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'volume_litres':
          result.volumeLitres = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'safety_rating':
          result.safetyRating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'safety_grade':
          result.safetyGrade = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'modification':
          result.modification = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$CreateCarReqSerializer implements StructuredSerializer<CreateCarReq> {
  @override
  final Iterable<Type> types = const [CreateCarReq, _$CreateCarReq];
  @override
  final String wireName = 'CreateCarReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, CreateCarReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.carModel;
    if (value != null) {
      result
        ..add('car_model')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.generation;
    if (value != null) {
      result
        ..add('generation')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.configuration;
    if (value != null) {
      result
        ..add('configuration')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body_type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.fuelType;
    if (value != null) {
      result
        ..add('fuel_type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.numberOfOwners;
    if (value != null) {
      result
        ..add('number_of_owners')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.year;
    if (value != null) {
      result
        ..add('year')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mileage;
    if (value != null) {
      result
        ..add('mileage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.currency;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.engineSize;
    if (value != null) {
      result
        ..add('engine_size')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.horsepower;
    if (value != null) {
      result
        ..add('horsepower')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.usedCar;
    if (value != null) {
      result
        ..add('used_car')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.paintCondition;
    if (value != null) {
      result
        ..add('paint_condition')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.photos;
    if (value != null) {
      result
        ..add('photos')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ImagesModel)])));
    }
    value = object.changedPart;
    if (value != null) {
      result
        ..add('changed_part')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ChangedPartReq)])));
    }
    value = object.externalBodyKit;
    if (value != null) {
      result
        ..add('external_body_kit')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.salon;
    if (value != null) {
      result
        ..add('salon')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.additionalPhones;
    if (value != null) {
      result
        ..add('additional_phones')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(AdditionalPhones)])));
    }
    value = object.time24;
    if (value != null) {
      result
        ..add('time24')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.timeFrom;
    if (value != null) {
      result
        ..add('time_from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timeTo;
    if (value != null) {
      result
        ..add('time_to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mediaTools;
    if (value != null) {
      result
        ..add('media_tools')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.optics;
    if (value != null) {
      result
        ..add('optics')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.barter;
    if (value != null) {
      result
        ..add('barter')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isCheaper;
    if (value != null) {
      result
        ..add('is_cheaper')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  CreateCarReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreateCarReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'car_model':
          result.carModel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'generation':
          result.generation = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'configuration':
          result.configuration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'body_type':
          result.bodyType = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'fuel_type':
          result.fuelType = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'region':
          result.region = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'transmission':
          result.transmission = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'number_of_owners':
          result.numberOfOwners = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mileage':
          result.mileage = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'engine_size':
          result.engineSize = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'horsepower':
          result.horsepower = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'used_car':
          result.usedCar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'paint_condition':
          result.paintCondition = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'photos':
          result.photos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ImagesModel)]))!
              as BuiltList<Object?>);
          break;
        case 'changed_part':
          result.changedPart.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ChangedPartReq)]))!
              as BuiltList<Object?>);
          break;
        case 'external_body_kit':
          result.externalBodyKit.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'salon':
          result.salon.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'additional_phones':
          result.additionalPhones.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AdditionalPhones)]))!
              as BuiltList<Object?>);
          break;
        case 'time24':
          result.time24 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'time_from':
          result.timeFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'time_to':
          result.timeTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'media_tools':
          result.mediaTools.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'modification':
          result.modification = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'optics':
          result.optics.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'barter':
          result.barter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'is_cheaper':
          result.isCheaper = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$CreateCarResSerializer implements StructuredSerializer<CreateCarRes> {
  @override
  final Iterable<Type> types = const [CreateCarRes, _$CreateCarRes];
  @override
  final String wireName = 'CreateCarRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, CreateCarRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.numberOfOwners;
    if (value != null) {
      result
        ..add('number_of_owners')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.year;
    if (value != null) {
      result
        ..add('year')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mileage;
    if (value != null) {
      result
        ..add('mileage')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.currency;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.engineSize;
    if (value != null) {
      result
        ..add('engine_size')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.horsepower;
    if (value != null) {
      result
        ..add('horsepower')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.rated;
    if (value != null) {
      result
        ..add('rated')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.active;
    if (value != null) {
      result
        ..add('active')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.usedCar;
    if (value != null) {
      result
        ..add('used_car')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.avtoritetDiagnostics;
    if (value != null) {
      result
        ..add('avtoritet_diagnostics')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.orientMotorsWarranty;
    if (value != null) {
      result
        ..add('orient_motors_warranty')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.ownedByOrientMotors;
    if (value != null) {
      result
        ..add('owned_by_orient_motors')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.avtoritetPremiumDiagnostics;
    if (value != null) {
      result
        ..add('avtoritet_premium_diagnostics')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.time24;
    if (value != null) {
      result
        ..add('time24')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.timeFrom;
    if (value != null) {
      result
        ..add('time_from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timeTo;
    if (value != null) {
      result
        ..add('time_to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postedAt;
    if (value != null) {
      result
        ..add('posted_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.carModel;
    if (value != null) {
      result
        ..add('car_model')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.generation;
    if (value != null) {
      result
        ..add('generation')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.owner;
    if (value != null) {
      result
        ..add('owner')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body_type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.fuelType;
    if (value != null) {
      result
        ..add('fuel_type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.driveUnit;
    if (value != null) {
      result
        ..add('drive_unit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.paintCondition;
    if (value != null) {
      result
        ..add('paint_condition')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.likedBy;
    if (value != null) {
      result
        ..add('liked_by')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.mediaTools;
    if (value != null) {
      result
        ..add('media_tools')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.optics;
    if (value != null) {
      result
        ..add('optics')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.externalBodyKit;
    if (value != null) {
      result
        ..add('external_body_kit')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.salon;
    if (value != null) {
      result
        ..add('salon')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.vehicleOptions;
    if (value != null) {
      result
        ..add('vehicle_options')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.changedPart;
    if (value != null) {
      result
        ..add('changed_part')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    return result;
  }

  @override
  CreateCarRes deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreateCarResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'number_of_owners':
          result.numberOfOwners = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mileage':
          result.mileage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'engine_size':
          result.engineSize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'horsepower':
          result.horsepower = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'rated':
          result.rated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'active':
          result.active = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'used_car':
          result.usedCar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'avtoritet_diagnostics':
          result.avtoritetDiagnostics = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'orient_motors_warranty':
          result.orientMotorsWarranty = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'owned_by_orient_motors':
          result.ownedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'avtoritet_premium_diagnostics':
          result.avtoritetPremiumDiagnostics = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'time24':
          result.time24 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'time_from':
          result.timeFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'time_to':
          result.timeTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'posted_at':
          result.postedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'car_model':
          result.carModel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'generation':
          result.generation = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'modification':
          result.modification = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'owner':
          result.owner = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'body_type':
          result.bodyType = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'fuel_type':
          result.fuelType = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'region':
          result.region = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'transmission':
          result.transmission = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'drive_unit':
          result.driveUnit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'paint_condition':
          result.paintCondition = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'liked_by':
          result.likedBy.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'media_tools':
          result.mediaTools.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'optics':
          result.optics.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'external_body_kit':
          result.externalBodyKit.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'salon':
          result.salon.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'vehicle_options':
          result.vehicleOptions.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'changed_part':
          result.changedPart.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$CarModelSerializer implements StructuredSerializer<CarModel> {
  @override
  final Iterable<Type> types = const [CarModel, _$CarModel];
  @override
  final String wireName = 'CarModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CarModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.additionalPhones;
    if (value != null) {
      result
        ..add('additional_phones')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(AdditionalPhones)])));
    }
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Brands)));
    }
    value = object.carModel;
    if (value != null) {
      result
        ..add('car_model')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(CarModel)));
    }
    value = object.generation;
    if (value != null) {
      result
        ..add('generation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GenerationModel)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ModificationModel)));
    }
    value = object.owner;
    if (value != null) {
      result
        ..add('owner')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Owner)));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.fuelType;
    if (value != null) {
      result
        ..add('fuel_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.driveUnit;
    if (value != null) {
      result
        ..add('drive_unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.numberOfOwners;
    if (value != null) {
      result
        ..add('number_of_owners')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.year;
    if (value != null) {
      result
        ..add('year')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mileage;
    if (value != null) {
      result
        ..add('mileage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.currency;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.engineSize;
    if (value != null) {
      result
        ..add('engine_size')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.horsepower;
    if (value != null) {
      result
        ..add('horsepower')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.rated;
    if (value != null) {
      result
        ..add('rated')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.active;
    if (value != null) {
      result
        ..add('active')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.usedCar;
    if (value != null) {
      result
        ..add('used_car')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.avtoritetDiagnostics;
    if (value != null) {
      result
        ..add('avtoritet_diagnostics')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.orientMotorsWarranty;
    if (value != null) {
      result
        ..add('orient_motors_warranty')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.postedAt;
    if (value != null) {
      result
        ..add('posted_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ownedByOrientMotors;
    if (value != null) {
      result
        ..add('owned_by_orient_motors')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.avtoritetPremiumDiagnostics;
    if (value != null) {
      result
        ..add('avtoritet_premium_diagnostics')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.likedBy;
    if (value != null) {
      result
        ..add('liked_by')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.photos;
    if (value != null) {
      result
        ..add('photos')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ImagesModel)])));
    }
    value = object.paintCondition;
    if (value != null) {
      result
        ..add('paint_condition')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(PaintCondition)));
    }
    value = object.mediaTools;
    if (value != null) {
      result
        ..add('media_tools')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DriveUnitModel)])));
    }
    value = object.optics;
    if (value != null) {
      result
        ..add('optics')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DriveUnitModel)])));
    }
    value = object.externalBodyKit;
    if (value != null) {
      result
        ..add('external_body_kit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DriveUnitModel)])));
    }
    value = object.salon;
    if (value != null) {
      result
        ..add('salon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DriveUnitModel)])));
    }
    value = object.vehicleOptions;
    if (value != null) {
      result
        ..add('vehicle_options')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DriveUnitModel)])));
    }
    value = object.time24;
    if (value != null) {
      result
        ..add('time24')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.timeFrom;
    if (value != null) {
      result
        ..add('time_from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timeTo;
    if (value != null) {
      result
        ..add('time_to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.barter;
    if (value != null) {
      result
        ..add('barter')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isCheaper;
    if (value != null) {
      result
        ..add('is_cheaper')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.changedPart;
    if (value != null) {
      result
        ..add('changed_part')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ChangedPart)])));
    }
    value = object.totalLikes;
    if (value != null) {
      result
        ..add('total_likes')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.totalViews;
    if (value != null) {
      result
        ..add('total_views')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CarModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'additional_phones':
          result.additionalPhones.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AdditionalPhones)]))!
              as BuiltList<Object?>);
          break;
        case 'brand':
          result.brand.replace(serializers.deserialize(value,
              specifiedType: const FullType(Brands))! as Brands);
          break;
        case 'car_model':
          result.carModel.replace(serializers.deserialize(value,
              specifiedType: const FullType(CarModel))! as CarModel);
          break;
        case 'generation':
          result.generation.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GenerationModel))!
              as GenerationModel);
          break;
        case 'modification':
          result.modification.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ModificationModel))!
              as ModificationModel);
          break;
        case 'owner':
          result.owner.replace(serializers.deserialize(value,
              specifiedType: const FullType(Owner))! as Owner);
          break;
        case 'body_type':
          result.bodyType.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'fuel_type':
          result.fuelType.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'region':
          result.region.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'transmission':
          result.transmission.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'color':
          result.color.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'drive_unit':
          result.driveUnit.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'number_of_owners':
          result.numberOfOwners = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mileage':
          result.mileage = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'engine_size':
          result.engineSize = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'horsepower':
          result.horsepower = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'rated':
          result.rated = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'active':
          result.active = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'used_car':
          result.usedCar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'avtoritet_diagnostics':
          result.avtoritetDiagnostics = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'orient_motors_warranty':
          result.orientMotorsWarranty = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'posted_at':
          result.postedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'owned_by_orient_motors':
          result.ownedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'avtoritet_premium_diagnostics':
          result.avtoritetPremiumDiagnostics = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'liked_by':
          result.likedBy = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'photos':
          result.photos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ImagesModel)]))!
              as BuiltList<Object?>);
          break;
        case 'paint_condition':
          result.paintCondition.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaintCondition))!
              as PaintCondition);
          break;
        case 'media_tools':
          result.mediaTools.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DriveUnitModel)]))!
              as BuiltList<Object?>);
          break;
        case 'optics':
          result.optics.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DriveUnitModel)]))!
              as BuiltList<Object?>);
          break;
        case 'external_body_kit':
          result.externalBodyKit.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DriveUnitModel)]))!
              as BuiltList<Object?>);
          break;
        case 'salon':
          result.salon.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DriveUnitModel)]))!
              as BuiltList<Object?>);
          break;
        case 'vehicle_options':
          result.vehicleOptions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DriveUnitModel)]))!
              as BuiltList<Object?>);
          break;
        case 'time24':
          result.time24 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'time_from':
          result.timeFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'time_to':
          result.timeTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'barter':
          result.barter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'is_cheaper':
          result.isCheaper = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'changed_part':
          result.changedPart.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ChangedPart)]))!
              as BuiltList<Object?>);
          break;
        case 'total_likes':
          result.totalLikes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'total_views':
          result.totalViews = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$OwnerSerializer implements StructuredSerializer<Owner> {
  @override
  final Iterable<Type> types = const [Owner, _$Owner];
  @override
  final String wireName = 'Owner';

  @override
  Iterable<Object?> serialize(Serializers serializers, Owner object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fullName;
    if (value != null) {
      result
        ..add('full_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.profilePic;
    if (value != null) {
      result
        ..add('profile_pic')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Owner deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OwnerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'profile_pic':
          result.profilePic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AdditionalPhonesSerializer
    implements StructuredSerializer<AdditionalPhones> {
  @override
  final Iterable<Type> types = const [AdditionalPhones, _$AdditionalPhones];
  @override
  final String wireName = 'AdditionalPhones';

  @override
  Iterable<Object?> serialize(Serializers serializers, AdditionalPhones object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.number;
    if (value != null) {
      result
        ..add('number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.car;
    if (value != null) {
      result
        ..add('car')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  AdditionalPhones deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdditionalPhonesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car':
          result.car = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$OptionsModelCarDetailSerializer
    implements StructuredSerializer<OptionsModelCarDetail> {
  @override
  final Iterable<Type> types = const [
    OptionsModelCarDetail,
    _$OptionsModelCarDetail
  ];
  @override
  final String wireName = 'OptionsModelCarDetail';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, OptionsModelCarDetail object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.electroMirrors;
    if (value != null) {
      result
        ..add('electro_mirrors')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.airbagSide;
    if (value != null) {
      result
        ..add('airbag_side')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.hatch;
    if (value != null) {
      result
        ..add('hatch')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.ledLight;
    if (value != null) {
      result
        ..add('led_light')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.rainSensor;
    if (value != null) {
      result
        ..add('rain_sensor')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.aux;
    if (value != null) {
      result
        ..add('aux')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  OptionsModelCarDetail deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OptionsModelCarDetailBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'electro_mirrors':
          result.electroMirrors = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'airbag_side':
          result.airbagSide = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'hatch':
          result.hatch = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'led_light':
          result.ledLight = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'rain_sensor':
          result.rainSensor = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'aux':
          result.aux = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'modification':
          result.modification = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$PaintConditionSerializer
    implements StructuredSerializer<PaintCondition> {
  @override
  final Iterable<Type> types = const [PaintCondition, _$PaintCondition];
  @override
  final String wireName = 'PaintCondition';

  @override
  Iterable<Object?> serialize(Serializers serializers, PaintCondition object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PaintCondition deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaintConditionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ChangedPartSerializer implements StructuredSerializer<ChangedPart> {
  @override
  final Iterable<Type> types = const [ChangedPart, _$ChangedPart];
  @override
  final String wireName = 'ChangedPart';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChangedPart object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.changedPart;
    if (value != null) {
      result
        ..add('changed_part')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    value = object.changedPartQuality;
    if (value != null) {
      result
        ..add('changed_part_quality')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NamedModel)));
    }
    return result;
  }

  @override
  ChangedPart deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChangedPartBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'changed_part':
          result.changedPart.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
        case 'changed_part_quality':
          result.changedPartQuality.replace(serializers.deserialize(value,
              specifiedType: const FullType(NamedModel))! as NamedModel);
          break;
      }
    }

    return result.build();
  }
}

class _$ChangedPartReqSerializer
    implements StructuredSerializer<ChangedPartReq> {
  @override
  final Iterable<Type> types = const [ChangedPartReq, _$ChangedPartReq];
  @override
  final String wireName = 'ChangedPartReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChangedPartReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.partId;
    if (value != null) {
      result
        ..add('part_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.qualityId;
    if (value != null) {
      result
        ..add('quality_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ChangedPartReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChangedPartReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'part_id':
          result.partId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'quality_id':
          result.qualityId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$CarResResultSerializer implements StructuredSerializer<CarResResult> {
  @override
  final Iterable<Type> types = const [CarResResult, _$CarResResult];
  @override
  final String wireName = 'CarResResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, CarResResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.next;
    if (value != null) {
      result
        ..add('next')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.previous;
    if (value != null) {
      result
        ..add('previous')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.results;
    if (value != null) {
      result
        ..add('results')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(CarModel)])));
    }
    return result;
  }

  @override
  CarResResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarResResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'next':
          result.next = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'previous':
          result.previous = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'results':
          result.results.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CarModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$QuestionModelSerializer implements StructuredSerializer<QuestionModel> {
  @override
  final Iterable<Type> types = const [QuestionModel, _$QuestionModel];
  @override
  final String wireName = 'QuestionModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, QuestionModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.question;
    if (value != null) {
      result
        ..add('question')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  QuestionModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuestionModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'question':
          result.question = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$BrandReq extends BrandReq {
  @override
  final String? name;
  @override
  final String? icon;

  factory _$BrandReq([void Function(BrandReqBuilder)? updates]) =>
      (new BrandReqBuilder()..update(updates))._build();

  _$BrandReq._({this.name, this.icon}) : super._();

  @override
  BrandReq rebuild(void Function(BrandReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandReqBuilder toBuilder() => new BrandReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BrandReq && name == other.name && icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BrandReq')
          ..add('name', name)
          ..add('icon', icon))
        .toString();
  }
}

class BrandReqBuilder implements Builder<BrandReq, BrandReqBuilder> {
  _$BrandReq? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  BrandReqBuilder();

  BrandReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BrandReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BrandReq;
  }

  @override
  void update(void Function(BrandReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BrandReq build() => _build();

  _$BrandReq _build() {
    final _$result = _$v ?? new _$BrandReq._(name: name, icon: icon);
    replace(_$result);
    return _$result;
  }
}

class _$BrandResResult extends BrandResResult {
  @override
  final int? count;
  @override
  final String? next;
  @override
  final String? previous;
  @override
  final BuiltList<Brands>? results;

  factory _$BrandResResult([void Function(BrandResResultBuilder)? updates]) =>
      (new BrandResResultBuilder()..update(updates))._build();

  _$BrandResResult._({this.count, this.next, this.previous, this.results})
      : super._();

  @override
  BrandResResult rebuild(void Function(BrandResResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandResResultBuilder toBuilder() =>
      new BrandResResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BrandResResult &&
        count == other.count &&
        next == other.next &&
        previous == other.previous &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, next.hashCode);
    _$hash = $jc(_$hash, previous.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BrandResResult')
          ..add('count', count)
          ..add('next', next)
          ..add('previous', previous)
          ..add('results', results))
        .toString();
  }
}

class BrandResResultBuilder
    implements Builder<BrandResResult, BrandResResultBuilder> {
  _$BrandResResult? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _next;
  String? get next => _$this._next;
  set next(String? next) => _$this._next = next;

  String? _previous;
  String? get previous => _$this._previous;
  set previous(String? previous) => _$this._previous = previous;

  ListBuilder<Brands>? _results;
  ListBuilder<Brands> get results =>
      _$this._results ??= new ListBuilder<Brands>();
  set results(ListBuilder<Brands>? results) => _$this._results = results;

  BrandResResultBuilder();

  BrandResResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _next = $v.next;
      _previous = $v.previous;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BrandResResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BrandResResult;
  }

  @override
  void update(void Function(BrandResResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BrandResResult build() => _build();

  _$BrandResResult _build() {
    _$BrandResResult _$result;
    try {
      _$result = _$v ??
          new _$BrandResResult._(
              count: count,
              next: next,
              previous: previous,
              results: _results?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BrandResResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GenerationsConfigurationsRes extends GenerationsConfigurationsRes {
  @override
  final int? id;
  @override
  final String? apiConfigurationId;
  @override
  final int? doorsCount;
  @override
  final String? bodyType;
  @override
  final String? notice;
  @override
  final BuiltList<ModificationModel>? modification;

  factory _$GenerationsConfigurationsRes(
          [void Function(GenerationsConfigurationsResBuilder)? updates]) =>
      (new GenerationsConfigurationsResBuilder()..update(updates))._build();

  _$GenerationsConfigurationsRes._(
      {this.id,
      this.apiConfigurationId,
      this.doorsCount,
      this.bodyType,
      this.notice,
      this.modification})
      : super._();

  @override
  GenerationsConfigurationsRes rebuild(
          void Function(GenerationsConfigurationsResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerationsConfigurationsResBuilder toBuilder() =>
      new GenerationsConfigurationsResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerationsConfigurationsRes &&
        id == other.id &&
        apiConfigurationId == other.apiConfigurationId &&
        doorsCount == other.doorsCount &&
        bodyType == other.bodyType &&
        notice == other.notice &&
        modification == other.modification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, apiConfigurationId.hashCode);
    _$hash = $jc(_$hash, doorsCount.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jc(_$hash, notice.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerationsConfigurationsRes')
          ..add('id', id)
          ..add('apiConfigurationId', apiConfigurationId)
          ..add('doorsCount', doorsCount)
          ..add('bodyType', bodyType)
          ..add('notice', notice)
          ..add('modification', modification))
        .toString();
  }
}

class GenerationsConfigurationsResBuilder
    implements
        Builder<GenerationsConfigurationsRes,
            GenerationsConfigurationsResBuilder> {
  _$GenerationsConfigurationsRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _apiConfigurationId;
  String? get apiConfigurationId => _$this._apiConfigurationId;
  set apiConfigurationId(String? apiConfigurationId) =>
      _$this._apiConfigurationId = apiConfigurationId;

  int? _doorsCount;
  int? get doorsCount => _$this._doorsCount;
  set doorsCount(int? doorsCount) => _$this._doorsCount = doorsCount;

  String? _bodyType;
  String? get bodyType => _$this._bodyType;
  set bodyType(String? bodyType) => _$this._bodyType = bodyType;

  String? _notice;
  String? get notice => _$this._notice;
  set notice(String? notice) => _$this._notice = notice;

  ListBuilder<ModificationModel>? _modification;
  ListBuilder<ModificationModel> get modification =>
      _$this._modification ??= new ListBuilder<ModificationModel>();
  set modification(ListBuilder<ModificationModel>? modification) =>
      _$this._modification = modification;

  GenerationsConfigurationsResBuilder();

  GenerationsConfigurationsResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _apiConfigurationId = $v.apiConfigurationId;
      _doorsCount = $v.doorsCount;
      _bodyType = $v.bodyType;
      _notice = $v.notice;
      _modification = $v.modification?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerationsConfigurationsRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GenerationsConfigurationsRes;
  }

  @override
  void update(void Function(GenerationsConfigurationsResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerationsConfigurationsRes build() => _build();

  _$GenerationsConfigurationsRes _build() {
    _$GenerationsConfigurationsRes _$result;
    try {
      _$result = _$v ??
          new _$GenerationsConfigurationsRes._(
              id: id,
              apiConfigurationId: apiConfigurationId,
              doorsCount: doorsCount,
              bodyType: bodyType,
              notice: notice,
              modification: _modification?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'modification';
        _modification?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GenerationsConfigurationsRes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ModificationModel extends ModificationModel {
  @override
  final int? id;
  @override
  final String? apiModificationId;
  @override
  final int? configuration;
  @override
  final double? offersPriceFrom;
  @override
  final double? offersPriceTo;
  @override
  final String? groupName;
  @override
  final BuiltList<OptionsModelCarDetail> optionsModelCarDetail;
  @override
  final BuiltList<SpecificationsModel>? specifications;

  factory _$ModificationModel(
          [void Function(ModificationModelBuilder)? updates]) =>
      (new ModificationModelBuilder()..update(updates))._build();

  _$ModificationModel._(
      {this.id,
      this.apiModificationId,
      this.configuration,
      this.offersPriceFrom,
      this.offersPriceTo,
      this.groupName,
      required this.optionsModelCarDetail,
      this.specifications})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        optionsModelCarDetail, r'ModificationModel', 'optionsModelCarDetail');
  }

  @override
  ModificationModel rebuild(void Function(ModificationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModificationModelBuilder toBuilder() =>
      new ModificationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModificationModel &&
        id == other.id &&
        apiModificationId == other.apiModificationId &&
        configuration == other.configuration &&
        offersPriceFrom == other.offersPriceFrom &&
        offersPriceTo == other.offersPriceTo &&
        groupName == other.groupName &&
        optionsModelCarDetail == other.optionsModelCarDetail &&
        specifications == other.specifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, apiModificationId.hashCode);
    _$hash = $jc(_$hash, configuration.hashCode);
    _$hash = $jc(_$hash, offersPriceFrom.hashCode);
    _$hash = $jc(_$hash, offersPriceTo.hashCode);
    _$hash = $jc(_$hash, groupName.hashCode);
    _$hash = $jc(_$hash, optionsModelCarDetail.hashCode);
    _$hash = $jc(_$hash, specifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ModificationModel')
          ..add('id', id)
          ..add('apiModificationId', apiModificationId)
          ..add('configuration', configuration)
          ..add('offersPriceFrom', offersPriceFrom)
          ..add('offersPriceTo', offersPriceTo)
          ..add('groupName', groupName)
          ..add('optionsModelCarDetail', optionsModelCarDetail)
          ..add('specifications', specifications))
        .toString();
  }
}

class ModificationModelBuilder
    implements Builder<ModificationModel, ModificationModelBuilder> {
  _$ModificationModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _apiModificationId;
  String? get apiModificationId => _$this._apiModificationId;
  set apiModificationId(String? apiModificationId) =>
      _$this._apiModificationId = apiModificationId;

  int? _configuration;
  int? get configuration => _$this._configuration;
  set configuration(int? configuration) =>
      _$this._configuration = configuration;

  double? _offersPriceFrom;
  double? get offersPriceFrom => _$this._offersPriceFrom;
  set offersPriceFrom(double? offersPriceFrom) =>
      _$this._offersPriceFrom = offersPriceFrom;

  double? _offersPriceTo;
  double? get offersPriceTo => _$this._offersPriceTo;
  set offersPriceTo(double? offersPriceTo) =>
      _$this._offersPriceTo = offersPriceTo;

  String? _groupName;
  String? get groupName => _$this._groupName;
  set groupName(String? groupName) => _$this._groupName = groupName;

  ListBuilder<OptionsModelCarDetail>? _optionsModelCarDetail;
  ListBuilder<OptionsModelCarDetail> get optionsModelCarDetail =>
      _$this._optionsModelCarDetail ??=
          new ListBuilder<OptionsModelCarDetail>();
  set optionsModelCarDetail(
          ListBuilder<OptionsModelCarDetail>? optionsModelCarDetail) =>
      _$this._optionsModelCarDetail = optionsModelCarDetail;

  ListBuilder<SpecificationsModel>? _specifications;
  ListBuilder<SpecificationsModel> get specifications =>
      _$this._specifications ??= new ListBuilder<SpecificationsModel>();
  set specifications(ListBuilder<SpecificationsModel>? specifications) =>
      _$this._specifications = specifications;

  ModificationModelBuilder();

  ModificationModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _apiModificationId = $v.apiModificationId;
      _configuration = $v.configuration;
      _offersPriceFrom = $v.offersPriceFrom;
      _offersPriceTo = $v.offersPriceTo;
      _groupName = $v.groupName;
      _optionsModelCarDetail = $v.optionsModelCarDetail.toBuilder();
      _specifications = $v.specifications?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModificationModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ModificationModel;
  }

  @override
  void update(void Function(ModificationModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ModificationModel build() => _build();

  _$ModificationModel _build() {
    _$ModificationModel _$result;
    try {
      _$result = _$v ??
          new _$ModificationModel._(
              id: id,
              apiModificationId: apiModificationId,
              configuration: configuration,
              offersPriceFrom: offersPriceFrom,
              offersPriceTo: offersPriceTo,
              groupName: groupName,
              optionsModelCarDetail: optionsModelCarDetail.build(),
              specifications: _specifications?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'optionsModelCarDetail';
        optionsModelCarDetail.build();
        _$failedField = 'specifications';
        _specifications?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ModificationModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SpecificationsModel extends SpecificationsModel {
  @override
  final int? id;
  @override
  final double? horsePower;
  @override
  final String? engineType;
  @override
  final String? transmission;
  @override
  final String? drive;
  @override
  final double? volume;
  @override
  final double? timeTo100;
  @override
  final double? maxSpeed;
  @override
  final double? diameter;
  @override
  final String? petrolType;
  @override
  final double? weight;
  @override
  final double? height;
  @override
  final double? width;
  @override
  final double? length;
  @override
  final double? fuelTankCapacity;
  @override
  final double? volumeLitres;
  @override
  final double? safetyRating;
  @override
  final double? safetyGrade;
  @override
  final double? modification;

  factory _$SpecificationsModel(
          [void Function(SpecificationsModelBuilder)? updates]) =>
      (new SpecificationsModelBuilder()..update(updates))._build();

  _$SpecificationsModel._(
      {this.id,
      this.horsePower,
      this.engineType,
      this.transmission,
      this.drive,
      this.volume,
      this.timeTo100,
      this.maxSpeed,
      this.diameter,
      this.petrolType,
      this.weight,
      this.height,
      this.width,
      this.length,
      this.fuelTankCapacity,
      this.volumeLitres,
      this.safetyRating,
      this.safetyGrade,
      this.modification})
      : super._();

  @override
  SpecificationsModel rebuild(
          void Function(SpecificationsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SpecificationsModelBuilder toBuilder() =>
      new SpecificationsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SpecificationsModel &&
        id == other.id &&
        horsePower == other.horsePower &&
        engineType == other.engineType &&
        transmission == other.transmission &&
        drive == other.drive &&
        volume == other.volume &&
        timeTo100 == other.timeTo100 &&
        maxSpeed == other.maxSpeed &&
        diameter == other.diameter &&
        petrolType == other.petrolType &&
        weight == other.weight &&
        height == other.height &&
        width == other.width &&
        length == other.length &&
        fuelTankCapacity == other.fuelTankCapacity &&
        volumeLitres == other.volumeLitres &&
        safetyRating == other.safetyRating &&
        safetyGrade == other.safetyGrade &&
        modification == other.modification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, horsePower.hashCode);
    _$hash = $jc(_$hash, engineType.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, drive.hashCode);
    _$hash = $jc(_$hash, volume.hashCode);
    _$hash = $jc(_$hash, timeTo100.hashCode);
    _$hash = $jc(_$hash, maxSpeed.hashCode);
    _$hash = $jc(_$hash, diameter.hashCode);
    _$hash = $jc(_$hash, petrolType.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, width.hashCode);
    _$hash = $jc(_$hash, length.hashCode);
    _$hash = $jc(_$hash, fuelTankCapacity.hashCode);
    _$hash = $jc(_$hash, volumeLitres.hashCode);
    _$hash = $jc(_$hash, safetyRating.hashCode);
    _$hash = $jc(_$hash, safetyGrade.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SpecificationsModel')
          ..add('id', id)
          ..add('horsePower', horsePower)
          ..add('engineType', engineType)
          ..add('transmission', transmission)
          ..add('drive', drive)
          ..add('volume', volume)
          ..add('timeTo100', timeTo100)
          ..add('maxSpeed', maxSpeed)
          ..add('diameter', diameter)
          ..add('petrolType', petrolType)
          ..add('weight', weight)
          ..add('height', height)
          ..add('width', width)
          ..add('length', length)
          ..add('fuelTankCapacity', fuelTankCapacity)
          ..add('volumeLitres', volumeLitres)
          ..add('safetyRating', safetyRating)
          ..add('safetyGrade', safetyGrade)
          ..add('modification', modification))
        .toString();
  }
}

class SpecificationsModelBuilder
    implements Builder<SpecificationsModel, SpecificationsModelBuilder> {
  _$SpecificationsModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _horsePower;
  double? get horsePower => _$this._horsePower;
  set horsePower(double? horsePower) => _$this._horsePower = horsePower;

  String? _engineType;
  String? get engineType => _$this._engineType;
  set engineType(String? engineType) => _$this._engineType = engineType;

  String? _transmission;
  String? get transmission => _$this._transmission;
  set transmission(String? transmission) => _$this._transmission = transmission;

  String? _drive;
  String? get drive => _$this._drive;
  set drive(String? drive) => _$this._drive = drive;

  double? _volume;
  double? get volume => _$this._volume;
  set volume(double? volume) => _$this._volume = volume;

  double? _timeTo100;
  double? get timeTo100 => _$this._timeTo100;
  set timeTo100(double? timeTo100) => _$this._timeTo100 = timeTo100;

  double? _maxSpeed;
  double? get maxSpeed => _$this._maxSpeed;
  set maxSpeed(double? maxSpeed) => _$this._maxSpeed = maxSpeed;

  double? _diameter;
  double? get diameter => _$this._diameter;
  set diameter(double? diameter) => _$this._diameter = diameter;

  String? _petrolType;
  String? get petrolType => _$this._petrolType;
  set petrolType(String? petrolType) => _$this._petrolType = petrolType;

  double? _weight;
  double? get weight => _$this._weight;
  set weight(double? weight) => _$this._weight = weight;

  double? _height;
  double? get height => _$this._height;
  set height(double? height) => _$this._height = height;

  double? _width;
  double? get width => _$this._width;
  set width(double? width) => _$this._width = width;

  double? _length;
  double? get length => _$this._length;
  set length(double? length) => _$this._length = length;

  double? _fuelTankCapacity;
  double? get fuelTankCapacity => _$this._fuelTankCapacity;
  set fuelTankCapacity(double? fuelTankCapacity) =>
      _$this._fuelTankCapacity = fuelTankCapacity;

  double? _volumeLitres;
  double? get volumeLitres => _$this._volumeLitres;
  set volumeLitres(double? volumeLitres) => _$this._volumeLitres = volumeLitres;

  double? _safetyRating;
  double? get safetyRating => _$this._safetyRating;
  set safetyRating(double? safetyRating) => _$this._safetyRating = safetyRating;

  double? _safetyGrade;
  double? get safetyGrade => _$this._safetyGrade;
  set safetyGrade(double? safetyGrade) => _$this._safetyGrade = safetyGrade;

  double? _modification;
  double? get modification => _$this._modification;
  set modification(double? modification) => _$this._modification = modification;

  SpecificationsModelBuilder();

  SpecificationsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _horsePower = $v.horsePower;
      _engineType = $v.engineType;
      _transmission = $v.transmission;
      _drive = $v.drive;
      _volume = $v.volume;
      _timeTo100 = $v.timeTo100;
      _maxSpeed = $v.maxSpeed;
      _diameter = $v.diameter;
      _petrolType = $v.petrolType;
      _weight = $v.weight;
      _height = $v.height;
      _width = $v.width;
      _length = $v.length;
      _fuelTankCapacity = $v.fuelTankCapacity;
      _volumeLitres = $v.volumeLitres;
      _safetyRating = $v.safetyRating;
      _safetyGrade = $v.safetyGrade;
      _modification = $v.modification;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SpecificationsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SpecificationsModel;
  }

  @override
  void update(void Function(SpecificationsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SpecificationsModel build() => _build();

  _$SpecificationsModel _build() {
    final _$result = _$v ??
        new _$SpecificationsModel._(
            id: id,
            horsePower: horsePower,
            engineType: engineType,
            transmission: transmission,
            drive: drive,
            volume: volume,
            timeTo100: timeTo100,
            maxSpeed: maxSpeed,
            diameter: diameter,
            petrolType: petrolType,
            weight: weight,
            height: height,
            width: width,
            length: length,
            fuelTankCapacity: fuelTankCapacity,
            volumeLitres: volumeLitres,
            safetyRating: safetyRating,
            safetyGrade: safetyGrade,
            modification: modification);
    replace(_$result);
    return _$result;
  }
}

class _$CreateCarReq extends CreateCarReq {
  @override
  final int? brand;
  @override
  final int? carModel;
  @override
  final int? generation;
  @override
  final int? configuration;
  @override
  final int? bodyType;
  @override
  final int? fuelType;
  @override
  final int? region;
  @override
  final int? transmission;
  @override
  final String? numberOfOwners;
  @override
  final int? color;
  @override
  final int? year;
  @override
  final double? mileage;
  @override
  final double? price;
  @override
  final String? currency;
  @override
  final String? engineSize;
  @override
  final String? horsepower;
  @override
  final bool? usedCar;
  @override
  final String? description;
  @override
  final int? paintCondition;
  @override
  final BuiltList<ImagesModel>? photos;
  @override
  final BuiltList<ChangedPartReq>? changedPart;
  @override
  final BuiltList<int>? externalBodyKit;
  @override
  final BuiltList<int>? salon;
  @override
  final BuiltList<AdditionalPhones>? additionalPhones;
  @override
  final bool? time24;
  @override
  final String? timeFrom;
  @override
  final String? timeTo;
  @override
  final BuiltList<int>? mediaTools;
  @override
  final int? modification;
  @override
  final BuiltList<int>? optics;
  @override
  final bool? barter;
  @override
  final bool? isCheaper;

  factory _$CreateCarReq([void Function(CreateCarReqBuilder)? updates]) =>
      (new CreateCarReqBuilder()..update(updates))._build();

  _$CreateCarReq._(
      {this.brand,
      this.carModel,
      this.generation,
      this.configuration,
      this.bodyType,
      this.fuelType,
      this.region,
      this.transmission,
      this.numberOfOwners,
      this.color,
      this.year,
      this.mileage,
      this.price,
      this.currency,
      this.engineSize,
      this.horsepower,
      this.usedCar,
      this.description,
      this.paintCondition,
      this.photos,
      this.changedPart,
      this.externalBodyKit,
      this.salon,
      this.additionalPhones,
      this.time24,
      this.timeFrom,
      this.timeTo,
      this.mediaTools,
      this.modification,
      this.optics,
      this.barter,
      this.isCheaper})
      : super._();

  @override
  CreateCarReq rebuild(void Function(CreateCarReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateCarReqBuilder toBuilder() => new CreateCarReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCarReq &&
        brand == other.brand &&
        carModel == other.carModel &&
        generation == other.generation &&
        configuration == other.configuration &&
        bodyType == other.bodyType &&
        fuelType == other.fuelType &&
        region == other.region &&
        transmission == other.transmission &&
        numberOfOwners == other.numberOfOwners &&
        color == other.color &&
        year == other.year &&
        mileage == other.mileage &&
        price == other.price &&
        currency == other.currency &&
        engineSize == other.engineSize &&
        horsepower == other.horsepower &&
        usedCar == other.usedCar &&
        description == other.description &&
        paintCondition == other.paintCondition &&
        photos == other.photos &&
        changedPart == other.changedPart &&
        externalBodyKit == other.externalBodyKit &&
        salon == other.salon &&
        additionalPhones == other.additionalPhones &&
        time24 == other.time24 &&
        timeFrom == other.timeFrom &&
        timeTo == other.timeTo &&
        mediaTools == other.mediaTools &&
        modification == other.modification &&
        optics == other.optics &&
        barter == other.barter &&
        isCheaper == other.isCheaper;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, configuration.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jc(_$hash, fuelType.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, numberOfOwners.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, mileage.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, engineSize.hashCode);
    _$hash = $jc(_$hash, horsepower.hashCode);
    _$hash = $jc(_$hash, usedCar.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, paintCondition.hashCode);
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jc(_$hash, changedPart.hashCode);
    _$hash = $jc(_$hash, externalBodyKit.hashCode);
    _$hash = $jc(_$hash, salon.hashCode);
    _$hash = $jc(_$hash, additionalPhones.hashCode);
    _$hash = $jc(_$hash, time24.hashCode);
    _$hash = $jc(_$hash, timeFrom.hashCode);
    _$hash = $jc(_$hash, timeTo.hashCode);
    _$hash = $jc(_$hash, mediaTools.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jc(_$hash, optics.hashCode);
    _$hash = $jc(_$hash, barter.hashCode);
    _$hash = $jc(_$hash, isCheaper.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateCarReq')
          ..add('brand', brand)
          ..add('carModel', carModel)
          ..add('generation', generation)
          ..add('configuration', configuration)
          ..add('bodyType', bodyType)
          ..add('fuelType', fuelType)
          ..add('region', region)
          ..add('transmission', transmission)
          ..add('numberOfOwners', numberOfOwners)
          ..add('color', color)
          ..add('year', year)
          ..add('mileage', mileage)
          ..add('price', price)
          ..add('currency', currency)
          ..add('engineSize', engineSize)
          ..add('horsepower', horsepower)
          ..add('usedCar', usedCar)
          ..add('description', description)
          ..add('paintCondition', paintCondition)
          ..add('photos', photos)
          ..add('changedPart', changedPart)
          ..add('externalBodyKit', externalBodyKit)
          ..add('salon', salon)
          ..add('additionalPhones', additionalPhones)
          ..add('time24', time24)
          ..add('timeFrom', timeFrom)
          ..add('timeTo', timeTo)
          ..add('mediaTools', mediaTools)
          ..add('modification', modification)
          ..add('optics', optics)
          ..add('barter', barter)
          ..add('isCheaper', isCheaper))
        .toString();
  }
}

class CreateCarReqBuilder
    implements Builder<CreateCarReq, CreateCarReqBuilder> {
  _$CreateCarReq? _$v;

  int? _brand;
  int? get brand => _$this._brand;
  set brand(int? brand) => _$this._brand = brand;

  int? _carModel;
  int? get carModel => _$this._carModel;
  set carModel(int? carModel) => _$this._carModel = carModel;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  int? _configuration;
  int? get configuration => _$this._configuration;
  set configuration(int? configuration) =>
      _$this._configuration = configuration;

  int? _bodyType;
  int? get bodyType => _$this._bodyType;
  set bodyType(int? bodyType) => _$this._bodyType = bodyType;

  int? _fuelType;
  int? get fuelType => _$this._fuelType;
  set fuelType(int? fuelType) => _$this._fuelType = fuelType;

  int? _region;
  int? get region => _$this._region;
  set region(int? region) => _$this._region = region;

  int? _transmission;
  int? get transmission => _$this._transmission;
  set transmission(int? transmission) => _$this._transmission = transmission;

  String? _numberOfOwners;
  String? get numberOfOwners => _$this._numberOfOwners;
  set numberOfOwners(String? numberOfOwners) =>
      _$this._numberOfOwners = numberOfOwners;

  int? _color;
  int? get color => _$this._color;
  set color(int? color) => _$this._color = color;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  double? _mileage;
  double? get mileage => _$this._mileage;
  set mileage(double? mileage) => _$this._mileage = mileage;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _engineSize;
  String? get engineSize => _$this._engineSize;
  set engineSize(String? engineSize) => _$this._engineSize = engineSize;

  String? _horsepower;
  String? get horsepower => _$this._horsepower;
  set horsepower(String? horsepower) => _$this._horsepower = horsepower;

  bool? _usedCar;
  bool? get usedCar => _$this._usedCar;
  set usedCar(bool? usedCar) => _$this._usedCar = usedCar;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _paintCondition;
  int? get paintCondition => _$this._paintCondition;
  set paintCondition(int? paintCondition) =>
      _$this._paintCondition = paintCondition;

  ListBuilder<ImagesModel>? _photos;
  ListBuilder<ImagesModel> get photos =>
      _$this._photos ??= new ListBuilder<ImagesModel>();
  set photos(ListBuilder<ImagesModel>? photos) => _$this._photos = photos;

  ListBuilder<ChangedPartReq>? _changedPart;
  ListBuilder<ChangedPartReq> get changedPart =>
      _$this._changedPart ??= new ListBuilder<ChangedPartReq>();
  set changedPart(ListBuilder<ChangedPartReq>? changedPart) =>
      _$this._changedPart = changedPart;

  ListBuilder<int>? _externalBodyKit;
  ListBuilder<int> get externalBodyKit =>
      _$this._externalBodyKit ??= new ListBuilder<int>();
  set externalBodyKit(ListBuilder<int>? externalBodyKit) =>
      _$this._externalBodyKit = externalBodyKit;

  ListBuilder<int>? _salon;
  ListBuilder<int> get salon => _$this._salon ??= new ListBuilder<int>();
  set salon(ListBuilder<int>? salon) => _$this._salon = salon;

  ListBuilder<AdditionalPhones>? _additionalPhones;
  ListBuilder<AdditionalPhones> get additionalPhones =>
      _$this._additionalPhones ??= new ListBuilder<AdditionalPhones>();
  set additionalPhones(ListBuilder<AdditionalPhones>? additionalPhones) =>
      _$this._additionalPhones = additionalPhones;

  bool? _time24;
  bool? get time24 => _$this._time24;
  set time24(bool? time24) => _$this._time24 = time24;

  String? _timeFrom;
  String? get timeFrom => _$this._timeFrom;
  set timeFrom(String? timeFrom) => _$this._timeFrom = timeFrom;

  String? _timeTo;
  String? get timeTo => _$this._timeTo;
  set timeTo(String? timeTo) => _$this._timeTo = timeTo;

  ListBuilder<int>? _mediaTools;
  ListBuilder<int> get mediaTools =>
      _$this._mediaTools ??= new ListBuilder<int>();
  set mediaTools(ListBuilder<int>? mediaTools) =>
      _$this._mediaTools = mediaTools;

  int? _modification;
  int? get modification => _$this._modification;
  set modification(int? modification) => _$this._modification = modification;

  ListBuilder<int>? _optics;
  ListBuilder<int> get optics => _$this._optics ??= new ListBuilder<int>();
  set optics(ListBuilder<int>? optics) => _$this._optics = optics;

  bool? _barter;
  bool? get barter => _$this._barter;
  set barter(bool? barter) => _$this._barter = barter;

  bool? _isCheaper;
  bool? get isCheaper => _$this._isCheaper;
  set isCheaper(bool? isCheaper) => _$this._isCheaper = isCheaper;

  CreateCarReqBuilder();

  CreateCarReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _brand = $v.brand;
      _carModel = $v.carModel;
      _generation = $v.generation;
      _configuration = $v.configuration;
      _bodyType = $v.bodyType;
      _fuelType = $v.fuelType;
      _region = $v.region;
      _transmission = $v.transmission;
      _numberOfOwners = $v.numberOfOwners;
      _color = $v.color;
      _year = $v.year;
      _mileage = $v.mileage;
      _price = $v.price;
      _currency = $v.currency;
      _engineSize = $v.engineSize;
      _horsepower = $v.horsepower;
      _usedCar = $v.usedCar;
      _description = $v.description;
      _paintCondition = $v.paintCondition;
      _photos = $v.photos?.toBuilder();
      _changedPart = $v.changedPart?.toBuilder();
      _externalBodyKit = $v.externalBodyKit?.toBuilder();
      _salon = $v.salon?.toBuilder();
      _additionalPhones = $v.additionalPhones?.toBuilder();
      _time24 = $v.time24;
      _timeFrom = $v.timeFrom;
      _timeTo = $v.timeTo;
      _mediaTools = $v.mediaTools?.toBuilder();
      _modification = $v.modification;
      _optics = $v.optics?.toBuilder();
      _barter = $v.barter;
      _isCheaper = $v.isCheaper;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateCarReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateCarReq;
  }

  @override
  void update(void Function(CreateCarReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCarReq build() => _build();

  _$CreateCarReq _build() {
    _$CreateCarReq _$result;
    try {
      _$result = _$v ??
          new _$CreateCarReq._(
              brand: brand,
              carModel: carModel,
              generation: generation,
              configuration: configuration,
              bodyType: bodyType,
              fuelType: fuelType,
              region: region,
              transmission: transmission,
              numberOfOwners: numberOfOwners,
              color: color,
              year: year,
              mileage: mileage,
              price: price,
              currency: currency,
              engineSize: engineSize,
              horsepower: horsepower,
              usedCar: usedCar,
              description: description,
              paintCondition: paintCondition,
              photos: _photos?.build(),
              changedPart: _changedPart?.build(),
              externalBodyKit: _externalBodyKit?.build(),
              salon: _salon?.build(),
              additionalPhones: _additionalPhones?.build(),
              time24: time24,
              timeFrom: timeFrom,
              timeTo: timeTo,
              mediaTools: _mediaTools?.build(),
              modification: modification,
              optics: _optics?.build(),
              barter: barter,
              isCheaper: isCheaper);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photos';
        _photos?.build();
        _$failedField = 'changedPart';
        _changedPart?.build();
        _$failedField = 'externalBodyKit';
        _externalBodyKit?.build();
        _$failedField = 'salon';
        _salon?.build();
        _$failedField = 'additionalPhones';
        _additionalPhones?.build();

        _$failedField = 'mediaTools';
        _mediaTools?.build();

        _$failedField = 'optics';
        _optics?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CreateCarReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CreateCarRes extends CreateCarRes {
  @override
  final int? id;
  @override
  final int? numberOfOwners;
  @override
  final int? year;
  @override
  final int? mileage;
  @override
  final int? price;
  @override
  final String? currency;
  @override
  final int? engineSize;
  @override
  final int? horsepower;
  @override
  final int? rated;
  @override
  final bool? active;
  @override
  final bool? usedCar;
  @override
  final bool? avtoritetDiagnostics;
  @override
  final bool? orientMotorsWarranty;
  @override
  final bool? ownedByOrientMotors;
  @override
  final bool? avtoritetPremiumDiagnostics;
  @override
  final String? description;
  @override
  final bool? time24;
  @override
  final String? timeFrom;
  @override
  final String? timeTo;
  @override
  final String? postedAt;
  @override
  final int? brand;
  @override
  final int? carModel;
  @override
  final int? generation;
  @override
  final int? modification;
  @override
  final int? owner;
  @override
  final int? bodyType;
  @override
  final int? fuelType;
  @override
  final int? region;
  @override
  final int? transmission;
  @override
  final int? color;
  @override
  final int? driveUnit;
  @override
  final int? paintCondition;
  @override
  final BuiltList<int>? likedBy;
  @override
  final BuiltList<int>? mediaTools;
  @override
  final BuiltList<int>? optics;
  @override
  final BuiltList<int>? externalBodyKit;
  @override
  final BuiltList<int>? salon;
  @override
  final BuiltList<int>? vehicleOptions;
  @override
  final BuiltList<int>? changedPart;

  factory _$CreateCarRes([void Function(CreateCarResBuilder)? updates]) =>
      (new CreateCarResBuilder()..update(updates))._build();

  _$CreateCarRes._(
      {this.id,
      this.numberOfOwners,
      this.year,
      this.mileage,
      this.price,
      this.currency,
      this.engineSize,
      this.horsepower,
      this.rated,
      this.active,
      this.usedCar,
      this.avtoritetDiagnostics,
      this.orientMotorsWarranty,
      this.ownedByOrientMotors,
      this.avtoritetPremiumDiagnostics,
      this.description,
      this.time24,
      this.timeFrom,
      this.timeTo,
      this.postedAt,
      this.brand,
      this.carModel,
      this.generation,
      this.modification,
      this.owner,
      this.bodyType,
      this.fuelType,
      this.region,
      this.transmission,
      this.color,
      this.driveUnit,
      this.paintCondition,
      this.likedBy,
      this.mediaTools,
      this.optics,
      this.externalBodyKit,
      this.salon,
      this.vehicleOptions,
      this.changedPart})
      : super._();

  @override
  CreateCarRes rebuild(void Function(CreateCarResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateCarResBuilder toBuilder() => new CreateCarResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCarRes &&
        id == other.id &&
        numberOfOwners == other.numberOfOwners &&
        year == other.year &&
        mileage == other.mileage &&
        price == other.price &&
        currency == other.currency &&
        engineSize == other.engineSize &&
        horsepower == other.horsepower &&
        rated == other.rated &&
        active == other.active &&
        usedCar == other.usedCar &&
        avtoritetDiagnostics == other.avtoritetDiagnostics &&
        orientMotorsWarranty == other.orientMotorsWarranty &&
        ownedByOrientMotors == other.ownedByOrientMotors &&
        avtoritetPremiumDiagnostics == other.avtoritetPremiumDiagnostics &&
        description == other.description &&
        time24 == other.time24 &&
        timeFrom == other.timeFrom &&
        timeTo == other.timeTo &&
        postedAt == other.postedAt &&
        brand == other.brand &&
        carModel == other.carModel &&
        generation == other.generation &&
        modification == other.modification &&
        owner == other.owner &&
        bodyType == other.bodyType &&
        fuelType == other.fuelType &&
        region == other.region &&
        transmission == other.transmission &&
        color == other.color &&
        driveUnit == other.driveUnit &&
        paintCondition == other.paintCondition &&
        likedBy == other.likedBy &&
        mediaTools == other.mediaTools &&
        optics == other.optics &&
        externalBodyKit == other.externalBodyKit &&
        salon == other.salon &&
        vehicleOptions == other.vehicleOptions &&
        changedPart == other.changedPart;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, numberOfOwners.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, mileage.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, engineSize.hashCode);
    _$hash = $jc(_$hash, horsepower.hashCode);
    _$hash = $jc(_$hash, rated.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, usedCar.hashCode);
    _$hash = $jc(_$hash, avtoritetDiagnostics.hashCode);
    _$hash = $jc(_$hash, orientMotorsWarranty.hashCode);
    _$hash = $jc(_$hash, ownedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, avtoritetPremiumDiagnostics.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, time24.hashCode);
    _$hash = $jc(_$hash, timeFrom.hashCode);
    _$hash = $jc(_$hash, timeTo.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jc(_$hash, fuelType.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, driveUnit.hashCode);
    _$hash = $jc(_$hash, paintCondition.hashCode);
    _$hash = $jc(_$hash, likedBy.hashCode);
    _$hash = $jc(_$hash, mediaTools.hashCode);
    _$hash = $jc(_$hash, optics.hashCode);
    _$hash = $jc(_$hash, externalBodyKit.hashCode);
    _$hash = $jc(_$hash, salon.hashCode);
    _$hash = $jc(_$hash, vehicleOptions.hashCode);
    _$hash = $jc(_$hash, changedPart.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateCarRes')
          ..add('id', id)
          ..add('numberOfOwners', numberOfOwners)
          ..add('year', year)
          ..add('mileage', mileage)
          ..add('price', price)
          ..add('currency', currency)
          ..add('engineSize', engineSize)
          ..add('horsepower', horsepower)
          ..add('rated', rated)
          ..add('active', active)
          ..add('usedCar', usedCar)
          ..add('avtoritetDiagnostics', avtoritetDiagnostics)
          ..add('orientMotorsWarranty', orientMotorsWarranty)
          ..add('ownedByOrientMotors', ownedByOrientMotors)
          ..add('avtoritetPremiumDiagnostics', avtoritetPremiumDiagnostics)
          ..add('description', description)
          ..add('time24', time24)
          ..add('timeFrom', timeFrom)
          ..add('timeTo', timeTo)
          ..add('postedAt', postedAt)
          ..add('brand', brand)
          ..add('carModel', carModel)
          ..add('generation', generation)
          ..add('modification', modification)
          ..add('owner', owner)
          ..add('bodyType', bodyType)
          ..add('fuelType', fuelType)
          ..add('region', region)
          ..add('transmission', transmission)
          ..add('color', color)
          ..add('driveUnit', driveUnit)
          ..add('paintCondition', paintCondition)
          ..add('likedBy', likedBy)
          ..add('mediaTools', mediaTools)
          ..add('optics', optics)
          ..add('externalBodyKit', externalBodyKit)
          ..add('salon', salon)
          ..add('vehicleOptions', vehicleOptions)
          ..add('changedPart', changedPart))
        .toString();
  }
}

class CreateCarResBuilder
    implements Builder<CreateCarRes, CreateCarResBuilder> {
  _$CreateCarRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _numberOfOwners;
  int? get numberOfOwners => _$this._numberOfOwners;
  set numberOfOwners(int? numberOfOwners) =>
      _$this._numberOfOwners = numberOfOwners;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _mileage;
  int? get mileage => _$this._mileage;
  set mileage(int? mileage) => _$this._mileage = mileage;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  int? _engineSize;
  int? get engineSize => _$this._engineSize;
  set engineSize(int? engineSize) => _$this._engineSize = engineSize;

  int? _horsepower;
  int? get horsepower => _$this._horsepower;
  set horsepower(int? horsepower) => _$this._horsepower = horsepower;

  int? _rated;
  int? get rated => _$this._rated;
  set rated(int? rated) => _$this._rated = rated;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  bool? _usedCar;
  bool? get usedCar => _$this._usedCar;
  set usedCar(bool? usedCar) => _$this._usedCar = usedCar;

  bool? _avtoritetDiagnostics;
  bool? get avtoritetDiagnostics => _$this._avtoritetDiagnostics;
  set avtoritetDiagnostics(bool? avtoritetDiagnostics) =>
      _$this._avtoritetDiagnostics = avtoritetDiagnostics;

  bool? _orientMotorsWarranty;
  bool? get orientMotorsWarranty => _$this._orientMotorsWarranty;
  set orientMotorsWarranty(bool? orientMotorsWarranty) =>
      _$this._orientMotorsWarranty = orientMotorsWarranty;

  bool? _ownedByOrientMotors;
  bool? get ownedByOrientMotors => _$this._ownedByOrientMotors;
  set ownedByOrientMotors(bool? ownedByOrientMotors) =>
      _$this._ownedByOrientMotors = ownedByOrientMotors;

  bool? _avtoritetPremiumDiagnostics;
  bool? get avtoritetPremiumDiagnostics => _$this._avtoritetPremiumDiagnostics;
  set avtoritetPremiumDiagnostics(bool? avtoritetPremiumDiagnostics) =>
      _$this._avtoritetPremiumDiagnostics = avtoritetPremiumDiagnostics;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _time24;
  bool? get time24 => _$this._time24;
  set time24(bool? time24) => _$this._time24 = time24;

  String? _timeFrom;
  String? get timeFrom => _$this._timeFrom;
  set timeFrom(String? timeFrom) => _$this._timeFrom = timeFrom;

  String? _timeTo;
  String? get timeTo => _$this._timeTo;
  set timeTo(String? timeTo) => _$this._timeTo = timeTo;

  String? _postedAt;
  String? get postedAt => _$this._postedAt;
  set postedAt(String? postedAt) => _$this._postedAt = postedAt;

  int? _brand;
  int? get brand => _$this._brand;
  set brand(int? brand) => _$this._brand = brand;

  int? _carModel;
  int? get carModel => _$this._carModel;
  set carModel(int? carModel) => _$this._carModel = carModel;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  int? _modification;
  int? get modification => _$this._modification;
  set modification(int? modification) => _$this._modification = modification;

  int? _owner;
  int? get owner => _$this._owner;
  set owner(int? owner) => _$this._owner = owner;

  int? _bodyType;
  int? get bodyType => _$this._bodyType;
  set bodyType(int? bodyType) => _$this._bodyType = bodyType;

  int? _fuelType;
  int? get fuelType => _$this._fuelType;
  set fuelType(int? fuelType) => _$this._fuelType = fuelType;

  int? _region;
  int? get region => _$this._region;
  set region(int? region) => _$this._region = region;

  int? _transmission;
  int? get transmission => _$this._transmission;
  set transmission(int? transmission) => _$this._transmission = transmission;

  int? _color;
  int? get color => _$this._color;
  set color(int? color) => _$this._color = color;

  int? _driveUnit;
  int? get driveUnit => _$this._driveUnit;
  set driveUnit(int? driveUnit) => _$this._driveUnit = driveUnit;

  int? _paintCondition;
  int? get paintCondition => _$this._paintCondition;
  set paintCondition(int? paintCondition) =>
      _$this._paintCondition = paintCondition;

  ListBuilder<int>? _likedBy;
  ListBuilder<int> get likedBy => _$this._likedBy ??= new ListBuilder<int>();
  set likedBy(ListBuilder<int>? likedBy) => _$this._likedBy = likedBy;

  ListBuilder<int>? _mediaTools;
  ListBuilder<int> get mediaTools =>
      _$this._mediaTools ??= new ListBuilder<int>();
  set mediaTools(ListBuilder<int>? mediaTools) =>
      _$this._mediaTools = mediaTools;

  ListBuilder<int>? _optics;
  ListBuilder<int> get optics => _$this._optics ??= new ListBuilder<int>();
  set optics(ListBuilder<int>? optics) => _$this._optics = optics;

  ListBuilder<int>? _externalBodyKit;
  ListBuilder<int> get externalBodyKit =>
      _$this._externalBodyKit ??= new ListBuilder<int>();
  set externalBodyKit(ListBuilder<int>? externalBodyKit) =>
      _$this._externalBodyKit = externalBodyKit;

  ListBuilder<int>? _salon;
  ListBuilder<int> get salon => _$this._salon ??= new ListBuilder<int>();
  set salon(ListBuilder<int>? salon) => _$this._salon = salon;

  ListBuilder<int>? _vehicleOptions;
  ListBuilder<int> get vehicleOptions =>
      _$this._vehicleOptions ??= new ListBuilder<int>();
  set vehicleOptions(ListBuilder<int>? vehicleOptions) =>
      _$this._vehicleOptions = vehicleOptions;

  ListBuilder<int>? _changedPart;
  ListBuilder<int> get changedPart =>
      _$this._changedPart ??= new ListBuilder<int>();
  set changedPart(ListBuilder<int>? changedPart) =>
      _$this._changedPart = changedPart;

  CreateCarResBuilder();

  CreateCarResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _numberOfOwners = $v.numberOfOwners;
      _year = $v.year;
      _mileage = $v.mileage;
      _price = $v.price;
      _currency = $v.currency;
      _engineSize = $v.engineSize;
      _horsepower = $v.horsepower;
      _rated = $v.rated;
      _active = $v.active;
      _usedCar = $v.usedCar;
      _avtoritetDiagnostics = $v.avtoritetDiagnostics;
      _orientMotorsWarranty = $v.orientMotorsWarranty;
      _ownedByOrientMotors = $v.ownedByOrientMotors;
      _avtoritetPremiumDiagnostics = $v.avtoritetPremiumDiagnostics;
      _description = $v.description;
      _time24 = $v.time24;
      _timeFrom = $v.timeFrom;
      _timeTo = $v.timeTo;
      _postedAt = $v.postedAt;
      _brand = $v.brand;
      _carModel = $v.carModel;
      _generation = $v.generation;
      _modification = $v.modification;
      _owner = $v.owner;
      _bodyType = $v.bodyType;
      _fuelType = $v.fuelType;
      _region = $v.region;
      _transmission = $v.transmission;
      _color = $v.color;
      _driveUnit = $v.driveUnit;
      _paintCondition = $v.paintCondition;
      _likedBy = $v.likedBy?.toBuilder();
      _mediaTools = $v.mediaTools?.toBuilder();
      _optics = $v.optics?.toBuilder();
      _externalBodyKit = $v.externalBodyKit?.toBuilder();
      _salon = $v.salon?.toBuilder();
      _vehicleOptions = $v.vehicleOptions?.toBuilder();
      _changedPart = $v.changedPart?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateCarRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateCarRes;
  }

  @override
  void update(void Function(CreateCarResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCarRes build() => _build();

  _$CreateCarRes _build() {
    _$CreateCarRes _$result;
    try {
      _$result = _$v ??
          new _$CreateCarRes._(
              id: id,
              numberOfOwners: numberOfOwners,
              year: year,
              mileage: mileage,
              price: price,
              currency: currency,
              engineSize: engineSize,
              horsepower: horsepower,
              rated: rated,
              active: active,
              usedCar: usedCar,
              avtoritetDiagnostics: avtoritetDiagnostics,
              orientMotorsWarranty: orientMotorsWarranty,
              ownedByOrientMotors: ownedByOrientMotors,
              avtoritetPremiumDiagnostics: avtoritetPremiumDiagnostics,
              description: description,
              time24: time24,
              timeFrom: timeFrom,
              timeTo: timeTo,
              postedAt: postedAt,
              brand: brand,
              carModel: carModel,
              generation: generation,
              modification: modification,
              owner: owner,
              bodyType: bodyType,
              fuelType: fuelType,
              region: region,
              transmission: transmission,
              color: color,
              driveUnit: driveUnit,
              paintCondition: paintCondition,
              likedBy: _likedBy?.build(),
              mediaTools: _mediaTools?.build(),
              optics: _optics?.build(),
              externalBodyKit: _externalBodyKit?.build(),
              salon: _salon?.build(),
              vehicleOptions: _vehicleOptions?.build(),
              changedPart: _changedPart?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'likedBy';
        _likedBy?.build();
        _$failedField = 'mediaTools';
        _mediaTools?.build();
        _$failedField = 'optics';
        _optics?.build();
        _$failedField = 'externalBodyKit';
        _externalBodyKit?.build();
        _$failedField = 'salon';
        _salon?.build();
        _$failedField = 'vehicleOptions';
        _vehicleOptions?.build();
        _$failedField = 'changedPart';
        _changedPart?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CreateCarRes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CarModel extends CarModel {
  @override
  final int? id;
  @override
  final BuiltList<AdditionalPhones>? additionalPhones;
  @override
  final Brands? brand;
  @override
  final CarModel? carModel;
  @override
  final GenerationModel? generation;
  @override
  final ModificationModel? modification;
  @override
  final Owner? owner;
  @override
  final NamedModel? bodyType;
  @override
  final NamedModel? fuelType;
  @override
  final NamedModel? region;
  @override
  final NamedModel? transmission;
  @override
  final NamedModel? color;
  @override
  final NamedModel? driveUnit;
  @override
  final int? numberOfOwners;
  @override
  final int? year;
  @override
  final double? mileage;
  @override
  final double? price;
  @override
  final String? currency;
  @override
  final String? name;
  @override
  final int? countOfCars;
  @override
  final double? engineSize;
  @override
  final double? horsepower;
  @override
  final double? rated;
  @override
  final bool? active;
  @override
  final bool? usedCar;
  @override
  final bool? avtoritetDiagnostics;
  @override
  final bool? orientMotorsWarranty;
  @override
  final String? postedAt;
  @override
  final bool? ownedByOrientMotors;
  @override
  final bool? avtoritetPremiumDiagnostics;
  @override
  final String? description;
  @override
  final bool? likedBy;
  @override
  final BuiltList<ImagesModel>? photos;
  @override
  final PaintCondition? paintCondition;
  @override
  final BuiltList<DriveUnitModel>? mediaTools;
  @override
  final BuiltList<DriveUnitModel>? optics;
  @override
  final BuiltList<DriveUnitModel>? externalBodyKit;
  @override
  final BuiltList<DriveUnitModel>? salon;
  @override
  final BuiltList<DriveUnitModel>? vehicleOptions;
  @override
  final bool? time24;
  @override
  final String? timeFrom;
  @override
  final String? timeTo;
  @override
  final bool? barter;
  @override
  final bool? isCheaper;
  @override
  final BuiltList<ChangedPart>? changedPart;
  @override
  final int? totalLikes;
  @override
  final int? totalViews;

  factory _$CarModel([void Function(CarModelBuilder)? updates]) =>
      (new CarModelBuilder()..update(updates))._build();

  _$CarModel._(
      {this.id,
      this.additionalPhones,
      this.brand,
      this.carModel,
      this.generation,
      this.modification,
      this.owner,
      this.bodyType,
      this.fuelType,
      this.region,
      this.transmission,
      this.color,
      this.driveUnit,
      this.numberOfOwners,
      this.year,
      this.mileage,
      this.price,
      this.currency,
      this.name,
      this.countOfCars,
      this.engineSize,
      this.horsepower,
      this.rated,
      this.active,
      this.usedCar,
      this.avtoritetDiagnostics,
      this.orientMotorsWarranty,
      this.postedAt,
      this.ownedByOrientMotors,
      this.avtoritetPremiumDiagnostics,
      this.description,
      this.likedBy,
      this.photos,
      this.paintCondition,
      this.mediaTools,
      this.optics,
      this.externalBodyKit,
      this.salon,
      this.vehicleOptions,
      this.time24,
      this.timeFrom,
      this.timeTo,
      this.barter,
      this.isCheaper,
      this.changedPart,
      this.totalLikes,
      this.totalViews})
      : super._();

  @override
  CarModel rebuild(void Function(CarModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarModelBuilder toBuilder() => new CarModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CarModel &&
        id == other.id &&
        additionalPhones == other.additionalPhones &&
        brand == other.brand &&
        carModel == other.carModel &&
        generation == other.generation &&
        modification == other.modification &&
        owner == other.owner &&
        bodyType == other.bodyType &&
        fuelType == other.fuelType &&
        region == other.region &&
        transmission == other.transmission &&
        color == other.color &&
        driveUnit == other.driveUnit &&
        numberOfOwners == other.numberOfOwners &&
        year == other.year &&
        mileage == other.mileage &&
        price == other.price &&
        currency == other.currency &&
        name == other.name &&
        countOfCars == other.countOfCars &&
        engineSize == other.engineSize &&
        horsepower == other.horsepower &&
        rated == other.rated &&
        active == other.active &&
        usedCar == other.usedCar &&
        avtoritetDiagnostics == other.avtoritetDiagnostics &&
        orientMotorsWarranty == other.orientMotorsWarranty &&
        postedAt == other.postedAt &&
        ownedByOrientMotors == other.ownedByOrientMotors &&
        avtoritetPremiumDiagnostics == other.avtoritetPremiumDiagnostics &&
        description == other.description &&
        likedBy == other.likedBy &&
        photos == other.photos &&
        paintCondition == other.paintCondition &&
        mediaTools == other.mediaTools &&
        optics == other.optics &&
        externalBodyKit == other.externalBodyKit &&
        salon == other.salon &&
        vehicleOptions == other.vehicleOptions &&
        time24 == other.time24 &&
        timeFrom == other.timeFrom &&
        timeTo == other.timeTo &&
        barter == other.barter &&
        isCheaper == other.isCheaper &&
        changedPart == other.changedPart &&
        totalLikes == other.totalLikes &&
        totalViews == other.totalViews;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, additionalPhones.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jc(_$hash, fuelType.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, driveUnit.hashCode);
    _$hash = $jc(_$hash, numberOfOwners.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, mileage.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jc(_$hash, engineSize.hashCode);
    _$hash = $jc(_$hash, horsepower.hashCode);
    _$hash = $jc(_$hash, rated.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, usedCar.hashCode);
    _$hash = $jc(_$hash, avtoritetDiagnostics.hashCode);
    _$hash = $jc(_$hash, orientMotorsWarranty.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, ownedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, avtoritetPremiumDiagnostics.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, likedBy.hashCode);
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jc(_$hash, paintCondition.hashCode);
    _$hash = $jc(_$hash, mediaTools.hashCode);
    _$hash = $jc(_$hash, optics.hashCode);
    _$hash = $jc(_$hash, externalBodyKit.hashCode);
    _$hash = $jc(_$hash, salon.hashCode);
    _$hash = $jc(_$hash, vehicleOptions.hashCode);
    _$hash = $jc(_$hash, time24.hashCode);
    _$hash = $jc(_$hash, timeFrom.hashCode);
    _$hash = $jc(_$hash, timeTo.hashCode);
    _$hash = $jc(_$hash, barter.hashCode);
    _$hash = $jc(_$hash, isCheaper.hashCode);
    _$hash = $jc(_$hash, changedPart.hashCode);
    _$hash = $jc(_$hash, totalLikes.hashCode);
    _$hash = $jc(_$hash, totalViews.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CarModel')
          ..add('id', id)
          ..add('additionalPhones', additionalPhones)
          ..add('brand', brand)
          ..add('carModel', carModel)
          ..add('generation', generation)
          ..add('modification', modification)
          ..add('owner', owner)
          ..add('bodyType', bodyType)
          ..add('fuelType', fuelType)
          ..add('region', region)
          ..add('transmission', transmission)
          ..add('color', color)
          ..add('driveUnit', driveUnit)
          ..add('numberOfOwners', numberOfOwners)
          ..add('year', year)
          ..add('mileage', mileage)
          ..add('price', price)
          ..add('currency', currency)
          ..add('name', name)
          ..add('countOfCars', countOfCars)
          ..add('engineSize', engineSize)
          ..add('horsepower', horsepower)
          ..add('rated', rated)
          ..add('active', active)
          ..add('usedCar', usedCar)
          ..add('avtoritetDiagnostics', avtoritetDiagnostics)
          ..add('orientMotorsWarranty', orientMotorsWarranty)
          ..add('postedAt', postedAt)
          ..add('ownedByOrientMotors', ownedByOrientMotors)
          ..add('avtoritetPremiumDiagnostics', avtoritetPremiumDiagnostics)
          ..add('description', description)
          ..add('likedBy', likedBy)
          ..add('photos', photos)
          ..add('paintCondition', paintCondition)
          ..add('mediaTools', mediaTools)
          ..add('optics', optics)
          ..add('externalBodyKit', externalBodyKit)
          ..add('salon', salon)
          ..add('vehicleOptions', vehicleOptions)
          ..add('time24', time24)
          ..add('timeFrom', timeFrom)
          ..add('timeTo', timeTo)
          ..add('barter', barter)
          ..add('isCheaper', isCheaper)
          ..add('changedPart', changedPart)
          ..add('totalLikes', totalLikes)
          ..add('totalViews', totalViews))
        .toString();
  }
}

class CarModelBuilder implements Builder<CarModel, CarModelBuilder> {
  _$CarModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ListBuilder<AdditionalPhones>? _additionalPhones;
  ListBuilder<AdditionalPhones> get additionalPhones =>
      _$this._additionalPhones ??= new ListBuilder<AdditionalPhones>();
  set additionalPhones(ListBuilder<AdditionalPhones>? additionalPhones) =>
      _$this._additionalPhones = additionalPhones;

  BrandsBuilder? _brand;
  BrandsBuilder get brand => _$this._brand ??= new BrandsBuilder();
  set brand(BrandsBuilder? brand) => _$this._brand = brand;

  CarModelBuilder? _carModel;
  CarModelBuilder get carModel => _$this._carModel ??= new CarModelBuilder();
  set carModel(CarModelBuilder? carModel) => _$this._carModel = carModel;

  GenerationModelBuilder? _generation;
  GenerationModelBuilder get generation =>
      _$this._generation ??= new GenerationModelBuilder();
  set generation(GenerationModelBuilder? generation) =>
      _$this._generation = generation;

  ModificationModelBuilder? _modification;
  ModificationModelBuilder get modification =>
      _$this._modification ??= new ModificationModelBuilder();
  set modification(ModificationModelBuilder? modification) =>
      _$this._modification = modification;

  OwnerBuilder? _owner;
  OwnerBuilder get owner => _$this._owner ??= new OwnerBuilder();
  set owner(OwnerBuilder? owner) => _$this._owner = owner;

  NamedModelBuilder? _bodyType;
  NamedModelBuilder get bodyType =>
      _$this._bodyType ??= new NamedModelBuilder();
  set bodyType(NamedModelBuilder? bodyType) => _$this._bodyType = bodyType;

  NamedModelBuilder? _fuelType;
  NamedModelBuilder get fuelType =>
      _$this._fuelType ??= new NamedModelBuilder();
  set fuelType(NamedModelBuilder? fuelType) => _$this._fuelType = fuelType;

  NamedModelBuilder? _region;
  NamedModelBuilder get region => _$this._region ??= new NamedModelBuilder();
  set region(NamedModelBuilder? region) => _$this._region = region;

  NamedModelBuilder? _transmission;
  NamedModelBuilder get transmission =>
      _$this._transmission ??= new NamedModelBuilder();
  set transmission(NamedModelBuilder? transmission) =>
      _$this._transmission = transmission;

  NamedModelBuilder? _color;
  NamedModelBuilder get color => _$this._color ??= new NamedModelBuilder();
  set color(NamedModelBuilder? color) => _$this._color = color;

  NamedModelBuilder? _driveUnit;
  NamedModelBuilder get driveUnit =>
      _$this._driveUnit ??= new NamedModelBuilder();
  set driveUnit(NamedModelBuilder? driveUnit) => _$this._driveUnit = driveUnit;

  int? _numberOfOwners;
  int? get numberOfOwners => _$this._numberOfOwners;
  set numberOfOwners(int? numberOfOwners) =>
      _$this._numberOfOwners = numberOfOwners;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  double? _mileage;
  double? get mileage => _$this._mileage;
  set mileage(double? mileage) => _$this._mileage = mileage;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  double? _engineSize;
  double? get engineSize => _$this._engineSize;
  set engineSize(double? engineSize) => _$this._engineSize = engineSize;

  double? _horsepower;
  double? get horsepower => _$this._horsepower;
  set horsepower(double? horsepower) => _$this._horsepower = horsepower;

  double? _rated;
  double? get rated => _$this._rated;
  set rated(double? rated) => _$this._rated = rated;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  bool? _usedCar;
  bool? get usedCar => _$this._usedCar;
  set usedCar(bool? usedCar) => _$this._usedCar = usedCar;

  bool? _avtoritetDiagnostics;
  bool? get avtoritetDiagnostics => _$this._avtoritetDiagnostics;
  set avtoritetDiagnostics(bool? avtoritetDiagnostics) =>
      _$this._avtoritetDiagnostics = avtoritetDiagnostics;

  bool? _orientMotorsWarranty;
  bool? get orientMotorsWarranty => _$this._orientMotorsWarranty;
  set orientMotorsWarranty(bool? orientMotorsWarranty) =>
      _$this._orientMotorsWarranty = orientMotorsWarranty;

  String? _postedAt;
  String? get postedAt => _$this._postedAt;
  set postedAt(String? postedAt) => _$this._postedAt = postedAt;

  bool? _ownedByOrientMotors;
  bool? get ownedByOrientMotors => _$this._ownedByOrientMotors;
  set ownedByOrientMotors(bool? ownedByOrientMotors) =>
      _$this._ownedByOrientMotors = ownedByOrientMotors;

  bool? _avtoritetPremiumDiagnostics;
  bool? get avtoritetPremiumDiagnostics => _$this._avtoritetPremiumDiagnostics;
  set avtoritetPremiumDiagnostics(bool? avtoritetPremiumDiagnostics) =>
      _$this._avtoritetPremiumDiagnostics = avtoritetPremiumDiagnostics;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _likedBy;
  bool? get likedBy => _$this._likedBy;
  set likedBy(bool? likedBy) => _$this._likedBy = likedBy;

  ListBuilder<ImagesModel>? _photos;
  ListBuilder<ImagesModel> get photos =>
      _$this._photos ??= new ListBuilder<ImagesModel>();
  set photos(ListBuilder<ImagesModel>? photos) => _$this._photos = photos;

  PaintConditionBuilder? _paintCondition;
  PaintConditionBuilder get paintCondition =>
      _$this._paintCondition ??= new PaintConditionBuilder();
  set paintCondition(PaintConditionBuilder? paintCondition) =>
      _$this._paintCondition = paintCondition;

  ListBuilder<DriveUnitModel>? _mediaTools;
  ListBuilder<DriveUnitModel> get mediaTools =>
      _$this._mediaTools ??= new ListBuilder<DriveUnitModel>();
  set mediaTools(ListBuilder<DriveUnitModel>? mediaTools) =>
      _$this._mediaTools = mediaTools;

  ListBuilder<DriveUnitModel>? _optics;
  ListBuilder<DriveUnitModel> get optics =>
      _$this._optics ??= new ListBuilder<DriveUnitModel>();
  set optics(ListBuilder<DriveUnitModel>? optics) => _$this._optics = optics;

  ListBuilder<DriveUnitModel>? _externalBodyKit;
  ListBuilder<DriveUnitModel> get externalBodyKit =>
      _$this._externalBodyKit ??= new ListBuilder<DriveUnitModel>();
  set externalBodyKit(ListBuilder<DriveUnitModel>? externalBodyKit) =>
      _$this._externalBodyKit = externalBodyKit;

  ListBuilder<DriveUnitModel>? _salon;
  ListBuilder<DriveUnitModel> get salon =>
      _$this._salon ??= new ListBuilder<DriveUnitModel>();
  set salon(ListBuilder<DriveUnitModel>? salon) => _$this._salon = salon;

  ListBuilder<DriveUnitModel>? _vehicleOptions;
  ListBuilder<DriveUnitModel> get vehicleOptions =>
      _$this._vehicleOptions ??= new ListBuilder<DriveUnitModel>();
  set vehicleOptions(ListBuilder<DriveUnitModel>? vehicleOptions) =>
      _$this._vehicleOptions = vehicleOptions;

  bool? _time24;
  bool? get time24 => _$this._time24;
  set time24(bool? time24) => _$this._time24 = time24;

  String? _timeFrom;
  String? get timeFrom => _$this._timeFrom;
  set timeFrom(String? timeFrom) => _$this._timeFrom = timeFrom;

  String? _timeTo;
  String? get timeTo => _$this._timeTo;
  set timeTo(String? timeTo) => _$this._timeTo = timeTo;

  bool? _barter;
  bool? get barter => _$this._barter;
  set barter(bool? barter) => _$this._barter = barter;

  bool? _isCheaper;
  bool? get isCheaper => _$this._isCheaper;
  set isCheaper(bool? isCheaper) => _$this._isCheaper = isCheaper;

  ListBuilder<ChangedPart>? _changedPart;
  ListBuilder<ChangedPart> get changedPart =>
      _$this._changedPart ??= new ListBuilder<ChangedPart>();
  set changedPart(ListBuilder<ChangedPart>? changedPart) =>
      _$this._changedPart = changedPart;

  int? _totalLikes;
  int? get totalLikes => _$this._totalLikes;
  set totalLikes(int? totalLikes) => _$this._totalLikes = totalLikes;

  int? _totalViews;
  int? get totalViews => _$this._totalViews;
  set totalViews(int? totalViews) => _$this._totalViews = totalViews;

  CarModelBuilder();

  CarModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _additionalPhones = $v.additionalPhones?.toBuilder();
      _brand = $v.brand?.toBuilder();
      _carModel = $v.carModel?.toBuilder();
      _generation = $v.generation?.toBuilder();
      _modification = $v.modification?.toBuilder();
      _owner = $v.owner?.toBuilder();
      _bodyType = $v.bodyType?.toBuilder();
      _fuelType = $v.fuelType?.toBuilder();
      _region = $v.region?.toBuilder();
      _transmission = $v.transmission?.toBuilder();
      _color = $v.color?.toBuilder();
      _driveUnit = $v.driveUnit?.toBuilder();
      _numberOfOwners = $v.numberOfOwners;
      _year = $v.year;
      _mileage = $v.mileage;
      _price = $v.price;
      _currency = $v.currency;
      _name = $v.name;
      _countOfCars = $v.countOfCars;
      _engineSize = $v.engineSize;
      _horsepower = $v.horsepower;
      _rated = $v.rated;
      _active = $v.active;
      _usedCar = $v.usedCar;
      _avtoritetDiagnostics = $v.avtoritetDiagnostics;
      _orientMotorsWarranty = $v.orientMotorsWarranty;
      _postedAt = $v.postedAt;
      _ownedByOrientMotors = $v.ownedByOrientMotors;
      _avtoritetPremiumDiagnostics = $v.avtoritetPremiumDiagnostics;
      _description = $v.description;
      _likedBy = $v.likedBy;
      _photos = $v.photos?.toBuilder();
      _paintCondition = $v.paintCondition?.toBuilder();
      _mediaTools = $v.mediaTools?.toBuilder();
      _optics = $v.optics?.toBuilder();
      _externalBodyKit = $v.externalBodyKit?.toBuilder();
      _salon = $v.salon?.toBuilder();
      _vehicleOptions = $v.vehicleOptions?.toBuilder();
      _time24 = $v.time24;
      _timeFrom = $v.timeFrom;
      _timeTo = $v.timeTo;
      _barter = $v.barter;
      _isCheaper = $v.isCheaper;
      _changedPart = $v.changedPart?.toBuilder();
      _totalLikes = $v.totalLikes;
      _totalViews = $v.totalViews;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CarModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CarModel;
  }

  @override
  void update(void Function(CarModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CarModel build() => _build();

  _$CarModel _build() {
    _$CarModel _$result;
    try {
      _$result = _$v ??
          new _$CarModel._(
              id: id,
              additionalPhones: _additionalPhones?.build(),
              brand: _brand?.build(),
              carModel: _carModel?.build(),
              generation: _generation?.build(),
              modification: _modification?.build(),
              owner: _owner?.build(),
              bodyType: _bodyType?.build(),
              fuelType: _fuelType?.build(),
              region: _region?.build(),
              transmission: _transmission?.build(),
              color: _color?.build(),
              driveUnit: _driveUnit?.build(),
              numberOfOwners: numberOfOwners,
              year: year,
              mileage: mileage,
              price: price,
              currency: currency,
              name: name,
              countOfCars: countOfCars,
              engineSize: engineSize,
              horsepower: horsepower,
              rated: rated,
              active: active,
              usedCar: usedCar,
              avtoritetDiagnostics: avtoritetDiagnostics,
              orientMotorsWarranty: orientMotorsWarranty,
              postedAt: postedAt,
              ownedByOrientMotors: ownedByOrientMotors,
              avtoritetPremiumDiagnostics: avtoritetPremiumDiagnostics,
              description: description,
              likedBy: likedBy,
              photos: _photos?.build(),
              paintCondition: _paintCondition?.build(),
              mediaTools: _mediaTools?.build(),
              optics: _optics?.build(),
              externalBodyKit: _externalBodyKit?.build(),
              salon: _salon?.build(),
              vehicleOptions: _vehicleOptions?.build(),
              time24: time24,
              timeFrom: timeFrom,
              timeTo: timeTo,
              barter: barter,
              isCheaper: isCheaper,
              changedPart: _changedPart?.build(),
              totalLikes: totalLikes,
              totalViews: totalViews);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'additionalPhones';
        _additionalPhones?.build();
        _$failedField = 'brand';
        _brand?.build();
        _$failedField = 'carModel';
        _carModel?.build();
        _$failedField = 'generation';
        _generation?.build();
        _$failedField = 'modification';
        _modification?.build();
        _$failedField = 'owner';
        _owner?.build();
        _$failedField = 'bodyType';
        _bodyType?.build();
        _$failedField = 'fuelType';
        _fuelType?.build();
        _$failedField = 'region';
        _region?.build();
        _$failedField = 'transmission';
        _transmission?.build();
        _$failedField = 'color';
        _color?.build();
        _$failedField = 'driveUnit';
        _driveUnit?.build();

        _$failedField = 'photos';
        _photos?.build();
        _$failedField = 'paintCondition';
        _paintCondition?.build();
        _$failedField = 'mediaTools';
        _mediaTools?.build();
        _$failedField = 'optics';
        _optics?.build();
        _$failedField = 'externalBodyKit';
        _externalBodyKit?.build();
        _$failedField = 'salon';
        _salon?.build();
        _$failedField = 'vehicleOptions';
        _vehicleOptions?.build();

        _$failedField = 'changedPart';
        _changedPart?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CarModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Owner extends Owner {
  @override
  final int? id;
  @override
  final String? username;
  @override
  final String? fullName;
  @override
  final String? profilePic;

  factory _$Owner([void Function(OwnerBuilder)? updates]) =>
      (new OwnerBuilder()..update(updates))._build();

  _$Owner._({this.id, this.username, this.fullName, this.profilePic})
      : super._();

  @override
  Owner rebuild(void Function(OwnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OwnerBuilder toBuilder() => new OwnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Owner &&
        id == other.id &&
        username == other.username &&
        fullName == other.fullName &&
        profilePic == other.profilePic;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, profilePic.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Owner')
          ..add('id', id)
          ..add('username', username)
          ..add('fullName', fullName)
          ..add('profilePic', profilePic))
        .toString();
  }
}

class OwnerBuilder implements Builder<Owner, OwnerBuilder> {
  _$Owner? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _profilePic;
  String? get profilePic => _$this._profilePic;
  set profilePic(String? profilePic) => _$this._profilePic = profilePic;

  OwnerBuilder();

  OwnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _fullName = $v.fullName;
      _profilePic = $v.profilePic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Owner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Owner;
  }

  @override
  void update(void Function(OwnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Owner build() => _build();

  _$Owner _build() {
    final _$result = _$v ??
        new _$Owner._(
            id: id,
            username: username,
            fullName: fullName,
            profilePic: profilePic);
    replace(_$result);
    return _$result;
  }
}

class _$AdditionalPhones extends AdditionalPhones {
  @override
  final int? id;
  @override
  final String? number;
  @override
  final int? car;

  factory _$AdditionalPhones(
          [void Function(AdditionalPhonesBuilder)? updates]) =>
      (new AdditionalPhonesBuilder()..update(updates))._build();

  _$AdditionalPhones._({this.id, this.number, this.car}) : super._();

  @override
  AdditionalPhones rebuild(void Function(AdditionalPhonesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdditionalPhonesBuilder toBuilder() =>
      new AdditionalPhonesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdditionalPhones &&
        id == other.id &&
        number == other.number &&
        car == other.car;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, car.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdditionalPhones')
          ..add('id', id)
          ..add('number', number)
          ..add('car', car))
        .toString();
  }
}

class AdditionalPhonesBuilder
    implements Builder<AdditionalPhones, AdditionalPhonesBuilder> {
  _$AdditionalPhones? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  int? _car;
  int? get car => _$this._car;
  set car(int? car) => _$this._car = car;

  AdditionalPhonesBuilder();

  AdditionalPhonesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _number = $v.number;
      _car = $v.car;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdditionalPhones other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdditionalPhones;
  }

  @override
  void update(void Function(AdditionalPhonesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdditionalPhones build() => _build();

  _$AdditionalPhones _build() {
    final _$result =
        _$v ?? new _$AdditionalPhones._(id: id, number: number, car: car);
    replace(_$result);
    return _$result;
  }
}

class _$OptionsModelCarDetail extends OptionsModelCarDetail {
  @override
  final int? id;
  @override
  final bool? electroMirrors;
  @override
  final bool? airbagSide;
  @override
  final bool? hatch;
  @override
  final bool? ledLight;
  @override
  final bool? rainSensor;
  @override
  final bool? aux;
  @override
  final int? modification;

  factory _$OptionsModelCarDetail(
          [void Function(OptionsModelCarDetailBuilder)? updates]) =>
      (new OptionsModelCarDetailBuilder()..update(updates))._build();

  _$OptionsModelCarDetail._(
      {this.id,
      this.electroMirrors,
      this.airbagSide,
      this.hatch,
      this.ledLight,
      this.rainSensor,
      this.aux,
      this.modification})
      : super._();

  @override
  OptionsModelCarDetail rebuild(
          void Function(OptionsModelCarDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OptionsModelCarDetailBuilder toBuilder() =>
      new OptionsModelCarDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OptionsModelCarDetail &&
        id == other.id &&
        electroMirrors == other.electroMirrors &&
        airbagSide == other.airbagSide &&
        hatch == other.hatch &&
        ledLight == other.ledLight &&
        rainSensor == other.rainSensor &&
        aux == other.aux &&
        modification == other.modification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, electroMirrors.hashCode);
    _$hash = $jc(_$hash, airbagSide.hashCode);
    _$hash = $jc(_$hash, hatch.hashCode);
    _$hash = $jc(_$hash, ledLight.hashCode);
    _$hash = $jc(_$hash, rainSensor.hashCode);
    _$hash = $jc(_$hash, aux.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OptionsModelCarDetail')
          ..add('id', id)
          ..add('electroMirrors', electroMirrors)
          ..add('airbagSide', airbagSide)
          ..add('hatch', hatch)
          ..add('ledLight', ledLight)
          ..add('rainSensor', rainSensor)
          ..add('aux', aux)
          ..add('modification', modification))
        .toString();
  }
}

class OptionsModelCarDetailBuilder
    implements Builder<OptionsModelCarDetail, OptionsModelCarDetailBuilder> {
  _$OptionsModelCarDetail? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _electroMirrors;
  bool? get electroMirrors => _$this._electroMirrors;
  set electroMirrors(bool? electroMirrors) =>
      _$this._electroMirrors = electroMirrors;

  bool? _airbagSide;
  bool? get airbagSide => _$this._airbagSide;
  set airbagSide(bool? airbagSide) => _$this._airbagSide = airbagSide;

  bool? _hatch;
  bool? get hatch => _$this._hatch;
  set hatch(bool? hatch) => _$this._hatch = hatch;

  bool? _ledLight;
  bool? get ledLight => _$this._ledLight;
  set ledLight(bool? ledLight) => _$this._ledLight = ledLight;

  bool? _rainSensor;
  bool? get rainSensor => _$this._rainSensor;
  set rainSensor(bool? rainSensor) => _$this._rainSensor = rainSensor;

  bool? _aux;
  bool? get aux => _$this._aux;
  set aux(bool? aux) => _$this._aux = aux;

  int? _modification;
  int? get modification => _$this._modification;
  set modification(int? modification) => _$this._modification = modification;

  OptionsModelCarDetailBuilder();

  OptionsModelCarDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _electroMirrors = $v.electroMirrors;
      _airbagSide = $v.airbagSide;
      _hatch = $v.hatch;
      _ledLight = $v.ledLight;
      _rainSensor = $v.rainSensor;
      _aux = $v.aux;
      _modification = $v.modification;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OptionsModelCarDetail other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OptionsModelCarDetail;
  }

  @override
  void update(void Function(OptionsModelCarDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OptionsModelCarDetail build() => _build();

  _$OptionsModelCarDetail _build() {
    final _$result = _$v ??
        new _$OptionsModelCarDetail._(
            id: id,
            electroMirrors: electroMirrors,
            airbagSide: airbagSide,
            hatch: hatch,
            ledLight: ledLight,
            rainSensor: rainSensor,
            aux: aux,
            modification: modification);
    replace(_$result);
    return _$result;
  }
}

class _$PaintCondition extends PaintCondition {
  @override
  final int? id;
  @override
  final String? title;

  factory _$PaintCondition([void Function(PaintConditionBuilder)? updates]) =>
      (new PaintConditionBuilder()..update(updates))._build();

  _$PaintCondition._({this.id, this.title}) : super._();

  @override
  PaintCondition rebuild(void Function(PaintConditionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaintConditionBuilder toBuilder() =>
      new PaintConditionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaintCondition && id == other.id && title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaintCondition')
          ..add('id', id)
          ..add('title', title))
        .toString();
  }
}

class PaintConditionBuilder
    implements Builder<PaintCondition, PaintConditionBuilder> {
  _$PaintCondition? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  PaintConditionBuilder();

  PaintConditionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaintCondition other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaintCondition;
  }

  @override
  void update(void Function(PaintConditionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaintCondition build() => _build();

  _$PaintCondition _build() {
    final _$result = _$v ?? new _$PaintCondition._(id: id, title: title);
    replace(_$result);
    return _$result;
  }
}

class _$ChangedPart extends ChangedPart {
  @override
  final int? id;
  @override
  final String? description;
  @override
  final NamedModel? changedPart;
  @override
  final NamedModel? changedPartQuality;

  factory _$ChangedPart([void Function(ChangedPartBuilder)? updates]) =>
      (new ChangedPartBuilder()..update(updates))._build();

  _$ChangedPart._(
      {this.id, this.description, this.changedPart, this.changedPartQuality})
      : super._();

  @override
  ChangedPart rebuild(void Function(ChangedPartBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangedPartBuilder toBuilder() => new ChangedPartBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangedPart &&
        id == other.id &&
        description == other.description &&
        changedPart == other.changedPart &&
        changedPartQuality == other.changedPartQuality;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, changedPart.hashCode);
    _$hash = $jc(_$hash, changedPartQuality.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangedPart')
          ..add('id', id)
          ..add('description', description)
          ..add('changedPart', changedPart)
          ..add('changedPartQuality', changedPartQuality))
        .toString();
  }
}

class ChangedPartBuilder implements Builder<ChangedPart, ChangedPartBuilder> {
  _$ChangedPart? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  NamedModelBuilder? _changedPart;
  NamedModelBuilder get changedPart =>
      _$this._changedPart ??= new NamedModelBuilder();
  set changedPart(NamedModelBuilder? changedPart) =>
      _$this._changedPart = changedPart;

  NamedModelBuilder? _changedPartQuality;
  NamedModelBuilder get changedPartQuality =>
      _$this._changedPartQuality ??= new NamedModelBuilder();
  set changedPartQuality(NamedModelBuilder? changedPartQuality) =>
      _$this._changedPartQuality = changedPartQuality;

  ChangedPartBuilder();

  ChangedPartBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _description = $v.description;
      _changedPart = $v.changedPart?.toBuilder();
      _changedPartQuality = $v.changedPartQuality?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangedPart other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChangedPart;
  }

  @override
  void update(void Function(ChangedPartBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangedPart build() => _build();

  _$ChangedPart _build() {
    _$ChangedPart _$result;
    try {
      _$result = _$v ??
          new _$ChangedPart._(
              id: id,
              description: description,
              changedPart: _changedPart?.build(),
              changedPartQuality: _changedPartQuality?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'changedPart';
        _changedPart?.build();
        _$failedField = 'changedPartQuality';
        _changedPartQuality?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ChangedPart', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ChangedPartReq extends ChangedPartReq {
  @override
  final int? id;
  @override
  final int? partId;
  @override
  final int? qualityId;
  @override
  final String? description;

  factory _$ChangedPartReq([void Function(ChangedPartReqBuilder)? updates]) =>
      (new ChangedPartReqBuilder()..update(updates))._build();

  _$ChangedPartReq._({this.id, this.partId, this.qualityId, this.description})
      : super._();

  @override
  ChangedPartReq rebuild(void Function(ChangedPartReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangedPartReqBuilder toBuilder() =>
      new ChangedPartReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangedPartReq &&
        id == other.id &&
        partId == other.partId &&
        qualityId == other.qualityId &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, partId.hashCode);
    _$hash = $jc(_$hash, qualityId.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangedPartReq')
          ..add('id', id)
          ..add('partId', partId)
          ..add('qualityId', qualityId)
          ..add('description', description))
        .toString();
  }
}

class ChangedPartReqBuilder
    implements Builder<ChangedPartReq, ChangedPartReqBuilder> {
  _$ChangedPartReq? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _partId;
  int? get partId => _$this._partId;
  set partId(int? partId) => _$this._partId = partId;

  int? _qualityId;
  int? get qualityId => _$this._qualityId;
  set qualityId(int? qualityId) => _$this._qualityId = qualityId;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ChangedPartReqBuilder();

  ChangedPartReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _partId = $v.partId;
      _qualityId = $v.qualityId;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangedPartReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChangedPartReq;
  }

  @override
  void update(void Function(ChangedPartReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangedPartReq build() => _build();

  _$ChangedPartReq _build() {
    final _$result = _$v ??
        new _$ChangedPartReq._(
            id: id,
            partId: partId,
            qualityId: qualityId,
            description: description);
    replace(_$result);
    return _$result;
  }
}

class _$CarResResult extends CarResResult {
  @override
  final int? count;
  @override
  final String? next;
  @override
  final String? previous;
  @override
  final BuiltList<CarModel>? results;

  factory _$CarResResult([void Function(CarResResultBuilder)? updates]) =>
      (new CarResResultBuilder()..update(updates))._build();

  _$CarResResult._({this.count, this.next, this.previous, this.results})
      : super._();

  @override
  CarResResult rebuild(void Function(CarResResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarResResultBuilder toBuilder() => new CarResResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CarResResult &&
        count == other.count &&
        next == other.next &&
        previous == other.previous &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, next.hashCode);
    _$hash = $jc(_$hash, previous.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CarResResult')
          ..add('count', count)
          ..add('next', next)
          ..add('previous', previous)
          ..add('results', results))
        .toString();
  }
}

class CarResResultBuilder
    implements Builder<CarResResult, CarResResultBuilder> {
  _$CarResResult? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _next;
  String? get next => _$this._next;
  set next(String? next) => _$this._next = next;

  String? _previous;
  String? get previous => _$this._previous;
  set previous(String? previous) => _$this._previous = previous;

  ListBuilder<CarModel>? _results;
  ListBuilder<CarModel> get results =>
      _$this._results ??= new ListBuilder<CarModel>();
  set results(ListBuilder<CarModel>? results) => _$this._results = results;

  CarResResultBuilder();

  CarResResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _next = $v.next;
      _previous = $v.previous;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CarResResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CarResResult;
  }

  @override
  void update(void Function(CarResResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CarResResult build() => _build();

  _$CarResResult _build() {
    _$CarResResult _$result;
    try {
      _$result = _$v ??
          new _$CarResResult._(
              count: count,
              next: next,
              previous: previous,
              results: _results?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CarResResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$QuestionModel extends QuestionModel {
  @override
  final int? id;
  @override
  final String? question;

  factory _$QuestionModel([void Function(QuestionModelBuilder)? updates]) =>
      (new QuestionModelBuilder()..update(updates))._build();

  _$QuestionModel._({this.id, this.question}) : super._();

  @override
  QuestionModel rebuild(void Function(QuestionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuestionModelBuilder toBuilder() => new QuestionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuestionModel &&
        id == other.id &&
        question == other.question;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, question.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuestionModel')
          ..add('id', id)
          ..add('question', question))
        .toString();
  }
}

class QuestionModelBuilder
    implements Builder<QuestionModel, QuestionModelBuilder> {
  _$QuestionModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _question;
  String? get question => _$this._question;
  set question(String? question) => _$this._question = question;

  QuestionModelBuilder();

  QuestionModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _question = $v.question;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuestionModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QuestionModel;
  }

  @override
  void update(void Function(QuestionModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuestionModel build() => _build();

  _$QuestionModel _build() {
    final _$result = _$v ?? new _$QuestionModel._(id: id, question: question);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

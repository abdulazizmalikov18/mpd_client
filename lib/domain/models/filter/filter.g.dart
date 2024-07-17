// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FilterRes> _$filterResSerializer = new _$FilterResSerializer();
Serializer<Cars> _$carsSerializer = new _$CarsSerializer();
Serializer<NamedModel> _$namedModelSerializer = new _$NamedModelSerializer();
Serializer<Brands> _$brandsSerializer = new _$BrandsSerializer();
Serializer<Condition> _$conditionSerializer = new _$ConditionSerializer();
Serializer<CarModels> _$carModelsSerializer = new _$CarModelsSerializer();
Serializer<GenerationModel> _$generationModelSerializer =
    new _$GenerationModelSerializer();
Serializer<ImagesModel> _$imagesModelSerializer = new _$ImagesModelSerializer();
Serializer<TotalCarsRes> _$totalCarsResSerializer =
    new _$TotalCarsResSerializer();
Serializer<OwnerModel> _$ownerModelSerializer = new _$OwnerModelSerializer();
Serializer<FilterSearchReq> _$filterSearchReqSerializer =
    new _$FilterSearchReqSerializer();
Serializer<FilterSearchRes> _$filterSearchResSerializer =
    new _$FilterSearchResSerializer();
Serializer<Region> _$regionSerializer = new _$RegionSerializer();
Serializer<Services> _$servicesSerializer = new _$ServicesSerializer();
Serializer<BodyType> _$bodyTypeSerializer = new _$BodyTypeSerializer();
Serializer<SearchList> _$searchListSerializer = new _$SearchListSerializer();

class _$FilterResSerializer implements StructuredSerializer<FilterRes> {
  @override
  final Iterable<Type> types = const [FilterRes, _$FilterRes];
  @override
  final String wireName = 'FilterRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, FilterRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.cars;
    if (value != null) {
      result
        ..add('cars')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Cars)));
    }
    value = object.regions;
    if (value != null) {
      result
        ..add('regions')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.brands;
    if (value != null) {
      result
        ..add('brands')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Brands)])));
    }
    value = object.fuelTypes;
    if (value != null) {
      result
        ..add('fuel_types')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.colors;
    if (value != null) {
      result
        ..add('colors')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.transmissions;
    if (value != null) {
      result
        ..add('transmissions')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.bodyTypes;
    if (value != null) {
      result
        ..add('body_types')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.services;
    if (value != null) {
      result
        ..add('services')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ServicesRes)])));
    }
    value = object.condition;
    if (value != null) {
      result
        ..add('condition')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Condition)])));
    }
    return result;
  }

  @override
  FilterRes deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FilterResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'cars':
          result.cars.replace(serializers.deserialize(value,
              specifiedType: const FullType(Cars))! as Cars);
          break;
        case 'regions':
          result.regions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'brands':
          result.brands.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Brands)]))!
              as BuiltList<Object?>);
          break;
        case 'fuel_types':
          result.fuelTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'colors':
          result.colors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'transmissions':
          result.transmissions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'body_types':
          result.bodyTypes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'services':
          result.services.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ServicesRes)]))!
              as BuiltList<Object?>);
          break;
        case 'condition':
          result.condition.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Condition)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$CarsSerializer implements StructuredSerializer<Cars> {
  @override
  final Iterable<Type> types = const [Cars, _$Cars];
  @override
  final String wireName = 'Cars';

  @override
  Iterable<Object?> serialize(Serializers serializers, Cars object,
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
    value = object.totalPageCount;
    if (value != null) {
      result
        ..add('total_page_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  Cars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarsBuilder();

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
        case 'total_page_count':
          result.totalPageCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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

class _$NamedModelSerializer implements StructuredSerializer<NamedModel> {
  @override
  final Iterable<Type> types = const [NamedModel, _$NamedModel];
  @override
  final String wireName = 'NamedModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, NamedModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NamedModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NamedModelBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$BrandsSerializer implements StructuredSerializer<Brands> {
  @override
  final Iterable<Type> types = const [Brands, _$Brands];
  @override
  final String wireName = 'Brands';

  @override
  Iterable<Object?> serialize(Serializers serializers, Brands object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.carModels;
    if (value != null) {
      result
        ..add('car_models')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(CarModels)])));
    }
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.top;
    if (value != null) {
      result
        ..add('top')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Brands deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrandsBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_models':
          result.carModels.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CarModels)]))!
              as BuiltList<Object?>);
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'top':
          result.top = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ConditionSerializer implements StructuredSerializer<Condition> {
  @override
  final Iterable<Type> types = const [Condition, _$Condition];
  @override
  final String wireName = 'Condition';

  @override
  Iterable<Object?> serialize(Serializers serializers, Condition object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.isUsed;
    if (value != null) {
      result
        ..add('is_used')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Condition deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConditionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'is_used':
          result.isUsed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$CarModelsSerializer implements StructuredSerializer<CarModels> {
  @override
  final Iterable<Type> types = const [CarModels, _$CarModels];
  @override
  final String wireName = 'CarModels';

  @override
  Iterable<Object?> serialize(Serializers serializers, CarModels object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.top;
    if (value != null) {
      result
        ..add('top')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.generations;
    if (value != null) {
      result
        ..add('generations')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CarModels deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarModelsBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'top':
          result.top = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'generations':
          result.generations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GenerationModelSerializer
    implements StructuredSerializer<GenerationModel> {
  @override
  final Iterable<Type> types = const [GenerationModel, _$GenerationModel];
  @override
  final String wireName = 'GenerationModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, GenerationModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.yearStart;
    if (value != null) {
      result
        ..add('year_start')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.yearStop;
    if (value != null) {
      result
        ..add('year_stop')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isrestyle;
    if (value != null) {
      result
        ..add('isrestyle')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.apiGenerationId;
    if (value != null) {
      result
        ..add('api_generation_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.carModel;
    if (value != null) {
      result
        ..add('car_model')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GenerationModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GenerationModelBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'year_start':
          result.yearStart = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year_stop':
          result.yearStop = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'isrestyle':
          result.isrestyle = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'api_generation_id':
          result.apiGenerationId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_model':
          result.carModel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ImagesModelSerializer implements StructuredSerializer<ImagesModel> {
  @override
  final Iterable<Type> types = const [ImagesModel, _$ImagesModel];
  @override
  final String wireName = 'ImagesModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ImagesModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
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
  ImagesModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImagesModelBuilder();

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
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
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

class _$TotalCarsResSerializer implements StructuredSerializer<TotalCarsRes> {
  @override
  final Iterable<Type> types = const [TotalCarsRes, _$TotalCarsRes];
  @override
  final String wireName = 'TotalCarsRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, TotalCarsRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.countIn24;
    if (value != null) {
      result
        ..add('count_in_24')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  TotalCarsRes deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TotalCarsResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'count_in_24':
          result.countIn24 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$OwnerModelSerializer implements StructuredSerializer<OwnerModel> {
  @override
  final Iterable<Type> types = const [OwnerModel, _$OwnerModel];
  @override
  final String wireName = 'OwnerModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, OwnerModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastLogin;
    if (value != null) {
      result
        ..add('last_login')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isSuperuser;
    if (value != null) {
      result
        ..add('is_superuser')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.firstName;
    if (value != null) {
      result
        ..add('first_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastName;
    if (value != null) {
      result
        ..add('last_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isStaff;
    if (value != null) {
      result
        ..add('is_staff')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isActive;
    if (value != null) {
      result
        ..add('is_active')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.dateJoined;
    if (value != null) {
      result
        ..add('date_joined')
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
    value = object.sellertype;
    if (value != null) {
      result
        ..add('sellertype')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.groups;
    if (value != null) {
      result
        ..add('groups')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(dynamic)])));
    }
    value = object.userPermissions;
    if (value != null) {
      result
        ..add('user_permissions')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(dynamic)])));
    }
    return result;
  }

  @override
  OwnerModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OwnerModelBuilder();

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
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'last_login':
          result.lastLogin = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'is_superuser':
          result.isSuperuser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'is_staff':
          result.isStaff = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'is_active':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'date_joined':
          result.dateJoined = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'sellertype':
          result.sellertype = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'groups':
          result.groups.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(dynamic)]))!
              as BuiltList<Object?>);
          break;
        case 'user_permissions':
          result.userPermissions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(dynamic)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$FilterSearchReqSerializer
    implements StructuredSerializer<FilterSearchReq> {
  @override
  final Iterable<Type> types = const [FilterSearchReq, _$FilterSearchReq];
  @override
  final String wireName = 'FilterSearchReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, FilterSearchReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.yearFrom;
    if (value != null) {
      result
        ..add('year_from')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.yearTo;
    if (value != null) {
      result
        ..add('year_to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.priceFrom;
    if (value != null) {
      result
        ..add('price_from')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.priceTo;
    if (value != null) {
      result
        ..add('price_to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.currency;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mileageFrom;
    if (value != null) {
      result
        ..add('mileage_from')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mileageTo;
    if (value != null) {
      result
        ..add('mileage_to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.condition;
    if (value != null) {
      result
        ..add('condition')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.services;
    if (value != null) {
      result
        ..add('services')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.fuel;
    if (value != null) {
      result
        ..add('fuel')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body_type')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    return result;
  }

  @override
  FilterSearchReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FilterSearchReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'year_from':
          result.yearFrom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year_to':
          result.yearTo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'price_from':
          result.priceFrom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'price_to':
          result.priceTo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mileage_from':
          result.mileageFrom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mileage_to':
          result.mileageTo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'condition':
          result.condition = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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
          result.generation.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'region':
          result.region.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'services':
          result.services.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'fuel':
          result.fuel.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'color':
          result.color.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'transmission':
          result.transmission.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'body_type':
          result.bodyType.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$FilterSearchResSerializer
    implements StructuredSerializer<FilterSearchRes> {
  @override
  final Iterable<Type> types = const [FilterSearchRes, _$FilterSearchRes];
  @override
  final String wireName = 'FilterSearchRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, FilterSearchRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'brand',
      serializers.serialize(object.brand,
          specifiedType: const FullType(Brands)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
            specifiedType: const FullType(
                BuiltList, const [const FullType(GenerationModel)])));
    }
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Region)])));
    }
    value = object.services;
    if (value != null) {
      result
        ..add('services')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Services)])));
    }
    value = object.fuel;
    if (value != null) {
      result
        ..add('fuel')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Region)])));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(NamedModel)])));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body_type')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(BodyType)])));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Region)])));
    }
    value = object.yearFrom;
    if (value != null) {
      result
        ..add('year_from')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.yearTo;
    if (value != null) {
      result
        ..add('year_to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.priceFrom;
    if (value != null) {
      result
        ..add('price_from')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.priceTo;
    if (value != null) {
      result
        ..add('price_to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.currency;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mileageFrom;
    if (value != null) {
      result
        ..add('mileage_from')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mileageTo;
    if (value != null) {
      result
        ..add('mileage_to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.condition;
    if (value != null) {
      result
        ..add('condition')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  FilterSearchRes deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FilterSearchResBuilder();

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
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GenerationModel)]))!
              as BuiltList<Object?>);
          break;
        case 'region':
          result.region.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Region)]))!
              as BuiltList<Object?>);
          break;
        case 'services':
          result.services.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Services)]))!
              as BuiltList<Object?>);
          break;
        case 'fuel':
          result.fuel.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Region)]))!
              as BuiltList<Object?>);
          break;
        case 'color':
          result.color.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NamedModel)]))!
              as BuiltList<Object?>);
          break;
        case 'body_type':
          result.bodyType.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BodyType)]))!
              as BuiltList<Object?>);
          break;
        case 'transmission':
          result.transmission.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Region)]))!
              as BuiltList<Object?>);
          break;
        case 'year_from':
          result.yearFrom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year_to':
          result.yearTo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'price_from':
          result.priceFrom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'price_to':
          result.priceTo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mileage_from':
          result.mileageFrom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mileage_to':
          result.mileageTo = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'condition':
          result.condition = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$RegionSerializer implements StructuredSerializer<Region> {
  @override
  final Iterable<Type> types = const [Region, _$Region];
  @override
  final String wireName = 'Region';

  @override
  Iterable<Object?> serialize(Serializers serializers, Region object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Region deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RegionBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ServicesSerializer implements StructuredSerializer<Services> {
  @override
  final Iterable<Type> types = const [Services, _$Services];
  @override
  final String wireName = 'Services';

  @override
  Iterable<Object?> serialize(Serializers serializers, Services object,
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
  Services deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ServicesBuilder();

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
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$BodyTypeSerializer implements StructuredSerializer<BodyType> {
  @override
  final Iterable<Type> types = const [BodyType, _$BodyType];
  @override
  final String wireName = 'BodyType';

  @override
  Iterable<Object?> serialize(Serializers serializers, BodyType object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
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
  BodyType deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BodyTypeBuilder();

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

class _$SearchListSerializer implements StructuredSerializer<SearchList> {
  @override
  final Iterable<Type> types = const [SearchList, _$SearchList];
  @override
  final String wireName = 'SearchList';

  @override
  Iterable<Object?> serialize(Serializers serializers, SearchList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.carModel;
    if (value != null) {
      result
        ..add('car_model')
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
    value = object.yearStart;
    if (value != null) {
      result
        ..add('year_start')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.yearStop;
    if (value != null) {
      result
        ..add('year_stop')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.brandId;
    if (value != null) {
      result
        ..add('brand_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.carModelId;
    if (value != null) {
      result
        ..add('car_model_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SearchList deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchListBuilder();

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
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_model':
          result.carModel = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'year_start':
          result.yearStart = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'year_stop':
          result.yearStop = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'brand_id':
          result.brandId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'car_model_id':
          result.carModelId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$FilterRes extends FilterRes {
  @override
  final Cars? cars;
  @override
  final BuiltList<NamedModel>? regions;
  @override
  final BuiltList<Brands>? brands;
  @override
  final BuiltList<NamedModel>? fuelTypes;
  @override
  final BuiltList<NamedModel>? colors;
  @override
  final BuiltList<NamedModel>? transmissions;
  @override
  final BuiltList<NamedModel>? bodyTypes;
  @override
  final BuiltList<ServicesRes>? services;
  @override
  final BuiltList<Condition>? condition;

  factory _$FilterRes([void Function(FilterResBuilder)? updates]) =>
      (new FilterResBuilder()..update(updates))._build();

  _$FilterRes._(
      {this.cars,
      this.regions,
      this.brands,
      this.fuelTypes,
      this.colors,
      this.transmissions,
      this.bodyTypes,
      this.services,
      this.condition})
      : super._();

  @override
  FilterRes rebuild(void Function(FilterResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FilterResBuilder toBuilder() => new FilterResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FilterRes &&
        cars == other.cars &&
        regions == other.regions &&
        brands == other.brands &&
        fuelTypes == other.fuelTypes &&
        colors == other.colors &&
        transmissions == other.transmissions &&
        bodyTypes == other.bodyTypes &&
        services == other.services &&
        condition == other.condition;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cars.hashCode);
    _$hash = $jc(_$hash, regions.hashCode);
    _$hash = $jc(_$hash, brands.hashCode);
    _$hash = $jc(_$hash, fuelTypes.hashCode);
    _$hash = $jc(_$hash, colors.hashCode);
    _$hash = $jc(_$hash, transmissions.hashCode);
    _$hash = $jc(_$hash, bodyTypes.hashCode);
    _$hash = $jc(_$hash, services.hashCode);
    _$hash = $jc(_$hash, condition.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FilterRes')
          ..add('cars', cars)
          ..add('regions', regions)
          ..add('brands', brands)
          ..add('fuelTypes', fuelTypes)
          ..add('colors', colors)
          ..add('transmissions', transmissions)
          ..add('bodyTypes', bodyTypes)
          ..add('services', services)
          ..add('condition', condition))
        .toString();
  }
}

class FilterResBuilder implements Builder<FilterRes, FilterResBuilder> {
  _$FilterRes? _$v;

  CarsBuilder? _cars;
  CarsBuilder get cars => _$this._cars ??= new CarsBuilder();
  set cars(CarsBuilder? cars) => _$this._cars = cars;

  ListBuilder<NamedModel>? _regions;
  ListBuilder<NamedModel> get regions =>
      _$this._regions ??= new ListBuilder<NamedModel>();
  set regions(ListBuilder<NamedModel>? regions) => _$this._regions = regions;

  ListBuilder<Brands>? _brands;
  ListBuilder<Brands> get brands =>
      _$this._brands ??= new ListBuilder<Brands>();
  set brands(ListBuilder<Brands>? brands) => _$this._brands = brands;

  ListBuilder<NamedModel>? _fuelTypes;
  ListBuilder<NamedModel> get fuelTypes =>
      _$this._fuelTypes ??= new ListBuilder<NamedModel>();
  set fuelTypes(ListBuilder<NamedModel>? fuelTypes) =>
      _$this._fuelTypes = fuelTypes;

  ListBuilder<NamedModel>? _colors;
  ListBuilder<NamedModel> get colors =>
      _$this._colors ??= new ListBuilder<NamedModel>();
  set colors(ListBuilder<NamedModel>? colors) => _$this._colors = colors;

  ListBuilder<NamedModel>? _transmissions;
  ListBuilder<NamedModel> get transmissions =>
      _$this._transmissions ??= new ListBuilder<NamedModel>();
  set transmissions(ListBuilder<NamedModel>? transmissions) =>
      _$this._transmissions = transmissions;

  ListBuilder<NamedModel>? _bodyTypes;
  ListBuilder<NamedModel> get bodyTypes =>
      _$this._bodyTypes ??= new ListBuilder<NamedModel>();
  set bodyTypes(ListBuilder<NamedModel>? bodyTypes) =>
      _$this._bodyTypes = bodyTypes;

  ListBuilder<ServicesRes>? _services;
  ListBuilder<ServicesRes> get services =>
      _$this._services ??= new ListBuilder<ServicesRes>();
  set services(ListBuilder<ServicesRes>? services) =>
      _$this._services = services;

  ListBuilder<Condition>? _condition;
  ListBuilder<Condition> get condition =>
      _$this._condition ??= new ListBuilder<Condition>();
  set condition(ListBuilder<Condition>? condition) =>
      _$this._condition = condition;

  FilterResBuilder();

  FilterResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cars = $v.cars?.toBuilder();
      _regions = $v.regions?.toBuilder();
      _brands = $v.brands?.toBuilder();
      _fuelTypes = $v.fuelTypes?.toBuilder();
      _colors = $v.colors?.toBuilder();
      _transmissions = $v.transmissions?.toBuilder();
      _bodyTypes = $v.bodyTypes?.toBuilder();
      _services = $v.services?.toBuilder();
      _condition = $v.condition?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FilterRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FilterRes;
  }

  @override
  void update(void Function(FilterResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FilterRes build() => _build();

  _$FilterRes _build() {
    _$FilterRes _$result;
    try {
      _$result = _$v ??
          new _$FilterRes._(
              cars: _cars?.build(),
              regions: _regions?.build(),
              brands: _brands?.build(),
              fuelTypes: _fuelTypes?.build(),
              colors: _colors?.build(),
              transmissions: _transmissions?.build(),
              bodyTypes: _bodyTypes?.build(),
              services: _services?.build(),
              condition: _condition?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cars';
        _cars?.build();
        _$failedField = 'regions';
        _regions?.build();
        _$failedField = 'brands';
        _brands?.build();
        _$failedField = 'fuelTypes';
        _fuelTypes?.build();
        _$failedField = 'colors';
        _colors?.build();
        _$failedField = 'transmissions';
        _transmissions?.build();
        _$failedField = 'bodyTypes';
        _bodyTypes?.build();
        _$failedField = 'services';
        _services?.build();
        _$failedField = 'condition';
        _condition?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FilterRes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Cars extends Cars {
  @override
  final int? count;
  @override
  final String? next;
  @override
  final String? previous;
  @override
  final int? totalPageCount;
  @override
  final BuiltList<CarModel>? results;

  factory _$Cars([void Function(CarsBuilder)? updates]) =>
      (new CarsBuilder()..update(updates))._build();

  _$Cars._(
      {this.count, this.next, this.previous, this.totalPageCount, this.results})
      : super._();

  @override
  Cars rebuild(void Function(CarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarsBuilder toBuilder() => new CarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Cars &&
        count == other.count &&
        next == other.next &&
        previous == other.previous &&
        totalPageCount == other.totalPageCount &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, next.hashCode);
    _$hash = $jc(_$hash, previous.hashCode);
    _$hash = $jc(_$hash, totalPageCount.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Cars')
          ..add('count', count)
          ..add('next', next)
          ..add('previous', previous)
          ..add('totalPageCount', totalPageCount)
          ..add('results', results))
        .toString();
  }
}

class CarsBuilder implements Builder<Cars, CarsBuilder> {
  _$Cars? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _next;
  String? get next => _$this._next;
  set next(String? next) => _$this._next = next;

  String? _previous;
  String? get previous => _$this._previous;
  set previous(String? previous) => _$this._previous = previous;

  int? _totalPageCount;
  int? get totalPageCount => _$this._totalPageCount;
  set totalPageCount(int? totalPageCount) =>
      _$this._totalPageCount = totalPageCount;

  ListBuilder<CarModel>? _results;
  ListBuilder<CarModel> get results =>
      _$this._results ??= new ListBuilder<CarModel>();
  set results(ListBuilder<CarModel>? results) => _$this._results = results;

  CarsBuilder();

  CarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _next = $v.next;
      _previous = $v.previous;
      _totalPageCount = $v.totalPageCount;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Cars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Cars;
  }

  @override
  void update(void Function(CarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Cars build() => _build();

  _$Cars _build() {
    _$Cars _$result;
    try {
      _$result = _$v ??
          new _$Cars._(
              count: count,
              next: next,
              previous: previous,
              totalPageCount: totalPageCount,
              results: _results?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Cars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NamedModel extends NamedModel {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? countOfCars;
  @override
  final String? code;

  factory _$NamedModel([void Function(NamedModelBuilder)? updates]) =>
      (new NamedModelBuilder()..update(updates))._build();

  _$NamedModel._({this.id, this.name, this.countOfCars, this.code}) : super._();

  @override
  NamedModel rebuild(void Function(NamedModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NamedModelBuilder toBuilder() => new NamedModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NamedModel &&
        id == other.id &&
        name == other.name &&
        countOfCars == other.countOfCars &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NamedModel')
          ..add('id', id)
          ..add('name', name)
          ..add('countOfCars', countOfCars)
          ..add('code', code))
        .toString();
  }
}

class NamedModelBuilder implements Builder<NamedModel, NamedModelBuilder> {
  _$NamedModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  NamedModelBuilder();

  NamedModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _countOfCars = $v.countOfCars;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NamedModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NamedModel;
  }

  @override
  void update(void Function(NamedModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NamedModel build() => _build();

  _$NamedModel _build() {
    final _$result = _$v ??
        new _$NamedModel._(
            id: id, name: name, countOfCars: countOfCars, code: code);
    replace(_$result);
    return _$result;
  }
}

class _$Brands extends Brands {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final BuiltList<CarModels>? carModels;
  @override
  final String? icon;
  @override
  final bool? top;
  @override
  final int? countOfCars;

  factory _$Brands([void Function(BrandsBuilder)? updates]) =>
      (new BrandsBuilder()..update(updates))._build();

  _$Brands._(
      {this.id,
      this.name,
      this.carModels,
      this.icon,
      this.top,
      this.countOfCars})
      : super._();

  @override
  Brands rebuild(void Function(BrandsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandsBuilder toBuilder() => new BrandsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Brands &&
        id == other.id &&
        name == other.name &&
        carModels == other.carModels &&
        icon == other.icon &&
        top == other.top &&
        countOfCars == other.countOfCars;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, carModels.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, top.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Brands')
          ..add('id', id)
          ..add('name', name)
          ..add('carModels', carModels)
          ..add('icon', icon)
          ..add('top', top)
          ..add('countOfCars', countOfCars))
        .toString();
  }
}

class BrandsBuilder implements Builder<Brands, BrandsBuilder> {
  _$Brands? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<CarModels>? _carModels;
  ListBuilder<CarModels> get carModels =>
      _$this._carModels ??= new ListBuilder<CarModels>();
  set carModels(ListBuilder<CarModels>? carModels) =>
      _$this._carModels = carModels;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  bool? _top;
  bool? get top => _$this._top;
  set top(bool? top) => _$this._top = top;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  BrandsBuilder();

  BrandsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _carModels = $v.carModels?.toBuilder();
      _icon = $v.icon;
      _top = $v.top;
      _countOfCars = $v.countOfCars;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Brands other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Brands;
  }

  @override
  void update(void Function(BrandsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Brands build() => _build();

  _$Brands _build() {
    _$Brands _$result;
    try {
      _$result = _$v ??
          new _$Brands._(
              id: id,
              name: name,
              carModels: _carModels?.build(),
              icon: icon,
              top: top,
              countOfCars: countOfCars);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'carModels';
        _carModels?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Brands', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Condition extends Condition {
  @override
  final bool? isUsed;
  @override
  final int? countOfCars;

  factory _$Condition([void Function(ConditionBuilder)? updates]) =>
      (new ConditionBuilder()..update(updates))._build();

  _$Condition._({this.isUsed, this.countOfCars}) : super._();

  @override
  Condition rebuild(void Function(ConditionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConditionBuilder toBuilder() => new ConditionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Condition &&
        isUsed == other.isUsed &&
        countOfCars == other.countOfCars;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isUsed.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Condition')
          ..add('isUsed', isUsed)
          ..add('countOfCars', countOfCars))
        .toString();
  }
}

class ConditionBuilder implements Builder<Condition, ConditionBuilder> {
  _$Condition? _$v;

  bool? _isUsed;
  bool? get isUsed => _$this._isUsed;
  set isUsed(bool? isUsed) => _$this._isUsed = isUsed;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  ConditionBuilder();

  ConditionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isUsed = $v.isUsed;
      _countOfCars = $v.countOfCars;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Condition other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Condition;
  }

  @override
  void update(void Function(ConditionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Condition build() => _build();

  _$Condition _build() {
    final _$result =
        _$v ?? new _$Condition._(isUsed: isUsed, countOfCars: countOfCars);
    replace(_$result);
    return _$result;
  }
}

class _$CarModels extends CarModels {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final bool? top;
  @override
  final BuiltList<NamedModel>? generations;
  @override
  final int? countOfCars;

  factory _$CarModels([void Function(CarModelsBuilder)? updates]) =>
      (new CarModelsBuilder()..update(updates))._build();

  _$CarModels._(
      {this.id, this.name, this.top, this.generations, this.countOfCars})
      : super._();

  @override
  CarModels rebuild(void Function(CarModelsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarModelsBuilder toBuilder() => new CarModelsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CarModels &&
        id == other.id &&
        name == other.name &&
        top == other.top &&
        generations == other.generations &&
        countOfCars == other.countOfCars;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, top.hashCode);
    _$hash = $jc(_$hash, generations.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CarModels')
          ..add('id', id)
          ..add('name', name)
          ..add('top', top)
          ..add('generations', generations)
          ..add('countOfCars', countOfCars))
        .toString();
  }
}

class CarModelsBuilder implements Builder<CarModels, CarModelsBuilder> {
  _$CarModels? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _top;
  bool? get top => _$this._top;
  set top(bool? top) => _$this._top = top;

  ListBuilder<NamedModel>? _generations;
  ListBuilder<NamedModel> get generations =>
      _$this._generations ??= new ListBuilder<NamedModel>();
  set generations(ListBuilder<NamedModel>? generations) =>
      _$this._generations = generations;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  CarModelsBuilder();

  CarModelsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _top = $v.top;
      _generations = $v.generations?.toBuilder();
      _countOfCars = $v.countOfCars;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CarModels other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CarModels;
  }

  @override
  void update(void Function(CarModelsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CarModels build() => _build();

  _$CarModels _build() {
    _$CarModels _$result;
    try {
      _$result = _$v ??
          new _$CarModels._(
              id: id,
              name: name,
              top: top,
              generations: _generations?.build(),
              countOfCars: countOfCars);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'generations';
        _generations?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CarModels', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GenerationModel extends GenerationModel {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? yearStart;
  @override
  final int? yearStop;
  @override
  final bool? isrestyle;
  @override
  final int? countOfCars;
  @override
  final String? apiGenerationId;
  @override
  final int? carModel;

  factory _$GenerationModel([void Function(GenerationModelBuilder)? updates]) =>
      (new GenerationModelBuilder()..update(updates))._build();

  _$GenerationModel._(
      {this.id,
      this.name,
      this.yearStart,
      this.yearStop,
      this.isrestyle,
      this.countOfCars,
      this.apiGenerationId,
      this.carModel})
      : super._();

  @override
  GenerationModel rebuild(void Function(GenerationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerationModelBuilder toBuilder() =>
      new GenerationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerationModel &&
        id == other.id &&
        name == other.name &&
        yearStart == other.yearStart &&
        yearStop == other.yearStop &&
        isrestyle == other.isrestyle &&
        countOfCars == other.countOfCars &&
        apiGenerationId == other.apiGenerationId &&
        carModel == other.carModel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, yearStart.hashCode);
    _$hash = $jc(_$hash, yearStop.hashCode);
    _$hash = $jc(_$hash, isrestyle.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jc(_$hash, apiGenerationId.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerationModel')
          ..add('id', id)
          ..add('name', name)
          ..add('yearStart', yearStart)
          ..add('yearStop', yearStop)
          ..add('isrestyle', isrestyle)
          ..add('countOfCars', countOfCars)
          ..add('apiGenerationId', apiGenerationId)
          ..add('carModel', carModel))
        .toString();
  }
}

class GenerationModelBuilder
    implements Builder<GenerationModel, GenerationModelBuilder> {
  _$GenerationModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _yearStart;
  int? get yearStart => _$this._yearStart;
  set yearStart(int? yearStart) => _$this._yearStart = yearStart;

  int? _yearStop;
  int? get yearStop => _$this._yearStop;
  set yearStop(int? yearStop) => _$this._yearStop = yearStop;

  bool? _isrestyle;
  bool? get isrestyle => _$this._isrestyle;
  set isrestyle(bool? isrestyle) => _$this._isrestyle = isrestyle;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  String? _apiGenerationId;
  String? get apiGenerationId => _$this._apiGenerationId;
  set apiGenerationId(String? apiGenerationId) =>
      _$this._apiGenerationId = apiGenerationId;

  int? _carModel;
  int? get carModel => _$this._carModel;
  set carModel(int? carModel) => _$this._carModel = carModel;

  GenerationModelBuilder();

  GenerationModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _yearStart = $v.yearStart;
      _yearStop = $v.yearStop;
      _isrestyle = $v.isrestyle;
      _countOfCars = $v.countOfCars;
      _apiGenerationId = $v.apiGenerationId;
      _carModel = $v.carModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerationModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GenerationModel;
  }

  @override
  void update(void Function(GenerationModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerationModel build() => _build();

  _$GenerationModel _build() {
    final _$result = _$v ??
        new _$GenerationModel._(
            id: id,
            name: name,
            yearStart: yearStart,
            yearStop: yearStop,
            isrestyle: isrestyle,
            countOfCars: countOfCars,
            apiGenerationId: apiGenerationId,
            carModel: carModel);
    replace(_$result);
    return _$result;
  }
}

class _$ImagesModel extends ImagesModel {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final String? type;
  @override
  final int? car;

  factory _$ImagesModel([void Function(ImagesModelBuilder)? updates]) =>
      (new ImagesModelBuilder()..update(updates))._build();

  _$ImagesModel._({this.id, this.url, this.type, this.car}) : super._();

  @override
  ImagesModel rebuild(void Function(ImagesModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImagesModelBuilder toBuilder() => new ImagesModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImagesModel &&
        id == other.id &&
        url == other.url &&
        type == other.type &&
        car == other.car;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, car.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImagesModel')
          ..add('id', id)
          ..add('url', url)
          ..add('type', type)
          ..add('car', car))
        .toString();
  }
}

class ImagesModelBuilder implements Builder<ImagesModel, ImagesModelBuilder> {
  _$ImagesModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _car;
  int? get car => _$this._car;
  set car(int? car) => _$this._car = car;

  ImagesModelBuilder();

  ImagesModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _url = $v.url;
      _type = $v.type;
      _car = $v.car;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImagesModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImagesModel;
  }

  @override
  void update(void Function(ImagesModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImagesModel build() => _build();

  _$ImagesModel _build() {
    final _$result =
        _$v ?? new _$ImagesModel._(id: id, url: url, type: type, car: car);
    replace(_$result);
    return _$result;
  }
}

class _$TotalCarsRes extends TotalCarsRes {
  @override
  final int? countOfCars;
  @override
  final int? countIn24;

  factory _$TotalCarsRes([void Function(TotalCarsResBuilder)? updates]) =>
      (new TotalCarsResBuilder()..update(updates))._build();

  _$TotalCarsRes._({this.countOfCars, this.countIn24}) : super._();

  @override
  TotalCarsRes rebuild(void Function(TotalCarsResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotalCarsResBuilder toBuilder() => new TotalCarsResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TotalCarsRes &&
        countOfCars == other.countOfCars &&
        countIn24 == other.countIn24;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jc(_$hash, countIn24.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TotalCarsRes')
          ..add('countOfCars', countOfCars)
          ..add('countIn24', countIn24))
        .toString();
  }
}

class TotalCarsResBuilder
    implements Builder<TotalCarsRes, TotalCarsResBuilder> {
  _$TotalCarsRes? _$v;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  int? _countIn24;
  int? get countIn24 => _$this._countIn24;
  set countIn24(int? countIn24) => _$this._countIn24 = countIn24;

  TotalCarsResBuilder();

  TotalCarsResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _countOfCars = $v.countOfCars;
      _countIn24 = $v.countIn24;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TotalCarsRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TotalCarsRes;
  }

  @override
  void update(void Function(TotalCarsResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TotalCarsRes build() => _build();

  _$TotalCarsRes _build() {
    final _$result = _$v ??
        new _$TotalCarsRes._(countOfCars: countOfCars, countIn24: countIn24);
    replace(_$result);
    return _$result;
  }
}

class _$OwnerModel extends OwnerModel {
  @override
  final int? id;
  @override
  final String? password;
  @override
  final String? lastLogin;
  @override
  final bool? isSuperuser;
  @override
  final String? username;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final bool? isStaff;
  @override
  final bool? isActive;
  @override
  final String? dateJoined;
  @override
  final String? fullName;
  @override
  final String? sellertype;
  @override
  final BuiltList<dynamic>? groups;
  @override
  final BuiltList<dynamic>? userPermissions;

  factory _$OwnerModel([void Function(OwnerModelBuilder)? updates]) =>
      (new OwnerModelBuilder()..update(updates))._build();

  _$OwnerModel._(
      {this.id,
      this.password,
      this.lastLogin,
      this.isSuperuser,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.fullName,
      this.sellertype,
      this.groups,
      this.userPermissions})
      : super._();

  @override
  OwnerModel rebuild(void Function(OwnerModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OwnerModelBuilder toBuilder() => new OwnerModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OwnerModel &&
        id == other.id &&
        password == other.password &&
        lastLogin == other.lastLogin &&
        isSuperuser == other.isSuperuser &&
        username == other.username &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        isStaff == other.isStaff &&
        isActive == other.isActive &&
        dateJoined == other.dateJoined &&
        fullName == other.fullName &&
        sellertype == other.sellertype &&
        groups == other.groups &&
        userPermissions == other.userPermissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, lastLogin.hashCode);
    _$hash = $jc(_$hash, isSuperuser.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, isStaff.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, dateJoined.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, sellertype.hashCode);
    _$hash = $jc(_$hash, groups.hashCode);
    _$hash = $jc(_$hash, userPermissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OwnerModel')
          ..add('id', id)
          ..add('password', password)
          ..add('lastLogin', lastLogin)
          ..add('isSuperuser', isSuperuser)
          ..add('username', username)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('isStaff', isStaff)
          ..add('isActive', isActive)
          ..add('dateJoined', dateJoined)
          ..add('fullName', fullName)
          ..add('sellertype', sellertype)
          ..add('groups', groups)
          ..add('userPermissions', userPermissions))
        .toString();
  }
}

class OwnerModelBuilder implements Builder<OwnerModel, OwnerModelBuilder> {
  _$OwnerModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _lastLogin;
  String? get lastLogin => _$this._lastLogin;
  set lastLogin(String? lastLogin) => _$this._lastLogin = lastLogin;

  bool? _isSuperuser;
  bool? get isSuperuser => _$this._isSuperuser;
  set isSuperuser(bool? isSuperuser) => _$this._isSuperuser = isSuperuser;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _isStaff;
  bool? get isStaff => _$this._isStaff;
  set isStaff(bool? isStaff) => _$this._isStaff = isStaff;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  String? _dateJoined;
  String? get dateJoined => _$this._dateJoined;
  set dateJoined(String? dateJoined) => _$this._dateJoined = dateJoined;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _sellertype;
  String? get sellertype => _$this._sellertype;
  set sellertype(String? sellertype) => _$this._sellertype = sellertype;

  ListBuilder<dynamic>? _groups;
  ListBuilder<dynamic> get groups =>
      _$this._groups ??= new ListBuilder<dynamic>();
  set groups(ListBuilder<dynamic>? groups) => _$this._groups = groups;

  ListBuilder<dynamic>? _userPermissions;
  ListBuilder<dynamic> get userPermissions =>
      _$this._userPermissions ??= new ListBuilder<dynamic>();
  set userPermissions(ListBuilder<dynamic>? userPermissions) =>
      _$this._userPermissions = userPermissions;

  OwnerModelBuilder();

  OwnerModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _password = $v.password;
      _lastLogin = $v.lastLogin;
      _isSuperuser = $v.isSuperuser;
      _username = $v.username;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _isStaff = $v.isStaff;
      _isActive = $v.isActive;
      _dateJoined = $v.dateJoined;
      _fullName = $v.fullName;
      _sellertype = $v.sellertype;
      _groups = $v.groups?.toBuilder();
      _userPermissions = $v.userPermissions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OwnerModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OwnerModel;
  }

  @override
  void update(void Function(OwnerModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OwnerModel build() => _build();

  _$OwnerModel _build() {
    _$OwnerModel _$result;
    try {
      _$result = _$v ??
          new _$OwnerModel._(
              id: id,
              password: password,
              lastLogin: lastLogin,
              isSuperuser: isSuperuser,
              username: username,
              firstName: firstName,
              lastName: lastName,
              email: email,
              isStaff: isStaff,
              isActive: isActive,
              dateJoined: dateJoined,
              fullName: fullName,
              sellertype: sellertype,
              groups: _groups?.build(),
              userPermissions: _userPermissions?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'groups';
        _groups?.build();
        _$failedField = 'userPermissions';
        _userPermissions?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'OwnerModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$FilterSearchReq extends FilterSearchReq {
  @override
  final int? yearFrom;
  @override
  final int? yearTo;
  @override
  final int? priceFrom;
  @override
  final int? priceTo;
  @override
  final String? currency;
  @override
  final int? mileageFrom;
  @override
  final int? mileageTo;
  @override
  final int? condition;
  @override
  final int? user;
  @override
  final int? brand;
  @override
  final int? carModel;
  @override
  final BuiltList<int>? generation;
  @override
  final BuiltList<int>? region;
  @override
  final BuiltList<int>? services;
  @override
  final BuiltList<int>? fuel;
  @override
  final BuiltList<int>? color;
  @override
  final BuiltList<int>? transmission;
  @override
  final BuiltList<int>? bodyType;

  factory _$FilterSearchReq([void Function(FilterSearchReqBuilder)? updates]) =>
      (new FilterSearchReqBuilder()..update(updates))._build();

  _$FilterSearchReq._(
      {this.yearFrom,
      this.yearTo,
      this.priceFrom,
      this.priceTo,
      this.currency,
      this.mileageFrom,
      this.mileageTo,
      this.condition,
      this.user,
      this.brand,
      this.carModel,
      this.generation,
      this.region,
      this.services,
      this.fuel,
      this.color,
      this.transmission,
      this.bodyType})
      : super._();

  @override
  FilterSearchReq rebuild(void Function(FilterSearchReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FilterSearchReqBuilder toBuilder() =>
      new FilterSearchReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FilterSearchReq &&
        yearFrom == other.yearFrom &&
        yearTo == other.yearTo &&
        priceFrom == other.priceFrom &&
        priceTo == other.priceTo &&
        currency == other.currency &&
        mileageFrom == other.mileageFrom &&
        mileageTo == other.mileageTo &&
        condition == other.condition &&
        user == other.user &&
        brand == other.brand &&
        carModel == other.carModel &&
        generation == other.generation &&
        region == other.region &&
        services == other.services &&
        fuel == other.fuel &&
        color == other.color &&
        transmission == other.transmission &&
        bodyType == other.bodyType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, yearFrom.hashCode);
    _$hash = $jc(_$hash, yearTo.hashCode);
    _$hash = $jc(_$hash, priceFrom.hashCode);
    _$hash = $jc(_$hash, priceTo.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, mileageFrom.hashCode);
    _$hash = $jc(_$hash, mileageTo.hashCode);
    _$hash = $jc(_$hash, condition.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, services.hashCode);
    _$hash = $jc(_$hash, fuel.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FilterSearchReq')
          ..add('yearFrom', yearFrom)
          ..add('yearTo', yearTo)
          ..add('priceFrom', priceFrom)
          ..add('priceTo', priceTo)
          ..add('currency', currency)
          ..add('mileageFrom', mileageFrom)
          ..add('mileageTo', mileageTo)
          ..add('condition', condition)
          ..add('user', user)
          ..add('brand', brand)
          ..add('carModel', carModel)
          ..add('generation', generation)
          ..add('region', region)
          ..add('services', services)
          ..add('fuel', fuel)
          ..add('color', color)
          ..add('transmission', transmission)
          ..add('bodyType', bodyType))
        .toString();
  }
}

class FilterSearchReqBuilder
    implements Builder<FilterSearchReq, FilterSearchReqBuilder> {
  _$FilterSearchReq? _$v;

  int? _yearFrom;
  int? get yearFrom => _$this._yearFrom;
  set yearFrom(int? yearFrom) => _$this._yearFrom = yearFrom;

  int? _yearTo;
  int? get yearTo => _$this._yearTo;
  set yearTo(int? yearTo) => _$this._yearTo = yearTo;

  int? _priceFrom;
  int? get priceFrom => _$this._priceFrom;
  set priceFrom(int? priceFrom) => _$this._priceFrom = priceFrom;

  int? _priceTo;
  int? get priceTo => _$this._priceTo;
  set priceTo(int? priceTo) => _$this._priceTo = priceTo;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  int? _mileageFrom;
  int? get mileageFrom => _$this._mileageFrom;
  set mileageFrom(int? mileageFrom) => _$this._mileageFrom = mileageFrom;

  int? _mileageTo;
  int? get mileageTo => _$this._mileageTo;
  set mileageTo(int? mileageTo) => _$this._mileageTo = mileageTo;

  int? _condition;
  int? get condition => _$this._condition;
  set condition(int? condition) => _$this._condition = condition;

  int? _user;
  int? get user => _$this._user;
  set user(int? user) => _$this._user = user;

  int? _brand;
  int? get brand => _$this._brand;
  set brand(int? brand) => _$this._brand = brand;

  int? _carModel;
  int? get carModel => _$this._carModel;
  set carModel(int? carModel) => _$this._carModel = carModel;

  ListBuilder<int>? _generation;
  ListBuilder<int> get generation =>
      _$this._generation ??= new ListBuilder<int>();
  set generation(ListBuilder<int>? generation) =>
      _$this._generation = generation;

  ListBuilder<int>? _region;
  ListBuilder<int> get region => _$this._region ??= new ListBuilder<int>();
  set region(ListBuilder<int>? region) => _$this._region = region;

  ListBuilder<int>? _services;
  ListBuilder<int> get services => _$this._services ??= new ListBuilder<int>();
  set services(ListBuilder<int>? services) => _$this._services = services;

  ListBuilder<int>? _fuel;
  ListBuilder<int> get fuel => _$this._fuel ??= new ListBuilder<int>();
  set fuel(ListBuilder<int>? fuel) => _$this._fuel = fuel;

  ListBuilder<int>? _color;
  ListBuilder<int> get color => _$this._color ??= new ListBuilder<int>();
  set color(ListBuilder<int>? color) => _$this._color = color;

  ListBuilder<int>? _transmission;
  ListBuilder<int> get transmission =>
      _$this._transmission ??= new ListBuilder<int>();
  set transmission(ListBuilder<int>? transmission) =>
      _$this._transmission = transmission;

  ListBuilder<int>? _bodyType;
  ListBuilder<int> get bodyType => _$this._bodyType ??= new ListBuilder<int>();
  set bodyType(ListBuilder<int>? bodyType) => _$this._bodyType = bodyType;

  FilterSearchReqBuilder();

  FilterSearchReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _yearFrom = $v.yearFrom;
      _yearTo = $v.yearTo;
      _priceFrom = $v.priceFrom;
      _priceTo = $v.priceTo;
      _currency = $v.currency;
      _mileageFrom = $v.mileageFrom;
      _mileageTo = $v.mileageTo;
      _condition = $v.condition;
      _user = $v.user;
      _brand = $v.brand;
      _carModel = $v.carModel;
      _generation = $v.generation?.toBuilder();
      _region = $v.region?.toBuilder();
      _services = $v.services?.toBuilder();
      _fuel = $v.fuel?.toBuilder();
      _color = $v.color?.toBuilder();
      _transmission = $v.transmission?.toBuilder();
      _bodyType = $v.bodyType?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FilterSearchReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FilterSearchReq;
  }

  @override
  void update(void Function(FilterSearchReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FilterSearchReq build() => _build();

  _$FilterSearchReq _build() {
    _$FilterSearchReq _$result;
    try {
      _$result = _$v ??
          new _$FilterSearchReq._(
              yearFrom: yearFrom,
              yearTo: yearTo,
              priceFrom: priceFrom,
              priceTo: priceTo,
              currency: currency,
              mileageFrom: mileageFrom,
              mileageTo: mileageTo,
              condition: condition,
              user: user,
              brand: brand,
              carModel: carModel,
              generation: _generation?.build(),
              region: _region?.build(),
              services: _services?.build(),
              fuel: _fuel?.build(),
              color: _color?.build(),
              transmission: _transmission?.build(),
              bodyType: _bodyType?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'generation';
        _generation?.build();
        _$failedField = 'region';
        _region?.build();
        _$failedField = 'services';
        _services?.build();
        _$failedField = 'fuel';
        _fuel?.build();
        _$failedField = 'color';
        _color?.build();
        _$failedField = 'transmission';
        _transmission?.build();
        _$failedField = 'bodyType';
        _bodyType?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FilterSearchReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$FilterSearchRes extends FilterSearchRes {
  @override
  final int? id;
  @override
  final Brands brand;
  @override
  final CarModel? carModel;
  @override
  final BuiltList<GenerationModel>? generation;
  @override
  final BuiltList<Region>? region;
  @override
  final BuiltList<Services>? services;
  @override
  final BuiltList<Region>? fuel;
  @override
  final BuiltList<NamedModel>? color;
  @override
  final BuiltList<BodyType>? bodyType;
  @override
  final BuiltList<Region>? transmission;
  @override
  final int? yearFrom;
  @override
  final int? yearTo;
  @override
  final int? priceFrom;
  @override
  final int? priceTo;
  @override
  final String? currency;
  @override
  final int? mileageFrom;
  @override
  final int? mileageTo;
  @override
  final int? condition;
  @override
  final int? user;

  factory _$FilterSearchRes([void Function(FilterSearchResBuilder)? updates]) =>
      (new FilterSearchResBuilder()..update(updates))._build();

  _$FilterSearchRes._(
      {this.id,
      required this.brand,
      this.carModel,
      this.generation,
      this.region,
      this.services,
      this.fuel,
      this.color,
      this.bodyType,
      this.transmission,
      this.yearFrom,
      this.yearTo,
      this.priceFrom,
      this.priceTo,
      this.currency,
      this.mileageFrom,
      this.mileageTo,
      this.condition,
      this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(brand, r'FilterSearchRes', 'brand');
  }

  @override
  FilterSearchRes rebuild(void Function(FilterSearchResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FilterSearchResBuilder toBuilder() =>
      new FilterSearchResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FilterSearchRes &&
        id == other.id &&
        brand == other.brand &&
        carModel == other.carModel &&
        generation == other.generation &&
        region == other.region &&
        services == other.services &&
        fuel == other.fuel &&
        color == other.color &&
        bodyType == other.bodyType &&
        transmission == other.transmission &&
        yearFrom == other.yearFrom &&
        yearTo == other.yearTo &&
        priceFrom == other.priceFrom &&
        priceTo == other.priceTo &&
        currency == other.currency &&
        mileageFrom == other.mileageFrom &&
        mileageTo == other.mileageTo &&
        condition == other.condition &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, services.hashCode);
    _$hash = $jc(_$hash, fuel.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, yearFrom.hashCode);
    _$hash = $jc(_$hash, yearTo.hashCode);
    _$hash = $jc(_$hash, priceFrom.hashCode);
    _$hash = $jc(_$hash, priceTo.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, mileageFrom.hashCode);
    _$hash = $jc(_$hash, mileageTo.hashCode);
    _$hash = $jc(_$hash, condition.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FilterSearchRes')
          ..add('id', id)
          ..add('brand', brand)
          ..add('carModel', carModel)
          ..add('generation', generation)
          ..add('region', region)
          ..add('services', services)
          ..add('fuel', fuel)
          ..add('color', color)
          ..add('bodyType', bodyType)
          ..add('transmission', transmission)
          ..add('yearFrom', yearFrom)
          ..add('yearTo', yearTo)
          ..add('priceFrom', priceFrom)
          ..add('priceTo', priceTo)
          ..add('currency', currency)
          ..add('mileageFrom', mileageFrom)
          ..add('mileageTo', mileageTo)
          ..add('condition', condition)
          ..add('user', user))
        .toString();
  }
}

class FilterSearchResBuilder
    implements Builder<FilterSearchRes, FilterSearchResBuilder> {
  _$FilterSearchRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  BrandsBuilder? _brand;
  BrandsBuilder get brand => _$this._brand ??= new BrandsBuilder();
  set brand(BrandsBuilder? brand) => _$this._brand = brand;

  CarModelBuilder? _carModel;
  CarModelBuilder get carModel => _$this._carModel ??= new CarModelBuilder();
  set carModel(CarModelBuilder? carModel) => _$this._carModel = carModel;

  ListBuilder<GenerationModel>? _generation;
  ListBuilder<GenerationModel> get generation =>
      _$this._generation ??= new ListBuilder<GenerationModel>();
  set generation(ListBuilder<GenerationModel>? generation) =>
      _$this._generation = generation;

  ListBuilder<Region>? _region;
  ListBuilder<Region> get region =>
      _$this._region ??= new ListBuilder<Region>();
  set region(ListBuilder<Region>? region) => _$this._region = region;

  ListBuilder<Services>? _services;
  ListBuilder<Services> get services =>
      _$this._services ??= new ListBuilder<Services>();
  set services(ListBuilder<Services>? services) => _$this._services = services;

  ListBuilder<Region>? _fuel;
  ListBuilder<Region> get fuel => _$this._fuel ??= new ListBuilder<Region>();
  set fuel(ListBuilder<Region>? fuel) => _$this._fuel = fuel;

  ListBuilder<NamedModel>? _color;
  ListBuilder<NamedModel> get color =>
      _$this._color ??= new ListBuilder<NamedModel>();
  set color(ListBuilder<NamedModel>? color) => _$this._color = color;

  ListBuilder<BodyType>? _bodyType;
  ListBuilder<BodyType> get bodyType =>
      _$this._bodyType ??= new ListBuilder<BodyType>();
  set bodyType(ListBuilder<BodyType>? bodyType) => _$this._bodyType = bodyType;

  ListBuilder<Region>? _transmission;
  ListBuilder<Region> get transmission =>
      _$this._transmission ??= new ListBuilder<Region>();
  set transmission(ListBuilder<Region>? transmission) =>
      _$this._transmission = transmission;

  int? _yearFrom;
  int? get yearFrom => _$this._yearFrom;
  set yearFrom(int? yearFrom) => _$this._yearFrom = yearFrom;

  int? _yearTo;
  int? get yearTo => _$this._yearTo;
  set yearTo(int? yearTo) => _$this._yearTo = yearTo;

  int? _priceFrom;
  int? get priceFrom => _$this._priceFrom;
  set priceFrom(int? priceFrom) => _$this._priceFrom = priceFrom;

  int? _priceTo;
  int? get priceTo => _$this._priceTo;
  set priceTo(int? priceTo) => _$this._priceTo = priceTo;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  int? _mileageFrom;
  int? get mileageFrom => _$this._mileageFrom;
  set mileageFrom(int? mileageFrom) => _$this._mileageFrom = mileageFrom;

  int? _mileageTo;
  int? get mileageTo => _$this._mileageTo;
  set mileageTo(int? mileageTo) => _$this._mileageTo = mileageTo;

  int? _condition;
  int? get condition => _$this._condition;
  set condition(int? condition) => _$this._condition = condition;

  int? _user;
  int? get user => _$this._user;
  set user(int? user) => _$this._user = user;

  FilterSearchResBuilder();

  FilterSearchResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _brand = $v.brand.toBuilder();
      _carModel = $v.carModel?.toBuilder();
      _generation = $v.generation?.toBuilder();
      _region = $v.region?.toBuilder();
      _services = $v.services?.toBuilder();
      _fuel = $v.fuel?.toBuilder();
      _color = $v.color?.toBuilder();
      _bodyType = $v.bodyType?.toBuilder();
      _transmission = $v.transmission?.toBuilder();
      _yearFrom = $v.yearFrom;
      _yearTo = $v.yearTo;
      _priceFrom = $v.priceFrom;
      _priceTo = $v.priceTo;
      _currency = $v.currency;
      _mileageFrom = $v.mileageFrom;
      _mileageTo = $v.mileageTo;
      _condition = $v.condition;
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FilterSearchRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FilterSearchRes;
  }

  @override
  void update(void Function(FilterSearchResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FilterSearchRes build() => _build();

  _$FilterSearchRes _build() {
    _$FilterSearchRes _$result;
    try {
      _$result = _$v ??
          new _$FilterSearchRes._(
              id: id,
              brand: brand.build(),
              carModel: _carModel?.build(),
              generation: _generation?.build(),
              region: _region?.build(),
              services: _services?.build(),
              fuel: _fuel?.build(),
              color: _color?.build(),
              bodyType: _bodyType?.build(),
              transmission: _transmission?.build(),
              yearFrom: yearFrom,
              yearTo: yearTo,
              priceFrom: priceFrom,
              priceTo: priceTo,
              currency: currency,
              mileageFrom: mileageFrom,
              mileageTo: mileageTo,
              condition: condition,
              user: user);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'brand';
        brand.build();
        _$failedField = 'carModel';
        _carModel?.build();
        _$failedField = 'generation';
        _generation?.build();
        _$failedField = 'region';
        _region?.build();
        _$failedField = 'services';
        _services?.build();
        _$failedField = 'fuel';
        _fuel?.build();
        _$failedField = 'color';
        _color?.build();
        _$failedField = 'bodyType';
        _bodyType?.build();
        _$failedField = 'transmission';
        _transmission?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FilterSearchRes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Region extends Region {
  @override
  final int? id;
  @override
  final String? name;

  factory _$Region([void Function(RegionBuilder)? updates]) =>
      (new RegionBuilder()..update(updates))._build();

  _$Region._({this.id, this.name}) : super._();

  @override
  Region rebuild(void Function(RegionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegionBuilder toBuilder() => new RegionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Region && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Region')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class RegionBuilder implements Builder<Region, RegionBuilder> {
  _$Region? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  RegionBuilder();

  RegionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Region other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Region;
  }

  @override
  void update(void Function(RegionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Region build() => _build();

  _$Region _build() {
    final _$result = _$v ?? new _$Region._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

class _$Services extends Services {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;

  factory _$Services([void Function(ServicesBuilder)? updates]) =>
      (new ServicesBuilder()..update(updates))._build();

  _$Services._({this.id, this.title, this.description}) : super._();

  @override
  Services rebuild(void Function(ServicesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ServicesBuilder toBuilder() => new ServicesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Services &&
        id == other.id &&
        title == other.title &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Services')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description))
        .toString();
  }
}

class ServicesBuilder implements Builder<Services, ServicesBuilder> {
  _$Services? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ServicesBuilder();

  ServicesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Services other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Services;
  }

  @override
  void update(void Function(ServicesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Services build() => _build();

  _$Services _build() {
    final _$result =
        _$v ?? new _$Services._(id: id, title: title, description: description);
    replace(_$result);
    return _$result;
  }
}

class _$BodyType extends BodyType {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? icon;

  factory _$BodyType([void Function(BodyTypeBuilder)? updates]) =>
      (new BodyTypeBuilder()..update(updates))._build();

  _$BodyType._({this.id, this.name, this.icon}) : super._();

  @override
  BodyType rebuild(void Function(BodyTypeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BodyTypeBuilder toBuilder() => new BodyTypeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BodyType &&
        id == other.id &&
        name == other.name &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BodyType')
          ..add('id', id)
          ..add('name', name)
          ..add('icon', icon))
        .toString();
  }
}

class BodyTypeBuilder implements Builder<BodyType, BodyTypeBuilder> {
  _$BodyType? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  BodyTypeBuilder();

  BodyTypeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BodyType other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BodyType;
  }

  @override
  void update(void Function(BodyTypeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BodyType build() => _build();

  _$BodyType _build() {
    final _$result = _$v ?? new _$BodyType._(id: id, name: name, icon: icon);
    replace(_$result);
    return _$result;
  }
}

class _$SearchList extends SearchList {
  @override
  final int? id;
  @override
  final String? brand;
  @override
  final String? carModel;
  @override
  final String? name;
  @override
  final int? yearStart;
  @override
  final int? yearStop;
  @override
  final int? countOfCars;
  @override
  final int? brandId;
  @override
  final int? carModelId;

  factory _$SearchList([void Function(SearchListBuilder)? updates]) =>
      (new SearchListBuilder()..update(updates))._build();

  _$SearchList._(
      {this.id,
      this.brand,
      this.carModel,
      this.name,
      this.yearStart,
      this.yearStop,
      this.countOfCars,
      this.brandId,
      this.carModelId})
      : super._();

  @override
  SearchList rebuild(void Function(SearchListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchListBuilder toBuilder() => new SearchListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchList &&
        id == other.id &&
        brand == other.brand &&
        carModel == other.carModel &&
        name == other.name &&
        yearStart == other.yearStart &&
        yearStop == other.yearStop &&
        countOfCars == other.countOfCars &&
        brandId == other.brandId &&
        carModelId == other.carModelId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, yearStart.hashCode);
    _$hash = $jc(_$hash, yearStop.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jc(_$hash, brandId.hashCode);
    _$hash = $jc(_$hash, carModelId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchList')
          ..add('id', id)
          ..add('brand', brand)
          ..add('carModel', carModel)
          ..add('name', name)
          ..add('yearStart', yearStart)
          ..add('yearStop', yearStop)
          ..add('countOfCars', countOfCars)
          ..add('brandId', brandId)
          ..add('carModelId', carModelId))
        .toString();
  }
}

class SearchListBuilder implements Builder<SearchList, SearchListBuilder> {
  _$SearchList? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  String? _carModel;
  String? get carModel => _$this._carModel;
  set carModel(String? carModel) => _$this._carModel = carModel;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _yearStart;
  int? get yearStart => _$this._yearStart;
  set yearStart(int? yearStart) => _$this._yearStart = yearStart;

  int? _yearStop;
  int? get yearStop => _$this._yearStop;
  set yearStop(int? yearStop) => _$this._yearStop = yearStop;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  int? _brandId;
  int? get brandId => _$this._brandId;
  set brandId(int? brandId) => _$this._brandId = brandId;

  int? _carModelId;
  int? get carModelId => _$this._carModelId;
  set carModelId(int? carModelId) => _$this._carModelId = carModelId;

  SearchListBuilder();

  SearchListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _brand = $v.brand;
      _carModel = $v.carModel;
      _name = $v.name;
      _yearStart = $v.yearStart;
      _yearStop = $v.yearStop;
      _countOfCars = $v.countOfCars;
      _brandId = $v.brandId;
      _carModelId = $v.carModelId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchList;
  }

  @override
  void update(void Function(SearchListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchList build() => _build();

  _$SearchList _build() {
    final _$result = _$v ??
        new _$SearchList._(
            id: id,
            brand: brand,
            carModel: carModel,
            name: name,
            yearStart: yearStart,
            yearStop: yearStop,
            countOfCars: countOfCars,
            brandId: brandId,
            carModelId: carModelId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

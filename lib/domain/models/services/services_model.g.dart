// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ServicesRes> _$servicesResSerializer = new _$ServicesResSerializer();

class _$ServicesResSerializer implements StructuredSerializer<ServicesRes> {
  @override
  final Iterable<Type> types = const [ServicesRes, _$ServicesRes];
  @override
  final String wireName = 'ServicesRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, ServicesRes object,
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
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ServicesRes deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ServicesResBuilder();

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
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ServicesRes extends ServicesRes {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final int? countOfCars;

  factory _$ServicesRes([void Function(ServicesResBuilder)? updates]) =>
      (new ServicesResBuilder()..update(updates))._build();

  _$ServicesRes._({this.id, this.title, this.description, this.countOfCars})
      : super._();

  @override
  ServicesRes rebuild(void Function(ServicesResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ServicesResBuilder toBuilder() => new ServicesResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServicesRes &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        countOfCars == other.countOfCars;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServicesRes')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('countOfCars', countOfCars))
        .toString();
  }
}

class ServicesResBuilder implements Builder<ServicesRes, ServicesResBuilder> {
  _$ServicesRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  ServicesResBuilder();

  ServicesResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _countOfCars = $v.countOfCars;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServicesRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ServicesRes;
  }

  @override
  void update(void Function(ServicesResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ServicesRes build() => _build();

  _$ServicesRes _build() {
    final _$result = _$v ??
        new _$ServicesRes._(
            id: id,
            title: title,
            description: description,
            countOfCars: countOfCars);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

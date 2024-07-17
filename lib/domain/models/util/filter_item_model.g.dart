// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_item_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FilterItemModel> _$filterItemModelSerializer =
    new _$FilterItemModelSerializer();

class _$FilterItemModelSerializer
    implements StructuredSerializer<FilterItemModel> {
  @override
  final Iterable<Type> types = const [FilterItemModel, _$FilterItemModel];
  @override
  final String wireName = 'FilterItemModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, FilterItemModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.valueId;
    if (value != null) {
      result
        ..add('value_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  FilterItemModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FilterItemModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value_id':
          result.valueId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$FilterItemModel extends FilterItemModel {
  @override
  final String? value;
  @override
  final int? valueId;

  factory _$FilterItemModel([void Function(FilterItemModelBuilder)? updates]) =>
      (new FilterItemModelBuilder()..update(updates))._build();

  _$FilterItemModel._({this.value, this.valueId}) : super._();

  @override
  FilterItemModel rebuild(void Function(FilterItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FilterItemModelBuilder toBuilder() =>
      new FilterItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FilterItemModel &&
        value == other.value &&
        valueId == other.valueId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, valueId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FilterItemModel')
          ..add('value', value)
          ..add('valueId', valueId))
        .toString();
  }
}

class FilterItemModelBuilder
    implements Builder<FilterItemModel, FilterItemModelBuilder> {
  _$FilterItemModel? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  int? _valueId;
  int? get valueId => _$this._valueId;
  set valueId(int? valueId) => _$this._valueId = valueId;

  FilterItemModelBuilder();

  FilterItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _valueId = $v.valueId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FilterItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FilterItemModel;
  }

  @override
  void update(void Function(FilterItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FilterItemModel build() => _build();

  _$FilterItemModel _build() {
    final _$result =
        _$v ?? new _$FilterItemModel._(value: value, valueId: valueId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SuccessModel> _$successModelSerializer =
    new _$SuccessModelSerializer();

class _$SuccessModelSerializer implements StructuredSerializer<SuccessModel> {
  @override
  final Iterable<Type> types = const [SuccessModel, _$SuccessModel];
  @override
  final String wireName = 'SuccessModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, SuccessModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.detail;
    if (value != null) {
      result
        ..add('detail')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SuccessModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SuccessModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'detail':
          result.detail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SuccessModel extends SuccessModel {
  @override
  final String? detail;

  factory _$SuccessModel([void Function(SuccessModelBuilder)? updates]) =>
      (new SuccessModelBuilder()..update(updates))._build();

  _$SuccessModel._({this.detail}) : super._();

  @override
  SuccessModel rebuild(void Function(SuccessModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuccessModelBuilder toBuilder() => new SuccessModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuccessModel && detail == other.detail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuccessModel')..add('detail', detail))
        .toString();
  }
}

class SuccessModelBuilder
    implements Builder<SuccessModel, SuccessModelBuilder> {
  _$SuccessModel? _$v;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  SuccessModelBuilder();

  SuccessModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _detail = $v.detail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuccessModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SuccessModel;
  }

  @override
  void update(void Function(SuccessModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuccessModel build() => _build();

  _$SuccessModel _build() {
    final _$result = _$v ?? new _$SuccessModel._(detail: detail);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

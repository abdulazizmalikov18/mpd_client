// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specifications.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TransmissionModel> _$transmissionModelSerializer =
    new _$TransmissionModelSerializer();
Serializer<TranslationsModel> _$translationsModelSerializer =
    new _$TranslationsModelSerializer();
Serializer<UzModel> _$uzModelSerializer = new _$UzModelSerializer();
Serializer<RuModel> _$ruModelSerializer = new _$RuModelSerializer();
Serializer<DriveUnitModel> _$driveUnitModelSerializer =
    new _$DriveUnitModelSerializer();
Serializer<OptionsRes> _$optionsResSerializer = new _$OptionsResSerializer();

class _$TransmissionModelSerializer
    implements StructuredSerializer<TransmissionModel> {
  @override
  final Iterable<Type> types = const [TransmissionModel, _$TransmissionModel];
  @override
  final String wireName = 'TransmissionModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TransmissionModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.translations;
    if (value != null) {
      result
        ..add('translations')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(TranslationsModel)));
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
  TransmissionModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransmissionModelBuilder();

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
        case 'translations':
          result.translations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TranslationsModel))!
              as TranslationsModel);
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

class _$TranslationsModelSerializer
    implements StructuredSerializer<TranslationsModel> {
  @override
  final Iterable<Type> types = const [TranslationsModel, _$TranslationsModel];
  @override
  final String wireName = 'TranslationsModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, TranslationsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.ru;
    if (value != null) {
      result
        ..add('ru')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(RuModel)));
    }
    value = object.uz;
    if (value != null) {
      result
        ..add('uz')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UzModel)));
    }
    return result;
  }

  @override
  TranslationsModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TranslationsModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'ru':
          result.ru.replace(serializers.deserialize(value,
              specifiedType: const FullType(RuModel))! as RuModel);
          break;
        case 'uz':
          result.uz.replace(serializers.deserialize(value,
              specifiedType: const FullType(UzModel))! as UzModel);
          break;
      }
    }

    return result.build();
  }
}

class _$UzModelSerializer implements StructuredSerializer<UzModel> {
  @override
  final Iterable<Type> types = const [UzModel, _$UzModel];
  @override
  final String wireName = 'UzModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, UzModel object,
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
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  UzModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UzModelBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$RuModelSerializer implements StructuredSerializer<RuModel> {
  @override
  final Iterable<Type> types = const [RuModel, _$RuModel];
  @override
  final String wireName = 'RuModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, RuModel object,
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
    return result;
  }

  @override
  RuModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RuModelBuilder();

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
      }
    }

    return result.build();
  }
}

class _$DriveUnitModelSerializer
    implements StructuredSerializer<DriveUnitModel> {
  @override
  final Iterable<Type> types = const [DriveUnitModel, _$DriveUnitModel];
  @override
  final String wireName = 'DriveUnitModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, DriveUnitModel object,
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
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
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
  DriveUnitModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DriveUnitModelBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
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

class _$OptionsResSerializer implements StructuredSerializer<OptionsRes> {
  @override
  final Iterable<Type> types = const [OptionsRes, _$OptionsRes];
  @override
  final String wireName = 'OptionsRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, OptionsRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
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
    value = object.optics;
    if (value != null) {
      result
        ..add('optics')
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
    value = object.mediaTools;
    if (value != null) {
      result
        ..add('media_tools')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DriveUnitModel)])));
    }
    return result;
  }

  @override
  OptionsRes deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OptionsResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'optics':
          result.optics.replace(serializers.deserialize(value,
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
        case 'media_tools':
          result.mediaTools.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DriveUnitModel)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TransmissionModel extends TransmissionModel {
  @override
  final int? id;
  @override
  final TranslationsModel? translations;
  @override
  final String? icon;

  factory _$TransmissionModel(
          [void Function(TransmissionModelBuilder)? updates]) =>
      (new TransmissionModelBuilder()..update(updates))._build();

  _$TransmissionModel._({this.id, this.translations, this.icon}) : super._();

  @override
  TransmissionModel rebuild(void Function(TransmissionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransmissionModelBuilder toBuilder() =>
      new TransmissionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransmissionModel &&
        id == other.id &&
        translations == other.translations &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, translations.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransmissionModel')
          ..add('id', id)
          ..add('translations', translations)
          ..add('icon', icon))
        .toString();
  }
}

class TransmissionModelBuilder
    implements Builder<TransmissionModel, TransmissionModelBuilder> {
  _$TransmissionModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  TranslationsModelBuilder? _translations;
  TranslationsModelBuilder get translations =>
      _$this._translations ??= new TranslationsModelBuilder();
  set translations(TranslationsModelBuilder? translations) =>
      _$this._translations = translations;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  TransmissionModelBuilder();

  TransmissionModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _translations = $v.translations?.toBuilder();
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransmissionModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransmissionModel;
  }

  @override
  void update(void Function(TransmissionModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransmissionModel build() => _build();

  _$TransmissionModel _build() {
    _$TransmissionModel _$result;
    try {
      _$result = _$v ??
          new _$TransmissionModel._(
              id: id, translations: _translations?.build(), icon: icon);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'translations';
        _translations?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TransmissionModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TranslationsModel extends TranslationsModel {
  @override
  final RuModel? ru;
  @override
  final UzModel? uz;

  factory _$TranslationsModel(
          [void Function(TranslationsModelBuilder)? updates]) =>
      (new TranslationsModelBuilder()..update(updates))._build();

  _$TranslationsModel._({this.ru, this.uz}) : super._();

  @override
  TranslationsModel rebuild(void Function(TranslationsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TranslationsModelBuilder toBuilder() =>
      new TranslationsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TranslationsModel && ru == other.ru && uz == other.uz;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ru.hashCode);
    _$hash = $jc(_$hash, uz.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TranslationsModel')
          ..add('ru', ru)
          ..add('uz', uz))
        .toString();
  }
}

class TranslationsModelBuilder
    implements Builder<TranslationsModel, TranslationsModelBuilder> {
  _$TranslationsModel? _$v;

  RuModelBuilder? _ru;
  RuModelBuilder get ru => _$this._ru ??= new RuModelBuilder();
  set ru(RuModelBuilder? ru) => _$this._ru = ru;

  UzModelBuilder? _uz;
  UzModelBuilder get uz => _$this._uz ??= new UzModelBuilder();
  set uz(UzModelBuilder? uz) => _$this._uz = uz;

  TranslationsModelBuilder();

  TranslationsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ru = $v.ru?.toBuilder();
      _uz = $v.uz?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TranslationsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TranslationsModel;
  }

  @override
  void update(void Function(TranslationsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TranslationsModel build() => _build();

  _$TranslationsModel _build() {
    _$TranslationsModel _$result;
    try {
      _$result =
          _$v ?? new _$TranslationsModel._(ru: _ru?.build(), uz: _uz?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ru';
        _ru?.build();
        _$failedField = 'uz';
        _uz?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TranslationsModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UzModel extends UzModel {
  @override
  final String? name;
  @override
  final int? id;

  factory _$UzModel([void Function(UzModelBuilder)? updates]) =>
      (new UzModelBuilder()..update(updates))._build();

  _$UzModel._({this.name, this.id}) : super._();

  @override
  UzModel rebuild(void Function(UzModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UzModelBuilder toBuilder() => new UzModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UzModel && name == other.name && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UzModel')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class UzModelBuilder implements Builder<UzModel, UzModelBuilder> {
  _$UzModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  UzModelBuilder();

  UzModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UzModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UzModel;
  }

  @override
  void update(void Function(UzModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UzModel build() => _build();

  _$UzModel _build() {
    final _$result = _$v ?? new _$UzModel._(name: name, id: id);
    replace(_$result);
    return _$result;
  }
}

class _$RuModel extends RuModel {
  @override
  final String? name;

  factory _$RuModel([void Function(RuModelBuilder)? updates]) =>
      (new RuModelBuilder()..update(updates))._build();

  _$RuModel._({this.name}) : super._();

  @override
  RuModel rebuild(void Function(RuModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RuModelBuilder toBuilder() => new RuModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RuModel && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RuModel')..add('name', name))
        .toString();
  }
}

class RuModelBuilder implements Builder<RuModel, RuModelBuilder> {
  _$RuModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  RuModelBuilder();

  RuModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RuModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RuModel;
  }

  @override
  void update(void Function(RuModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RuModel build() => _build();

  _$RuModel _build() {
    final _$result = _$v ?? new _$RuModel._(name: name);
    replace(_$result);
    return _$result;
  }
}

class _$DriveUnitModel extends DriveUnitModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? name;
  @override
  final bool? value;
  @override
  final String? icon;
  @override
  final String? image;
  @override
  final String? description;

  factory _$DriveUnitModel([void Function(DriveUnitModelBuilder)? updates]) =>
      (new DriveUnitModelBuilder()..update(updates))._build();

  _$DriveUnitModel._(
      {this.id,
      this.title,
      this.name,
      this.value,
      this.icon,
      this.image,
      this.description})
      : super._();

  @override
  DriveUnitModel rebuild(void Function(DriveUnitModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DriveUnitModelBuilder toBuilder() =>
      new DriveUnitModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriveUnitModel &&
        id == other.id &&
        title == other.title &&
        name == other.name &&
        value == other.value &&
        icon == other.icon &&
        image == other.image &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DriveUnitModel')
          ..add('id', id)
          ..add('title', title)
          ..add('name', name)
          ..add('value', value)
          ..add('icon', icon)
          ..add('image', image)
          ..add('description', description))
        .toString();
  }
}

class DriveUnitModelBuilder
    implements Builder<DriveUnitModel, DriveUnitModelBuilder> {
  _$DriveUnitModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _value;
  bool? get value => _$this._value;
  set value(bool? value) => _$this._value = value;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DriveUnitModelBuilder();

  DriveUnitModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _name = $v.name;
      _value = $v.value;
      _icon = $v.icon;
      _image = $v.image;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DriveUnitModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DriveUnitModel;
  }

  @override
  void update(void Function(DriveUnitModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriveUnitModel build() => _build();

  _$DriveUnitModel _build() {
    final _$result = _$v ??
        new _$DriveUnitModel._(
            id: id,
            title: title,
            name: name,
            value: value,
            icon: icon,
            image: image,
            description: description);
    replace(_$result);
    return _$result;
  }
}

class _$OptionsRes extends OptionsRes {
  @override
  final BuiltList<DriveUnitModel>? externalBodyKit;
  @override
  final BuiltList<DriveUnitModel>? salon;
  @override
  final BuiltList<DriveUnitModel>? optics;
  @override
  final BuiltList<DriveUnitModel>? vehicleOptions;
  @override
  final BuiltList<DriveUnitModel>? mediaTools;

  factory _$OptionsRes([void Function(OptionsResBuilder)? updates]) =>
      (new OptionsResBuilder()..update(updates))._build();

  _$OptionsRes._(
      {this.externalBodyKit,
      this.salon,
      this.optics,
      this.vehicleOptions,
      this.mediaTools})
      : super._();

  @override
  OptionsRes rebuild(void Function(OptionsResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OptionsResBuilder toBuilder() => new OptionsResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OptionsRes &&
        externalBodyKit == other.externalBodyKit &&
        salon == other.salon &&
        optics == other.optics &&
        vehicleOptions == other.vehicleOptions &&
        mediaTools == other.mediaTools;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, externalBodyKit.hashCode);
    _$hash = $jc(_$hash, salon.hashCode);
    _$hash = $jc(_$hash, optics.hashCode);
    _$hash = $jc(_$hash, vehicleOptions.hashCode);
    _$hash = $jc(_$hash, mediaTools.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OptionsRes')
          ..add('externalBodyKit', externalBodyKit)
          ..add('salon', salon)
          ..add('optics', optics)
          ..add('vehicleOptions', vehicleOptions)
          ..add('mediaTools', mediaTools))
        .toString();
  }
}

class OptionsResBuilder implements Builder<OptionsRes, OptionsResBuilder> {
  _$OptionsRes? _$v;

  ListBuilder<DriveUnitModel>? _externalBodyKit;
  ListBuilder<DriveUnitModel> get externalBodyKit =>
      _$this._externalBodyKit ??= new ListBuilder<DriveUnitModel>();
  set externalBodyKit(ListBuilder<DriveUnitModel>? externalBodyKit) =>
      _$this._externalBodyKit = externalBodyKit;

  ListBuilder<DriveUnitModel>? _salon;
  ListBuilder<DriveUnitModel> get salon =>
      _$this._salon ??= new ListBuilder<DriveUnitModel>();
  set salon(ListBuilder<DriveUnitModel>? salon) => _$this._salon = salon;

  ListBuilder<DriveUnitModel>? _optics;
  ListBuilder<DriveUnitModel> get optics =>
      _$this._optics ??= new ListBuilder<DriveUnitModel>();
  set optics(ListBuilder<DriveUnitModel>? optics) => _$this._optics = optics;

  ListBuilder<DriveUnitModel>? _vehicleOptions;
  ListBuilder<DriveUnitModel> get vehicleOptions =>
      _$this._vehicleOptions ??= new ListBuilder<DriveUnitModel>();
  set vehicleOptions(ListBuilder<DriveUnitModel>? vehicleOptions) =>
      _$this._vehicleOptions = vehicleOptions;

  ListBuilder<DriveUnitModel>? _mediaTools;
  ListBuilder<DriveUnitModel> get mediaTools =>
      _$this._mediaTools ??= new ListBuilder<DriveUnitModel>();
  set mediaTools(ListBuilder<DriveUnitModel>? mediaTools) =>
      _$this._mediaTools = mediaTools;

  OptionsResBuilder();

  OptionsResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _externalBodyKit = $v.externalBodyKit?.toBuilder();
      _salon = $v.salon?.toBuilder();
      _optics = $v.optics?.toBuilder();
      _vehicleOptions = $v.vehicleOptions?.toBuilder();
      _mediaTools = $v.mediaTools?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OptionsRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OptionsRes;
  }

  @override
  void update(void Function(OptionsResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OptionsRes build() => _build();

  _$OptionsRes _build() {
    _$OptionsRes _$result;
    try {
      _$result = _$v ??
          new _$OptionsRes._(
              externalBodyKit: _externalBodyKit?.build(),
              salon: _salon?.build(),
              optics: _optics?.build(),
              vehicleOptions: _vehicleOptions?.build(),
              mediaTools: _mediaTools?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'externalBodyKit';
        _externalBodyKit?.build();
        _$failedField = 'salon';
        _salon?.build();
        _$failedField = 'optics';
        _optics?.build();
        _$failedField = 'vehicleOptions';
        _vehicleOptions?.build();
        _$failedField = 'mediaTools';
        _mediaTools?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'OptionsRes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

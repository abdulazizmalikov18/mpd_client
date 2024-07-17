// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CurrencyModel> _$currencyModelSerializer =
    new _$CurrencyModelSerializer();
Serializer<BranchModel> _$branchModelSerializer = new _$BranchModelSerializer();
Serializer<BranchComplaintModel> _$branchComplaintModelSerializer =
    new _$BranchComplaintModelSerializer();
Serializer<NewsModel> _$newsModelSerializer = new _$NewsModelSerializer();
Serializer<NotificationModel> _$notificationModelSerializer =
    new _$NotificationModelSerializer();
Serializer<UnreadModel> _$unreadModelSerializer = new _$UnreadModelSerializer();

class _$CurrencyModelSerializer implements StructuredSerializer<CurrencyModel> {
  @override
  final Iterable<Type> types = const [CurrencyModel, _$CurrencyModel];
  @override
  final String wireName = 'CurrencyModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CurrencyModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.amount;
    if (value != null) {
      result
        ..add('amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  CurrencyModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$BranchModelSerializer implements StructuredSerializer<BranchModel> {
  @override
  final Iterable<Type> types = const [BranchModel, _$BranchModel];
  @override
  final String wireName = 'BranchModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, BranchModel object,
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
    value = object.photos;
    if (value != null) {
      result
        ..add('photos')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.contact;
    if (value != null) {
      result
        ..add('contact')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.workingTime;
    if (value != null) {
      result
        ..add('working_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lat;
    if (value != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.long;
    if (value != null) {
      result
        ..add('long')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  BranchModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BranchModelBuilder();

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
        case 'photos':
          result.photos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'contact':
          result.contact = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'working_time':
          result.workingTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'long':
          result.long = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$BranchComplaintModelSerializer
    implements StructuredSerializer<BranchComplaintModel> {
  @override
  final Iterable<Type> types = const [
    BranchComplaintModel,
    _$BranchComplaintModel
  ];
  @override
  final String wireName = 'BranchComplaintModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, BranchComplaintModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.text;
    if (value != null) {
      result
        ..add('text')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BranchComplaintModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BranchComplaintModelBuilder();

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
        case 'region':
          result.region = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$NewsModelSerializer implements StructuredSerializer<NewsModel> {
  @override
  final Iterable<Type> types = const [NewsModel, _$NewsModel];
  @override
  final String wireName = 'NewsModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, NewsModel object,
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
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.famous;
    if (value != null) {
      result
        ..add('famous')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.photos;
    if (value != null) {
      result
        ..add('photos')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  NewsModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewsModelBuilder();

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
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'famous':
          result.famous = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'photos':
          result.photos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$NotificationModelSerializer
    implements StructuredSerializer<NotificationModel> {
  @override
  final Iterable<Type> types = const [NotificationModel, _$NotificationModel];
  @override
  final String wireName = 'NotificationModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, NotificationModel object,
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
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
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
    value = object.photo;
    if (value != null) {
      result
        ..add('photo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.read;
    if (value != null) {
      result
        ..add('read')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  NotificationModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NotificationModelBuilder();

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
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo':
          result.photo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'read':
          result.read = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$UnreadModelSerializer implements StructuredSerializer<UnreadModel> {
  @override
  final Iterable<Type> types = const [UnreadModel, _$UnreadModel];
  @override
  final String wireName = 'UnreadModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, UnreadModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  UnreadModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UnreadModelBuilder();

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
      }
    }

    return result.build();
  }
}

class _$CurrencyModel extends CurrencyModel {
  @override
  final double? amount;

  factory _$CurrencyModel([void Function(CurrencyModelBuilder)? updates]) =>
      (new CurrencyModelBuilder()..update(updates))._build();

  _$CurrencyModel._({this.amount}) : super._();

  @override
  CurrencyModel rebuild(void Function(CurrencyModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyModelBuilder toBuilder() => new CurrencyModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyModel && amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CurrencyModel')
          ..add('amount', amount))
        .toString();
  }
}

class CurrencyModelBuilder
    implements Builder<CurrencyModel, CurrencyModelBuilder> {
  _$CurrencyModel? _$v;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  CurrencyModelBuilder();

  CurrencyModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CurrencyModel;
  }

  @override
  void update(void Function(CurrencyModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrencyModel build() => _build();

  _$CurrencyModel _build() {
    final _$result = _$v ?? new _$CurrencyModel._(amount: amount);
    replace(_$result);
    return _$result;
  }
}

class _$BranchModel extends BranchModel {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final BuiltList<String>? photos;
  @override
  final String? address;
  @override
  final String? contact;
  @override
  final String? workingTime;
  @override
  final double? lat;
  @override
  final double? long;

  factory _$BranchModel([void Function(BranchModelBuilder)? updates]) =>
      (new BranchModelBuilder()..update(updates))._build();

  _$BranchModel._(
      {this.id,
      this.name,
      this.photos,
      this.address,
      this.contact,
      this.workingTime,
      this.lat,
      this.long})
      : super._();

  @override
  BranchModel rebuild(void Function(BranchModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BranchModelBuilder toBuilder() => new BranchModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BranchModel &&
        id == other.id &&
        name == other.name &&
        photos == other.photos &&
        address == other.address &&
        contact == other.contact &&
        workingTime == other.workingTime &&
        lat == other.lat &&
        long == other.long;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, contact.hashCode);
    _$hash = $jc(_$hash, workingTime.hashCode);
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, long.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BranchModel')
          ..add('id', id)
          ..add('name', name)
          ..add('photos', photos)
          ..add('address', address)
          ..add('contact', contact)
          ..add('workingTime', workingTime)
          ..add('lat', lat)
          ..add('long', long))
        .toString();
  }
}

class BranchModelBuilder implements Builder<BranchModel, BranchModelBuilder> {
  _$BranchModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<String>? _photos;
  ListBuilder<String> get photos =>
      _$this._photos ??= new ListBuilder<String>();
  set photos(ListBuilder<String>? photos) => _$this._photos = photos;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _contact;
  String? get contact => _$this._contact;
  set contact(String? contact) => _$this._contact = contact;

  String? _workingTime;
  String? get workingTime => _$this._workingTime;
  set workingTime(String? workingTime) => _$this._workingTime = workingTime;

  double? _lat;
  double? get lat => _$this._lat;
  set lat(double? lat) => _$this._lat = lat;

  double? _long;
  double? get long => _$this._long;
  set long(double? long) => _$this._long = long;

  BranchModelBuilder();

  BranchModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _photos = $v.photos?.toBuilder();
      _address = $v.address;
      _contact = $v.contact;
      _workingTime = $v.workingTime;
      _lat = $v.lat;
      _long = $v.long;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BranchModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BranchModel;
  }

  @override
  void update(void Function(BranchModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BranchModel build() => _build();

  _$BranchModel _build() {
    _$BranchModel _$result;
    try {
      _$result = _$v ??
          new _$BranchModel._(
              id: id,
              name: name,
              photos: _photos?.build(),
              address: address,
              contact: contact,
              workingTime: workingTime,
              lat: lat,
              long: long);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photos';
        _photos?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BranchModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$BranchComplaintModel extends BranchComplaintModel {
  @override
  final int? id;
  @override
  final int? region;
  @override
  final String? text;

  factory _$BranchComplaintModel(
          [void Function(BranchComplaintModelBuilder)? updates]) =>
      (new BranchComplaintModelBuilder()..update(updates))._build();

  _$BranchComplaintModel._({this.id, this.region, this.text}) : super._();

  @override
  BranchComplaintModel rebuild(
          void Function(BranchComplaintModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BranchComplaintModelBuilder toBuilder() =>
      new BranchComplaintModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BranchComplaintModel &&
        id == other.id &&
        region == other.region &&
        text == other.text;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BranchComplaintModel')
          ..add('id', id)
          ..add('region', region)
          ..add('text', text))
        .toString();
  }
}

class BranchComplaintModelBuilder
    implements Builder<BranchComplaintModel, BranchComplaintModelBuilder> {
  _$BranchComplaintModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _region;
  int? get region => _$this._region;
  set region(int? region) => _$this._region = region;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  BranchComplaintModelBuilder();

  BranchComplaintModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _region = $v.region;
      _text = $v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BranchComplaintModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BranchComplaintModel;
  }

  @override
  void update(void Function(BranchComplaintModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BranchComplaintModel build() => _build();

  _$BranchComplaintModel _build() {
    final _$result =
        _$v ?? new _$BranchComplaintModel._(id: id, region: region, text: text);
    replace(_$result);
    return _$result;
  }
}

class _$NewsModel extends NewsModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? createdAt;
  @override
  final bool? famous;
  @override
  final BuiltList<String>? photos;

  factory _$NewsModel([void Function(NewsModelBuilder)? updates]) =>
      (new NewsModelBuilder()..update(updates))._build();

  _$NewsModel._(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.famous,
      this.photos})
      : super._();

  @override
  NewsModel rebuild(void Function(NewsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsModelBuilder toBuilder() => new NewsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewsModel &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        createdAt == other.createdAt &&
        famous == other.famous &&
        photos == other.photos;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, famous.hashCode);
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NewsModel')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('createdAt', createdAt)
          ..add('famous', famous)
          ..add('photos', photos))
        .toString();
  }
}

class NewsModelBuilder implements Builder<NewsModel, NewsModelBuilder> {
  _$NewsModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  bool? _famous;
  bool? get famous => _$this._famous;
  set famous(bool? famous) => _$this._famous = famous;

  ListBuilder<String>? _photos;
  ListBuilder<String> get photos =>
      _$this._photos ??= new ListBuilder<String>();
  set photos(ListBuilder<String>? photos) => _$this._photos = photos;

  NewsModelBuilder();

  NewsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _createdAt = $v.createdAt;
      _famous = $v.famous;
      _photos = $v.photos?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewsModel;
  }

  @override
  void update(void Function(NewsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NewsModel build() => _build();

  _$NewsModel _build() {
    _$NewsModel _$result;
    try {
      _$result = _$v ??
          new _$NewsModel._(
              id: id,
              title: title,
              description: description,
              createdAt: createdAt,
              famous: famous,
              photos: _photos?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'photos';
        _photos?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NewsModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NotificationModel extends NotificationModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? createdAt;
  @override
  final String? type;
  @override
  final String? photo;
  @override
  final bool? read;

  factory _$NotificationModel(
          [void Function(NotificationModelBuilder)? updates]) =>
      (new NotificationModelBuilder()..update(updates))._build();

  _$NotificationModel._(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.type,
      this.photo,
      this.read})
      : super._();

  @override
  NotificationModel rebuild(void Function(NotificationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationModelBuilder toBuilder() =>
      new NotificationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationModel &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        createdAt == other.createdAt &&
        type == other.type &&
        photo == other.photo &&
        read == other.read;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, photo.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationModel')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('createdAt', createdAt)
          ..add('type', type)
          ..add('photo', photo)
          ..add('read', read))
        .toString();
  }
}

class NotificationModelBuilder
    implements Builder<NotificationModel, NotificationModelBuilder> {
  _$NotificationModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _photo;
  String? get photo => _$this._photo;
  set photo(String? photo) => _$this._photo = photo;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  NotificationModelBuilder();

  NotificationModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _createdAt = $v.createdAt;
      _type = $v.type;
      _photo = $v.photo;
      _read = $v.read;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NotificationModel;
  }

  @override
  void update(void Function(NotificationModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationModel build() => _build();

  _$NotificationModel _build() {
    final _$result = _$v ??
        new _$NotificationModel._(
            id: id,
            title: title,
            description: description,
            createdAt: createdAt,
            type: type,
            photo: photo,
            read: read);
    replace(_$result);
    return _$result;
  }
}

class _$UnreadModel extends UnreadModel {
  @override
  final int? count;

  factory _$UnreadModel([void Function(UnreadModelBuilder)? updates]) =>
      (new UnreadModelBuilder()..update(updates))._build();

  _$UnreadModel._({this.count}) : super._();

  @override
  UnreadModel rebuild(void Function(UnreadModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnreadModelBuilder toBuilder() => new UnreadModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnreadModel && count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnreadModel')..add('count', count))
        .toString();
  }
}

class UnreadModelBuilder implements Builder<UnreadModel, UnreadModelBuilder> {
  _$UnreadModel? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  UnreadModelBuilder();

  UnreadModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnreadModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UnreadModel;
  }

  @override
  void update(void Function(UnreadModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnreadModel build() => _build();

  _$UnreadModel _build() {
    final _$result = _$v ?? new _$UnreadModel._(count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

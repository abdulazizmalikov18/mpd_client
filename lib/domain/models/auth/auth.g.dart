// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VerificationSendReq> _$verificationSendReqSerializer =
    new _$VerificationSendReqSerializer();
Serializer<VerificationVerifyReq> _$verificationVerifyReqSerializer =
    new _$VerificationVerifyReqSerializer();
Serializer<RegisterReq> _$registerReqSerializer = new _$RegisterReqSerializer();
Serializer<SignInReq> _$signInReqSerializer = new _$SignInReqSerializer();
Serializer<LoginRes> _$loginResSerializer = new _$LoginResSerializer();
Serializer<PasswordReq> _$passwordReqSerializer = new _$PasswordReqSerializer();
Serializer<CheckAuthModel> _$checkAuthModelSerializer =
    new _$CheckAuthModelSerializer();
Serializer<ResetPasswordReq> _$resetPasswordReqSerializer =
    new _$ResetPasswordReqSerializer();
Serializer<ForgotPasswordReqModel> _$forgotPasswordReqModelSerializer =
    new _$ForgotPasswordReqModelSerializer();
Serializer<ProfileModel> _$profileModelSerializer =
    new _$ProfileModelSerializer();
Serializer<ProfileRes> _$profileResSerializer = new _$ProfileResSerializer();

class _$VerificationSendReqSerializer
    implements StructuredSerializer<VerificationSendReq> {
  @override
  final Iterable<Type> types = const [
    VerificationSendReq,
    _$VerificationSendReq
  ];
  @override
  final String wireName = 'VerificationSendReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VerificationSendReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.autofill;
    if (value != null) {
      result
        ..add('autofill')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  VerificationSendReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VerificationSendReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'autofill':
          result.autofill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$VerificationVerifyReqSerializer
    implements StructuredSerializer<VerificationVerifyReq> {
  @override
  final Iterable<Type> types = const [
    VerificationVerifyReq,
    _$VerificationVerifyReq
  ];
  @override
  final String wireName = 'VerificationVerifyReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VerificationVerifyReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  VerificationVerifyReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VerificationVerifyReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$RegisterReqSerializer implements StructuredSerializer<RegisterReq> {
  @override
  final Iterable<Type> types = const [RegisterReq, _$RegisterReq];
  @override
  final String wireName = 'RegisterReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, RegisterReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.fullName;
    if (value != null) {
      result
        ..add('full_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  RegisterReq deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RegisterReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SignInReqSerializer implements StructuredSerializer<SignInReq> {
  @override
  final Iterable<Type> types = const [SignInReq, _$SignInReq];
  @override
  final String wireName = 'SignInReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, SignInReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SignInReq deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SignInReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResSerializer implements StructuredSerializer<LoginRes> {
  @override
  final Iterable<Type> types = const [LoginRes, _$LoginRes];
  @override
  final String wireName = 'LoginRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, LoginRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.access;
    if (value != null) {
      result
        ..add('access')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.refresh;
    if (value != null) {
      result
        ..add('refresh')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
  LoginRes deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'access':
          result.access = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'refresh':
          result.refresh = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'detail':
          result.detail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$PasswordReqSerializer implements StructuredSerializer<PasswordReq> {
  @override
  final Iterable<Type> types = const [PasswordReq, _$PasswordReq];
  @override
  final String wireName = 'PasswordReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, PasswordReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PasswordReq deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PasswordReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$CheckAuthModelSerializer
    implements StructuredSerializer<CheckAuthModel> {
  @override
  final Iterable<Type> types = const [CheckAuthModel, _$CheckAuthModel];
  @override
  final String wireName = 'CheckAuthModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CheckAuthModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
  CheckAuthModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CheckAuthModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'detail':
          result.detail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ResetPasswordReqSerializer
    implements StructuredSerializer<ResetPasswordReq> {
  @override
  final Iterable<Type> types = const [ResetPasswordReq, _$ResetPasswordReq];
  @override
  final String wireName = 'ResetPasswordReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, ResetPasswordReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.oldPwd;
    if (value != null) {
      result
        ..add('old-pwd')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.newPwd;
    if (value != null) {
      result
        ..add('new-pwd')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ResetPasswordReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ResetPasswordReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'old-pwd':
          result.oldPwd = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'new-pwd':
          result.newPwd = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ForgotPasswordReqModelSerializer
    implements StructuredSerializer<ForgotPasswordReqModel> {
  @override
  final Iterable<Type> types = const [
    ForgotPasswordReqModel,
    _$ForgotPasswordReqModel
  ];
  @override
  final String wireName = 'ForgotPasswordReqModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ForgotPasswordReqModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ForgotPasswordReqModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ForgotPasswordReqModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfileModelSerializer implements StructuredSerializer<ProfileModel> {
  @override
  final Iterable<Type> types = const [ProfileModel, _$ProfileModel];
  @override
  final String wireName = 'ProfileModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProfileModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.profilePic;
    if (value != null) {
      result
        ..add('profile_pic')
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
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ProfileModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'profile_pic':
          result.profilePic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'region':
          result.region = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfileResSerializer implements StructuredSerializer<ProfileRes> {
  @override
  final Iterable<Type> types = const [ProfileRes, _$ProfileRes];
  @override
  final String wireName = 'ProfileRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProfileRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.profilePic;
    if (value != null) {
      result
        ..add('profile_pic')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.region;
    if (value != null) {
      result
        ..add('region')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ProfileRes deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'profile_pic':
          result.profilePic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'region':
          result.region = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$VerificationSendReq extends VerificationSendReq {
  @override
  final String? phone;
  @override
  final String? autofill;

  factory _$VerificationSendReq(
          [void Function(VerificationSendReqBuilder)? updates]) =>
      (new VerificationSendReqBuilder()..update(updates))._build();

  _$VerificationSendReq._({this.phone, this.autofill}) : super._();

  @override
  VerificationSendReq rebuild(
          void Function(VerificationSendReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerificationSendReqBuilder toBuilder() =>
      new VerificationSendReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerificationSendReq &&
        phone == other.phone &&
        autofill == other.autofill;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, autofill.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerificationSendReq')
          ..add('phone', phone)
          ..add('autofill', autofill))
        .toString();
  }
}

class VerificationSendReqBuilder
    implements Builder<VerificationSendReq, VerificationSendReqBuilder> {
  _$VerificationSendReq? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _autofill;
  String? get autofill => _$this._autofill;
  set autofill(String? autofill) => _$this._autofill = autofill;

  VerificationSendReqBuilder();

  VerificationSendReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _autofill = $v.autofill;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerificationSendReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerificationSendReq;
  }

  @override
  void update(void Function(VerificationSendReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerificationSendReq build() => _build();

  _$VerificationSendReq _build() {
    final _$result =
        _$v ?? new _$VerificationSendReq._(phone: phone, autofill: autofill);
    replace(_$result);
    return _$result;
  }
}

class _$VerificationVerifyReq extends VerificationVerifyReq {
  @override
  final String? phone;
  @override
  final String? code;

  factory _$VerificationVerifyReq(
          [void Function(VerificationVerifyReqBuilder)? updates]) =>
      (new VerificationVerifyReqBuilder()..update(updates))._build();

  _$VerificationVerifyReq._({this.phone, this.code}) : super._();

  @override
  VerificationVerifyReq rebuild(
          void Function(VerificationVerifyReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerificationVerifyReqBuilder toBuilder() =>
      new VerificationVerifyReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerificationVerifyReq &&
        phone == other.phone &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerificationVerifyReq')
          ..add('phone', phone)
          ..add('code', code))
        .toString();
  }
}

class VerificationVerifyReqBuilder
    implements Builder<VerificationVerifyReq, VerificationVerifyReqBuilder> {
  _$VerificationVerifyReq? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  VerificationVerifyReqBuilder();

  VerificationVerifyReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerificationVerifyReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerificationVerifyReq;
  }

  @override
  void update(void Function(VerificationVerifyReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerificationVerifyReq build() => _build();

  _$VerificationVerifyReq _build() {
    final _$result =
        _$v ?? new _$VerificationVerifyReq._(phone: phone, code: code);
    replace(_$result);
    return _$result;
  }
}

class _$RegisterReq extends RegisterReq {
  @override
  final String? fullName;
  @override
  final String? password;

  factory _$RegisterReq([void Function(RegisterReqBuilder)? updates]) =>
      (new RegisterReqBuilder()..update(updates))._build();

  _$RegisterReq._({this.fullName, this.password}) : super._();

  @override
  RegisterReq rebuild(void Function(RegisterReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterReqBuilder toBuilder() => new RegisterReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterReq &&
        fullName == other.fullName &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterReq')
          ..add('fullName', fullName)
          ..add('password', password))
        .toString();
  }
}

class RegisterReqBuilder implements Builder<RegisterReq, RegisterReqBuilder> {
  _$RegisterReq? _$v;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  RegisterReqBuilder();

  RegisterReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fullName = $v.fullName;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegisterReq;
  }

  @override
  void update(void Function(RegisterReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterReq build() => _build();

  _$RegisterReq _build() {
    final _$result =
        _$v ?? new _$RegisterReq._(fullName: fullName, password: password);
    replace(_$result);
    return _$result;
  }
}

class _$SignInReq extends SignInReq {
  @override
  final String? phone;
  @override
  final String? password;

  factory _$SignInReq([void Function(SignInReqBuilder)? updates]) =>
      (new SignInReqBuilder()..update(updates))._build();

  _$SignInReq._({this.phone, this.password}) : super._();

  @override
  SignInReq rebuild(void Function(SignInReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignInReqBuilder toBuilder() => new SignInReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInReq &&
        phone == other.phone &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignInReq')
          ..add('phone', phone)
          ..add('password', password))
        .toString();
  }
}

class SignInReqBuilder implements Builder<SignInReq, SignInReqBuilder> {
  _$SignInReq? _$v;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  SignInReqBuilder();

  SignInReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phone = $v.phone;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignInReq;
  }

  @override
  void update(void Function(SignInReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignInReq build() => _build();

  _$SignInReq _build() {
    final _$result = _$v ?? new _$SignInReq._(phone: phone, password: password);
    replace(_$result);
    return _$result;
  }
}

class _$LoginRes extends LoginRes {
  @override
  final String? access;
  @override
  final String? refresh;
  @override
  final String? detail;

  factory _$LoginRes([void Function(LoginResBuilder)? updates]) =>
      (new LoginResBuilder()..update(updates))._build();

  _$LoginRes._({this.access, this.refresh, this.detail}) : super._();

  @override
  LoginRes rebuild(void Function(LoginResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResBuilder toBuilder() => new LoginResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginRes &&
        access == other.access &&
        refresh == other.refresh &&
        detail == other.detail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, access.hashCode);
    _$hash = $jc(_$hash, refresh.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginRes')
          ..add('access', access)
          ..add('refresh', refresh)
          ..add('detail', detail))
        .toString();
  }
}

class LoginResBuilder implements Builder<LoginRes, LoginResBuilder> {
  _$LoginRes? _$v;

  String? _access;
  String? get access => _$this._access;
  set access(String? access) => _$this._access = access;

  String? _refresh;
  String? get refresh => _$this._refresh;
  set refresh(String? refresh) => _$this._refresh = refresh;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  LoginResBuilder();

  LoginResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _access = $v.access;
      _refresh = $v.refresh;
      _detail = $v.detail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginRes;
  }

  @override
  void update(void Function(LoginResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginRes build() => _build();

  _$LoginRes _build() {
    final _$result = _$v ??
        new _$LoginRes._(access: access, refresh: refresh, detail: detail);
    replace(_$result);
    return _$result;
  }
}

class _$PasswordReq extends PasswordReq {
  @override
  final String? password;

  factory _$PasswordReq([void Function(PasswordReqBuilder)? updates]) =>
      (new PasswordReqBuilder()..update(updates))._build();

  _$PasswordReq._({this.password}) : super._();

  @override
  PasswordReq rebuild(void Function(PasswordReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordReqBuilder toBuilder() => new PasswordReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PasswordReq && password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PasswordReq')
          ..add('password', password))
        .toString();
  }
}

class PasswordReqBuilder implements Builder<PasswordReq, PasswordReqBuilder> {
  _$PasswordReq? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  PasswordReqBuilder();

  PasswordReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PasswordReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PasswordReq;
  }

  @override
  void update(void Function(PasswordReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PasswordReq build() => _build();

  _$PasswordReq _build() {
    final _$result = _$v ?? new _$PasswordReq._(password: password);
    replace(_$result);
    return _$result;
  }
}

class _$CheckAuthModel extends CheckAuthModel {
  @override
  final String? type;
  @override
  final String? detail;

  factory _$CheckAuthModel([void Function(CheckAuthModelBuilder)? updates]) =>
      (new CheckAuthModelBuilder()..update(updates))._build();

  _$CheckAuthModel._({this.type, this.detail}) : super._();

  @override
  CheckAuthModel rebuild(void Function(CheckAuthModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckAuthModelBuilder toBuilder() =>
      new CheckAuthModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckAuthModel &&
        type == other.type &&
        detail == other.detail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckAuthModel')
          ..add('type', type)
          ..add('detail', detail))
        .toString();
  }
}

class CheckAuthModelBuilder
    implements Builder<CheckAuthModel, CheckAuthModelBuilder> {
  _$CheckAuthModel? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  CheckAuthModelBuilder();

  CheckAuthModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _detail = $v.detail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckAuthModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CheckAuthModel;
  }

  @override
  void update(void Function(CheckAuthModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckAuthModel build() => _build();

  _$CheckAuthModel _build() {
    final _$result = _$v ?? new _$CheckAuthModel._(type: type, detail: detail);
    replace(_$result);
    return _$result;
  }
}

class _$ResetPasswordReq extends ResetPasswordReq {
  @override
  final String? oldPwd;
  @override
  final String? newPwd;

  factory _$ResetPasswordReq(
          [void Function(ResetPasswordReqBuilder)? updates]) =>
      (new ResetPasswordReqBuilder()..update(updates))._build();

  _$ResetPasswordReq._({this.oldPwd, this.newPwd}) : super._();

  @override
  ResetPasswordReq rebuild(void Function(ResetPasswordReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordReqBuilder toBuilder() =>
      new ResetPasswordReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordReq &&
        oldPwd == other.oldPwd &&
        newPwd == other.newPwd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oldPwd.hashCode);
    _$hash = $jc(_$hash, newPwd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPasswordReq')
          ..add('oldPwd', oldPwd)
          ..add('newPwd', newPwd))
        .toString();
  }
}

class ResetPasswordReqBuilder
    implements Builder<ResetPasswordReq, ResetPasswordReqBuilder> {
  _$ResetPasswordReq? _$v;

  String? _oldPwd;
  String? get oldPwd => _$this._oldPwd;
  set oldPwd(String? oldPwd) => _$this._oldPwd = oldPwd;

  String? _newPwd;
  String? get newPwd => _$this._newPwd;
  set newPwd(String? newPwd) => _$this._newPwd = newPwd;

  ResetPasswordReqBuilder();

  ResetPasswordReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oldPwd = $v.oldPwd;
      _newPwd = $v.newPwd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResetPasswordReq;
  }

  @override
  void update(void Function(ResetPasswordReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordReq build() => _build();

  _$ResetPasswordReq _build() {
    final _$result =
        _$v ?? new _$ResetPasswordReq._(oldPwd: oldPwd, newPwd: newPwd);
    replace(_$result);
    return _$result;
  }
}

class _$ForgotPasswordReqModel extends ForgotPasswordReqModel {
  @override
  final String? code;
  @override
  final String? phone;
  @override
  final String? password;

  factory _$ForgotPasswordReqModel(
          [void Function(ForgotPasswordReqModelBuilder)? updates]) =>
      (new ForgotPasswordReqModelBuilder()..update(updates))._build();

  _$ForgotPasswordReqModel._({this.code, this.phone, this.password})
      : super._();

  @override
  ForgotPasswordReqModel rebuild(
          void Function(ForgotPasswordReqModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForgotPasswordReqModelBuilder toBuilder() =>
      new ForgotPasswordReqModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgotPasswordReqModel &&
        code == other.code &&
        phone == other.phone &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForgotPasswordReqModel')
          ..add('code', code)
          ..add('phone', phone)
          ..add('password', password))
        .toString();
  }
}

class ForgotPasswordReqModelBuilder
    implements Builder<ForgotPasswordReqModel, ForgotPasswordReqModelBuilder> {
  _$ForgotPasswordReqModel? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  ForgotPasswordReqModelBuilder();

  ForgotPasswordReqModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _phone = $v.phone;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgotPasswordReqModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ForgotPasswordReqModel;
  }

  @override
  void update(void Function(ForgotPasswordReqModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgotPasswordReqModel build() => _build();

  _$ForgotPasswordReqModel _build() {
    final _$result = _$v ??
        new _$ForgotPasswordReqModel._(
            code: code, phone: phone, password: password);
    replace(_$result);
    return _$result;
  }
}

class _$ProfileModel extends ProfileModel {
  @override
  final String? profilePic;
  @override
  final String? fullName;
  @override
  final int? region;

  factory _$ProfileModel([void Function(ProfileModelBuilder)? updates]) =>
      (new ProfileModelBuilder()..update(updates))._build();

  _$ProfileModel._({this.profilePic, this.fullName, this.region}) : super._();

  @override
  ProfileModel rebuild(void Function(ProfileModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileModelBuilder toBuilder() => new ProfileModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileModel &&
        profilePic == other.profilePic &&
        fullName == other.fullName &&
        region == other.region;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, profilePic.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileModel')
          ..add('profilePic', profilePic)
          ..add('fullName', fullName)
          ..add('region', region))
        .toString();
  }
}

class ProfileModelBuilder
    implements Builder<ProfileModel, ProfileModelBuilder> {
  _$ProfileModel? _$v;

  String? _profilePic;
  String? get profilePic => _$this._profilePic;
  set profilePic(String? profilePic) => _$this._profilePic = profilePic;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  int? _region;
  int? get region => _$this._region;
  set region(int? region) => _$this._region = region;

  ProfileModelBuilder();

  ProfileModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _profilePic = $v.profilePic;
      _fullName = $v.fullName;
      _region = $v.region;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileModel;
  }

  @override
  void update(void Function(ProfileModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileModel build() => _build();

  _$ProfileModel _build() {
    final _$result = _$v ??
        new _$ProfileModel._(
            profilePic: profilePic, fullName: fullName, region: region);
    replace(_$result);
    return _$result;
  }
}

class _$ProfileRes extends ProfileRes {
  @override
  final String? profilePic;
  @override
  final String? username;
  @override
  final String? fullName;
  @override
  final int? region;
  @override
  final bool? password;

  factory _$ProfileRes([void Function(ProfileResBuilder)? updates]) =>
      (new ProfileResBuilder()..update(updates))._build();

  _$ProfileRes._(
      {this.profilePic,
      this.username,
      this.fullName,
      this.region,
      this.password})
      : super._();

  @override
  ProfileRes rebuild(void Function(ProfileResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileResBuilder toBuilder() => new ProfileResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileRes &&
        profilePic == other.profilePic &&
        username == other.username &&
        fullName == other.fullName &&
        region == other.region &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, profilePic.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, region.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileRes')
          ..add('profilePic', profilePic)
          ..add('username', username)
          ..add('fullName', fullName)
          ..add('region', region)
          ..add('password', password))
        .toString();
  }
}

class ProfileResBuilder implements Builder<ProfileRes, ProfileResBuilder> {
  _$ProfileRes? _$v;

  String? _profilePic;
  String? get profilePic => _$this._profilePic;
  set profilePic(String? profilePic) => _$this._profilePic = profilePic;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  int? _region;
  int? get region => _$this._region;
  set region(int? region) => _$this._region = region;

  bool? _password;
  bool? get password => _$this._password;
  set password(bool? password) => _$this._password = password;

  ProfileResBuilder();

  ProfileResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _profilePic = $v.profilePic;
      _username = $v.username;
      _fullName = $v.fullName;
      _region = $v.region;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileRes;
  }

  @override
  void update(void Function(ProfileResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileRes build() => _build();

  _$ProfileRes _build() {
    final _$result = _$v ??
        new _$ProfileRes._(
            profilePic: profilePic,
            username: username,
            fullName: fullName,
            region: region,
            password: password);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

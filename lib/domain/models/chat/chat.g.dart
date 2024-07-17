// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatWroteModel> _$chatWroteModelSerializer =
    new _$ChatWroteModelSerializer();
Serializer<ChatBlockModel> _$chatBlockModelSerializer =
    new _$ChatBlockModelSerializer();
Serializer<UserStatusModel> _$userStatusModelSerializer =
    new _$UserStatusModelSerializer();
Serializer<ContactModel> _$contactModelSerializer =
    new _$ContactModelSerializer();
Serializer<ChatMessageReq> _$chatMessageReqSerializer =
    new _$ChatMessageReqSerializer();
Serializer<ChatRoomModel> _$chatRoomModelSerializer =
    new _$ChatRoomModelSerializer();
Serializer<ChatUserModel> _$chatUserModelSerializer =
    new _$ChatUserModelSerializer();
Serializer<ChatMessageRes> _$chatMessageResSerializer =
    new _$ChatMessageResSerializer();
Serializer<RoomExistModel> _$roomExistModelSerializer =
    new _$RoomExistModelSerializer();

class _$ChatWroteModelSerializer
    implements StructuredSerializer<ChatWroteModel> {
  @override
  final Iterable<Type> types = const [ChatWroteModel, _$ChatWroteModel];
  @override
  final String wireName = 'ChatWroteModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatWroteModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.senderId;
    if (value != null) {
      result
        ..add('sender_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.announcementId;
    if (value != null) {
      result
        ..add('announcement_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.receiverId;
    if (value != null) {
      result
        ..add('receiver_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ChatWroteModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatWroteModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'sender_id':
          result.senderId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'announcement_id':
          result.announcementId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'receiver_id':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatBlockModelSerializer
    implements StructuredSerializer<ChatBlockModel> {
  @override
  final Iterable<Type> types = const [ChatBlockModel, _$ChatBlockModel];
  @override
  final String wireName = 'ChatBlockModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatBlockModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.reason;
    if (value != null) {
      result
        ..add('reason')
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
    value = object.blocker;
    if (value != null) {
      result
        ..add('blocker')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.blocked;
    if (value != null) {
      result
        ..add('blocked')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  ChatBlockModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatBlockModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'reason':
          result.reason = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'blocker':
          result.blocker = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'blocked':
          result.blocked = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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

class _$UserStatusModelSerializer
    implements StructuredSerializer<UserStatusModel> {
  @override
  final Iterable<Type> types = const [UserStatusModel, _$UserStatusModel];
  @override
  final String wireName = 'UserStatusModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserStatusModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  UserStatusModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStatusModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$ContactModelSerializer implements StructuredSerializer<ContactModel> {
  @override
  final Iterable<Type> types = const [ContactModel, _$ContactModel];
  @override
  final String wireName = 'ContactModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ContactModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.roomId;
    if (value != null) {
      result
        ..add('room_id')
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
    value = object.unreads;
    if (value != null) {
      result
        ..add('unreads')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.announcement;
    if (value != null) {
      result
        ..add('announcement')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ContactModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ContactModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'room_id':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'contact':
          result.contact = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'unreads':
          result.unreads = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'announcement':
          result.announcement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatMessageReqSerializer
    implements StructuredSerializer<ChatMessageReq> {
  @override
  final Iterable<Type> types = const [ChatMessageReq, _$ChatMessageReq];
  @override
  final String wireName = 'ChatMessageReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatMessageReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.roomId;
    if (value != null) {
      result
        ..add('room_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.ownerId;
    if (value != null) {
      result
        ..add('owner_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.receiverId;
    if (value != null) {
      result
        ..add('receiver_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
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
  ChatMessageReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatMessageReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'room_id':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'owner_id':
          result.ownerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'receiver_id':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
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

class _$ChatRoomModelSerializer implements StructuredSerializer<ChatRoomModel> {
  @override
  final Iterable<Type> types = const [ChatRoomModel, _$ChatRoomModel];
  @override
  final String wireName = 'ChatRoomModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatRoomModel object,
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
    value = object.firstPerson;
    if (value != null) {
      result
        ..add('first_person')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.secondPerson;
    if (value != null) {
      result
        ..add('second_person')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.announcement;
    if (value != null) {
      result
        ..add('announcement')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
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
  ChatRoomModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatRoomModelBuilder();

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
        case 'first_person':
          result.firstPerson = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'second_person':
          result.secondPerson = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'announcement':
          result.announcement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
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

class _$ChatUserModelSerializer implements StructuredSerializer<ChatUserModel> {
  @override
  final Iterable<Type> types = const [ChatUserModel, _$ChatUserModel];
  @override
  final String wireName = 'ChatUserModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatUserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
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
    value = object.firstName;
    if (value != null) {
      result
        ..add('first_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fcmToken;
    if (value != null) {
      result
        ..add('fcm_token')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ChatUserModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatUserModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fcm_token':
          result.fcmToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatMessageResSerializer
    implements StructuredSerializer<ChatMessageRes> {
  @override
  final Iterable<Type> types = const [ChatMessageRes, _$ChatMessageRes];
  @override
  final String wireName = 'ChatMessageRes';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatMessageRes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'owner',
      serializers.serialize(object.owner,
          specifiedType: const FullType(String)),
      'sent_time',
      serializers.serialize(object.sentTime,
          specifiedType: const FullType(String)),
      'room',
      serializers.serialize(object.room, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ChatMessageRes deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatMessageResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'owner':
          result.owner = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sent_time':
          result.sentTime = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'room':
          result.room = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$RoomExistModelSerializer
    implements StructuredSerializer<RoomExistModel> {
  @override
  final Iterable<Type> types = const [RoomExistModel, _$RoomExistModel];
  @override
  final String wireName = 'RoomExistModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, RoomExistModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'exist',
      serializers.serialize(object.exist, specifiedType: const FullType(bool)),
      'room_id',
      serializers.serialize(object.roomId, specifiedType: const FullType(int)),
      'blocked',
      serializers.serialize(object.blocked,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  RoomExistModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RoomExistModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'exist':
          result.exist = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'room_id':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'blocked':
          result.blocked = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatWroteModel extends ChatWroteModel {
  @override
  final int? senderId;
  @override
  final int? announcementId;
  @override
  final int? receiverId;

  factory _$ChatWroteModel([void Function(ChatWroteModelBuilder)? updates]) =>
      (new ChatWroteModelBuilder()..update(updates))._build();

  _$ChatWroteModel._({this.senderId, this.announcementId, this.receiverId})
      : super._();

  @override
  ChatWroteModel rebuild(void Function(ChatWroteModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatWroteModelBuilder toBuilder() =>
      new ChatWroteModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatWroteModel &&
        senderId == other.senderId &&
        announcementId == other.announcementId &&
        receiverId == other.receiverId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, announcementId.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatWroteModel')
          ..add('senderId', senderId)
          ..add('announcementId', announcementId)
          ..add('receiverId', receiverId))
        .toString();
  }
}

class ChatWroteModelBuilder
    implements Builder<ChatWroteModel, ChatWroteModelBuilder> {
  _$ChatWroteModel? _$v;

  int? _senderId;
  int? get senderId => _$this._senderId;
  set senderId(int? senderId) => _$this._senderId = senderId;

  int? _announcementId;
  int? get announcementId => _$this._announcementId;
  set announcementId(int? announcementId) =>
      _$this._announcementId = announcementId;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  ChatWroteModelBuilder();

  ChatWroteModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _senderId = $v.senderId;
      _announcementId = $v.announcementId;
      _receiverId = $v.receiverId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatWroteModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatWroteModel;
  }

  @override
  void update(void Function(ChatWroteModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatWroteModel build() => _build();

  _$ChatWroteModel _build() {
    final _$result = _$v ??
        new _$ChatWroteModel._(
            senderId: senderId,
            announcementId: announcementId,
            receiverId: receiverId);
    replace(_$result);
    return _$result;
  }
}

class _$ChatBlockModel extends ChatBlockModel {
  @override
  final String? reason;
  @override
  final String? description;
  @override
  final int? blocker;
  @override
  final int? blocked;
  @override
  final int? id;

  factory _$ChatBlockModel([void Function(ChatBlockModelBuilder)? updates]) =>
      (new ChatBlockModelBuilder()..update(updates))._build();

  _$ChatBlockModel._(
      {this.reason, this.description, this.blocker, this.blocked, this.id})
      : super._();

  @override
  ChatBlockModel rebuild(void Function(ChatBlockModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatBlockModelBuilder toBuilder() =>
      new ChatBlockModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatBlockModel &&
        reason == other.reason &&
        description == other.description &&
        blocker == other.blocker &&
        blocked == other.blocked &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, blocker.hashCode);
    _$hash = $jc(_$hash, blocked.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatBlockModel')
          ..add('reason', reason)
          ..add('description', description)
          ..add('blocker', blocker)
          ..add('blocked', blocked)
          ..add('id', id))
        .toString();
  }
}

class ChatBlockModelBuilder
    implements Builder<ChatBlockModel, ChatBlockModelBuilder> {
  _$ChatBlockModel? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _blocker;
  int? get blocker => _$this._blocker;
  set blocker(int? blocker) => _$this._blocker = blocker;

  int? _blocked;
  int? get blocked => _$this._blocked;
  set blocked(int? blocked) => _$this._blocked = blocked;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ChatBlockModelBuilder();

  ChatBlockModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _description = $v.description;
      _blocker = $v.blocker;
      _blocked = $v.blocked;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatBlockModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatBlockModel;
  }

  @override
  void update(void Function(ChatBlockModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatBlockModel build() => _build();

  _$ChatBlockModel _build() {
    final _$result = _$v ??
        new _$ChatBlockModel._(
            reason: reason,
            description: description,
            blocker: blocker,
            blocked: blocked,
            id: id);
    replace(_$result);
    return _$result;
  }
}

class _$UserStatusModel extends UserStatusModel {
  @override
  final int? userId;
  @override
  final bool? status;

  factory _$UserStatusModel([void Function(UserStatusModelBuilder)? updates]) =>
      (new UserStatusModelBuilder()..update(updates))._build();

  _$UserStatusModel._({this.userId, this.status}) : super._();

  @override
  UserStatusModel rebuild(void Function(UserStatusModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStatusModelBuilder toBuilder() =>
      new UserStatusModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserStatusModel &&
        userId == other.userId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserStatusModel')
          ..add('userId', userId)
          ..add('status', status))
        .toString();
  }
}

class UserStatusModelBuilder
    implements Builder<UserStatusModel, UserStatusModelBuilder> {
  _$UserStatusModel? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  UserStatusModelBuilder();

  UserStatusModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserStatusModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserStatusModel;
  }

  @override
  void update(void Function(UserStatusModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserStatusModel build() => _build();

  _$UserStatusModel _build() {
    final _$result =
        _$v ?? new _$UserStatusModel._(userId: userId, status: status);
    replace(_$result);
    return _$result;
  }
}

class _$ContactModel extends ContactModel {
  @override
  final String? roomId;
  @override
  final String? contact;
  @override
  final String? unreads;
  @override
  final String? announcement;

  factory _$ContactModel([void Function(ContactModelBuilder)? updates]) =>
      (new ContactModelBuilder()..update(updates))._build();

  _$ContactModel._({this.roomId, this.contact, this.unreads, this.announcement})
      : super._();

  @override
  ContactModel rebuild(void Function(ContactModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContactModelBuilder toBuilder() => new ContactModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContactModel &&
        roomId == other.roomId &&
        contact == other.contact &&
        unreads == other.unreads &&
        announcement == other.announcement;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, contact.hashCode);
    _$hash = $jc(_$hash, unreads.hashCode);
    _$hash = $jc(_$hash, announcement.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContactModel')
          ..add('roomId', roomId)
          ..add('contact', contact)
          ..add('unreads', unreads)
          ..add('announcement', announcement))
        .toString();
  }
}

class ContactModelBuilder
    implements Builder<ContactModel, ContactModelBuilder> {
  _$ContactModel? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _contact;
  String? get contact => _$this._contact;
  set contact(String? contact) => _$this._contact = contact;

  String? _unreads;
  String? get unreads => _$this._unreads;
  set unreads(String? unreads) => _$this._unreads = unreads;

  String? _announcement;
  String? get announcement => _$this._announcement;
  set announcement(String? announcement) => _$this._announcement = announcement;

  ContactModelBuilder();

  ContactModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _contact = $v.contact;
      _unreads = $v.unreads;
      _announcement = $v.announcement;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContactModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ContactModel;
  }

  @override
  void update(void Function(ContactModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContactModel build() => _build();

  _$ContactModel _build() {
    final _$result = _$v ??
        new _$ContactModel._(
            roomId: roomId,
            contact: contact,
            unreads: unreads,
            announcement: announcement);
    replace(_$result);
    return _$result;
  }
}

class _$ChatMessageReq extends ChatMessageReq {
  @override
  final int? roomId;
  @override
  final int? ownerId;
  @override
  final int? receiverId;
  @override
  final String? message;
  @override
  final bool? read;

  factory _$ChatMessageReq([void Function(ChatMessageReqBuilder)? updates]) =>
      (new ChatMessageReqBuilder()..update(updates))._build();

  _$ChatMessageReq._(
      {this.roomId, this.ownerId, this.receiverId, this.message, this.read})
      : super._();

  @override
  ChatMessageReq rebuild(void Function(ChatMessageReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatMessageReqBuilder toBuilder() =>
      new ChatMessageReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatMessageReq &&
        roomId == other.roomId &&
        ownerId == other.ownerId &&
        receiverId == other.receiverId &&
        message == other.message &&
        read == other.read;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, ownerId.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatMessageReq')
          ..add('roomId', roomId)
          ..add('ownerId', ownerId)
          ..add('receiverId', receiverId)
          ..add('message', message)
          ..add('read', read))
        .toString();
  }
}

class ChatMessageReqBuilder
    implements Builder<ChatMessageReq, ChatMessageReqBuilder> {
  _$ChatMessageReq? _$v;

  int? _roomId;
  int? get roomId => _$this._roomId;
  set roomId(int? roomId) => _$this._roomId = roomId;

  int? _ownerId;
  int? get ownerId => _$this._ownerId;
  set ownerId(int? ownerId) => _$this._ownerId = ownerId;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  ChatMessageReqBuilder();

  ChatMessageReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _ownerId = $v.ownerId;
      _receiverId = $v.receiverId;
      _message = $v.message;
      _read = $v.read;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatMessageReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatMessageReq;
  }

  @override
  void update(void Function(ChatMessageReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatMessageReq build() => _build();

  _$ChatMessageReq _build() {
    final _$result = _$v ??
        new _$ChatMessageReq._(
            roomId: roomId,
            ownerId: ownerId,
            receiverId: receiverId,
            message: message,
            read: read);
    replace(_$result);
    return _$result;
  }
}

class _$ChatRoomModel extends ChatRoomModel {
  @override
  final String? name;
  @override
  final int? firstPerson;
  @override
  final int? secondPerson;
  @override
  final String? announcement;
  @override
  final String? updatedAt;
  @override
  final int? id;

  factory _$ChatRoomModel([void Function(ChatRoomModelBuilder)? updates]) =>
      (new ChatRoomModelBuilder()..update(updates))._build();

  _$ChatRoomModel._(
      {this.name,
      this.firstPerson,
      this.secondPerson,
      this.announcement,
      this.updatedAt,
      this.id})
      : super._();

  @override
  ChatRoomModel rebuild(void Function(ChatRoomModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatRoomModelBuilder toBuilder() => new ChatRoomModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRoomModel &&
        name == other.name &&
        firstPerson == other.firstPerson &&
        secondPerson == other.secondPerson &&
        announcement == other.announcement &&
        updatedAt == other.updatedAt &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, firstPerson.hashCode);
    _$hash = $jc(_$hash, secondPerson.hashCode);
    _$hash = $jc(_$hash, announcement.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatRoomModel')
          ..add('name', name)
          ..add('firstPerson', firstPerson)
          ..add('secondPerson', secondPerson)
          ..add('announcement', announcement)
          ..add('updatedAt', updatedAt)
          ..add('id', id))
        .toString();
  }
}

class ChatRoomModelBuilder
    implements Builder<ChatRoomModel, ChatRoomModelBuilder> {
  _$ChatRoomModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _firstPerson;
  int? get firstPerson => _$this._firstPerson;
  set firstPerson(int? firstPerson) => _$this._firstPerson = firstPerson;

  int? _secondPerson;
  int? get secondPerson => _$this._secondPerson;
  set secondPerson(int? secondPerson) => _$this._secondPerson = secondPerson;

  String? _announcement;
  String? get announcement => _$this._announcement;
  set announcement(String? announcement) => _$this._announcement = announcement;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ChatRoomModelBuilder();

  ChatRoomModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _firstPerson = $v.firstPerson;
      _secondPerson = $v.secondPerson;
      _announcement = $v.announcement;
      _updatedAt = $v.updatedAt;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatRoomModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatRoomModel;
  }

  @override
  void update(void Function(ChatRoomModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatRoomModel build() => _build();

  _$ChatRoomModel _build() {
    final _$result = _$v ??
        new _$ChatRoomModel._(
            name: name,
            firstPerson: firstPerson,
            secondPerson: secondPerson,
            announcement: announcement,
            updatedAt: updatedAt,
            id: id);
    replace(_$result);
    return _$result;
  }
}

class _$ChatUserModel extends ChatUserModel {
  @override
  final String? id;
  @override
  final String? username;
  @override
  final String? firstName;
  @override
  final String? fcmToken;

  factory _$ChatUserModel([void Function(ChatUserModelBuilder)? updates]) =>
      (new ChatUserModelBuilder()..update(updates))._build();

  _$ChatUserModel._({this.id, this.username, this.firstName, this.fcmToken})
      : super._();

  @override
  ChatUserModel rebuild(void Function(ChatUserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatUserModelBuilder toBuilder() => new ChatUserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatUserModel &&
        id == other.id &&
        username == other.username &&
        firstName == other.firstName &&
        fcmToken == other.fcmToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, fcmToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatUserModel')
          ..add('id', id)
          ..add('username', username)
          ..add('firstName', firstName)
          ..add('fcmToken', fcmToken))
        .toString();
  }
}

class ChatUserModelBuilder
    implements Builder<ChatUserModel, ChatUserModelBuilder> {
  _$ChatUserModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _fcmToken;
  String? get fcmToken => _$this._fcmToken;
  set fcmToken(String? fcmToken) => _$this._fcmToken = fcmToken;

  ChatUserModelBuilder();

  ChatUserModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _firstName = $v.firstName;
      _fcmToken = $v.fcmToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatUserModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatUserModel;
  }

  @override
  void update(void Function(ChatUserModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatUserModel build() => _build();

  _$ChatUserModel _build() {
    final _$result = _$v ??
        new _$ChatUserModel._(
            id: id,
            username: username,
            firstName: firstName,
            fcmToken: fcmToken);
    replace(_$result);
    return _$result;
  }
}

class _$ChatMessageRes extends ChatMessageRes {
  @override
  final String message;
  @override
  final String owner;
  @override
  final String sentTime;
  @override
  final String room;

  factory _$ChatMessageRes([void Function(ChatMessageResBuilder)? updates]) =>
      (new ChatMessageResBuilder()..update(updates))._build();

  _$ChatMessageRes._(
      {required this.message,
      required this.owner,
      required this.sentTime,
      required this.room})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, r'ChatMessageRes', 'message');
    BuiltValueNullFieldError.checkNotNull(owner, r'ChatMessageRes', 'owner');
    BuiltValueNullFieldError.checkNotNull(
        sentTime, r'ChatMessageRes', 'sentTime');
    BuiltValueNullFieldError.checkNotNull(room, r'ChatMessageRes', 'room');
  }

  @override
  ChatMessageRes rebuild(void Function(ChatMessageResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatMessageResBuilder toBuilder() =>
      new ChatMessageResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatMessageRes &&
        message == other.message &&
        owner == other.owner &&
        sentTime == other.sentTime &&
        room == other.room;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, sentTime.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatMessageRes')
          ..add('message', message)
          ..add('owner', owner)
          ..add('sentTime', sentTime)
          ..add('room', room))
        .toString();
  }
}

class ChatMessageResBuilder
    implements Builder<ChatMessageRes, ChatMessageResBuilder> {
  _$ChatMessageRes? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _sentTime;
  String? get sentTime => _$this._sentTime;
  set sentTime(String? sentTime) => _$this._sentTime = sentTime;

  String? _room;
  String? get room => _$this._room;
  set room(String? room) => _$this._room = room;

  ChatMessageResBuilder();

  ChatMessageResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _owner = $v.owner;
      _sentTime = $v.sentTime;
      _room = $v.room;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatMessageRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatMessageRes;
  }

  @override
  void update(void Function(ChatMessageResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatMessageRes build() => _build();

  _$ChatMessageRes _build() {
    final _$result = _$v ??
        new _$ChatMessageRes._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'ChatMessageRes', 'message'),
            owner: BuiltValueNullFieldError.checkNotNull(
                owner, r'ChatMessageRes', 'owner'),
            sentTime: BuiltValueNullFieldError.checkNotNull(
                sentTime, r'ChatMessageRes', 'sentTime'),
            room: BuiltValueNullFieldError.checkNotNull(
                room, r'ChatMessageRes', 'room'));
    replace(_$result);
    return _$result;
  }
}

class _$RoomExistModel extends RoomExistModel {
  @override
  final bool exist;
  @override
  final int roomId;
  @override
  final bool blocked;

  factory _$RoomExistModel([void Function(RoomExistModelBuilder)? updates]) =>
      (new RoomExistModelBuilder()..update(updates))._build();

  _$RoomExistModel._(
      {required this.exist, required this.roomId, required this.blocked})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(exist, r'RoomExistModel', 'exist');
    BuiltValueNullFieldError.checkNotNull(roomId, r'RoomExistModel', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        blocked, r'RoomExistModel', 'blocked');
  }

  @override
  RoomExistModel rebuild(void Function(RoomExistModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoomExistModelBuilder toBuilder() =>
      new RoomExistModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoomExistModel &&
        exist == other.exist &&
        roomId == other.roomId &&
        blocked == other.blocked;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, exist.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, blocked.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoomExistModel')
          ..add('exist', exist)
          ..add('roomId', roomId)
          ..add('blocked', blocked))
        .toString();
  }
}

class RoomExistModelBuilder
    implements Builder<RoomExistModel, RoomExistModelBuilder> {
  _$RoomExistModel? _$v;

  bool? _exist;
  bool? get exist => _$this._exist;
  set exist(bool? exist) => _$this._exist = exist;

  int? _roomId;
  int? get roomId => _$this._roomId;
  set roomId(int? roomId) => _$this._roomId = roomId;

  bool? _blocked;
  bool? get blocked => _$this._blocked;
  set blocked(bool? blocked) => _$this._blocked = blocked;

  RoomExistModelBuilder();

  RoomExistModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _exist = $v.exist;
      _roomId = $v.roomId;
      _blocked = $v.blocked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoomExistModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RoomExistModel;
  }

  @override
  void update(void Function(RoomExistModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoomExistModel build() => _build();

  _$RoomExistModel _build() {
    final _$result = _$v ??
        new _$RoomExistModel._(
            exist: BuiltValueNullFieldError.checkNotNull(
                exist, r'RoomExistModel', 'exist'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'RoomExistModel', 'roomId'),
            blocked: BuiltValueNullFieldError.checkNotNull(
                blocked, r'RoomExistModel', 'blocked'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

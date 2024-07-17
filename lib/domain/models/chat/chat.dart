import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat.g.dart';

abstract class ChatWroteModel
    implements Built<ChatWroteModel, ChatWroteModelBuilder> {
  ChatWroteModel._();

  factory ChatWroteModel([Function(ChatWroteModelBuilder b) updates]) =
      _$ChatWroteModel;

  @BuiltValueField(wireName: 'sender_id')
  int? get senderId;
  @BuiltValueField(wireName: 'announcement_id')
  int? get announcementId;
  @BuiltValueField(wireName: 'receiver_id')
  int? get receiverId;

  static Serializer<ChatWroteModel> get serializer =>
      _$chatWroteModelSerializer;
}

abstract class ChatBlockModel
    implements Built<ChatBlockModel, ChatBlockModelBuilder> {
  ChatBlockModel._();

  factory ChatBlockModel([Function(ChatBlockModelBuilder b) updates]) =
      _$ChatBlockModel;

  @BuiltValueField(wireName: 'reason')
  String? get reason;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'blocker')
  int? get blocker;
  @BuiltValueField(wireName: 'blocked')
  int? get blocked;
  @BuiltValueField(wireName: 'id')
  int? get id;

  static Serializer<ChatBlockModel> get serializer =>
      _$chatBlockModelSerializer;
}

abstract class UserStatusModel
    implements Built<UserStatusModel, UserStatusModelBuilder> {
  UserStatusModel._();

  factory UserStatusModel([Function(UserStatusModelBuilder b) updates]) =
      _$UserStatusModel;

  @BuiltValueField(wireName: 'user_id')
  int? get userId;
  @BuiltValueField(wireName: 'status')
  bool? get status;

  static Serializer<UserStatusModel> get serializer =>
      _$userStatusModelSerializer;
}

abstract class ContactModel
    implements Built<ContactModel, ContactModelBuilder> {
  ContactModel._();

  factory ContactModel([Function(ContactModelBuilder b) updates]) =
      _$ContactModel;

  @BuiltValueField(wireName: 'room_id')
  String? get roomId;
  @BuiltValueField(wireName: 'contact')
  String? get contact;
  @BuiltValueField(wireName: 'unreads')
  String? get unreads;
  @BuiltValueField(wireName: 'announcement')
  String? get announcement;

  static Serializer<ContactModel> get serializer => _$contactModelSerializer;
}

abstract class ChatMessageReq
    implements Built<ChatMessageReq, ChatMessageReqBuilder> {
  ChatMessageReq._();

  factory ChatMessageReq([Function(ChatMessageReqBuilder b) updates]) =
      _$ChatMessageReq;

  @BuiltValueField(wireName: 'room_id')
  int? get roomId;
  @BuiltValueField(wireName: 'owner_id')
  int? get ownerId;
  @BuiltValueField(wireName: 'receiver_id')
  int? get receiverId;
  @BuiltValueField(wireName: 'message')
  String? get message;
  @BuiltValueField(wireName: 'read')
  bool? get read;

  static Serializer<ChatMessageReq> get serializer =>
      _$chatMessageReqSerializer;
}

abstract class ChatRoomModel
    implements Built<ChatRoomModel, ChatRoomModelBuilder> {
  ChatRoomModel._();

  factory ChatRoomModel([Function(ChatRoomModelBuilder b) updates]) =
      _$ChatRoomModel;

  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'first_person')
  int? get firstPerson;
  @BuiltValueField(wireName: 'second_person')
  int? get secondPerson;
  @BuiltValueField(wireName: 'announcement')
  String? get announcement;
  @BuiltValueField(wireName: 'updated_at')
  String? get updatedAt;
  @BuiltValueField(wireName: 'id')
  int? get id;

  static Serializer<ChatRoomModel> get serializer => _$chatRoomModelSerializer;
}

abstract class ChatUserModel
    implements Built<ChatUserModel, ChatUserModelBuilder> {
  ChatUserModel._();

  factory ChatUserModel([Function(ChatUserModelBuilder b) updates]) =
      _$ChatUserModel;

  @BuiltValueField(wireName: 'id')
  String? get id;
  @BuiltValueField(wireName: 'username')
  String? get username;
  @BuiltValueField(wireName: 'first_name')
  String? get firstName;
  @BuiltValueField(wireName: 'fcm_token')
  String? get fcmToken;

  static Serializer<ChatUserModel> get serializer => _$chatUserModelSerializer;
}

abstract class ChatMessageRes
    implements Built<ChatMessageRes, ChatMessageResBuilder> {
  ChatMessageRes._();

  factory ChatMessageRes([Function(ChatMessageResBuilder b) updates]) =
      _$ChatMessageRes;

  @BuiltValueField(wireName: 'message')
  String get message;
  @BuiltValueField(wireName: 'owner')
  String get owner;
  @BuiltValueField(wireName: 'sent_time')
  String get sentTime;
  @BuiltValueField(wireName: 'room')
  String get room;

  static Serializer<ChatMessageRes> get serializer =>
      _$chatMessageResSerializer;
}

abstract class RoomExistModel
    implements Built<RoomExistModel, RoomExistModelBuilder> {
  RoomExistModel._();

  factory RoomExistModel([Function(RoomExistModelBuilder b) updates]) =
      _$RoomExistModel;

  @BuiltValueField(wireName: 'exist')
  bool get exist;
  @BuiltValueField(wireName: 'room_id')
  int get roomId;
  @BuiltValueField(wireName: 'blocked')
  bool get blocked;

  static Serializer<RoomExistModel> get serializer =>
      _$roomExistModelSerializer;
}

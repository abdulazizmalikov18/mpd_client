import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth.g.dart';

/// verification send
abstract class VerificationSendReq
    implements Built<VerificationSendReq, VerificationSendReqBuilder> {
  VerificationSendReq._();

  factory VerificationSendReq(
      [Function(VerificationSendReqBuilder b) updates]) = _$VerificationSendReq;

  @BuiltValueField(wireName: 'phone')
  String? get phone;

  @BuiltValueField(wireName: 'autofill')
  String? get autofill;

  static Serializer<VerificationSendReq> get serializer =>
      _$verificationSendReqSerializer;
}

/// verification verify
abstract class VerificationVerifyReq
    implements Built<VerificationVerifyReq, VerificationVerifyReqBuilder> {
  VerificationVerifyReq._();

  factory VerificationVerifyReq(
          [Function(VerificationVerifyReqBuilder b) updates]) =
      _$VerificationVerifyReq;

  @BuiltValueField(wireName: 'phone')
  String? get phone;

  @BuiltValueField(wireName: 'code')
  String? get code;

  static Serializer<VerificationVerifyReq> get serializer =>
      _$verificationVerifyReqSerializer;
}

///registeration
abstract class RegisterReq implements Built<RegisterReq, RegisterReqBuilder> {
  RegisterReq._();

  factory RegisterReq([Function(RegisterReqBuilder b) updates]) = _$RegisterReq;

  @BuiltValueField(wireName: 'full_name')
  String? get fullName;

  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<RegisterReq> get serializer => _$registerReqSerializer;
}

/// login

abstract class SignInReq implements Built<SignInReq, SignInReqBuilder> {
  SignInReq._();

  factory SignInReq([Function(SignInReqBuilder b) updates]) = _$SignInReq;

  @BuiltValueField(wireName: 'phone')
  String? get phone;

  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<SignInReq> get serializer => _$signInReqSerializer;
}

abstract class LoginRes implements Built<LoginRes, LoginResBuilder> {
  LoginRes._();

  factory LoginRes([Function(LoginResBuilder b) updates]) = _$LoginRes;

  @BuiltValueField(wireName: 'access')
  String? get access;

  @BuiltValueField(wireName: 'refresh')
  String? get refresh;

  @BuiltValueField(wireName: 'detail')
  String? get detail;

  static Serializer<LoginRes> get serializer => _$loginResSerializer;
}

/// update password

abstract class PasswordReq implements Built<PasswordReq, PasswordReqBuilder> {
  PasswordReq._();

  factory PasswordReq([Function(PasswordReqBuilder b) updates]) = _$PasswordReq;

  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<PasswordReq> get serializer => _$passwordReqSerializer;
}

abstract class CheckAuthModel
    implements Built<CheckAuthModel, CheckAuthModelBuilder> {
  CheckAuthModel._();

  factory CheckAuthModel([Function(CheckAuthModelBuilder b) updates]) =
      _$CheckAuthModel;

  @BuiltValueField(wireName: 'type')
  String? get type;
  @BuiltValueField(wireName: 'detail')
  String? get detail;

  static Serializer<CheckAuthModel> get serializer =>
      _$checkAuthModelSerializer;
}

/// reset password
abstract class ResetPasswordReq
    implements Built<ResetPasswordReq, ResetPasswordReqBuilder> {
  ResetPasswordReq._();

  factory ResetPasswordReq([Function(ResetPasswordReqBuilder b) updates]) =
      _$ResetPasswordReq;

  @BuiltValueField(wireName: 'old-pwd')
  String? get oldPwd;
  @BuiltValueField(wireName: 'new-pwd')
  String? get newPwd;

  static Serializer<ResetPasswordReq> get serializer =>
      _$resetPasswordReqSerializer;
}

abstract class ForgotPasswordReqModel
    implements Built<ForgotPasswordReqModel, ForgotPasswordReqModelBuilder> {
  ForgotPasswordReqModel._();

  factory ForgotPasswordReqModel(
          [Function(ForgotPasswordReqModelBuilder b) updates]) =
      _$ForgotPasswordReqModel;

  @BuiltValueField(wireName: 'code')
  String? get code;
  @BuiltValueField(wireName: 'phone')
  String? get phone;
  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<ForgotPasswordReqModel> get serializer =>
      _$forgotPasswordReqModelSerializer;
}

/// profile
abstract class ProfileModel
    implements Built<ProfileModel, ProfileModelBuilder> {
  ProfileModel._();

  factory ProfileModel([Function(ProfileModelBuilder b) updates]) =
      _$ProfileModel;

  @BuiltValueField(wireName: 'profile_pic')
  String? get profilePic;
  @BuiltValueField(wireName: 'full_name')
  String? get fullName;
  @BuiltValueField(wireName: 'region')
  int? get region;

  static Serializer<ProfileModel> get serializer => _$profileModelSerializer;
}

abstract class ProfileRes implements Built<ProfileRes, ProfileResBuilder> {
  ProfileRes._();

  factory ProfileRes([Function(ProfileResBuilder b) updates]) = _$ProfileRes;

  @BuiltValueField(wireName: 'profile_pic')
  String? get profilePic;
  @BuiltValueField(wireName: 'username')
  String? get username;
  @BuiltValueField(wireName: 'full_name')
  String? get fullName;
  @BuiltValueField(wireName: 'region')
  int? get region;
  @BuiltValueField(wireName: 'password')
  bool? get password;

  static Serializer<ProfileRes> get serializer => _$profileResSerializer;
}

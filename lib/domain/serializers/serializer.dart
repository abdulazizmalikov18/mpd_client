import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/chat/chat.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/domain/models/services/services_model.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/domain/models/success_model/success_model.dart';
import 'package:orient_motors/domain/models/upload_image/upload_image.dart';

import '../models/auth/auth.dart';

part 'serializer.g.dart';

@SerializersFor([
  //Auth
  RegisterReq,
  VerificationSendReq,
  VerificationVerifyReq,
  SignInReq,
  PasswordReq,
  LoginRes,
  SuccessModel,
  CheckAuthModel,
  ResetPasswordReq,
  ProfileModel,
  ProfileRes,
  ForgotPasswordReqModel,

  //car
  BrandResResult,
  BrandReq,
  CreateCarReq,
  GenerationsConfigurationsRes,
  ModificationModel,
  SpecificationsModel,
  CreateCarRes,
  CarModel,
  Owner,
  OptionsModelCarDetail,
  PaintCondition,
  ChangedPart,
  AdditionalPhones,
  ChangedPartReq,
  CarResResult,
  QuestionModel,

  // Filter
  FilterRes,
  Cars,
  NamedModel,
  Brands,
  Condition,
  CarModels,
  GenerationModel,
  ImagesModel,
  TransmissionModel,
  TranslationsModel,
  UzModel,
  RuModel,
  DriveUnitModel,
  PreSignedUrlReq,
  PreSignedUrlRes,
  OptionsRes,
  ImagesModel,
  TotalCarsRes,
  OwnerModel,
  FilterSearchReq,
  FilterSearchRes,
  Region,
  Services,
  BodyType,
  SearchList,

  //Services
  ServicesRes,

  //Review
  ReviewSysthesisModel,
  ReviewListModel,
  Advantage,
  ReviewFaqModel,
  ReviewDesignModel,
  ReviewSafetyConvenienceModel,
  Parametres,
  ReviewSizeSpaceModel,
  Dimension,
  ReviewMaintenanceModel,
  ReviewPriceModel,
  ReviewSpecificationModel,
  ReviewLinkModel,
  Brand,
  CommentModel,
  CommentsModel,
  ReviewFilterReq,
  ReviewFilterEither,
  VotingGeneration,
  ReviewIdEither,

  //Main
  CurrencyModel,
  BranchModel,
  BranchComplaintModel,
  NewsModel,
  NotificationModel,
  UnreadModel,

  //Chat
  ChatWroteModel,
  ChatBlockModel,
  UserStatusModel,
  ContactModel,
  ChatMessageReq,
  ChatRoomModel,
  ChatUserModel,
  ChatMessageRes,
  RoomExistModel
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

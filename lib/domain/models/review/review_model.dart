library review_model;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';

part 'review_model.g.dart';

abstract class ReviewSysthesisModel
    implements Built<ReviewSysthesisModel, ReviewSysthesisModelBuilder> {
  ReviewSysthesisModel._();

  factory ReviewSysthesisModel(
          [Function(ReviewSysthesisModelBuilder b) updates]) =
      _$ReviewSysthesisModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'text')
  String? get text;
  @BuiltValueField(wireName: 'photo')
  String? get photo;

  static Serializer<ReviewSysthesisModel> get serializer =>
      _$reviewSysthesisModelSerializer;
}

abstract class ReviewFilterEither
    implements Built<ReviewFilterEither, ReviewFilterEitherBuilder> {
  ReviewFilterEither._();

  factory ReviewFilterEither([Function(ReviewFilterEitherBuilder b) updates]) =
      _$ReviewFilterEither;

  @BuiltValueField(wireName: 'result')
  BuiltList<ReviewListModel>? get result;
  @BuiltValueField(wireName: 'voting_generation')
  VotingGeneration? get votingGeneration;

  static Serializer<ReviewFilterEither> get serializer =>
      _$reviewFilterEitherSerializer;
}

abstract class ReviewIdEither
    implements Built<ReviewIdEither, ReviewIdEitherBuilder> {
  ReviewIdEither._();

  factory ReviewIdEither([Function(ReviewIdEitherBuilder b) updates]) =
      _$ReviewIdEither;

  @BuiltValueField(wireName: 'car_review_id')
  int? get carReviewId;
  @BuiltValueField(wireName: 'voting_generation')
  VotingGeneration? get votingGeneration;

  static Serializer<ReviewIdEither> get serializer =>
      _$reviewIdEitherSerializer;
}

abstract class VotingGeneration
    implements Built<VotingGeneration, VotingGenerationBuilder> {
  VotingGeneration._();

  factory VotingGeneration([Function(VotingGenerationBuilder b) updates]) =
      _$VotingGeneration;

  @BuiltValueField(wireName: 'generation_id')
  int? get generationId;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'icon')
  String? get icon;
  @BuiltValueField(wireName: 'generation_votes')
  int? get generationVotes;

  static Serializer<VotingGeneration> get serializer =>
      _$votingGenerationSerializer;
}

abstract class ReviewListModel
    implements Built<ReviewListModel, ReviewListModelBuilder> {
  ReviewListModel._();

  factory ReviewListModel([Function(ReviewListModelBuilder b) updates]) =
      _$ReviewListModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'car_model')
  CarModel? get carModel;
  @BuiltValueField(wireName: 'advantage')
  Advantage? get advantage;
  @BuiltValueField(wireName: 'disadvantage')
  Advantage? get disadvantage;
  @BuiltValueField(wireName: 'orient_motors_overall_rating')
  double? get orientMotorsOverallRating;
  @BuiltValueField(wireName: 'users_rating')
  double? get usersRating;
  @BuiltValueField(wireName: 'photo')
  String? get photo;

  static Serializer<ReviewListModel> get serializer =>
      _$reviewListModelSerializer;
}

abstract class Advantage implements Built<Advantage, AdvantageBuilder> {
  Advantage._();

  factory Advantage([Function(AdvantageBuilder b) updates]) = _$Advantage;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'text')
  String? get text;

  static Serializer<Advantage> get serializer => _$advantageSerializer;
}

abstract class ReviewFaqModel
    implements Built<ReviewFaqModel, ReviewFaqModelBuilder> {
  ReviewFaqModel._();

  factory ReviewFaqModel([Function(ReviewFaqModelBuilder b) updates]) =
      _$ReviewFaqModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'question')
  String? get question;
  @BuiltValueField(wireName: 'answer')
  String? get answer;

  static Serializer<ReviewFaqModel> get serializer =>
      _$reviewFaqModelSerializer;
}

abstract class ReviewDesignModel
    implements Built<ReviewDesignModel, ReviewDesignModelBuilder> {
  ReviewDesignModel._();

  factory ReviewDesignModel([Function(ReviewDesignModelBuilder b) updates]) =
      _$ReviewDesignModel;

  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'external_design')
  String? get externalDesign;
  @BuiltValueField(wireName: 'interior_design')
  String? get interiorDesign;
  @BuiltValueField(wireName: 'rated_by_orient_motors')
  double? get ratedByOrientMotors;
  @BuiltValueField(wireName: 'external_photos')
  BuiltList<String>? get externalPhotos;
  @BuiltValueField(wireName: 'interior_photos')
  BuiltList<String>? get interiorPhotos;

  static Serializer<ReviewDesignModel> get serializer =>
      _$reviewDesignModelSerializer;
}

abstract class ReviewSafetyConvenienceModel
    implements
        Built<ReviewSafetyConvenienceModel,
            ReviewSafetyConvenienceModelBuilder> {
  ReviewSafetyConvenienceModel._();

  factory ReviewSafetyConvenienceModel(
          [Function(ReviewSafetyConvenienceModelBuilder b) updates]) =
      _$ReviewSafetyConvenienceModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'safety_title')
  String? get safetyTitle;
  @BuiltValueField(wireName: 'safety_equipment')
  String? get safetyEquipment;
  @BuiltValueField(wireName: 'convenience_title')
  String? get convenienceTitle;
  @BuiltValueField(wireName: 'convenience_equipment')
  String? get convenienceEquipment;
  @BuiltValueField(wireName: 'rated_by_orient_motors')
  double? get ratedByOrientMotors;
  @BuiltValueField(wireName: 'advantages')
  BuiltList<Advantage>? get advantages;
  @BuiltValueField(wireName: 'disadvantages')
  BuiltList<Advantage>? get disadvantages;
  @BuiltValueField(wireName: 'parametres')
  Parametres? get parametres;

  static Serializer<ReviewSafetyConvenienceModel> get serializer =>
      _$reviewSafetyConvenienceModelSerializer;
}

abstract class Parametres implements Built<Parametres, ParametresBuilder> {
  Parametres._();

  factory Parametres([Function(ParametresBuilder b) updates]) = _$Parametres;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'horse_power')
  double? get horsePower;
  @BuiltValueField(wireName: 'engine_type')
  String? get engineType;
  @BuiltValueField(wireName: 'transmission')
  String? get transmission;
  @BuiltValueField(wireName: 'drive')
  String? get drive;
  @BuiltValueField(wireName: 'volume')
  double? get volume;
  @BuiltValueField(wireName: 'time_to_100')
  double? get timeTo100;
  @BuiltValueField(wireName: 'max_speed')
  double? get maxSpeed;
  @BuiltValueField(wireName: 'diameter')
  double? get diameter;
  @BuiltValueField(wireName: 'petrol_type')
  String? get petrolType;
  @BuiltValueField(wireName: 'weight')
  double? get weight;
  @BuiltValueField(wireName: 'height')
  double? get height;
  @BuiltValueField(wireName: 'width')
  double? get width;
  @BuiltValueField(wireName: 'length')
  double? get length;
  @BuiltValueField(wireName: 'fuel_tank_capacity')
  double? get fuelTankCapacity;
  @BuiltValueField(wireName: 'volume_litres')
  double? get volumeLitres;
  @BuiltValueField(wireName: 'safety_rating')
  double? get safetyRating;
  @BuiltValueField(wireName: 'safety_grade')
  double? get safetyGrade;
  @BuiltValueField(wireName: 'modification')
  double? get modification;

  static Serializer<Parametres> get serializer => _$parametresSerializer;
}

abstract class ReviewSizeSpaceModel
    implements Built<ReviewSizeSpaceModel, ReviewSizeSpaceModelBuilder> {
  ReviewSizeSpaceModel._();

  factory ReviewSizeSpaceModel(
          [Function(ReviewSizeSpaceModelBuilder b) updates]) =
      _$ReviewSizeSpaceModel;

  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'dimension')
  Dimension? get dimension;
  @BuiltValueField(wireName: 'dimensions_and_space')
  String? get dimensionsAndSpace;
  @BuiltValueField(wireName: 'rated_by_orient_motors')
  double? get ratedByOrientMotors;
  @BuiltValueField(wireName: 'height_width_photo')
  String? get heightWidthPhoto;
  @BuiltValueField(wireName: 'length_photo')
  String? get lengthPhoto;
  @BuiltValueField(wireName: 'photos')
  BuiltList<String>? get photos;

  static Serializer<ReviewSizeSpaceModel> get serializer =>
      _$reviewSizeSpaceModelSerializer;
}

abstract class Dimension implements Built<Dimension, DimensionBuilder> {
  Dimension._();

  factory Dimension([Function(DimensionBuilder b) updates]) = _$Dimension;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'horse_power')
  double? get horsePower;
  @BuiltValueField(wireName: 'engine_type')
  String? get engineType;
  @BuiltValueField(wireName: 'transmission')
  String? get transmission;
  @BuiltValueField(wireName: 'drive')
  String? get drive;
  @BuiltValueField(wireName: 'volume')
  double? get volume;
  @BuiltValueField(wireName: 'time_to_100')
  double? get timeTo100;
  @BuiltValueField(wireName: 'max_speed')
  double? get maxSpeed;
  @BuiltValueField(wireName: 'diameter')
  double? get diameter;
  @BuiltValueField(wireName: 'petrol_type')
  String? get petrolType;
  @BuiltValueField(wireName: 'weight')
  double? get weight;
  @BuiltValueField(wireName: 'height')
  double? get height;
  @BuiltValueField(wireName: 'width')
  double? get width;
  @BuiltValueField(wireName: 'length')
  double? get length;
  @BuiltValueField(wireName: 'fuel_tank_capacity')
  double? get fuelTankCapacity;
  @BuiltValueField(wireName: 'volume_litres')
  double? get volumeLitres;
  @BuiltValueField(wireName: 'safety_rating')
  double? get safetyRating;
  @BuiltValueField(wireName: 'safety_grade')
  double? get safetyGrade;
  @BuiltValueField(wireName: 'modification')
  double? get modification;

  static Serializer<Dimension> get serializer => _$dimensionSerializer;
}

abstract class ReviewMaintenanceModel
    implements Built<ReviewMaintenanceModel, ReviewMaintenanceModelBuilder> {
  ReviewMaintenanceModel._();

  factory ReviewMaintenanceModel(
          [Function(ReviewMaintenanceModelBuilder b) updates]) =
      _$ReviewMaintenanceModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'service')
  String? get service;
  @BuiltValueField(wireName: 'warranty')
  String? get warranty;
  @BuiltValueField(wireName: 'rated_by_orient_motors')
  double? get ratedByOrientMotors;
  @BuiltValueField(wireName: 'fuel_efficiency')
  String? get fuelEfficiency;
  @BuiltValueField(wireName: 'advantages')
  BuiltList<Advantage>? get advantages;
  @BuiltValueField(wireName: 'disadvantages')
  BuiltList<Advantage>? get disadvantages;

  static Serializer<ReviewMaintenanceModel> get serializer =>
      _$reviewMaintenanceModelSerializer;
}

abstract class ReviewPriceModel
    implements Built<ReviewPriceModel, ReviewPriceModelBuilder> {
  ReviewPriceModel._();

  factory ReviewPriceModel([Function(ReviewPriceModelBuilder b) updates]) =
      _$ReviewPriceModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'new_car_from')
  double? get newCarFrom;
  @BuiltValueField(wireName: 'new_car_to')
  double? get newCarTo;
  @BuiltValueField(wireName: 'used_car_from')
  double? get usedCarFrom;
  @BuiltValueField(wireName: 'used_car_to')
  double? get usedCarTo;
  @BuiltValueField(wireName: 'rated_by_orient_motors')
  double? get ratedByOrientMotors;
  @BuiltValueField(wireName: 'text')
  String? get text;

  static Serializer<ReviewPriceModel> get serializer =>
      _$reviewPriceModelSerializer;
}

abstract class ReviewSpecificationModel
    implements
        Built<ReviewSpecificationModel, ReviewSpecificationModelBuilder> {
  ReviewSpecificationModel._();

  factory ReviewSpecificationModel(
          [Function(ReviewSpecificationModelBuilder b) updates]) =
      _$ReviewSpecificationModel;

  @BuiltValueField(wireName: 'advantages')
  BuiltList<Advantage> get advantages;
  @BuiltValueField(wireName: 'disadvantages')
  BuiltList<Advantage> get disadvantages;
  @BuiltValueField(wireName: 'parametres')
  Parametres get parametres;

  static Serializer<ReviewSpecificationModel> get serializer =>
      _$reviewSpecificationModelSerializer;
}

abstract class ReviewLinkModel
    implements Built<ReviewLinkModel, ReviewLinkModelBuilder> {
  ReviewLinkModel._();

  factory ReviewLinkModel([Function(ReviewLinkModelBuilder b) updates]) =
      _$ReviewLinkModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'brand')
  Brand? get brand;
  @BuiltValueField(wireName: 'brand_url')
  String? get brandUrl;
  @BuiltValueField(wireName: 'service_center_url')
  String? get serviceCenterUrl;
  @BuiltValueField(wireName: 'exhibition_info_url')
  String? get exhibitionInfoUrl;
  @BuiltValueField(wireName: 'car_review')
  int? get carReview;

  static Serializer<ReviewLinkModel> get serializer =>
      _$reviewLinkModelSerializer;
}

abstract class Brand implements Built<Brand, BrandBuilder> {
  Brand._();

  factory Brand([Function(BrandBuilder b) updates]) = _$Brand;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'icon')
  String? get icon;
  @BuiltValueField(wireName: 'top')
  bool? get top;
  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  static Serializer<Brand> get serializer => _$brandSerializer;
}

abstract class CommentModel
    implements Built<CommentModel, CommentModelBuilder> {
  CommentModel._();

  factory CommentModel([Function(CommentModelBuilder b) updates]) =
      _$CommentModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'rating')
  double? get rating;
  @BuiltValueField(wireName: 'comment')
  String? get comment;
  @BuiltValueField(wireName: 'posted_at')
  String? get postedAt;
  @BuiltValueField(wireName: 'car_review')
  int? get carReview;

  static Serializer<CommentModel> get serializer => _$commentModelSerializer;
}

abstract class CommentsModel
    implements Built<CommentsModel, CommentsModelBuilder> {
  CommentsModel._();

  factory CommentsModel([Function(CommentsModelBuilder b) updates]) =
      _$CommentsModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'owner')
  Owner? get owner;
  @BuiltValueField(wireName: 'rating')
  double? get rating;
  @BuiltValueField(wireName: 'comment')
  String? get comment;
  @BuiltValueField(wireName: 'posted_at')
  String? get postedAt;
  @BuiltValueField(wireName: 'car_review')
  int? get carReview;

  static Serializer<CommentsModel> get serializer => _$commentsModelSerializer;
}

abstract class ReviewFilterReq
    implements Built<ReviewFilterReq, ReviewFilterReqBuilder> {
  ReviewFilterReq._();

  factory ReviewFilterReq([Function(ReviewFilterReqBuilder b) updates]) =
      _$ReviewFilterReq;

  @BuiltValueField(wireName: 'mark')
  int? get mark;
  @BuiltValueField(wireName: 'model')
  int? get model;
  @BuiltValueField(wireName: 'generation')
  int? get generation;
  @BuiltValueField(wireName: 'body-type')
  int? get bodyType;
  @BuiltValueField(wireName: 'order-by')
  String? get orderBy;

  static Serializer<ReviewFilterReq> get serializer =>
      _$reviewFilterReqSerializer;
}

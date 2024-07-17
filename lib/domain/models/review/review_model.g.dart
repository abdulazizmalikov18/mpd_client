// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReviewSysthesisModel> _$reviewSysthesisModelSerializer =
    new _$ReviewSysthesisModelSerializer();
Serializer<ReviewFilterEither> _$reviewFilterEitherSerializer =
    new _$ReviewFilterEitherSerializer();
Serializer<ReviewIdEither> _$reviewIdEitherSerializer =
    new _$ReviewIdEitherSerializer();
Serializer<VotingGeneration> _$votingGenerationSerializer =
    new _$VotingGenerationSerializer();
Serializer<ReviewListModel> _$reviewListModelSerializer =
    new _$ReviewListModelSerializer();
Serializer<Advantage> _$advantageSerializer = new _$AdvantageSerializer();
Serializer<ReviewFaqModel> _$reviewFaqModelSerializer =
    new _$ReviewFaqModelSerializer();
Serializer<ReviewDesignModel> _$reviewDesignModelSerializer =
    new _$ReviewDesignModelSerializer();
Serializer<ReviewSafetyConvenienceModel>
    _$reviewSafetyConvenienceModelSerializer =
    new _$ReviewSafetyConvenienceModelSerializer();
Serializer<Parametres> _$parametresSerializer = new _$ParametresSerializer();
Serializer<ReviewSizeSpaceModel> _$reviewSizeSpaceModelSerializer =
    new _$ReviewSizeSpaceModelSerializer();
Serializer<Dimension> _$dimensionSerializer = new _$DimensionSerializer();
Serializer<ReviewMaintenanceModel> _$reviewMaintenanceModelSerializer =
    new _$ReviewMaintenanceModelSerializer();
Serializer<ReviewPriceModel> _$reviewPriceModelSerializer =
    new _$ReviewPriceModelSerializer();
Serializer<ReviewSpecificationModel> _$reviewSpecificationModelSerializer =
    new _$ReviewSpecificationModelSerializer();
Serializer<ReviewLinkModel> _$reviewLinkModelSerializer =
    new _$ReviewLinkModelSerializer();
Serializer<Brand> _$brandSerializer = new _$BrandSerializer();
Serializer<CommentModel> _$commentModelSerializer =
    new _$CommentModelSerializer();
Serializer<CommentsModel> _$commentsModelSerializer =
    new _$CommentsModelSerializer();
Serializer<ReviewFilterReq> _$reviewFilterReqSerializer =
    new _$ReviewFilterReqSerializer();

class _$ReviewSysthesisModelSerializer
    implements StructuredSerializer<ReviewSysthesisModel> {
  @override
  final Iterable<Type> types = const [
    ReviewSysthesisModel,
    _$ReviewSysthesisModel
  ];
  @override
  final String wireName = 'ReviewSysthesisModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewSysthesisModel object,
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
    value = object.text;
    if (value != null) {
      result
        ..add('text')
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
    return result;
  }

  @override
  ReviewSysthesisModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewSysthesisModelBuilder();

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
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo':
          result.photo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewFilterEitherSerializer
    implements StructuredSerializer<ReviewFilterEither> {
  @override
  final Iterable<Type> types = const [ReviewFilterEither, _$ReviewFilterEither];
  @override
  final String wireName = 'ReviewFilterEither';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewFilterEither object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.result;
    if (value != null) {
      result
        ..add('result')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ReviewListModel)])));
    }
    value = object.votingGeneration;
    if (value != null) {
      result
        ..add('voting_generation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(VotingGeneration)));
    }
    return result;
  }

  @override
  ReviewFilterEither deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewFilterEitherBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'result':
          result.result.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ReviewListModel)]))!
              as BuiltList<Object?>);
          break;
        case 'voting_generation':
          result.votingGeneration.replace(serializers.deserialize(value,
                  specifiedType: const FullType(VotingGeneration))!
              as VotingGeneration);
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewIdEitherSerializer
    implements StructuredSerializer<ReviewIdEither> {
  @override
  final Iterable<Type> types = const [ReviewIdEither, _$ReviewIdEither];
  @override
  final String wireName = 'ReviewIdEither';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewIdEither object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.carReviewId;
    if (value != null) {
      result
        ..add('car_review_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.votingGeneration;
    if (value != null) {
      result
        ..add('voting_generation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(VotingGeneration)));
    }
    return result;
  }

  @override
  ReviewIdEither deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewIdEitherBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'car_review_id':
          result.carReviewId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'voting_generation':
          result.votingGeneration.replace(serializers.deserialize(value,
                  specifiedType: const FullType(VotingGeneration))!
              as VotingGeneration);
          break;
      }
    }

    return result.build();
  }
}

class _$VotingGenerationSerializer
    implements StructuredSerializer<VotingGeneration> {
  @override
  final Iterable<Type> types = const [VotingGeneration, _$VotingGeneration];
  @override
  final String wireName = 'VotingGeneration';

  @override
  Iterable<Object?> serialize(Serializers serializers, VotingGeneration object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.generationId;
    if (value != null) {
      result
        ..add('generation_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.generationVotes;
    if (value != null) {
      result
        ..add('generation_votes')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  VotingGeneration deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VotingGenerationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'generation_id':
          result.generationId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'generation_votes':
          result.generationVotes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewListModelSerializer
    implements StructuredSerializer<ReviewListModel> {
  @override
  final Iterable<Type> types = const [ReviewListModel, _$ReviewListModel];
  @override
  final String wireName = 'ReviewListModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewListModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.carModel;
    if (value != null) {
      result
        ..add('car_model')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(CarModel)));
    }
    value = object.advantage;
    if (value != null) {
      result
        ..add('advantage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Advantage)));
    }
    value = object.disadvantage;
    if (value != null) {
      result
        ..add('disadvantage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Advantage)));
    }
    value = object.orientMotorsOverallRating;
    if (value != null) {
      result
        ..add('orient_motors_overall_rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.usersRating;
    if (value != null) {
      result
        ..add('users_rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.photo;
    if (value != null) {
      result
        ..add('photo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ReviewListModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewListModelBuilder();

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
        case 'car_model':
          result.carModel.replace(serializers.deserialize(value,
              specifiedType: const FullType(CarModel))! as CarModel);
          break;
        case 'advantage':
          result.advantage.replace(serializers.deserialize(value,
              specifiedType: const FullType(Advantage))! as Advantage);
          break;
        case 'disadvantage':
          result.disadvantage.replace(serializers.deserialize(value,
              specifiedType: const FullType(Advantage))! as Advantage);
          break;
        case 'orient_motors_overall_rating':
          result.orientMotorsOverallRating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'users_rating':
          result.usersRating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'photo':
          result.photo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AdvantageSerializer implements StructuredSerializer<Advantage> {
  @override
  final Iterable<Type> types = const [Advantage, _$Advantage];
  @override
  final String wireName = 'Advantage';

  @override
  Iterable<Object?> serialize(Serializers serializers, Advantage object,
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
  Advantage deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdvantageBuilder();

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
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewFaqModelSerializer
    implements StructuredSerializer<ReviewFaqModel> {
  @override
  final Iterable<Type> types = const [ReviewFaqModel, _$ReviewFaqModel];
  @override
  final String wireName = 'ReviewFaqModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewFaqModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.question;
    if (value != null) {
      result
        ..add('question')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.answer;
    if (value != null) {
      result
        ..add('answer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ReviewFaqModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewFaqModelBuilder();

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
        case 'question':
          result.question = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'answer':
          result.answer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewDesignModelSerializer
    implements StructuredSerializer<ReviewDesignModel> {
  @override
  final Iterable<Type> types = const [ReviewDesignModel, _$ReviewDesignModel];
  @override
  final String wireName = 'ReviewDesignModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewDesignModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.externalDesign;
    if (value != null) {
      result
        ..add('external_design')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.interiorDesign;
    if (value != null) {
      result
        ..add('interior_design')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ratedByOrientMotors;
    if (value != null) {
      result
        ..add('rated_by_orient_motors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.externalPhotos;
    if (value != null) {
      result
        ..add('external_photos')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.interiorPhotos;
    if (value != null) {
      result
        ..add('interior_photos')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  ReviewDesignModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewDesignModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'external_design':
          result.externalDesign = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'interior_design':
          result.interiorDesign = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rated_by_orient_motors':
          result.ratedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'external_photos':
          result.externalPhotos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'interior_photos':
          result.interiorPhotos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewSafetyConvenienceModelSerializer
    implements StructuredSerializer<ReviewSafetyConvenienceModel> {
  @override
  final Iterable<Type> types = const [
    ReviewSafetyConvenienceModel,
    _$ReviewSafetyConvenienceModel
  ];
  @override
  final String wireName = 'ReviewSafetyConvenienceModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewSafetyConvenienceModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.safetyTitle;
    if (value != null) {
      result
        ..add('safety_title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.safetyEquipment;
    if (value != null) {
      result
        ..add('safety_equipment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.convenienceTitle;
    if (value != null) {
      result
        ..add('convenience_title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.convenienceEquipment;
    if (value != null) {
      result
        ..add('convenience_equipment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ratedByOrientMotors;
    if (value != null) {
      result
        ..add('rated_by_orient_motors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.advantages;
    if (value != null) {
      result
        ..add('advantages')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Advantage)])));
    }
    value = object.disadvantages;
    if (value != null) {
      result
        ..add('disadvantages')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Advantage)])));
    }
    value = object.parametres;
    if (value != null) {
      result
        ..add('parametres')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Parametres)));
    }
    return result;
  }

  @override
  ReviewSafetyConvenienceModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewSafetyConvenienceModelBuilder();

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
        case 'safety_title':
          result.safetyTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'safety_equipment':
          result.safetyEquipment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'convenience_title':
          result.convenienceTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'convenience_equipment':
          result.convenienceEquipment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rated_by_orient_motors':
          result.ratedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'advantages':
          result.advantages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Advantage)]))!
              as BuiltList<Object?>);
          break;
        case 'disadvantages':
          result.disadvantages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Advantage)]))!
              as BuiltList<Object?>);
          break;
        case 'parametres':
          result.parametres.replace(serializers.deserialize(value,
              specifiedType: const FullType(Parametres))! as Parametres);
          break;
      }
    }

    return result.build();
  }
}

class _$ParametresSerializer implements StructuredSerializer<Parametres> {
  @override
  final Iterable<Type> types = const [Parametres, _$Parametres];
  @override
  final String wireName = 'Parametres';

  @override
  Iterable<Object?> serialize(Serializers serializers, Parametres object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.horsePower;
    if (value != null) {
      result
        ..add('horse_power')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.engineType;
    if (value != null) {
      result
        ..add('engine_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.drive;
    if (value != null) {
      result
        ..add('drive')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.volume;
    if (value != null) {
      result
        ..add('volume')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.timeTo100;
    if (value != null) {
      result
        ..add('time_to_100')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.maxSpeed;
    if (value != null) {
      result
        ..add('max_speed')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.diameter;
    if (value != null) {
      result
        ..add('diameter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.petrolType;
    if (value != null) {
      result
        ..add('petrol_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.weight;
    if (value != null) {
      result
        ..add('weight')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.height;
    if (value != null) {
      result
        ..add('height')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.width;
    if (value != null) {
      result
        ..add('width')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.length;
    if (value != null) {
      result
        ..add('length')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.fuelTankCapacity;
    if (value != null) {
      result
        ..add('fuel_tank_capacity')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.volumeLitres;
    if (value != null) {
      result
        ..add('volume_litres')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.safetyRating;
    if (value != null) {
      result
        ..add('safety_rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.safetyGrade;
    if (value != null) {
      result
        ..add('safety_grade')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  Parametres deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ParametresBuilder();

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
        case 'horse_power':
          result.horsePower = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'engine_type':
          result.engineType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'transmission':
          result.transmission = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'drive':
          result.drive = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'volume':
          result.volume = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'time_to_100':
          result.timeTo100 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'max_speed':
          result.maxSpeed = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'diameter':
          result.diameter = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'petrol_type':
          result.petrolType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'weight':
          result.weight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'length':
          result.length = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'fuel_tank_capacity':
          result.fuelTankCapacity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'volume_litres':
          result.volumeLitres = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'safety_rating':
          result.safetyRating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'safety_grade':
          result.safetyGrade = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'modification':
          result.modification = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewSizeSpaceModelSerializer
    implements StructuredSerializer<ReviewSizeSpaceModel> {
  @override
  final Iterable<Type> types = const [
    ReviewSizeSpaceModel,
    _$ReviewSizeSpaceModel
  ];
  @override
  final String wireName = 'ReviewSizeSpaceModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewSizeSpaceModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dimension;
    if (value != null) {
      result
        ..add('dimension')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Dimension)));
    }
    value = object.dimensionsAndSpace;
    if (value != null) {
      result
        ..add('dimensions_and_space')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ratedByOrientMotors;
    if (value != null) {
      result
        ..add('rated_by_orient_motors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.heightWidthPhoto;
    if (value != null) {
      result
        ..add('height_width_photo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lengthPhoto;
    if (value != null) {
      result
        ..add('length_photo')
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
    return result;
  }

  @override
  ReviewSizeSpaceModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewSizeSpaceModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dimension':
          result.dimension.replace(serializers.deserialize(value,
              specifiedType: const FullType(Dimension))! as Dimension);
          break;
        case 'dimensions_and_space':
          result.dimensionsAndSpace = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rated_by_orient_motors':
          result.ratedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'height_width_photo':
          result.heightWidthPhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'length_photo':
          result.lengthPhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$DimensionSerializer implements StructuredSerializer<Dimension> {
  @override
  final Iterable<Type> types = const [Dimension, _$Dimension];
  @override
  final String wireName = 'Dimension';

  @override
  Iterable<Object?> serialize(Serializers serializers, Dimension object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.horsePower;
    if (value != null) {
      result
        ..add('horse_power')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.engineType;
    if (value != null) {
      result
        ..add('engine_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transmission;
    if (value != null) {
      result
        ..add('transmission')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.drive;
    if (value != null) {
      result
        ..add('drive')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.volume;
    if (value != null) {
      result
        ..add('volume')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.timeTo100;
    if (value != null) {
      result
        ..add('time_to_100')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.maxSpeed;
    if (value != null) {
      result
        ..add('max_speed')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.diameter;
    if (value != null) {
      result
        ..add('diameter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.petrolType;
    if (value != null) {
      result
        ..add('petrol_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.weight;
    if (value != null) {
      result
        ..add('weight')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.height;
    if (value != null) {
      result
        ..add('height')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.width;
    if (value != null) {
      result
        ..add('width')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.length;
    if (value != null) {
      result
        ..add('length')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.fuelTankCapacity;
    if (value != null) {
      result
        ..add('fuel_tank_capacity')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.volumeLitres;
    if (value != null) {
      result
        ..add('volume_litres')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.safetyRating;
    if (value != null) {
      result
        ..add('safety_rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.safetyGrade;
    if (value != null) {
      result
        ..add('safety_grade')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.modification;
    if (value != null) {
      result
        ..add('modification')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  Dimension deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DimensionBuilder();

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
        case 'horse_power':
          result.horsePower = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'engine_type':
          result.engineType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'transmission':
          result.transmission = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'drive':
          result.drive = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'volume':
          result.volume = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'time_to_100':
          result.timeTo100 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'max_speed':
          result.maxSpeed = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'diameter':
          result.diameter = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'petrol_type':
          result.petrolType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'weight':
          result.weight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'length':
          result.length = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'fuel_tank_capacity':
          result.fuelTankCapacity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'volume_litres':
          result.volumeLitres = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'safety_rating':
          result.safetyRating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'safety_grade':
          result.safetyGrade = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'modification':
          result.modification = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewMaintenanceModelSerializer
    implements StructuredSerializer<ReviewMaintenanceModel> {
  @override
  final Iterable<Type> types = const [
    ReviewMaintenanceModel,
    _$ReviewMaintenanceModel
  ];
  @override
  final String wireName = 'ReviewMaintenanceModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewMaintenanceModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.service;
    if (value != null) {
      result
        ..add('service')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.warranty;
    if (value != null) {
      result
        ..add('warranty')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ratedByOrientMotors;
    if (value != null) {
      result
        ..add('rated_by_orient_motors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.fuelEfficiency;
    if (value != null) {
      result
        ..add('fuel_efficiency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.advantages;
    if (value != null) {
      result
        ..add('advantages')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Advantage)])));
    }
    value = object.disadvantages;
    if (value != null) {
      result
        ..add('disadvantages')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Advantage)])));
    }
    return result;
  }

  @override
  ReviewMaintenanceModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewMaintenanceModelBuilder();

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
        case 'service':
          result.service = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'warranty':
          result.warranty = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rated_by_orient_motors':
          result.ratedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'fuel_efficiency':
          result.fuelEfficiency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'advantages':
          result.advantages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Advantage)]))!
              as BuiltList<Object?>);
          break;
        case 'disadvantages':
          result.disadvantages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Advantage)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewPriceModelSerializer
    implements StructuredSerializer<ReviewPriceModel> {
  @override
  final Iterable<Type> types = const [ReviewPriceModel, _$ReviewPriceModel];
  @override
  final String wireName = 'ReviewPriceModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewPriceModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.newCarFrom;
    if (value != null) {
      result
        ..add('new_car_from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.newCarTo;
    if (value != null) {
      result
        ..add('new_car_to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.usedCarFrom;
    if (value != null) {
      result
        ..add('used_car_from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.usedCarTo;
    if (value != null) {
      result
        ..add('used_car_to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.ratedByOrientMotors;
    if (value != null) {
      result
        ..add('rated_by_orient_motors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
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
  ReviewPriceModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewPriceModelBuilder();

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
        case 'new_car_from':
          result.newCarFrom = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'new_car_to':
          result.newCarTo = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'used_car_from':
          result.usedCarFrom = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'used_car_to':
          result.usedCarTo = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'rated_by_orient_motors':
          result.ratedByOrientMotors = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
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

class _$ReviewSpecificationModelSerializer
    implements StructuredSerializer<ReviewSpecificationModel> {
  @override
  final Iterable<Type> types = const [
    ReviewSpecificationModel,
    _$ReviewSpecificationModel
  ];
  @override
  final String wireName = 'ReviewSpecificationModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewSpecificationModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'advantages',
      serializers.serialize(object.advantages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Advantage)])),
      'disadvantages',
      serializers.serialize(object.disadvantages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Advantage)])),
      'parametres',
      serializers.serialize(object.parametres,
          specifiedType: const FullType(Parametres)),
    ];

    return result;
  }

  @override
  ReviewSpecificationModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewSpecificationModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'advantages':
          result.advantages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Advantage)]))!
              as BuiltList<Object?>);
          break;
        case 'disadvantages':
          result.disadvantages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Advantage)]))!
              as BuiltList<Object?>);
          break;
        case 'parametres':
          result.parametres.replace(serializers.deserialize(value,
              specifiedType: const FullType(Parametres))! as Parametres);
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewLinkModelSerializer
    implements StructuredSerializer<ReviewLinkModel> {
  @override
  final Iterable<Type> types = const [ReviewLinkModel, _$ReviewLinkModel];
  @override
  final String wireName = 'ReviewLinkModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewLinkModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Brand)));
    }
    value = object.brandUrl;
    if (value != null) {
      result
        ..add('brand_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.serviceCenterUrl;
    if (value != null) {
      result
        ..add('service_center_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.exhibitionInfoUrl;
    if (value != null) {
      result
        ..add('exhibition_info_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.carReview;
    if (value != null) {
      result
        ..add('car_review')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ReviewLinkModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewLinkModelBuilder();

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
        case 'brand':
          result.brand.replace(serializers.deserialize(value,
              specifiedType: const FullType(Brand))! as Brand);
          break;
        case 'brand_url':
          result.brandUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'service_center_url':
          result.serviceCenterUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'exhibition_info_url':
          result.exhibitionInfoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_review':
          result.carReview = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$BrandSerializer implements StructuredSerializer<Brand> {
  @override
  final Iterable<Type> types = const [Brand, _$Brand];
  @override
  final String wireName = 'Brand';

  @override
  Iterable<Object?> serialize(Serializers serializers, Brand object,
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
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.top;
    if (value != null) {
      result
        ..add('top')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.countOfCars;
    if (value != null) {
      result
        ..add('count_of_cars')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Brand deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrandBuilder();

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
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'top':
          result.top = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'count_of_cars':
          result.countOfCars = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$CommentModelSerializer implements StructuredSerializer<CommentModel> {
  @override
  final Iterable<Type> types = const [CommentModel, _$CommentModel];
  @override
  final String wireName = 'CommentModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CommentModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postedAt;
    if (value != null) {
      result
        ..add('posted_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.carReview;
    if (value != null) {
      result
        ..add('car_review')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CommentModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentModelBuilder();

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
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'posted_at':
          result.postedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_review':
          result.carReview = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$CommentsModelSerializer implements StructuredSerializer<CommentsModel> {
  @override
  final Iterable<Type> types = const [CommentsModel, _$CommentsModel];
  @override
  final String wireName = 'CommentsModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CommentsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.owner;
    if (value != null) {
      result
        ..add('owner')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Owner)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postedAt;
    if (value != null) {
      result
        ..add('posted_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.carReview;
    if (value != null) {
      result
        ..add('car_review')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CommentsModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentsModelBuilder();

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
        case 'owner':
          result.owner.replace(serializers.deserialize(value,
              specifiedType: const FullType(Owner))! as Owner);
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'posted_at':
          result.postedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'car_review':
          result.carReview = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewFilterReqSerializer
    implements StructuredSerializer<ReviewFilterReq> {
  @override
  final Iterable<Type> types = const [ReviewFilterReq, _$ReviewFilterReq];
  @override
  final String wireName = 'ReviewFilterReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewFilterReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.mark;
    if (value != null) {
      result
        ..add('mark')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.model;
    if (value != null) {
      result
        ..add('model')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.generation;
    if (value != null) {
      result
        ..add('generation')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.bodyType;
    if (value != null) {
      result
        ..add('body-type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.orderBy;
    if (value != null) {
      result
        ..add('order-by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ReviewFilterReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewFilterReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'mark':
          result.mark = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'generation':
          result.generation = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'body-type':
          result.bodyType = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'order-by':
          result.orderBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewSysthesisModel extends ReviewSysthesisModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? text;
  @override
  final String? photo;

  factory _$ReviewSysthesisModel(
          [void Function(ReviewSysthesisModelBuilder)? updates]) =>
      (new ReviewSysthesisModelBuilder()..update(updates))._build();

  _$ReviewSysthesisModel._({this.id, this.title, this.text, this.photo})
      : super._();

  @override
  ReviewSysthesisModel rebuild(
          void Function(ReviewSysthesisModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewSysthesisModelBuilder toBuilder() =>
      new ReviewSysthesisModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewSysthesisModel &&
        id == other.id &&
        title == other.title &&
        text == other.text &&
        photo == other.photo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, photo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewSysthesisModel')
          ..add('id', id)
          ..add('title', title)
          ..add('text', text)
          ..add('photo', photo))
        .toString();
  }
}

class ReviewSysthesisModelBuilder
    implements Builder<ReviewSysthesisModel, ReviewSysthesisModelBuilder> {
  _$ReviewSysthesisModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _photo;
  String? get photo => _$this._photo;
  set photo(String? photo) => _$this._photo = photo;

  ReviewSysthesisModelBuilder();

  ReviewSysthesisModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _text = $v.text;
      _photo = $v.photo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewSysthesisModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewSysthesisModel;
  }

  @override
  void update(void Function(ReviewSysthesisModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewSysthesisModel build() => _build();

  _$ReviewSysthesisModel _build() {
    final _$result = _$v ??
        new _$ReviewSysthesisModel._(
            id: id, title: title, text: text, photo: photo);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewFilterEither extends ReviewFilterEither {
  @override
  final BuiltList<ReviewListModel>? result;
  @override
  final VotingGeneration? votingGeneration;

  factory _$ReviewFilterEither(
          [void Function(ReviewFilterEitherBuilder)? updates]) =>
      (new ReviewFilterEitherBuilder()..update(updates))._build();

  _$ReviewFilterEither._({this.result, this.votingGeneration}) : super._();

  @override
  ReviewFilterEither rebuild(
          void Function(ReviewFilterEitherBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewFilterEitherBuilder toBuilder() =>
      new ReviewFilterEitherBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewFilterEither &&
        result == other.result &&
        votingGeneration == other.votingGeneration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, votingGeneration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewFilterEither')
          ..add('result', result)
          ..add('votingGeneration', votingGeneration))
        .toString();
  }
}

class ReviewFilterEitherBuilder
    implements Builder<ReviewFilterEither, ReviewFilterEitherBuilder> {
  _$ReviewFilterEither? _$v;

  ListBuilder<ReviewListModel>? _result;
  ListBuilder<ReviewListModel> get result =>
      _$this._result ??= new ListBuilder<ReviewListModel>();
  set result(ListBuilder<ReviewListModel>? result) => _$this._result = result;

  VotingGenerationBuilder? _votingGeneration;
  VotingGenerationBuilder get votingGeneration =>
      _$this._votingGeneration ??= new VotingGenerationBuilder();
  set votingGeneration(VotingGenerationBuilder? votingGeneration) =>
      _$this._votingGeneration = votingGeneration;

  ReviewFilterEitherBuilder();

  ReviewFilterEitherBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _result = $v.result?.toBuilder();
      _votingGeneration = $v.votingGeneration?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewFilterEither other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewFilterEither;
  }

  @override
  void update(void Function(ReviewFilterEitherBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewFilterEither build() => _build();

  _$ReviewFilterEither _build() {
    _$ReviewFilterEither _$result;
    try {
      _$result = _$v ??
          new _$ReviewFilterEither._(
              result: _result?.build(),
              votingGeneration: _votingGeneration?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'result';
        _result?.build();
        _$failedField = 'votingGeneration';
        _votingGeneration?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewFilterEither', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReviewIdEither extends ReviewIdEither {
  @override
  final int? carReviewId;
  @override
  final VotingGeneration? votingGeneration;

  factory _$ReviewIdEither([void Function(ReviewIdEitherBuilder)? updates]) =>
      (new ReviewIdEitherBuilder()..update(updates))._build();

  _$ReviewIdEither._({this.carReviewId, this.votingGeneration}) : super._();

  @override
  ReviewIdEither rebuild(void Function(ReviewIdEitherBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewIdEitherBuilder toBuilder() =>
      new ReviewIdEitherBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewIdEither &&
        carReviewId == other.carReviewId &&
        votingGeneration == other.votingGeneration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, carReviewId.hashCode);
    _$hash = $jc(_$hash, votingGeneration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewIdEither')
          ..add('carReviewId', carReviewId)
          ..add('votingGeneration', votingGeneration))
        .toString();
  }
}

class ReviewIdEitherBuilder
    implements Builder<ReviewIdEither, ReviewIdEitherBuilder> {
  _$ReviewIdEither? _$v;

  int? _carReviewId;
  int? get carReviewId => _$this._carReviewId;
  set carReviewId(int? carReviewId) => _$this._carReviewId = carReviewId;

  VotingGenerationBuilder? _votingGeneration;
  VotingGenerationBuilder get votingGeneration =>
      _$this._votingGeneration ??= new VotingGenerationBuilder();
  set votingGeneration(VotingGenerationBuilder? votingGeneration) =>
      _$this._votingGeneration = votingGeneration;

  ReviewIdEitherBuilder();

  ReviewIdEitherBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _carReviewId = $v.carReviewId;
      _votingGeneration = $v.votingGeneration?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewIdEither other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewIdEither;
  }

  @override
  void update(void Function(ReviewIdEitherBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewIdEither build() => _build();

  _$ReviewIdEither _build() {
    _$ReviewIdEither _$result;
    try {
      _$result = _$v ??
          new _$ReviewIdEither._(
              carReviewId: carReviewId,
              votingGeneration: _votingGeneration?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'votingGeneration';
        _votingGeneration?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewIdEither', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VotingGeneration extends VotingGeneration {
  @override
  final int? generationId;
  @override
  final String? name;
  @override
  final String? icon;
  @override
  final int? generationVotes;

  factory _$VotingGeneration(
          [void Function(VotingGenerationBuilder)? updates]) =>
      (new VotingGenerationBuilder()..update(updates))._build();

  _$VotingGeneration._(
      {this.generationId, this.name, this.icon, this.generationVotes})
      : super._();

  @override
  VotingGeneration rebuild(void Function(VotingGenerationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VotingGenerationBuilder toBuilder() =>
      new VotingGenerationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VotingGeneration &&
        generationId == other.generationId &&
        name == other.name &&
        icon == other.icon &&
        generationVotes == other.generationVotes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, generationId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, generationVotes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VotingGeneration')
          ..add('generationId', generationId)
          ..add('name', name)
          ..add('icon', icon)
          ..add('generationVotes', generationVotes))
        .toString();
  }
}

class VotingGenerationBuilder
    implements Builder<VotingGeneration, VotingGenerationBuilder> {
  _$VotingGeneration? _$v;

  int? _generationId;
  int? get generationId => _$this._generationId;
  set generationId(int? generationId) => _$this._generationId = generationId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  int? _generationVotes;
  int? get generationVotes => _$this._generationVotes;
  set generationVotes(int? generationVotes) =>
      _$this._generationVotes = generationVotes;

  VotingGenerationBuilder();

  VotingGenerationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _generationId = $v.generationId;
      _name = $v.name;
      _icon = $v.icon;
      _generationVotes = $v.generationVotes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VotingGeneration other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VotingGeneration;
  }

  @override
  void update(void Function(VotingGenerationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VotingGeneration build() => _build();

  _$VotingGeneration _build() {
    final _$result = _$v ??
        new _$VotingGeneration._(
            generationId: generationId,
            name: name,
            icon: icon,
            generationVotes: generationVotes);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewListModel extends ReviewListModel {
  @override
  final int? id;
  @override
  final CarModel? carModel;
  @override
  final Advantage? advantage;
  @override
  final Advantage? disadvantage;
  @override
  final double? orientMotorsOverallRating;
  @override
  final double? usersRating;
  @override
  final String? photo;

  factory _$ReviewListModel([void Function(ReviewListModelBuilder)? updates]) =>
      (new ReviewListModelBuilder()..update(updates))._build();

  _$ReviewListModel._(
      {this.id,
      this.carModel,
      this.advantage,
      this.disadvantage,
      this.orientMotorsOverallRating,
      this.usersRating,
      this.photo})
      : super._();

  @override
  ReviewListModel rebuild(void Function(ReviewListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewListModelBuilder toBuilder() =>
      new ReviewListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewListModel &&
        id == other.id &&
        carModel == other.carModel &&
        advantage == other.advantage &&
        disadvantage == other.disadvantage &&
        orientMotorsOverallRating == other.orientMotorsOverallRating &&
        usersRating == other.usersRating &&
        photo == other.photo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, carModel.hashCode);
    _$hash = $jc(_$hash, advantage.hashCode);
    _$hash = $jc(_$hash, disadvantage.hashCode);
    _$hash = $jc(_$hash, orientMotorsOverallRating.hashCode);
    _$hash = $jc(_$hash, usersRating.hashCode);
    _$hash = $jc(_$hash, photo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewListModel')
          ..add('id', id)
          ..add('carModel', carModel)
          ..add('advantage', advantage)
          ..add('disadvantage', disadvantage)
          ..add('orientMotorsOverallRating', orientMotorsOverallRating)
          ..add('usersRating', usersRating)
          ..add('photo', photo))
        .toString();
  }
}

class ReviewListModelBuilder
    implements Builder<ReviewListModel, ReviewListModelBuilder> {
  _$ReviewListModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  CarModelBuilder? _carModel;
  CarModelBuilder get carModel => _$this._carModel ??= new CarModelBuilder();
  set carModel(CarModelBuilder? carModel) => _$this._carModel = carModel;

  AdvantageBuilder? _advantage;
  AdvantageBuilder get advantage =>
      _$this._advantage ??= new AdvantageBuilder();
  set advantage(AdvantageBuilder? advantage) => _$this._advantage = advantage;

  AdvantageBuilder? _disadvantage;
  AdvantageBuilder get disadvantage =>
      _$this._disadvantage ??= new AdvantageBuilder();
  set disadvantage(AdvantageBuilder? disadvantage) =>
      _$this._disadvantage = disadvantage;

  double? _orientMotorsOverallRating;
  double? get orientMotorsOverallRating => _$this._orientMotorsOverallRating;
  set orientMotorsOverallRating(double? orientMotorsOverallRating) =>
      _$this._orientMotorsOverallRating = orientMotorsOverallRating;

  double? _usersRating;
  double? get usersRating => _$this._usersRating;
  set usersRating(double? usersRating) => _$this._usersRating = usersRating;

  String? _photo;
  String? get photo => _$this._photo;
  set photo(String? photo) => _$this._photo = photo;

  ReviewListModelBuilder();

  ReviewListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _carModel = $v.carModel?.toBuilder();
      _advantage = $v.advantage?.toBuilder();
      _disadvantage = $v.disadvantage?.toBuilder();
      _orientMotorsOverallRating = $v.orientMotorsOverallRating;
      _usersRating = $v.usersRating;
      _photo = $v.photo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewListModel;
  }

  @override
  void update(void Function(ReviewListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewListModel build() => _build();

  _$ReviewListModel _build() {
    _$ReviewListModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewListModel._(
              id: id,
              carModel: _carModel?.build(),
              advantage: _advantage?.build(),
              disadvantage: _disadvantage?.build(),
              orientMotorsOverallRating: orientMotorsOverallRating,
              usersRating: usersRating,
              photo: photo);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'carModel';
        _carModel?.build();
        _$failedField = 'advantage';
        _advantage?.build();
        _$failedField = 'disadvantage';
        _disadvantage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewListModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Advantage extends Advantage {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? text;

  factory _$Advantage([void Function(AdvantageBuilder)? updates]) =>
      (new AdvantageBuilder()..update(updates))._build();

  _$Advantage._({this.id, this.title, this.text}) : super._();

  @override
  Advantage rebuild(void Function(AdvantageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdvantageBuilder toBuilder() => new AdvantageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Advantage &&
        id == other.id &&
        title == other.title &&
        text == other.text;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Advantage')
          ..add('id', id)
          ..add('title', title)
          ..add('text', text))
        .toString();
  }
}

class AdvantageBuilder implements Builder<Advantage, AdvantageBuilder> {
  _$Advantage? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  AdvantageBuilder();

  AdvantageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _text = $v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Advantage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Advantage;
  }

  @override
  void update(void Function(AdvantageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Advantage build() => _build();

  _$Advantage _build() {
    final _$result = _$v ?? new _$Advantage._(id: id, title: title, text: text);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewFaqModel extends ReviewFaqModel {
  @override
  final int? id;
  @override
  final String? question;
  @override
  final String? answer;

  factory _$ReviewFaqModel([void Function(ReviewFaqModelBuilder)? updates]) =>
      (new ReviewFaqModelBuilder()..update(updates))._build();

  _$ReviewFaqModel._({this.id, this.question, this.answer}) : super._();

  @override
  ReviewFaqModel rebuild(void Function(ReviewFaqModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewFaqModelBuilder toBuilder() =>
      new ReviewFaqModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewFaqModel &&
        id == other.id &&
        question == other.question &&
        answer == other.answer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, question.hashCode);
    _$hash = $jc(_$hash, answer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewFaqModel')
          ..add('id', id)
          ..add('question', question)
          ..add('answer', answer))
        .toString();
  }
}

class ReviewFaqModelBuilder
    implements Builder<ReviewFaqModel, ReviewFaqModelBuilder> {
  _$ReviewFaqModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _question;
  String? get question => _$this._question;
  set question(String? question) => _$this._question = question;

  String? _answer;
  String? get answer => _$this._answer;
  set answer(String? answer) => _$this._answer = answer;

  ReviewFaqModelBuilder();

  ReviewFaqModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _question = $v.question;
      _answer = $v.answer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewFaqModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewFaqModel;
  }

  @override
  void update(void Function(ReviewFaqModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewFaqModel build() => _build();

  _$ReviewFaqModel _build() {
    final _$result = _$v ??
        new _$ReviewFaqModel._(id: id, question: question, answer: answer);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewDesignModel extends ReviewDesignModel {
  @override
  final String? title;
  @override
  final String? externalDesign;
  @override
  final String? interiorDesign;
  @override
  final double? ratedByOrientMotors;
  @override
  final BuiltList<String>? externalPhotos;
  @override
  final BuiltList<String>? interiorPhotos;

  factory _$ReviewDesignModel(
          [void Function(ReviewDesignModelBuilder)? updates]) =>
      (new ReviewDesignModelBuilder()..update(updates))._build();

  _$ReviewDesignModel._(
      {this.title,
      this.externalDesign,
      this.interiorDesign,
      this.ratedByOrientMotors,
      this.externalPhotos,
      this.interiorPhotos})
      : super._();

  @override
  ReviewDesignModel rebuild(void Function(ReviewDesignModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewDesignModelBuilder toBuilder() =>
      new ReviewDesignModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewDesignModel &&
        title == other.title &&
        externalDesign == other.externalDesign &&
        interiorDesign == other.interiorDesign &&
        ratedByOrientMotors == other.ratedByOrientMotors &&
        externalPhotos == other.externalPhotos &&
        interiorPhotos == other.interiorPhotos;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, externalDesign.hashCode);
    _$hash = $jc(_$hash, interiorDesign.hashCode);
    _$hash = $jc(_$hash, ratedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, externalPhotos.hashCode);
    _$hash = $jc(_$hash, interiorPhotos.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewDesignModel')
          ..add('title', title)
          ..add('externalDesign', externalDesign)
          ..add('interiorDesign', interiorDesign)
          ..add('ratedByOrientMotors', ratedByOrientMotors)
          ..add('externalPhotos', externalPhotos)
          ..add('interiorPhotos', interiorPhotos))
        .toString();
  }
}

class ReviewDesignModelBuilder
    implements Builder<ReviewDesignModel, ReviewDesignModelBuilder> {
  _$ReviewDesignModel? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _externalDesign;
  String? get externalDesign => _$this._externalDesign;
  set externalDesign(String? externalDesign) =>
      _$this._externalDesign = externalDesign;

  String? _interiorDesign;
  String? get interiorDesign => _$this._interiorDesign;
  set interiorDesign(String? interiorDesign) =>
      _$this._interiorDesign = interiorDesign;

  double? _ratedByOrientMotors;
  double? get ratedByOrientMotors => _$this._ratedByOrientMotors;
  set ratedByOrientMotors(double? ratedByOrientMotors) =>
      _$this._ratedByOrientMotors = ratedByOrientMotors;

  ListBuilder<String>? _externalPhotos;
  ListBuilder<String> get externalPhotos =>
      _$this._externalPhotos ??= new ListBuilder<String>();
  set externalPhotos(ListBuilder<String>? externalPhotos) =>
      _$this._externalPhotos = externalPhotos;

  ListBuilder<String>? _interiorPhotos;
  ListBuilder<String> get interiorPhotos =>
      _$this._interiorPhotos ??= new ListBuilder<String>();
  set interiorPhotos(ListBuilder<String>? interiorPhotos) =>
      _$this._interiorPhotos = interiorPhotos;

  ReviewDesignModelBuilder();

  ReviewDesignModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _externalDesign = $v.externalDesign;
      _interiorDesign = $v.interiorDesign;
      _ratedByOrientMotors = $v.ratedByOrientMotors;
      _externalPhotos = $v.externalPhotos?.toBuilder();
      _interiorPhotos = $v.interiorPhotos?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewDesignModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewDesignModel;
  }

  @override
  void update(void Function(ReviewDesignModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewDesignModel build() => _build();

  _$ReviewDesignModel _build() {
    _$ReviewDesignModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewDesignModel._(
              title: title,
              externalDesign: externalDesign,
              interiorDesign: interiorDesign,
              ratedByOrientMotors: ratedByOrientMotors,
              externalPhotos: _externalPhotos?.build(),
              interiorPhotos: _interiorPhotos?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'externalPhotos';
        _externalPhotos?.build();
        _$failedField = 'interiorPhotos';
        _interiorPhotos?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewDesignModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReviewSafetyConvenienceModel extends ReviewSafetyConvenienceModel {
  @override
  final int? id;
  @override
  final String? safetyTitle;
  @override
  final String? safetyEquipment;
  @override
  final String? convenienceTitle;
  @override
  final String? convenienceEquipment;
  @override
  final double? ratedByOrientMotors;
  @override
  final BuiltList<Advantage>? advantages;
  @override
  final BuiltList<Advantage>? disadvantages;
  @override
  final Parametres? parametres;

  factory _$ReviewSafetyConvenienceModel(
          [void Function(ReviewSafetyConvenienceModelBuilder)? updates]) =>
      (new ReviewSafetyConvenienceModelBuilder()..update(updates))._build();

  _$ReviewSafetyConvenienceModel._(
      {this.id,
      this.safetyTitle,
      this.safetyEquipment,
      this.convenienceTitle,
      this.convenienceEquipment,
      this.ratedByOrientMotors,
      this.advantages,
      this.disadvantages,
      this.parametres})
      : super._();

  @override
  ReviewSafetyConvenienceModel rebuild(
          void Function(ReviewSafetyConvenienceModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewSafetyConvenienceModelBuilder toBuilder() =>
      new ReviewSafetyConvenienceModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewSafetyConvenienceModel &&
        id == other.id &&
        safetyTitle == other.safetyTitle &&
        safetyEquipment == other.safetyEquipment &&
        convenienceTitle == other.convenienceTitle &&
        convenienceEquipment == other.convenienceEquipment &&
        ratedByOrientMotors == other.ratedByOrientMotors &&
        advantages == other.advantages &&
        disadvantages == other.disadvantages &&
        parametres == other.parametres;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, safetyTitle.hashCode);
    _$hash = $jc(_$hash, safetyEquipment.hashCode);
    _$hash = $jc(_$hash, convenienceTitle.hashCode);
    _$hash = $jc(_$hash, convenienceEquipment.hashCode);
    _$hash = $jc(_$hash, ratedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, advantages.hashCode);
    _$hash = $jc(_$hash, disadvantages.hashCode);
    _$hash = $jc(_$hash, parametres.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewSafetyConvenienceModel')
          ..add('id', id)
          ..add('safetyTitle', safetyTitle)
          ..add('safetyEquipment', safetyEquipment)
          ..add('convenienceTitle', convenienceTitle)
          ..add('convenienceEquipment', convenienceEquipment)
          ..add('ratedByOrientMotors', ratedByOrientMotors)
          ..add('advantages', advantages)
          ..add('disadvantages', disadvantages)
          ..add('parametres', parametres))
        .toString();
  }
}

class ReviewSafetyConvenienceModelBuilder
    implements
        Builder<ReviewSafetyConvenienceModel,
            ReviewSafetyConvenienceModelBuilder> {
  _$ReviewSafetyConvenienceModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _safetyTitle;
  String? get safetyTitle => _$this._safetyTitle;
  set safetyTitle(String? safetyTitle) => _$this._safetyTitle = safetyTitle;

  String? _safetyEquipment;
  String? get safetyEquipment => _$this._safetyEquipment;
  set safetyEquipment(String? safetyEquipment) =>
      _$this._safetyEquipment = safetyEquipment;

  String? _convenienceTitle;
  String? get convenienceTitle => _$this._convenienceTitle;
  set convenienceTitle(String? convenienceTitle) =>
      _$this._convenienceTitle = convenienceTitle;

  String? _convenienceEquipment;
  String? get convenienceEquipment => _$this._convenienceEquipment;
  set convenienceEquipment(String? convenienceEquipment) =>
      _$this._convenienceEquipment = convenienceEquipment;

  double? _ratedByOrientMotors;
  double? get ratedByOrientMotors => _$this._ratedByOrientMotors;
  set ratedByOrientMotors(double? ratedByOrientMotors) =>
      _$this._ratedByOrientMotors = ratedByOrientMotors;

  ListBuilder<Advantage>? _advantages;
  ListBuilder<Advantage> get advantages =>
      _$this._advantages ??= new ListBuilder<Advantage>();
  set advantages(ListBuilder<Advantage>? advantages) =>
      _$this._advantages = advantages;

  ListBuilder<Advantage>? _disadvantages;
  ListBuilder<Advantage> get disadvantages =>
      _$this._disadvantages ??= new ListBuilder<Advantage>();
  set disadvantages(ListBuilder<Advantage>? disadvantages) =>
      _$this._disadvantages = disadvantages;

  ParametresBuilder? _parametres;
  ParametresBuilder get parametres =>
      _$this._parametres ??= new ParametresBuilder();
  set parametres(ParametresBuilder? parametres) =>
      _$this._parametres = parametres;

  ReviewSafetyConvenienceModelBuilder();

  ReviewSafetyConvenienceModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _safetyTitle = $v.safetyTitle;
      _safetyEquipment = $v.safetyEquipment;
      _convenienceTitle = $v.convenienceTitle;
      _convenienceEquipment = $v.convenienceEquipment;
      _ratedByOrientMotors = $v.ratedByOrientMotors;
      _advantages = $v.advantages?.toBuilder();
      _disadvantages = $v.disadvantages?.toBuilder();
      _parametres = $v.parametres?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewSafetyConvenienceModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewSafetyConvenienceModel;
  }

  @override
  void update(void Function(ReviewSafetyConvenienceModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewSafetyConvenienceModel build() => _build();

  _$ReviewSafetyConvenienceModel _build() {
    _$ReviewSafetyConvenienceModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewSafetyConvenienceModel._(
              id: id,
              safetyTitle: safetyTitle,
              safetyEquipment: safetyEquipment,
              convenienceTitle: convenienceTitle,
              convenienceEquipment: convenienceEquipment,
              ratedByOrientMotors: ratedByOrientMotors,
              advantages: _advantages?.build(),
              disadvantages: _disadvantages?.build(),
              parametres: _parametres?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'advantages';
        _advantages?.build();
        _$failedField = 'disadvantages';
        _disadvantages?.build();
        _$failedField = 'parametres';
        _parametres?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewSafetyConvenienceModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Parametres extends Parametres {
  @override
  final int? id;
  @override
  final double? horsePower;
  @override
  final String? engineType;
  @override
  final String? transmission;
  @override
  final String? drive;
  @override
  final double? volume;
  @override
  final double? timeTo100;
  @override
  final double? maxSpeed;
  @override
  final double? diameter;
  @override
  final String? petrolType;
  @override
  final double? weight;
  @override
  final double? height;
  @override
  final double? width;
  @override
  final double? length;
  @override
  final double? fuelTankCapacity;
  @override
  final double? volumeLitres;
  @override
  final double? safetyRating;
  @override
  final double? safetyGrade;
  @override
  final double? modification;

  factory _$Parametres([void Function(ParametresBuilder)? updates]) =>
      (new ParametresBuilder()..update(updates))._build();

  _$Parametres._(
      {this.id,
      this.horsePower,
      this.engineType,
      this.transmission,
      this.drive,
      this.volume,
      this.timeTo100,
      this.maxSpeed,
      this.diameter,
      this.petrolType,
      this.weight,
      this.height,
      this.width,
      this.length,
      this.fuelTankCapacity,
      this.volumeLitres,
      this.safetyRating,
      this.safetyGrade,
      this.modification})
      : super._();

  @override
  Parametres rebuild(void Function(ParametresBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParametresBuilder toBuilder() => new ParametresBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Parametres &&
        id == other.id &&
        horsePower == other.horsePower &&
        engineType == other.engineType &&
        transmission == other.transmission &&
        drive == other.drive &&
        volume == other.volume &&
        timeTo100 == other.timeTo100 &&
        maxSpeed == other.maxSpeed &&
        diameter == other.diameter &&
        petrolType == other.petrolType &&
        weight == other.weight &&
        height == other.height &&
        width == other.width &&
        length == other.length &&
        fuelTankCapacity == other.fuelTankCapacity &&
        volumeLitres == other.volumeLitres &&
        safetyRating == other.safetyRating &&
        safetyGrade == other.safetyGrade &&
        modification == other.modification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, horsePower.hashCode);
    _$hash = $jc(_$hash, engineType.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, drive.hashCode);
    _$hash = $jc(_$hash, volume.hashCode);
    _$hash = $jc(_$hash, timeTo100.hashCode);
    _$hash = $jc(_$hash, maxSpeed.hashCode);
    _$hash = $jc(_$hash, diameter.hashCode);
    _$hash = $jc(_$hash, petrolType.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, width.hashCode);
    _$hash = $jc(_$hash, length.hashCode);
    _$hash = $jc(_$hash, fuelTankCapacity.hashCode);
    _$hash = $jc(_$hash, volumeLitres.hashCode);
    _$hash = $jc(_$hash, safetyRating.hashCode);
    _$hash = $jc(_$hash, safetyGrade.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Parametres')
          ..add('id', id)
          ..add('horsePower', horsePower)
          ..add('engineType', engineType)
          ..add('transmission', transmission)
          ..add('drive', drive)
          ..add('volume', volume)
          ..add('timeTo100', timeTo100)
          ..add('maxSpeed', maxSpeed)
          ..add('diameter', diameter)
          ..add('petrolType', petrolType)
          ..add('weight', weight)
          ..add('height', height)
          ..add('width', width)
          ..add('length', length)
          ..add('fuelTankCapacity', fuelTankCapacity)
          ..add('volumeLitres', volumeLitres)
          ..add('safetyRating', safetyRating)
          ..add('safetyGrade', safetyGrade)
          ..add('modification', modification))
        .toString();
  }
}

class ParametresBuilder implements Builder<Parametres, ParametresBuilder> {
  _$Parametres? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _horsePower;
  double? get horsePower => _$this._horsePower;
  set horsePower(double? horsePower) => _$this._horsePower = horsePower;

  String? _engineType;
  String? get engineType => _$this._engineType;
  set engineType(String? engineType) => _$this._engineType = engineType;

  String? _transmission;
  String? get transmission => _$this._transmission;
  set transmission(String? transmission) => _$this._transmission = transmission;

  String? _drive;
  String? get drive => _$this._drive;
  set drive(String? drive) => _$this._drive = drive;

  double? _volume;
  double? get volume => _$this._volume;
  set volume(double? volume) => _$this._volume = volume;

  double? _timeTo100;
  double? get timeTo100 => _$this._timeTo100;
  set timeTo100(double? timeTo100) => _$this._timeTo100 = timeTo100;

  double? _maxSpeed;
  double? get maxSpeed => _$this._maxSpeed;
  set maxSpeed(double? maxSpeed) => _$this._maxSpeed = maxSpeed;

  double? _diameter;
  double? get diameter => _$this._diameter;
  set diameter(double? diameter) => _$this._diameter = diameter;

  String? _petrolType;
  String? get petrolType => _$this._petrolType;
  set petrolType(String? petrolType) => _$this._petrolType = petrolType;

  double? _weight;
  double? get weight => _$this._weight;
  set weight(double? weight) => _$this._weight = weight;

  double? _height;
  double? get height => _$this._height;
  set height(double? height) => _$this._height = height;

  double? _width;
  double? get width => _$this._width;
  set width(double? width) => _$this._width = width;

  double? _length;
  double? get length => _$this._length;
  set length(double? length) => _$this._length = length;

  double? _fuelTankCapacity;
  double? get fuelTankCapacity => _$this._fuelTankCapacity;
  set fuelTankCapacity(double? fuelTankCapacity) =>
      _$this._fuelTankCapacity = fuelTankCapacity;

  double? _volumeLitres;
  double? get volumeLitres => _$this._volumeLitres;
  set volumeLitres(double? volumeLitres) => _$this._volumeLitres = volumeLitres;

  double? _safetyRating;
  double? get safetyRating => _$this._safetyRating;
  set safetyRating(double? safetyRating) => _$this._safetyRating = safetyRating;

  double? _safetyGrade;
  double? get safetyGrade => _$this._safetyGrade;
  set safetyGrade(double? safetyGrade) => _$this._safetyGrade = safetyGrade;

  double? _modification;
  double? get modification => _$this._modification;
  set modification(double? modification) => _$this._modification = modification;

  ParametresBuilder();

  ParametresBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _horsePower = $v.horsePower;
      _engineType = $v.engineType;
      _transmission = $v.transmission;
      _drive = $v.drive;
      _volume = $v.volume;
      _timeTo100 = $v.timeTo100;
      _maxSpeed = $v.maxSpeed;
      _diameter = $v.diameter;
      _petrolType = $v.petrolType;
      _weight = $v.weight;
      _height = $v.height;
      _width = $v.width;
      _length = $v.length;
      _fuelTankCapacity = $v.fuelTankCapacity;
      _volumeLitres = $v.volumeLitres;
      _safetyRating = $v.safetyRating;
      _safetyGrade = $v.safetyGrade;
      _modification = $v.modification;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Parametres other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Parametres;
  }

  @override
  void update(void Function(ParametresBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Parametres build() => _build();

  _$Parametres _build() {
    final _$result = _$v ??
        new _$Parametres._(
            id: id,
            horsePower: horsePower,
            engineType: engineType,
            transmission: transmission,
            drive: drive,
            volume: volume,
            timeTo100: timeTo100,
            maxSpeed: maxSpeed,
            diameter: diameter,
            petrolType: petrolType,
            weight: weight,
            height: height,
            width: width,
            length: length,
            fuelTankCapacity: fuelTankCapacity,
            volumeLitres: volumeLitres,
            safetyRating: safetyRating,
            safetyGrade: safetyGrade,
            modification: modification);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewSizeSpaceModel extends ReviewSizeSpaceModel {
  @override
  final String? title;
  @override
  final Dimension? dimension;
  @override
  final String? dimensionsAndSpace;
  @override
  final double? ratedByOrientMotors;
  @override
  final String? heightWidthPhoto;
  @override
  final String? lengthPhoto;
  @override
  final BuiltList<String>? photos;

  factory _$ReviewSizeSpaceModel(
          [void Function(ReviewSizeSpaceModelBuilder)? updates]) =>
      (new ReviewSizeSpaceModelBuilder()..update(updates))._build();

  _$ReviewSizeSpaceModel._(
      {this.title,
      this.dimension,
      this.dimensionsAndSpace,
      this.ratedByOrientMotors,
      this.heightWidthPhoto,
      this.lengthPhoto,
      this.photos})
      : super._();

  @override
  ReviewSizeSpaceModel rebuild(
          void Function(ReviewSizeSpaceModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewSizeSpaceModelBuilder toBuilder() =>
      new ReviewSizeSpaceModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewSizeSpaceModel &&
        title == other.title &&
        dimension == other.dimension &&
        dimensionsAndSpace == other.dimensionsAndSpace &&
        ratedByOrientMotors == other.ratedByOrientMotors &&
        heightWidthPhoto == other.heightWidthPhoto &&
        lengthPhoto == other.lengthPhoto &&
        photos == other.photos;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, dimension.hashCode);
    _$hash = $jc(_$hash, dimensionsAndSpace.hashCode);
    _$hash = $jc(_$hash, ratedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, heightWidthPhoto.hashCode);
    _$hash = $jc(_$hash, lengthPhoto.hashCode);
    _$hash = $jc(_$hash, photos.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewSizeSpaceModel')
          ..add('title', title)
          ..add('dimension', dimension)
          ..add('dimensionsAndSpace', dimensionsAndSpace)
          ..add('ratedByOrientMotors', ratedByOrientMotors)
          ..add('heightWidthPhoto', heightWidthPhoto)
          ..add('lengthPhoto', lengthPhoto)
          ..add('photos', photos))
        .toString();
  }
}

class ReviewSizeSpaceModelBuilder
    implements Builder<ReviewSizeSpaceModel, ReviewSizeSpaceModelBuilder> {
  _$ReviewSizeSpaceModel? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  DimensionBuilder? _dimension;
  DimensionBuilder get dimension =>
      _$this._dimension ??= new DimensionBuilder();
  set dimension(DimensionBuilder? dimension) => _$this._dimension = dimension;

  String? _dimensionsAndSpace;
  String? get dimensionsAndSpace => _$this._dimensionsAndSpace;
  set dimensionsAndSpace(String? dimensionsAndSpace) =>
      _$this._dimensionsAndSpace = dimensionsAndSpace;

  double? _ratedByOrientMotors;
  double? get ratedByOrientMotors => _$this._ratedByOrientMotors;
  set ratedByOrientMotors(double? ratedByOrientMotors) =>
      _$this._ratedByOrientMotors = ratedByOrientMotors;

  String? _heightWidthPhoto;
  String? get heightWidthPhoto => _$this._heightWidthPhoto;
  set heightWidthPhoto(String? heightWidthPhoto) =>
      _$this._heightWidthPhoto = heightWidthPhoto;

  String? _lengthPhoto;
  String? get lengthPhoto => _$this._lengthPhoto;
  set lengthPhoto(String? lengthPhoto) => _$this._lengthPhoto = lengthPhoto;

  ListBuilder<String>? _photos;
  ListBuilder<String> get photos =>
      _$this._photos ??= new ListBuilder<String>();
  set photos(ListBuilder<String>? photos) => _$this._photos = photos;

  ReviewSizeSpaceModelBuilder();

  ReviewSizeSpaceModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _dimension = $v.dimension?.toBuilder();
      _dimensionsAndSpace = $v.dimensionsAndSpace;
      _ratedByOrientMotors = $v.ratedByOrientMotors;
      _heightWidthPhoto = $v.heightWidthPhoto;
      _lengthPhoto = $v.lengthPhoto;
      _photos = $v.photos?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewSizeSpaceModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewSizeSpaceModel;
  }

  @override
  void update(void Function(ReviewSizeSpaceModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewSizeSpaceModel build() => _build();

  _$ReviewSizeSpaceModel _build() {
    _$ReviewSizeSpaceModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewSizeSpaceModel._(
              title: title,
              dimension: _dimension?.build(),
              dimensionsAndSpace: dimensionsAndSpace,
              ratedByOrientMotors: ratedByOrientMotors,
              heightWidthPhoto: heightWidthPhoto,
              lengthPhoto: lengthPhoto,
              photos: _photos?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dimension';
        _dimension?.build();

        _$failedField = 'photos';
        _photos?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewSizeSpaceModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Dimension extends Dimension {
  @override
  final int? id;
  @override
  final double? horsePower;
  @override
  final String? engineType;
  @override
  final String? transmission;
  @override
  final String? drive;
  @override
  final double? volume;
  @override
  final double? timeTo100;
  @override
  final double? maxSpeed;
  @override
  final double? diameter;
  @override
  final String? petrolType;
  @override
  final double? weight;
  @override
  final double? height;
  @override
  final double? width;
  @override
  final double? length;
  @override
  final double? fuelTankCapacity;
  @override
  final double? volumeLitres;
  @override
  final double? safetyRating;
  @override
  final double? safetyGrade;
  @override
  final double? modification;

  factory _$Dimension([void Function(DimensionBuilder)? updates]) =>
      (new DimensionBuilder()..update(updates))._build();

  _$Dimension._(
      {this.id,
      this.horsePower,
      this.engineType,
      this.transmission,
      this.drive,
      this.volume,
      this.timeTo100,
      this.maxSpeed,
      this.diameter,
      this.petrolType,
      this.weight,
      this.height,
      this.width,
      this.length,
      this.fuelTankCapacity,
      this.volumeLitres,
      this.safetyRating,
      this.safetyGrade,
      this.modification})
      : super._();

  @override
  Dimension rebuild(void Function(DimensionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DimensionBuilder toBuilder() => new DimensionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Dimension &&
        id == other.id &&
        horsePower == other.horsePower &&
        engineType == other.engineType &&
        transmission == other.transmission &&
        drive == other.drive &&
        volume == other.volume &&
        timeTo100 == other.timeTo100 &&
        maxSpeed == other.maxSpeed &&
        diameter == other.diameter &&
        petrolType == other.petrolType &&
        weight == other.weight &&
        height == other.height &&
        width == other.width &&
        length == other.length &&
        fuelTankCapacity == other.fuelTankCapacity &&
        volumeLitres == other.volumeLitres &&
        safetyRating == other.safetyRating &&
        safetyGrade == other.safetyGrade &&
        modification == other.modification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, horsePower.hashCode);
    _$hash = $jc(_$hash, engineType.hashCode);
    _$hash = $jc(_$hash, transmission.hashCode);
    _$hash = $jc(_$hash, drive.hashCode);
    _$hash = $jc(_$hash, volume.hashCode);
    _$hash = $jc(_$hash, timeTo100.hashCode);
    _$hash = $jc(_$hash, maxSpeed.hashCode);
    _$hash = $jc(_$hash, diameter.hashCode);
    _$hash = $jc(_$hash, petrolType.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, width.hashCode);
    _$hash = $jc(_$hash, length.hashCode);
    _$hash = $jc(_$hash, fuelTankCapacity.hashCode);
    _$hash = $jc(_$hash, volumeLitres.hashCode);
    _$hash = $jc(_$hash, safetyRating.hashCode);
    _$hash = $jc(_$hash, safetyGrade.hashCode);
    _$hash = $jc(_$hash, modification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Dimension')
          ..add('id', id)
          ..add('horsePower', horsePower)
          ..add('engineType', engineType)
          ..add('transmission', transmission)
          ..add('drive', drive)
          ..add('volume', volume)
          ..add('timeTo100', timeTo100)
          ..add('maxSpeed', maxSpeed)
          ..add('diameter', diameter)
          ..add('petrolType', petrolType)
          ..add('weight', weight)
          ..add('height', height)
          ..add('width', width)
          ..add('length', length)
          ..add('fuelTankCapacity', fuelTankCapacity)
          ..add('volumeLitres', volumeLitres)
          ..add('safetyRating', safetyRating)
          ..add('safetyGrade', safetyGrade)
          ..add('modification', modification))
        .toString();
  }
}

class DimensionBuilder implements Builder<Dimension, DimensionBuilder> {
  _$Dimension? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _horsePower;
  double? get horsePower => _$this._horsePower;
  set horsePower(double? horsePower) => _$this._horsePower = horsePower;

  String? _engineType;
  String? get engineType => _$this._engineType;
  set engineType(String? engineType) => _$this._engineType = engineType;

  String? _transmission;
  String? get transmission => _$this._transmission;
  set transmission(String? transmission) => _$this._transmission = transmission;

  String? _drive;
  String? get drive => _$this._drive;
  set drive(String? drive) => _$this._drive = drive;

  double? _volume;
  double? get volume => _$this._volume;
  set volume(double? volume) => _$this._volume = volume;

  double? _timeTo100;
  double? get timeTo100 => _$this._timeTo100;
  set timeTo100(double? timeTo100) => _$this._timeTo100 = timeTo100;

  double? _maxSpeed;
  double? get maxSpeed => _$this._maxSpeed;
  set maxSpeed(double? maxSpeed) => _$this._maxSpeed = maxSpeed;

  double? _diameter;
  double? get diameter => _$this._diameter;
  set diameter(double? diameter) => _$this._diameter = diameter;

  String? _petrolType;
  String? get petrolType => _$this._petrolType;
  set petrolType(String? petrolType) => _$this._petrolType = petrolType;

  double? _weight;
  double? get weight => _$this._weight;
  set weight(double? weight) => _$this._weight = weight;

  double? _height;
  double? get height => _$this._height;
  set height(double? height) => _$this._height = height;

  double? _width;
  double? get width => _$this._width;
  set width(double? width) => _$this._width = width;

  double? _length;
  double? get length => _$this._length;
  set length(double? length) => _$this._length = length;

  double? _fuelTankCapacity;
  double? get fuelTankCapacity => _$this._fuelTankCapacity;
  set fuelTankCapacity(double? fuelTankCapacity) =>
      _$this._fuelTankCapacity = fuelTankCapacity;

  double? _volumeLitres;
  double? get volumeLitres => _$this._volumeLitres;
  set volumeLitres(double? volumeLitres) => _$this._volumeLitres = volumeLitres;

  double? _safetyRating;
  double? get safetyRating => _$this._safetyRating;
  set safetyRating(double? safetyRating) => _$this._safetyRating = safetyRating;

  double? _safetyGrade;
  double? get safetyGrade => _$this._safetyGrade;
  set safetyGrade(double? safetyGrade) => _$this._safetyGrade = safetyGrade;

  double? _modification;
  double? get modification => _$this._modification;
  set modification(double? modification) => _$this._modification = modification;

  DimensionBuilder();

  DimensionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _horsePower = $v.horsePower;
      _engineType = $v.engineType;
      _transmission = $v.transmission;
      _drive = $v.drive;
      _volume = $v.volume;
      _timeTo100 = $v.timeTo100;
      _maxSpeed = $v.maxSpeed;
      _diameter = $v.diameter;
      _petrolType = $v.petrolType;
      _weight = $v.weight;
      _height = $v.height;
      _width = $v.width;
      _length = $v.length;
      _fuelTankCapacity = $v.fuelTankCapacity;
      _volumeLitres = $v.volumeLitres;
      _safetyRating = $v.safetyRating;
      _safetyGrade = $v.safetyGrade;
      _modification = $v.modification;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Dimension other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Dimension;
  }

  @override
  void update(void Function(DimensionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Dimension build() => _build();

  _$Dimension _build() {
    final _$result = _$v ??
        new _$Dimension._(
            id: id,
            horsePower: horsePower,
            engineType: engineType,
            transmission: transmission,
            drive: drive,
            volume: volume,
            timeTo100: timeTo100,
            maxSpeed: maxSpeed,
            diameter: diameter,
            petrolType: petrolType,
            weight: weight,
            height: height,
            width: width,
            length: length,
            fuelTankCapacity: fuelTankCapacity,
            volumeLitres: volumeLitres,
            safetyRating: safetyRating,
            safetyGrade: safetyGrade,
            modification: modification);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewMaintenanceModel extends ReviewMaintenanceModel {
  @override
  final int? id;
  @override
  final String? service;
  @override
  final String? warranty;
  @override
  final double? ratedByOrientMotors;
  @override
  final String? fuelEfficiency;
  @override
  final BuiltList<Advantage>? advantages;
  @override
  final BuiltList<Advantage>? disadvantages;

  factory _$ReviewMaintenanceModel(
          [void Function(ReviewMaintenanceModelBuilder)? updates]) =>
      (new ReviewMaintenanceModelBuilder()..update(updates))._build();

  _$ReviewMaintenanceModel._(
      {this.id,
      this.service,
      this.warranty,
      this.ratedByOrientMotors,
      this.fuelEfficiency,
      this.advantages,
      this.disadvantages})
      : super._();

  @override
  ReviewMaintenanceModel rebuild(
          void Function(ReviewMaintenanceModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewMaintenanceModelBuilder toBuilder() =>
      new ReviewMaintenanceModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewMaintenanceModel &&
        id == other.id &&
        service == other.service &&
        warranty == other.warranty &&
        ratedByOrientMotors == other.ratedByOrientMotors &&
        fuelEfficiency == other.fuelEfficiency &&
        advantages == other.advantages &&
        disadvantages == other.disadvantages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, service.hashCode);
    _$hash = $jc(_$hash, warranty.hashCode);
    _$hash = $jc(_$hash, ratedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, fuelEfficiency.hashCode);
    _$hash = $jc(_$hash, advantages.hashCode);
    _$hash = $jc(_$hash, disadvantages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewMaintenanceModel')
          ..add('id', id)
          ..add('service', service)
          ..add('warranty', warranty)
          ..add('ratedByOrientMotors', ratedByOrientMotors)
          ..add('fuelEfficiency', fuelEfficiency)
          ..add('advantages', advantages)
          ..add('disadvantages', disadvantages))
        .toString();
  }
}

class ReviewMaintenanceModelBuilder
    implements Builder<ReviewMaintenanceModel, ReviewMaintenanceModelBuilder> {
  _$ReviewMaintenanceModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _service;
  String? get service => _$this._service;
  set service(String? service) => _$this._service = service;

  String? _warranty;
  String? get warranty => _$this._warranty;
  set warranty(String? warranty) => _$this._warranty = warranty;

  double? _ratedByOrientMotors;
  double? get ratedByOrientMotors => _$this._ratedByOrientMotors;
  set ratedByOrientMotors(double? ratedByOrientMotors) =>
      _$this._ratedByOrientMotors = ratedByOrientMotors;

  String? _fuelEfficiency;
  String? get fuelEfficiency => _$this._fuelEfficiency;
  set fuelEfficiency(String? fuelEfficiency) =>
      _$this._fuelEfficiency = fuelEfficiency;

  ListBuilder<Advantage>? _advantages;
  ListBuilder<Advantage> get advantages =>
      _$this._advantages ??= new ListBuilder<Advantage>();
  set advantages(ListBuilder<Advantage>? advantages) =>
      _$this._advantages = advantages;

  ListBuilder<Advantage>? _disadvantages;
  ListBuilder<Advantage> get disadvantages =>
      _$this._disadvantages ??= new ListBuilder<Advantage>();
  set disadvantages(ListBuilder<Advantage>? disadvantages) =>
      _$this._disadvantages = disadvantages;

  ReviewMaintenanceModelBuilder();

  ReviewMaintenanceModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _service = $v.service;
      _warranty = $v.warranty;
      _ratedByOrientMotors = $v.ratedByOrientMotors;
      _fuelEfficiency = $v.fuelEfficiency;
      _advantages = $v.advantages?.toBuilder();
      _disadvantages = $v.disadvantages?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewMaintenanceModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewMaintenanceModel;
  }

  @override
  void update(void Function(ReviewMaintenanceModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewMaintenanceModel build() => _build();

  _$ReviewMaintenanceModel _build() {
    _$ReviewMaintenanceModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewMaintenanceModel._(
              id: id,
              service: service,
              warranty: warranty,
              ratedByOrientMotors: ratedByOrientMotors,
              fuelEfficiency: fuelEfficiency,
              advantages: _advantages?.build(),
              disadvantages: _disadvantages?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'advantages';
        _advantages?.build();
        _$failedField = 'disadvantages';
        _disadvantages?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewMaintenanceModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReviewPriceModel extends ReviewPriceModel {
  @override
  final int? id;
  @override
  final double? newCarFrom;
  @override
  final double? newCarTo;
  @override
  final double? usedCarFrom;
  @override
  final double? usedCarTo;
  @override
  final double? ratedByOrientMotors;
  @override
  final String? text;

  factory _$ReviewPriceModel(
          [void Function(ReviewPriceModelBuilder)? updates]) =>
      (new ReviewPriceModelBuilder()..update(updates))._build();

  _$ReviewPriceModel._(
      {this.id,
      this.newCarFrom,
      this.newCarTo,
      this.usedCarFrom,
      this.usedCarTo,
      this.ratedByOrientMotors,
      this.text})
      : super._();

  @override
  ReviewPriceModel rebuild(void Function(ReviewPriceModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewPriceModelBuilder toBuilder() =>
      new ReviewPriceModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewPriceModel &&
        id == other.id &&
        newCarFrom == other.newCarFrom &&
        newCarTo == other.newCarTo &&
        usedCarFrom == other.usedCarFrom &&
        usedCarTo == other.usedCarTo &&
        ratedByOrientMotors == other.ratedByOrientMotors &&
        text == other.text;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, newCarFrom.hashCode);
    _$hash = $jc(_$hash, newCarTo.hashCode);
    _$hash = $jc(_$hash, usedCarFrom.hashCode);
    _$hash = $jc(_$hash, usedCarTo.hashCode);
    _$hash = $jc(_$hash, ratedByOrientMotors.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewPriceModel')
          ..add('id', id)
          ..add('newCarFrom', newCarFrom)
          ..add('newCarTo', newCarTo)
          ..add('usedCarFrom', usedCarFrom)
          ..add('usedCarTo', usedCarTo)
          ..add('ratedByOrientMotors', ratedByOrientMotors)
          ..add('text', text))
        .toString();
  }
}

class ReviewPriceModelBuilder
    implements Builder<ReviewPriceModel, ReviewPriceModelBuilder> {
  _$ReviewPriceModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _newCarFrom;
  double? get newCarFrom => _$this._newCarFrom;
  set newCarFrom(double? newCarFrom) => _$this._newCarFrom = newCarFrom;

  double? _newCarTo;
  double? get newCarTo => _$this._newCarTo;
  set newCarTo(double? newCarTo) => _$this._newCarTo = newCarTo;

  double? _usedCarFrom;
  double? get usedCarFrom => _$this._usedCarFrom;
  set usedCarFrom(double? usedCarFrom) => _$this._usedCarFrom = usedCarFrom;

  double? _usedCarTo;
  double? get usedCarTo => _$this._usedCarTo;
  set usedCarTo(double? usedCarTo) => _$this._usedCarTo = usedCarTo;

  double? _ratedByOrientMotors;
  double? get ratedByOrientMotors => _$this._ratedByOrientMotors;
  set ratedByOrientMotors(double? ratedByOrientMotors) =>
      _$this._ratedByOrientMotors = ratedByOrientMotors;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  ReviewPriceModelBuilder();

  ReviewPriceModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _newCarFrom = $v.newCarFrom;
      _newCarTo = $v.newCarTo;
      _usedCarFrom = $v.usedCarFrom;
      _usedCarTo = $v.usedCarTo;
      _ratedByOrientMotors = $v.ratedByOrientMotors;
      _text = $v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewPriceModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewPriceModel;
  }

  @override
  void update(void Function(ReviewPriceModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewPriceModel build() => _build();

  _$ReviewPriceModel _build() {
    final _$result = _$v ??
        new _$ReviewPriceModel._(
            id: id,
            newCarFrom: newCarFrom,
            newCarTo: newCarTo,
            usedCarFrom: usedCarFrom,
            usedCarTo: usedCarTo,
            ratedByOrientMotors: ratedByOrientMotors,
            text: text);
    replace(_$result);
    return _$result;
  }
}

class _$ReviewSpecificationModel extends ReviewSpecificationModel {
  @override
  final BuiltList<Advantage> advantages;
  @override
  final BuiltList<Advantage> disadvantages;
  @override
  final Parametres parametres;

  factory _$ReviewSpecificationModel(
          [void Function(ReviewSpecificationModelBuilder)? updates]) =>
      (new ReviewSpecificationModelBuilder()..update(updates))._build();

  _$ReviewSpecificationModel._(
      {required this.advantages,
      required this.disadvantages,
      required this.parametres})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        advantages, r'ReviewSpecificationModel', 'advantages');
    BuiltValueNullFieldError.checkNotNull(
        disadvantages, r'ReviewSpecificationModel', 'disadvantages');
    BuiltValueNullFieldError.checkNotNull(
        parametres, r'ReviewSpecificationModel', 'parametres');
  }

  @override
  ReviewSpecificationModel rebuild(
          void Function(ReviewSpecificationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewSpecificationModelBuilder toBuilder() =>
      new ReviewSpecificationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewSpecificationModel &&
        advantages == other.advantages &&
        disadvantages == other.disadvantages &&
        parametres == other.parametres;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, advantages.hashCode);
    _$hash = $jc(_$hash, disadvantages.hashCode);
    _$hash = $jc(_$hash, parametres.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewSpecificationModel')
          ..add('advantages', advantages)
          ..add('disadvantages', disadvantages)
          ..add('parametres', parametres))
        .toString();
  }
}

class ReviewSpecificationModelBuilder
    implements
        Builder<ReviewSpecificationModel, ReviewSpecificationModelBuilder> {
  _$ReviewSpecificationModel? _$v;

  ListBuilder<Advantage>? _advantages;
  ListBuilder<Advantage> get advantages =>
      _$this._advantages ??= new ListBuilder<Advantage>();
  set advantages(ListBuilder<Advantage>? advantages) =>
      _$this._advantages = advantages;

  ListBuilder<Advantage>? _disadvantages;
  ListBuilder<Advantage> get disadvantages =>
      _$this._disadvantages ??= new ListBuilder<Advantage>();
  set disadvantages(ListBuilder<Advantage>? disadvantages) =>
      _$this._disadvantages = disadvantages;

  ParametresBuilder? _parametres;
  ParametresBuilder get parametres =>
      _$this._parametres ??= new ParametresBuilder();
  set parametres(ParametresBuilder? parametres) =>
      _$this._parametres = parametres;

  ReviewSpecificationModelBuilder();

  ReviewSpecificationModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _advantages = $v.advantages.toBuilder();
      _disadvantages = $v.disadvantages.toBuilder();
      _parametres = $v.parametres.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewSpecificationModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewSpecificationModel;
  }

  @override
  void update(void Function(ReviewSpecificationModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewSpecificationModel build() => _build();

  _$ReviewSpecificationModel _build() {
    _$ReviewSpecificationModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewSpecificationModel._(
              advantages: advantages.build(),
              disadvantages: disadvantages.build(),
              parametres: parametres.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'advantages';
        advantages.build();
        _$failedField = 'disadvantages';
        disadvantages.build();
        _$failedField = 'parametres';
        parametres.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewSpecificationModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReviewLinkModel extends ReviewLinkModel {
  @override
  final int? id;
  @override
  final Brand? brand;
  @override
  final String? brandUrl;
  @override
  final String? serviceCenterUrl;
  @override
  final String? exhibitionInfoUrl;
  @override
  final int? carReview;

  factory _$ReviewLinkModel([void Function(ReviewLinkModelBuilder)? updates]) =>
      (new ReviewLinkModelBuilder()..update(updates))._build();

  _$ReviewLinkModel._(
      {this.id,
      this.brand,
      this.brandUrl,
      this.serviceCenterUrl,
      this.exhibitionInfoUrl,
      this.carReview})
      : super._();

  @override
  ReviewLinkModel rebuild(void Function(ReviewLinkModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewLinkModelBuilder toBuilder() =>
      new ReviewLinkModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewLinkModel &&
        id == other.id &&
        brand == other.brand &&
        brandUrl == other.brandUrl &&
        serviceCenterUrl == other.serviceCenterUrl &&
        exhibitionInfoUrl == other.exhibitionInfoUrl &&
        carReview == other.carReview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, brandUrl.hashCode);
    _$hash = $jc(_$hash, serviceCenterUrl.hashCode);
    _$hash = $jc(_$hash, exhibitionInfoUrl.hashCode);
    _$hash = $jc(_$hash, carReview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewLinkModel')
          ..add('id', id)
          ..add('brand', brand)
          ..add('brandUrl', brandUrl)
          ..add('serviceCenterUrl', serviceCenterUrl)
          ..add('exhibitionInfoUrl', exhibitionInfoUrl)
          ..add('carReview', carReview))
        .toString();
  }
}

class ReviewLinkModelBuilder
    implements Builder<ReviewLinkModel, ReviewLinkModelBuilder> {
  _$ReviewLinkModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  BrandBuilder? _brand;
  BrandBuilder get brand => _$this._brand ??= new BrandBuilder();
  set brand(BrandBuilder? brand) => _$this._brand = brand;

  String? _brandUrl;
  String? get brandUrl => _$this._brandUrl;
  set brandUrl(String? brandUrl) => _$this._brandUrl = brandUrl;

  String? _serviceCenterUrl;
  String? get serviceCenterUrl => _$this._serviceCenterUrl;
  set serviceCenterUrl(String? serviceCenterUrl) =>
      _$this._serviceCenterUrl = serviceCenterUrl;

  String? _exhibitionInfoUrl;
  String? get exhibitionInfoUrl => _$this._exhibitionInfoUrl;
  set exhibitionInfoUrl(String? exhibitionInfoUrl) =>
      _$this._exhibitionInfoUrl = exhibitionInfoUrl;

  int? _carReview;
  int? get carReview => _$this._carReview;
  set carReview(int? carReview) => _$this._carReview = carReview;

  ReviewLinkModelBuilder();

  ReviewLinkModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _brand = $v.brand?.toBuilder();
      _brandUrl = $v.brandUrl;
      _serviceCenterUrl = $v.serviceCenterUrl;
      _exhibitionInfoUrl = $v.exhibitionInfoUrl;
      _carReview = $v.carReview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewLinkModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewLinkModel;
  }

  @override
  void update(void Function(ReviewLinkModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewLinkModel build() => _build();

  _$ReviewLinkModel _build() {
    _$ReviewLinkModel _$result;
    try {
      _$result = _$v ??
          new _$ReviewLinkModel._(
              id: id,
              brand: _brand?.build(),
              brandUrl: brandUrl,
              serviceCenterUrl: serviceCenterUrl,
              exhibitionInfoUrl: exhibitionInfoUrl,
              carReview: carReview);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'brand';
        _brand?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewLinkModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Brand extends Brand {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? icon;
  @override
  final bool? top;
  @override
  final int? countOfCars;

  factory _$Brand([void Function(BrandBuilder)? updates]) =>
      (new BrandBuilder()..update(updates))._build();

  _$Brand._({this.id, this.name, this.icon, this.top, this.countOfCars})
      : super._();

  @override
  Brand rebuild(void Function(BrandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandBuilder toBuilder() => new BrandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Brand &&
        id == other.id &&
        name == other.name &&
        icon == other.icon &&
        top == other.top &&
        countOfCars == other.countOfCars;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, top.hashCode);
    _$hash = $jc(_$hash, countOfCars.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Brand')
          ..add('id', id)
          ..add('name', name)
          ..add('icon', icon)
          ..add('top', top)
          ..add('countOfCars', countOfCars))
        .toString();
  }
}

class BrandBuilder implements Builder<Brand, BrandBuilder> {
  _$Brand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  bool? _top;
  bool? get top => _$this._top;
  set top(bool? top) => _$this._top = top;

  int? _countOfCars;
  int? get countOfCars => _$this._countOfCars;
  set countOfCars(int? countOfCars) => _$this._countOfCars = countOfCars;

  BrandBuilder();

  BrandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _icon = $v.icon;
      _top = $v.top;
      _countOfCars = $v.countOfCars;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Brand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Brand;
  }

  @override
  void update(void Function(BrandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Brand build() => _build();

  _$Brand _build() {
    final _$result = _$v ??
        new _$Brand._(
            id: id, name: name, icon: icon, top: top, countOfCars: countOfCars);
    replace(_$result);
    return _$result;
  }
}

class _$CommentModel extends CommentModel {
  @override
  final int? id;
  @override
  final double? rating;
  @override
  final String? comment;
  @override
  final String? postedAt;
  @override
  final int? carReview;

  factory _$CommentModel([void Function(CommentModelBuilder)? updates]) =>
      (new CommentModelBuilder()..update(updates))._build();

  _$CommentModel._(
      {this.id, this.rating, this.comment, this.postedAt, this.carReview})
      : super._();

  @override
  CommentModel rebuild(void Function(CommentModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentModelBuilder toBuilder() => new CommentModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentModel &&
        id == other.id &&
        rating == other.rating &&
        comment == other.comment &&
        postedAt == other.postedAt &&
        carReview == other.carReview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, carReview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommentModel')
          ..add('id', id)
          ..add('rating', rating)
          ..add('comment', comment)
          ..add('postedAt', postedAt)
          ..add('carReview', carReview))
        .toString();
  }
}

class CommentModelBuilder
    implements Builder<CommentModel, CommentModelBuilder> {
  _$CommentModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _postedAt;
  String? get postedAt => _$this._postedAt;
  set postedAt(String? postedAt) => _$this._postedAt = postedAt;

  int? _carReview;
  int? get carReview => _$this._carReview;
  set carReview(int? carReview) => _$this._carReview = carReview;

  CommentModelBuilder();

  CommentModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _rating = $v.rating;
      _comment = $v.comment;
      _postedAt = $v.postedAt;
      _carReview = $v.carReview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommentModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommentModel;
  }

  @override
  void update(void Function(CommentModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommentModel build() => _build();

  _$CommentModel _build() {
    final _$result = _$v ??
        new _$CommentModel._(
            id: id,
            rating: rating,
            comment: comment,
            postedAt: postedAt,
            carReview: carReview);
    replace(_$result);
    return _$result;
  }
}

class _$CommentsModel extends CommentsModel {
  @override
  final int? id;
  @override
  final Owner? owner;
  @override
  final double? rating;
  @override
  final String? comment;
  @override
  final String? postedAt;
  @override
  final int? carReview;

  factory _$CommentsModel([void Function(CommentsModelBuilder)? updates]) =>
      (new CommentsModelBuilder()..update(updates))._build();

  _$CommentsModel._(
      {this.id,
      this.owner,
      this.rating,
      this.comment,
      this.postedAt,
      this.carReview})
      : super._();

  @override
  CommentsModel rebuild(void Function(CommentsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentsModelBuilder toBuilder() => new CommentsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentsModel &&
        id == other.id &&
        owner == other.owner &&
        rating == other.rating &&
        comment == other.comment &&
        postedAt == other.postedAt &&
        carReview == other.carReview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, carReview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommentsModel')
          ..add('id', id)
          ..add('owner', owner)
          ..add('rating', rating)
          ..add('comment', comment)
          ..add('postedAt', postedAt)
          ..add('carReview', carReview))
        .toString();
  }
}

class CommentsModelBuilder
    implements Builder<CommentsModel, CommentsModelBuilder> {
  _$CommentsModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  OwnerBuilder? _owner;
  OwnerBuilder get owner => _$this._owner ??= new OwnerBuilder();
  set owner(OwnerBuilder? owner) => _$this._owner = owner;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _postedAt;
  String? get postedAt => _$this._postedAt;
  set postedAt(String? postedAt) => _$this._postedAt = postedAt;

  int? _carReview;
  int? get carReview => _$this._carReview;
  set carReview(int? carReview) => _$this._carReview = carReview;

  CommentsModelBuilder();

  CommentsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _owner = $v.owner?.toBuilder();
      _rating = $v.rating;
      _comment = $v.comment;
      _postedAt = $v.postedAt;
      _carReview = $v.carReview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommentsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommentsModel;
  }

  @override
  void update(void Function(CommentsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommentsModel build() => _build();

  _$CommentsModel _build() {
    _$CommentsModel _$result;
    try {
      _$result = _$v ??
          new _$CommentsModel._(
              id: id,
              owner: _owner?.build(),
              rating: rating,
              comment: comment,
              postedAt: postedAt,
              carReview: carReview);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'owner';
        _owner?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CommentsModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReviewFilterReq extends ReviewFilterReq {
  @override
  final int? mark;
  @override
  final int? model;
  @override
  final int? generation;
  @override
  final int? bodyType;
  @override
  final String? orderBy;

  factory _$ReviewFilterReq([void Function(ReviewFilterReqBuilder)? updates]) =>
      (new ReviewFilterReqBuilder()..update(updates))._build();

  _$ReviewFilterReq._(
      {this.mark, this.model, this.generation, this.bodyType, this.orderBy})
      : super._();

  @override
  ReviewFilterReq rebuild(void Function(ReviewFilterReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewFilterReqBuilder toBuilder() =>
      new ReviewFilterReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewFilterReq &&
        mark == other.mark &&
        model == other.model &&
        generation == other.generation &&
        bodyType == other.bodyType &&
        orderBy == other.orderBy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mark.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, bodyType.hashCode);
    _$hash = $jc(_$hash, orderBy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewFilterReq')
          ..add('mark', mark)
          ..add('model', model)
          ..add('generation', generation)
          ..add('bodyType', bodyType)
          ..add('orderBy', orderBy))
        .toString();
  }
}

class ReviewFilterReqBuilder
    implements Builder<ReviewFilterReq, ReviewFilterReqBuilder> {
  _$ReviewFilterReq? _$v;

  int? _mark;
  int? get mark => _$this._mark;
  set mark(int? mark) => _$this._mark = mark;

  int? _model;
  int? get model => _$this._model;
  set model(int? model) => _$this._model = model;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  int? _bodyType;
  int? get bodyType => _$this._bodyType;
  set bodyType(int? bodyType) => _$this._bodyType = bodyType;

  String? _orderBy;
  String? get orderBy => _$this._orderBy;
  set orderBy(String? orderBy) => _$this._orderBy = orderBy;

  ReviewFilterReqBuilder();

  ReviewFilterReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mark = $v.mark;
      _model = $v.model;
      _generation = $v.generation;
      _bodyType = $v.bodyType;
      _orderBy = $v.orderBy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewFilterReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewFilterReq;
  }

  @override
  void update(void Function(ReviewFilterReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewFilterReq build() => _build();

  _$ReviewFilterReq _build() {
    final _$result = _$v ??
        new _$ReviewFilterReq._(
            mark: mark,
            model: model,
            generation: generation,
            bodyType: bodyType,
            orderBy: orderBy);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

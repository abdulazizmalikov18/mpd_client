import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'services_model.g.dart';

abstract class ServicesRes implements Built<ServicesRes, ServicesResBuilder> {
  ServicesRes._();

  factory ServicesRes([Function(ServicesResBuilder b) updates]) = _$ServicesRes;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'description')
  String? get description;

  @BuiltValueField(wireName: 'count_of_cars')
  int? get countOfCars;

  static Serializer<ServicesRes> get serializer => _$servicesResSerializer;
}

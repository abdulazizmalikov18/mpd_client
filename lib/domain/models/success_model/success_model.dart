import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'success_model.g.dart';

abstract class SuccessModel
    implements Built<SuccessModel, SuccessModelBuilder> {
  SuccessModel._();

  factory SuccessModel([Function(SuccessModelBuilder b) updates]) =
      _$SuccessModel;

  @BuiltValueField(wireName: 'detail')
  String? get detail;

  static Serializer<SuccessModel> get serializer => _$successModelSerializer;
}

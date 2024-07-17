import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'filter_item_model.g.dart';

abstract class FilterItemModel
    implements Built<FilterItemModel, FilterItemModelBuilder> {
  FilterItemModel._();

  factory FilterItemModel([Function(FilterItemModelBuilder b) updates]) =
      _$FilterItemModel;

  @BuiltValueField(wireName: 'value')
  String? get value;
  @BuiltValueField(wireName: 'value_id')
  int? get valueId;

  static Serializer<FilterItemModel> get serializer =>
      _$filterItemModelSerializer;
}

import 'package:json_annotation/json_annotation.dart';
import 'package:mpd_client/features/home/data/models/specialist_order_model.dart';

part 'order_stream_model.g.dart';

@JsonSerializable()
class OrdersStreamModel {
  @JsonKey(name: "type")
  final String action;
  @JsonKey(name: "message")
  final SpecialistOrderModel message;

  const OrdersStreamModel({
    this.action = "",
    this.message = const SpecialistOrderModel(),
  });

  factory OrdersStreamModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersStreamModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersStreamModelToJson(this);
}

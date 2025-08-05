// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersStreamModel _$OrdersStreamModelFromJson(Map<String, dynamic> json) =>
    OrdersStreamModel(
      action: json['type'] as String? ?? "",
      message: json['message'] == null
          ? const SpecialistOrderModel()
          : SpecialistOrderModel.fromJson(
              json['message'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$OrdersStreamModelToJson(OrdersStreamModel instance) =>
    <String, dynamic>{'type': instance.action, 'message': instance.message};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Vehicle _$_$_VehicleFromJson(Map<String, dynamic> json) {
  return _$_Vehicle(
    id: json['id'] as String?,
    vehicleMake: json['vehicleMake'] as String,
    vehicleModel: json['vehicleModel'] as String,
    vehicleYear: json['vehicleYear'] as String,
    engineSize: json['engineSize'] as String,
    tireSpec: json['tireSpec'] as String,
    isBooked: json['isBooked'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_VehicleToJson(_$_Vehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleMake': instance.vehicleMake,
      'vehicleModel': instance.vehicleModel,
      'vehicleYear': instance.vehicleYear,
      'engineSize': instance.engineSize,
      'tireSpec': instance.tireSpec,
      'isBooked': instance.isBooked,
    };

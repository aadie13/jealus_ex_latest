// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Booking _$_$_BookingFromJson(Map<String, dynamic> json) {
  return _$_Booking(
    id: json['id'] as String?,
    serviceProvider:
        UserProfile.fromJson(json['serviceProvider'] as Map<String, dynamic>),
    startDate: DateTime.parse(json['startDate'] as String),
    startTimeHrs: json['startTimeHrs'] as int,
    startTimeMins: json['startTimeMins'] as int,
    service: Service.fromJson(json['service'] as Map<String, dynamic>),
    vehicles: (json['vehicles'] as List<dynamic>)
        .map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
        .toList(),
    isCompleted: json['isCompleted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_BookingToJson(_$_Booking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceProvider': instance.serviceProvider,
      'startDate': instance.startDate.toIso8601String(),
      'startTimeHrs': instance.startTimeHrs,
      'startTimeMins': instance.startTimeMins,
      'service': instance.service,
      'vehicles': instance.vehicles,
      'isCompleted': instance.isCompleted,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Booking _$_$_BookingFromJson(Map<String, dynamic> json) {
  return _$_Booking(
    id: json['id'] as String?,
    startDate: DateTime.parse(json['startDate'] as String),
    startTimeHrs: json['startTimeHrs'] as int,
    startTimeMins: json['startTimeMins'] as int,
    isCompleted: json['isCompleted'] as bool? ?? false,
    isAccepted: json['isAccepted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_BookingToJson(_$_Booking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'startTimeHrs': instance.startTimeHrs,
      'startTimeMins': instance.startTimeMins,
      'isCompleted': instance.isCompleted,
      'isAccepted': instance.isAccepted,
    };

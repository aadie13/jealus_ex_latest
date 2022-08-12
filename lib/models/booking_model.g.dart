// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Booking _$$_BookingFromJson(Map<String, dynamic> json) {
  final GeoFirePoint centerFromJson = GeoFirePoint(json['center']['geopoint'].latitude, json['center']['geopoint'].longitude);
  return _$_Booking(
    id: json['id'] as String?,
    userID: json['userID'] as String,
    mechanicID: json['mechanicID'] as String?,
    bidID: json['bidID'] as String?,
    startDate: DateTime.parse(json['startDate'] as String),
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    startTimeHrs: json['startTimeHrs'] as int,
    startTimeMins: json['startTimeMins'] as int,
    isCompleted: json['isCompleted'] as bool? ?? false,
    isAccepted: json['isAccepted'] as bool? ?? false,
    center: centerFromJson,
  );
}

Map<String, dynamic> _$$_BookingToJson(_$_Booking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'mechanicID': instance.mechanicID,
      'bidID': instance.bidID,
      'startDate': instance.startDate.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'startTimeHrs': instance.startTimeHrs,
      'startTimeMins': instance.startTimeMins,
      'isCompleted': instance.isCompleted,
      'isAccepted': instance.isAccepted,
      'center': instance.center.data,
    };

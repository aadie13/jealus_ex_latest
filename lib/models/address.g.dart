// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Adddress _$_$_AdddressFromJson(Map<String, dynamic> json) {
  return _$_Adddress(
    id: json['id'] as String?,
    placeFormattedAddress: json['placeFormattedAddress'] as String,
    placeName: json['placeName'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    addressType: json['addressType'] as String,
    isServiceLocation: json['isServiceLocation'] as bool? ?? false,
    isMainGarage: json['isMainGarage'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_AdddressToJson(_$_Adddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeFormattedAddress': instance.placeFormattedAddress,
      'placeName': instance.placeName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'addressType': instance.addressType,
      'isServiceLocation': instance.isServiceLocation,
      'isMainGarage': instance.isMainGarage,
    };

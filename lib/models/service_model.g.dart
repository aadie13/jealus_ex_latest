// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Service _$_$_ServiceFromJson(Map<String, dynamic> json) {
  return _$_Service(
    id: json['id'] as String?,
    serviceName: json['serviceName'] as String,
    typeSpecific: json['typeSpecific'] as String?,
    serviceCost: (json['serviceCost'] as num).toDouble(),
    serviceDurationMins: (json['serviceDurationMins'] as num).toDouble(),
    numberOfTires2Swap: json['numberOfTires2Swap'] as int?,
    numberofTires2Store: json['numberofTires2Store'] as int?,
    detailingPackage: json['detailingPackage'] as String?,
  );
}

Map<String, dynamic> _$_$_ServiceToJson(_$_Service instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'typeSpecific': instance.typeSpecific,
      'serviceCost': instance.serviceCost,
      'serviceDurationMins': instance.serviceDurationMins,
      'numberOfTires2Swap': instance.numberOfTires2Swap,
      'numberofTires2Store': instance.numberofTires2Store,
      'detailingPackage': instance.detailingPackage,
    };

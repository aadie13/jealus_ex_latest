// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bid _$_$_BidFromJson(Map<String, dynamic> json) {
  return _$_Bid(
    id: json['id'] as String?,
    bookingID: json['bookingID'] as String,
    mechanicID: json['mechanicID'] as String,
    bidAmount: (json['bidAmount'] as num).toDouble(),
    isAccepted: json['isAccepted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_BidToJson(_$_Bid instance) => <String, dynamic>{
      'id': instance.id,
      'bookingID': instance.bookingID,
      'mechanicID': instance.mechanicID,
      'bidAmount': instance.bidAmount,
      'isAccepted': instance.isAccepted,
    };

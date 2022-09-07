import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
//************************************************************//
part 'bid_model.g.dart';
part 'bid_model.freezed.dart';
//TODO: make each service into a separate class
@freezed
abstract class Bid implements _$Bid {
  const Bid._(); //private constructor put in to change with to implements.

  const factory Bid({
    String? id,
    required String bookingID,
    required String mechanicID,
    required double bidAmount,
    @Default(false) bool isAccepted,

  }) = _Bid;

  factory Bid.fromJson(Map<String, dynamic> data) =>
      _$BidFromJson(data);

  factory Bid.empty() => Bid(bookingID: '', mechanicID: '', bidAmount: 0.0);

  factory Bid.fromDocument(DocumentSnapshot doc){
    final data = doc.data()!;
    return Bid.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
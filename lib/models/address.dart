import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
//************************************************************//
part 'address.g.dart';
part 'address.freezed.dart';
//TODO: make each service into a separate class
@freezed
abstract class Adddress implements _$Adddress {
  const Adddress._(); //private constructor put in to change with to implements.

  const factory Adddress({
    String? id,
    required String placeFormattedAddress,
    required String placeName,
    required double latitude,
    required double longitude,
    required String addressType,
    @Default(false) bool isServiceLocation,
    @Default(false) bool isMainGarage,

  }) = _Adddress;

  factory Adddress.fromJson(Map<String, dynamic> data) =>
      _$AdddressFromJson(data);

  factory Adddress.empty() => Adddress(placeFormattedAddress: '', placeName: '', latitude: 0.0, longitude: 0.0, addressType: '');

  factory Adddress.fromDocument(DocumentSnapshot doc){
    final data = doc.data()!;
    return Adddress.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
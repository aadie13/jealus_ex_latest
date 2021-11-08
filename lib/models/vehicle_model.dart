import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_model.g.dart';
part 'vehicle_model.freezed.dart';


@freezed

abstract class Vehicle with _$Vehicle {
  const Vehicle._(); //private constructor put in to change with to implements.

  const factory Vehicle({
    String? id,
    required String vehicleMake,
    required String vehicleModel,
    required String vehicleYear,
    required String engineSize,
    required String tireSpec,
    @Default(false) bool isBooked,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> data) =>
      _$VehicleFromJson(data);

  factory Vehicle.fromDocument(DocumentSnapshot doc){
    final data = doc.data()!;
    return Vehicle.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

}
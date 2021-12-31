import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';
import 'service_model.dart';
import 'vehicle_model.dart';

//************************************************************//
part 'booking_model.g.dart';
part 'booking_model.freezed.dart';
//TODO: make each service into a separate class
@freezed
abstract class Booking implements _$Booking {
  const Booking._(); //private constructor put in to change with to implements.

  const factory Booking({
    String? id, //should be the user id of the customer
    //required UserProfile serviceProvider, //should be the mechanic user
    //TODO: add service provider to the booking
    required DateTime startDate,
    required int startTimeHrs,
    required int startTimeMins,
    //required Service service,//TODO: NOTE - this app allows one service per booking
    //TODO: add service to the booking
    //required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
    @Default(false) bool isCompleted, //is the job done? If so what are the reviews? TODO: add review setup in the app
    @Default(false) bool isAccepted, //has 
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> data) =>_$BookingFromJson(data);

  factory Booking.fromDocument(DocumentSnapshot doc){
    final data = doc.data()!;
    return Booking.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

}
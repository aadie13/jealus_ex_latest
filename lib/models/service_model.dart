import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
//************************************************************//
part 'service_model.g.dart';
part 'service_model.freezed.dart';
//TODO: make each service into a separate class
@freezed
abstract class Service implements _$Service {
  const Service._(); //private constructor put in to change with to implements.

  const factory Service({
    String? id,
    required String serviceName,
    String? typeSpecific, //TODO: this is specifically made for oil change {Synthetic, Regular or BYOO. Change it such that it is a ist with the string values which itself will have cost, properties etc
    required double serviceCost,
    required double serviceDurationMins,
    //To be used for Tire swapping
    // TODO bad practise below. Create Oil CHANGE, TireSwap, etc as separate class so each class can have a particular field like shown below.
    int? numberOfTires2Swap,
    int? numberofTires2Store,
    String? detailingPackage,
    @Default(false) bool isCurrent,

  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> data) =>
      _$ServiceFromJson(data);

  factory Service.fromDocument(DocumentSnapshot doc){
    final data = doc.data()!;
    return Service.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

}

List<Service> servicesList = [
  //TODO make the cost and duration a variable that changes from the input of the mechanics
  //And is average of the input from mechanics
  Service(serviceName: "Oil Change", serviceCost: 200, serviceDurationMins: 60),
  Service(serviceName: "Tire Change", serviceCost: 80, serviceDurationMins: 60),
  Service(serviceName: "Detailing", serviceCost: 100, serviceDurationMins: 180),
  Service(serviceName: "Inspection", serviceCost: 50, serviceDurationMins: 60),
  Service(serviceName: "Battery", serviceCost: 140, serviceDurationMins: 30),

];

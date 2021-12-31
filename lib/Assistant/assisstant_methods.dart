//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:jealus_ex/Assistant/request_assistant.dart';
// import 'package:jealus_ex/models/address.dart';
// import 'package:jealus_ex/models/address.dart';
//
// import '../configMaps.dart';
//
// class AssistantMethods{
//   static Future<String> searchCoordinateAddress(Position position, context) async{
//     String placeAddress = "";
//     String st1,st2,st3,st4;
//     String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
//
//     var response = await RequestAssistant.getRequest(url);
//
//     if(response != "failed"){
//       //placeAddress = response["results"][0]["formatted_adress"];
//       st1 = response["results"][0]["address_components"][0]["long_name"];
//       st2 = response["results"][0]["address_components"][1]["long_name"];
//       st3 = response["results"][0]["address_components"][5]["long_name"];
//       st4 = response["results"][0]["address_components"][6]["long_name"];
//       placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;
//       Adddress userPickUpAddress = new Adddress(placeFormattedAddress: placeAddress, placeName: 'Current Location', latitude: position.latitude, longitude: position.longitude, addressType: 'N/A');
//
//
//       //Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
//
//     }
//     return placeAddress;
//   }
// }
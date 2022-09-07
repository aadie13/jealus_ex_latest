//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/controllers/main_service_controller.dart';
import 'package:jealus_ex/controllers/user_bookings_service_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/address_repository.dart';
import 'package:jealus_ex/Archive/vehicle_repository_archive.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';

import '../models/address.dart';

abstract class BaseBookingRepository {
  Future<List<Booking>> retrieveBookings({required String userId});
  Future<String> createBooking(
      {required String userId, required Booking booking, required Service service});
  //Future<void> confirmVehicles({required String userId, required String bookingID});//, required List<Vehicle> vehicles});
  Future<void> updateBooking(
      {required String userId, required Booking booking});
  Future<void> deleteBooking(
      {required String userId, required String bookingId});
}

final bookingsRepositoryProvider =
    Provider<BookingRepository>((ref) => BookingRepository(ref.read));

class BookingRepository implements BaseBookingRepository {
  final Reader _read;
  const BookingRepository(this._read);

  @override
  Future<String> createBooking({required String userId, required Booking booking, required Service service}) async{
    // TODO: implement createBooking
    try{

      //Add this booking to the user "Bookings" collection
      final docRef = await _read(firebaseFirestoreProvider)
          .userBookingsRef(userId)
          .add(booking.toDocument());

      //get the selected vehicles list
      final selectedVehiclesList = await _read(
          selectedVehicleListProvider); //get the list of isBooked==true vehicles
      //add alll the selected vehicles to this booking (docRef.id)
      for (int i = 0; i< selectedVehiclesList.length; i++) {
        Vehicle vehicle = Vehicle(nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
        await _read(vehicleRepositoryProvider).addVehicleToABookingInUsersBookingsCollection(bookingID: docRef.id, vehicle: vehicle, userId: userId);
      }
      //Change the isBooked status of all vehicles in this users profile
      for (int i = 0; i< selectedVehiclesList.length; i++) {
        Vehicle vehicle = Vehicle(id: selectedVehiclesList[i].id!, nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
        await _read(vehicleControllerProvider).updateVehicle(updatedVehicle: vehicle);
      }

      //get the selected address list
      final selectedAddressList = await _read(
          selectedAddressListProvider); //get the list of isServiceLocation==true address
      //add alll the selected vehicles to this booking (docRef.id)
      for (int i = 0; i< selectedAddressList.length; i++) {
        Adddress address = Adddress(placeFormattedAddress: selectedAddressList[i].placeFormattedAddress, placeName: selectedAddressList[i].placeName, latitude: selectedAddressList[i].latitude, longitude: selectedAddressList[i].longitude, addressType: selectedAddressList[i].addressType);//Adddress(nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
        await _read(addressRepositoryProvider).addAddressToABookingInUsersBookingsCollection(bookingID: docRef.id, address: address, userId: userId);//.addVehicleToABookingInUsersBookingsCollection(bookingID: docRef.id, vehicle: vehicle, userId: userId);
      }
      //Change the isServiceLocation to false status of all address in this users profile
      for (int i = 0; i< selectedAddressList.length; i++) {
        Adddress address = Adddress(id: selectedAddressList[i].id, placeFormattedAddress: selectedAddressList[i].placeFormattedAddress, placeName: selectedAddressList[i].placeName, latitude: selectedAddressList[i].latitude, longitude: selectedAddressList[i].longitude, addressType: selectedAddressList[i].addressType);//Adddress(nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
        //await _read(addressControllerProvider)..addAddressToABookingInUsersBookingsCollection(bookingID: docRef.id, address: address, userId: userId);//.addVehicleToABookingInUsersBookingsCollection(bookingID: docRef.id, vehicle: vehicle, userId: userId);
      }

      return docRef.id;


    }on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
  // @override
  // Future<String> createBooking2(
  //     {required String userId, required Booking booking, required Service service}) async {
  //   try {
  //     //add the booking to the users "Bookings" collection
  //     final docRef = await _read(firebaseFirestoreProvider)
  //         .userBookingsRef(userId)
  //         .add(booking.toDocument());
  //     final VRef = await _read(firebaseFirestoreProvider).userBookedVehiclesRef(
  //         userId,
  //         docRef.id); //get inside the current booking to add the vehicles into
  //     final selectedVehiclesList = await _read(
  //         selectedVehicleListProvider); //get the list of isBooked==true vehicles
  //     final vehiclesControllerRef = await _read(vehicleControllerProvider);
  //     for (int i = 0; i < selectedVehiclesList.length; i++) {
  //       VRef.add(selectedVehiclesList[i].toDocument()).then((value) => {
  //         //after copying the selected vehicle to the booking document make sure to make isBooked == false
  //             vehiclesControllerRef.updateVehicle(
  //               updatedVehicle: selectedVehiclesList[i].copyWith(
  //                 isBooked: !selectedVehiclesList[i].isBooked,
  //               ),
  //             ),
  //           });
  //     }
  //     final ARef = await _read(firebaseFirestoreProvider).userBookedAddressRef(
  //         userId,
  //         docRef.id); //get inside the current booking to add the Adress into
  //     final addressControllerRef = await _read(addressControllerProvider);
  //     final selectedAddressList = await _read(selectedAddressListProvider);
  //     for (int i = 0; i < selectedAddressList.length; i++) {
  //       ARef.add(selectedAddressList[i].toDocument()).then((value) => {
  //         addressControllerRef.updateAddress(updatedAddress: selectedAddressList[i].copyWith(isServiceLocation: !selectedAddressList[i].isServiceLocation,)),
  //       });
  //     }
  //     return docRef.id;
  //   } on FirebaseException catch (e) {
  //     throw CustomException(message: e.message);
  //   }
  // }

  @override
  Future<void> updateBooking(
      {required String userId, required Booking booking}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userBookingsRef(userId)
          .doc(booking.id)
          .update(booking.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteBooking(
      {required String userId, required String bookingId}) async {
    try {
      await _read(firebaseFirestoreProvider).userBookingsRef(userId).doc(bookingId).collection('Vehicles').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await _read(firebaseFirestoreProvider).userBookingsRef(userId).doc(bookingId).collection('Service').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await _read(firebaseFirestoreProvider).userBookingsRef(userId).doc(bookingId).collection('Address').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await _read(firebaseFirestoreProvider)
          .userBookingsRef(userId)
          .doc(bookingId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Booking>> retrieveBookings({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).userBookingsRef(userId).get();
      return snap.docs.map((doc) => Booking.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }


}

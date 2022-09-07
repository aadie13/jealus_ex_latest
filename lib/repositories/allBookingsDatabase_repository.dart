import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import 'package:jealus_ex/Archive/vehicle_repository_archive.dart';
import '../controllers/user_bookings_service_controller.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import '../models/address.dart';
import '../models/service_model.dart';
import '../models/vehicle_model.dart';
import 'address_repository.dart';

abstract class BaseAllBookingsDatabaseRepository {
  Future<List<Booking>> retrieveBookings();
  Future<List<Booking>> retrieveUsersBookings(String userID);
  Future<String> createBooking(
      {required Booking booking, required Service service});
  //Future<void> confirmVehicles({required String userId, required String bookingID});//, required List<Vehicle> vehicles});
  Future<void> updateBooking(
      {required Booking booking});
  Future<void> deleteBooking(
      {required String bookingId});
}

final allBookingsDatabaseRepositoryProvider =
Provider<AllBookingsDatabaseRepository>((ref) => AllBookingsDatabaseRepository(ref.read));

class AllBookingsDatabaseRepository implements BaseAllBookingsDatabaseRepository {
  final Reader _read;
  const AllBookingsDatabaseRepository(this._read);

  @override
  Future<List<Booking>> retrieveBookings() async {
    try {
      final snap =
      await _read(firebaseFirestoreProvider).collection('AllBookingsDatabase').get();
      return snap.docs.map((doc) => Booking.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Booking>> retrieveUsersBookings(String userID) async {
    try {
      final snap =
      await _read(firebaseFirestoreProvider).collection('AllBookingsDatabase').where('userID', isEqualTo: userID).where('isCompleted', isEqualTo: false).get();
      return snap.docs.map((doc) => Booking.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createBooking(
      {required Booking booking, required Service service}) async {
    //final geo = Geoflutterfire();
    try {
      //add the booking document to all bookingsdatabase
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('AllBookingsDatabase').add(booking.toDocument());
        //add all the selected vehicles to the booking that is just created
        //get the selected vehicles list
        final selectedVehiclesList = await _read(
            selectedVehicleListProvider); //get the list of isBooked==true vehicles
        //add all the selected vehicles to this booking (docRef.id) in allBookingsDatabase
        for (int i = 0; i< selectedVehiclesList.length; i++) {
          Vehicle vehicle = Vehicle(nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
          await _read(vehicleRepositoryProvider).addVehicleToABookingInAllBookingsDatabase(bookingId: docRef.id, vehicle: vehicle);
        }
        //Change the isBooked status of all vehicles in this users profile
        for (int i = 0; i< selectedVehiclesList.length; i++) {
          Vehicle vehicle = Vehicle(id: selectedVehiclesList[i].id!, nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
          await _read(vehicleControllerProvider).updateVehicle(updatedVehicle: vehicle);
        }

        //add the address document to this booking in allbookingsdatabase
        //first get the address that is selected as isServiceAddress
        final selectedAddressList = await _read(
            selectedAddressListProvider); //get the list of isServiceLocation==true address
        //add all the selected vehicles to this booking (docRef.id)
        for (int i = 0; i< selectedAddressList.length; i++) {
          Adddress address = Adddress(placeFormattedAddress: selectedAddressList[i].placeFormattedAddress, placeName: selectedAddressList[i].placeName, latitude: selectedAddressList[i].latitude, longitude: selectedAddressList[i].longitude, addressType: selectedAddressList[i].addressType);//Adddress(nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
          await _read(addressRepositoryProvider).addAddressToABookingInAllBookingsDatabase(bookingId: docRef.id, address: address);//.addAddressToABookingInUsersBookingsCollection(bookingID: docRef.id, address: address, userId: userId);//.addVehicleToABookingInUsersBookingsCollection(bookingID: docRef.id, vehicle: vehicle, userId: userId);
        }
        //Change the isServiceLocation to false status of all address in this users profile
        for (int i = 0; i< selectedAddressList.length; i++) {
          Adddress address = Adddress(id: selectedAddressList[i].id, placeFormattedAddress: selectedAddressList[i].placeFormattedAddress, placeName: selectedAddressList[i].placeName, latitude: selectedAddressList[i].latitude, longitude: selectedAddressList[i].longitude, addressType: selectedAddressList[i].addressType);//Adddress(nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake, vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear, engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec);
          await _read(addressControllerProvider).updateAddress(updatedAddress: address);//.addAddressToABookingInUsersBookingsCollection(bookingID: docRef.id, address: address, userId: userId);//.addVehicleToABookingInUsersBookingsCollection(bookingID: docRef.id, vehicle: vehicle, userId: userId);
        }

        //add the service document to this booking in allbookingsdatabase
        await _read(usersBookingServiceControllerProvider).addServicetoABookingInAllBookingsDatabase(service: service, bookingID: docRef.id);
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateBooking(
      {required Booking booking}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('AllBookingsDatabase')
          .doc(booking.id)
          .update(booking.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteBooking(
      {required String bookingId}) async {
    try {
      await _read(firebaseFirestoreProvider).allBookingsDatabaseVehiclesRef(bookingId).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await _read(firebaseFirestoreProvider).allBookingsDatabaseServiceRef(bookingId).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await _read(firebaseFirestoreProvider).allBookingsDatabaseAddressRef(bookingId).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await _read(firebaseFirestoreProvider)
          .collection('AllBookingsDatabase')
          .doc(bookingId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }




}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../controllers/user_bookings_service_controller.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import '../models/service_model.dart';

abstract class BaseAllBookingsDatabaseRepository {
  Future<List<Booking>> retrieveBookings();
  Future<List<Booking>> retrieveUsersBookings(String userID);
  Future<void> createBooking(
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
  Future<void> createBooking(
      {required Booking booking, required Service service}) async {
    final geo = Geoflutterfire();
    try {
      //add the booking document
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('AllBookingsDatabase').add(booking.toDocument());

      //add vehicle to this booking
      //final VRef = await _read(firebaseFirestoreProvider).allBookingsDatabaseVehiclesRef(docRef.id);
      final selectedVehiclesList = await _read(
          selectedVehicleListProvider); //get the list of isBooked==true vehicles
      final vehiclesControllerRef = await _read(vehicleControllerProvider);
      for (int i = 0; i < selectedVehiclesList.length; i++) {
        vehiclesControllerRef.addVehicleToABookingInAllBookingsDatabase(
            nickName: selectedVehiclesList[i].nickName, vehicleMake: selectedVehiclesList[i].vehicleMake,
            vehicleModel: selectedVehiclesList[i].vehicleModel, vehicleYear: selectedVehiclesList[i].vehicleYear,
            engineSize: selectedVehiclesList[i].engineSize, tireSpec: selectedVehiclesList[i].tireSpec, bookingID: docRef.id).then((value) => {
          //after copying the selected vehicle to the booking document make sure to make isBooked == false
          vehiclesControllerRef.updateVehicle(
            updatedVehicle: selectedVehiclesList[i].copyWith(
              isBooked: !selectedVehiclesList[i].isBooked,
            ),
          ),
        });
        // VRef.add(selectedVehiclesList[i].toDocument()).then((value) => {
        //   //after copying the selected vehicle to the booking document make sure to make isBooked == false
        //   vehiclesControllerRef.updateVehicle(
        //     updatedVehicle: selectedVehiclesList[i].copyWith(
        //       isBooked: !selectedVehiclesList[i].isBooked,
        //     ),
        //   ),
        // });
      }

      //add address to this booking
      final ARef = await _read(firebaseFirestoreProvider).allBookingsDatabaseAddressRef(
          docRef.id); //get inside the current booking to add the Adress into
      final addressControllerRef = await _read(addressControllerProvider);
      final selectedAddressList = await _read(selectedAddressListProvider);
      for (int i = 0; i < selectedAddressList.length; i++) {
        GeoFirePoint bookingLocation = geo.point(latitude: selectedAddressList[i].latitude, longitude: selectedAddressList[i].longitude);
        addressControllerRef.addAddressToABookingInAllBookingsDatabase(
            placeFormattedAddress: selectedAddressList[i].placeFormattedAddress,
            placeName: selectedAddressList[i].placeName, latitude: selectedAddressList[i].latitude,
            longitude: selectedAddressList[i].longitude, addressType: selectedAddressList[i].addressType,
            bookingID: docRef.id).then((value) => {
          addressControllerRef.updateAddress(updatedAddress: selectedAddressList[i].copyWith(isServiceLocation: !selectedAddressList[i].isServiceLocation,)),
          ARef.add({'location': bookingLocation.data}),
        });
        // ARef.add(selectedAddressList[i].toDocument()).then((value) => {
        //   ARef.add({'location': bookingLocation.data}),
        //   addressControllerRef.updateAddress(updatedAddress: selectedAddressList[i].copyWith(isServiceLocation: !selectedAddressList[i].isServiceLocation,)),
        // });
      }

      //add service to this booking
      await _read(usersBookingServiceControllerProvider).addServicetoABookingInAllBookingsDatabase(service: service, bookingID: docRef.id);
      //     .then((value) async =>
      // {
      //   //GeoFirePoint bookingsLocation = geo.point(latitude: booking., longitude: booking.longitude)
      //   await _read(firebaseFirestoreProvider)
      //     .collection('AllBookingsDatabase').doc(bookingID).collection('position')
      // });
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
          await _read(firebaseFirestoreProvider).collection('AllBookingsDatabase').where('userID', isEqualTo: userID).get();
      return snap.docs.map((doc) => Booking.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

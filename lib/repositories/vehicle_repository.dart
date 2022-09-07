import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/models/vehicle_model.dart';

abstract class BaseVehicleRepository {
  //retrieving vehicles
  Future<List<Vehicle>> retrieveUsersVehicles({required String userID});
  Future<List<Vehicle>> retrieveVehiclesFromUsersBooking(
      {required String userID, required String bookingID});
  Future<List<Vehicle>> retrieveVehiclesFromBookingInAllBookingsDatabase(
      {required String bookingID});

  //adding vehicles
  Future<String> createUsersVehicle(
      {required String userID, required Vehicle vehicle});
  Future<String> addVehicleToABookingInAllBookingsDatabase(
      {required String bookingID, required Vehicle vehicle});
  Future<String> addVehicleToABookingInUsersBookingsCollection(
      {required String bookingID,
      required Vehicle vehicle,
      required String userID});

  //update and delete only from users profile. Vehicles cannot be modified in a
  // booking. If need be the user will need to cancel this booking and create
  // another booking from scratch
  Future<void> updateVehicle(
      {required String userID, required Vehicle vehicle});
  Future<void> deleteVehicle(
      {required String userID, required String vehicleID});
}

final vehicleRepositoryProvider =
    Provider<VehicleRepository>((ref) => VehicleRepository(ref.read));

class VehicleRepository implements BaseVehicleRepository {
  final Reader _read;
  const VehicleRepository(this._read);

  @override
  Future<List<Vehicle>> retrieveUsersVehicles({required String userID}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).userVehicleRef(userID).get();
      return snap.docs.map((doc) => Vehicle.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Vehicle>> retrieveVehiclesFromUsersBooking(
      {required String userID, required String bookingID}) async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .userBookingRefToAddVehicles(userID, bookingID)
          .get();
      return snap.docs.map((doc) => Vehicle.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Vehicle>> retrieveVehiclesFromBookingInAllBookingsDatabase(
      {required String bookingID}) async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .allBookingsDatabaseVehiclesRef(bookingID)
          .get();
      return snap.docs.map((doc) => Vehicle.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createUsersVehicle(
      {required String userID, required Vehicle vehicle}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userVehicleRef(userID)
          .add(vehicle.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> addVehicleToABookingInAllBookingsDatabase(
      {required String bookingID, required Vehicle vehicle}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .allBookingsDatabaseVehiclesRef(bookingID)
          .add(vehicle.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> addVehicleToABookingInUsersBookingsCollection(
      {required String bookingID,
      required Vehicle vehicle,
      required String userID}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userBookingRefToAddVehicles(userID, bookingID)
          .add(vehicle.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateVehicle(
      {required String userID, required Vehicle vehicle}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userVehicleRef(userID)
          .doc(vehicle.id)
          .update(vehicle.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteVehicle(
      {required String userID, required String vehicleID}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userVehicleRef(userID)
          .doc(vehicleID)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

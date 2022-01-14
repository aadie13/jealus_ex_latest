import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';

abstract class BaseAllBookingsDatabaseRepository {
  Future<List<Booking>> retrieveBookings();
  Future<void> createBooking(
      {required Booking booking, required String bookingID});
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
      {required Booking booking, required String bookingID}) async {
    try {
      //add the booking to the users "Bookings" collection
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('AllBookingsDatabase').doc(bookingID).set(booking.toDocument());
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
}

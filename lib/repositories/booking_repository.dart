import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';
import 'package:jealus_ex/models/booking_model.dart';


abstract class BaseBookingRepository {

  Future<List<Booking>> retrieveBookings({required String userId});
  Future<String> createBooking({required String userId, required Booking booking});
  Future<void> updateBooking({required String userId, required Booking booking});
  Future<void> deleteBooking({required String userId, required String bookingId});



}

final bookingsRepositoryProvider =
Provider<BookingRepository>((ref) => BookingRepository(ref.read));

class BookingRepository implements BaseBookingRepository{
  final Reader _read;
  const BookingRepository(this._read);

  @override
  Future<String> createBooking ({required String userId, required Booking booking}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userBookingsRef(userId).add(booking.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateBooking({required String userId, required Booking booking}) async{
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
  Future<void> deleteBooking({required String userId, required String bookingId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userBookingsRef(userId)
          .doc(bookingId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Booking>> retrieveBookings({required String userId}) async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .userBookingsRef(userId)
          .get();
      return snap.docs.map((doc) => Booking.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }




}





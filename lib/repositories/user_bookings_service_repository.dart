import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import 'package:jealus_ex/models/service_model.dart';
import '../custom_exception.dart';
import '../general_providers.dart';

abstract class BaseUsersBookingServiceRepository {
  Future<List<Service>> retrieveServices({required String userID, required String bookingID});
  Future<String> createService({required String userID, required String bookingID, required Service service});
  Future<String> addServicetoBookingInAllBookingsDatabase({required String bookingID, required Service service});
  Future<void> updateService({required String userID,  required String bookingID, required Service service});
  Future<void> deleteService({required String userID, required String bookingID, required String serviceID, });
}

final usersBookingServiceRepositoryProvider =
Provider<UsersBookingServiceRepository>((ref) => UsersBookingServiceRepository(ref.read));

class UsersBookingServiceRepository implements BaseUsersBookingServiceRepository{
  final Reader _read;
  const UsersBookingServiceRepository(this._read);

  @override
  Future<List<Service>> retrieveServices({required String userID, required String bookingID}) async{
    //retrieveService added to a booking of the user
    try {
      final snap =
          await _read(firebaseFirestoreProvider).userBookingsServiceRef(userID, bookingID).get();
      return snap.docs.map((doc) => Service.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createService({required String userID, required String bookingID, required Service service}) async{
    // add service to a booking
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userBookingsServiceRef(userID,bookingID)
          .add(service.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
  @override
  Future<String> addServicetoBookingInAllBookingsDatabase({required String bookingID, required Service service}) async{
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .allBookingsDatabaseServiceRef(bookingID)
          .add(service.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateService({required String userID,  required String bookingID, required Service service}) async{
    //update an existing service in a booking
    try {
      await _read(firebaseFirestoreProvider)
          .userBookingsServiceRef(userID,bookingID)
          .doc(service.id)
          .update(service.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteService({required String userID, required String bookingID, required String serviceID}) async{
    // delete a service from an existing booking
    try {
      await _read(firebaseFirestoreProvider)
          .userBookingsServiceRef(userID,bookingID)
          .doc(serviceID)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

}



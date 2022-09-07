import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/address.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';
import '../models/booking_model.dart';



abstract class BaseAddressRepository {
  //retrieve address from firestore
  Future<List<Adddress>> retrieveUsersAddresses({required String userID});
  Future<Adddress> retrieveAddressFromUsersBooking(
      {required String userID, required String bookingID});
  Future<Adddress> retrieveAddressFromBookingInAllBookingsDatabase(
      {required String bookingID});
  //create addresses
  Future<String> createAddress({required String userId, required Adddress address});
  Future<String> addAddressToABookingInAllBookingsDatabase({required String bookingId, required Adddress address});
  Future<String> addAddressToABookingInUsersBookingsCollection({required String bookingID, required Adddress address, required String userId});

  //update and delete only from users profile. Addresses cannot be modified in a
  // booking. If need be the user will need to cancel this booking and create
  // another booking from scratch
  Future<void> updateAddress({required String userId, required Adddress address});
  Future<void> deleteAddress({required String userId, required String addressId});

}

final addressRepositoryProvider =
Provider<AddressRepository>((ref) => AddressRepository(ref.read));

class AddressRepository implements BaseAddressRepository{
  final Reader _read;
  const AddressRepository(this._read);

  @override
  Future<List<Adddress>> retrieveUsersAddresses({required String userID}) async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .userAddressRef(userID)
          .get();
      return snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Adddress> retrieveAddressFromUsersBooking(
      {required String userID, required String bookingID}) async {
    try{
      final snap = await _read(firebaseFirestoreProvider).userBookingRefToAddAddress(userID, bookingID).get();
      return snap.docs.map((doc) => Adddress.fromDocument(doc)).toList().first;
    }on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Adddress> retrieveAddressFromBookingInAllBookingsDatabase(
      {required String bookingID}) async {
    try{
      final snap = await _read(firebaseFirestoreProvider).allBookingsDatabaseAddressRef(bookingID).get();
      return snap.docs.map((doc) => Adddress.fromDocument(doc)).toList().first;
    }on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createAddress ({required String userId, required Adddress address}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userAddressRef(userId).add(address.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> addAddressToABookingInAllBookingsDatabase({required String bookingId, required Adddress address}) async{
    try {
      final geo = Geoflutterfire();
      final docRef = await _read(firebaseFirestoreProvider)
          .allBookingsDatabaseAddressRef(bookingId).add(address.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> addAddressToABookingInUsersBookingsCollection({required String bookingID, required Adddress address, required String userId}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider).userBookingRefToAddAddress(userId, bookingID).add(address.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }



  @override
  Future<void> updateAddress({required String userId, required Adddress address}) async{
    try {
      await _read(firebaseFirestoreProvider)
          .userAddressRef(userId)
          .doc(address.id)
          .update(address.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
  @override
  Future<void> deleteAddress({required String userId, required String addressId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userAddressRef(userId)
          .doc(addressId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }


//commmment below are the functions needed for the mechanics app not for the users
//   @override
//   Future<Adddress> retrieveServiceAddress({required String userId}) async{
//     try {
//       final snap = await _read(firebaseFirestoreProvider)
//           .mechanicsAddressRef(userId)
//           .get();
//       List<Adddress> theList = snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
//       return theList.firstWhere((element) => element.isServiceLocation);
//       //return snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
//     } on FirebaseException catch (e) {
//       throw CustomException(message: e.message);
//     }
//   }
//
//   @override
//   Future<double> retrieveServiceAddressLattitude({required String userId}) async{
//     try {
//       final snap = await _read(firebaseFirestoreProvider)
//           .mechanicsAddressRef(userId)
//           .get();
//       List<Adddress> theList = [];
//       final somelist = await snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
//       theList.addAll(somelist);
//       final radius = await somelist.firstWhere((element) => element.isMainGarage).latitude;
//       return radius;
//       //return snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
//     } on FirebaseException catch (e) {
//       throw CustomException(message: e.message);
//     }
//   }
//
//   @override
//   Future<double> retrieveServiceAddressLongitude({required String userId}) async{
//     try {
//       final snap = await _read(firebaseFirestoreProvider)
//           .mechanicsAddressRef(userId)
//           .get();
//       List<Adddress> theList = [];
//       final somelist = await snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
//       theList.addAll(somelist);
//       final radius = await somelist.firstWhere((element) => element.isMainGarage).longitude;
//       return radius;
//       //return snap.docs.map((doc) => Adddress.fromDocument(doc)).toList();
//     } on FirebaseException catch (e) {
//       throw CustomException(message: e.message);
//     }
//   }

//comment

}





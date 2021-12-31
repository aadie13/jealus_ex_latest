import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference userBookingsRef(String userId) =>
      collection('Users').doc(userId).collection('Bookings');

  CollectionReference userBookedVehiclesRef(String userId, String bookingID) =>
      collection('Users').doc(userId).collection('Bookings').doc(bookingID).collection('Vehicles');

  CollectionReference userBookedAddressRef(String userId, String bookingID) =>
      collection('Users').doc(userId).collection('Bookings').doc(bookingID).collection('Address');

  CollectionReference userVehicleRef(String userId) =>
      collection('Users').doc(userId).collection('Vehicles');

  CollectionReference userAddressRef(String userId) =>
      collection('Users').doc(userId).collection('Addresses');


}
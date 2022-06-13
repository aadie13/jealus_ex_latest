import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {

  //reference to allBookingsDatabse start
  CollectionReference allBookingsDatabaseAddressRef(String bookingId) =>
      collection('AllBookingsDatabase').doc(bookingId).collection('Address');

  CollectionReference allBookingsDatabaseServiceRef(String bookingId) =>
      collection('AllBookingsDatabase').doc(bookingId).collection('Service');

  CollectionReference allBookingsDatabaseVehiclesRef(String bookingID) =>
      collection('AllBookingsDatabase').doc(bookingID).collection('Vehicles');

  CollectionReference allBookingsDatabaseBookingLocationRef(String bookingId, ) =>
      collection('AllBookingsDatabase').doc(bookingId).collection('Address');

  //reference to allBookingsDatabase end

  CollectionReference userBookingsRef(String userId) =>
      collection('Users').doc(userId).collection('Bookings');

  CollectionReference userBookedVehiclesRef(String userId, String bookingID) =>
      collection('Users').doc(userId).collection('Bookings').doc(bookingID).collection('Vehicles');

  CollectionReference userBookingsServiceRef(String userId, String bookingID) =>
      collection('Users').doc(userId).collection('Bookings').doc(bookingID).collection('Service');

  CollectionReference userBookedAddressRef(String userId, String bookingID) =>
      collection('Users').doc(userId).collection('Bookings').doc(bookingID).collection('Address');

  CollectionReference userVehicleRef(String userId) =>
      collection('Users').doc(userId).collection('Vehicles');

  CollectionReference userAddressRef(String userId) =>
      collection('Users').doc(userId).collection('Addresses');


}
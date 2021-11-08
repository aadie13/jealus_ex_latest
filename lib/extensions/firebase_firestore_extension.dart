import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference userBookingsRef(String userId) =>
      collection('Users').doc(userId).collection('Bookings');

  CollectionReference userVehicleRef(String userId) =>
      collection('Users').doc(userId).collection('Vehicles');


}
import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference userListRef(String userId) =>
      collection('Users').doc(userId).collection('UserProfile');


}
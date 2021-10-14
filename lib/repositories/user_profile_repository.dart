import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';

abstract class BaseUserProfileRepository {

  Future<List<UserProfile>> retrieveUsers();
  Future<String> createUser({required String userId, required UserProfile user});
  Future<void> updateUser({required UserProfile user});
  Future<void> deleteUser({required String userId});

}

final usersRepositoryProvider =
Provider<UserProfileRepository>((ref) => UserProfileRepository(ref.read));

class UserProfileRepository implements BaseUserProfileRepository{
  final Reader _read;
  const UserProfileRepository(this._read);

  @override
  Future<String> createUser ({required String userId ,required UserProfile user}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('Users').doc(userId)
          .set(user.toDocument());
      return userId;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateUser({required UserProfile user}) async{
    try {
      await _read(firebaseFirestoreProvider)
          .collection('Users')
          .doc(user.id)
          .update(user.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
  @override
  Future<void> deleteUser({required String userId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('Users')
          .doc(userId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<UserProfile>> retrieveUsers() async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('Users')
          .get();
      return snap.docs.map((doc) => UserProfile.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }




}





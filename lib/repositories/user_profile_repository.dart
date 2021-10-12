import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';

abstract class BaseUserProfileRepository {

  Future<List<UserProfile>> retrieveUserProfile();
  Future<String> createUserProfile({required String userId, required UserProfile user});
  Future<void> updateUserProfile({required UserProfile user});
  Future<void> deleteUserProfile({required String userId});

}

final userProfileRepositoryProvider =
Provider<UserProfileRepository>((ref) => UserProfileRepository(ref.read));

class UserProfileRepository implements BaseUserProfileRepository{
  final Reader _read;
  const UserProfileRepository(this._read);

  @override
  Future<String> createUserProfile ({required String userId ,required UserProfile user}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .add(user.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateUserProfile({required UserProfile user}) async{
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
  Future<void> deleteUserProfile({required String userId}) async {
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
  Future<List<UserProfile>> retrieveUserProfile() async{
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





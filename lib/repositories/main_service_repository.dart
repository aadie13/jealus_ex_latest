import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';



import 'package:jealus_ex/models/service_model.dart';
import '../custom_exception.dart';
import '../general_providers.dart';

abstract class BaseServiceRepository {
  Future<List<Service>> retrieveServices();
  Future<String> createService({required Service service});
  Future<void> updateService({required Service service});
  Future<void> deleteService({required String serviceID});
}

final serviceRepositoryProvider =
Provider<ServiceRepository>((ref) => ServiceRepository(ref.read));

class ServiceRepository implements BaseServiceRepository{
  final Reader _read;
  const ServiceRepository(this._read);


  @override
  Future<List<Service>> retrieveServices() async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('Services')
          .get();
      return snap.docs.map((doc) => Service.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createService ({required Service service}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('Services').add(service.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateService({required Service service}) async{
    try {
      await _read(firebaseFirestoreProvider)
          .collection('Users')
          .doc(service.id)
          .update(service.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteService({required String serviceID})  async{
    try {
      await _read(firebaseFirestoreProvider)
          .collection('Services').doc(serviceID)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


//provides an instance of firebaseAuth

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

//final authStateChangeProvider = StreamProvider<User>((ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance) ;
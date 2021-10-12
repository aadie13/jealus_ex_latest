import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//**********************************************//
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/general_providers.dart';

//useful for testing
abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;//return stream user
  Future<void> signInWithEmailAndPassword(String email, String password);//
  Future<void> registerNewUser(String email, String password);//
  Future<void> signInAnonymously();
  User? getCurrentUser();//
  Future<void> signOut();//
}


final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read)); // access this across the app

class AuthRepository implements BaseAuthRepository{

  final Reader _read; //Takes reader from Riverpod. Reader allows the authRepository to read other proviers in the app. In this case we need to read firebaseAuth.instance
  //which we will get from firebaseAuthProvider
  const AuthRepository(this._read);

  @override
  // TODO: implement authStateChanges
  Stream<User?> get authStateChanges => _read(firebaseAuthProvider)
      .authStateChanges(); //access teh firebaseAuth.instance;


  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async{
    try {
      await _read(firebaseAuthProvider).signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> registerNewUser (String email, String password) async{
    try {
      await _read(firebaseAuthProvider).createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signInAnonymously() async{
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser(){
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
      //await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

}



import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//**********************************************//
import 'package:jealus_ex/repositories/auth_repository.dart';

//keep track of users current authentication state
final authControllerProvider = StateNotifierProvider<AuthController>((ref) => AuthController(ref.read)..appStarted());//..appStarted()); // ..appStarted once the authController is instantiated. As soon as the app loads the user will be authenticated

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null){ //initial state to null no user is logged in
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

    appStarted() {//get current user from firebase

     _read(authRepositoryProvider).getCurrentUser();

    //return _read(authRepositoryProvider).getCurrentUser()!;
    // if(user != null) {
    //   return HomeView();
    // }else {
    //   return LogInView();
    // }
    }

  void signOut() async{
    await _read(authRepositoryProvider).signOut();
  }
}
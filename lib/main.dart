import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jealus_ex/repositories/auth_repository.dart';

//*******************************************************//
import 'package:jealus_ex/screens/home_view.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/screens/login_view.dart';
import 'package:jealus_ex/screens/registration_vew.dart';
import 'package:jealus_ex/screens/tabbar_screen.dart';
import 'package:jealus_ex/screens/create_profile_view.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(// give us the ability all our providers anywhere in the app : ProvideScope
      child:
      MyApp()));
}

class MyApp extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jealous Ex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeController(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/tabBarScreen' : (BuildContext context) => HomeController(),
          '/register': (BuildContext context) => Register(),
          '/logIn': (BuildContext context) => LogInView(),
          '/createUserProfile': (BuildContext context) => CreateUserProfile(),
        }
    );
  }
}

class HomeController extends HookWidget {
  @override
  Widget build(BuildContext context){

    final authControllerState = useProvider(authControllerProvider).state;
    if (authControllerState != null){
      return TabBarScreen();
    }
    return LogInView();

  }

}
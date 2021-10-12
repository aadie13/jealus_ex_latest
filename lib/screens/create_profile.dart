import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/user_profile_controller.dart';
import 'package:jealus_ex/repositories/auth_repository.dart';
import 'package:jealus_ex/repositories/user_profile_repository.dart';
import 'package:jealus_ex/models/user_model.dart';

class CreateUserProfileScreen extends HookWidget {
  TextEditingController GivenNameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Create your profile',style: TextStyle(fontSize: 25.0),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 20.0,
            ),
            Image(
              image: AssetImage("images/logo.png"),
              width: 390.0,
              height: 250.0,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 1.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: GivenNameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.yellow,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Create Profile",
                          style: TextStyle(
                              fontSize: 28.0, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: () {
                      if (GivenNameTextEditingController.text.length < 3) {
                        Fluttertoast.showToast(msg:"name must be at least 3 characters");
                      } else if (phoneTextEditingController.text.isEmpty) {
                        Fluttertoast.showToast(msg:"Enter Phone number");
                      }
                      // else if (context.read(vehicleControllerProvider).retrieveVehicles() == null) {
                      //   Fluttertoast.showToast(msg:
                      //   "Add at least one Vehicle to your profile");
                      // } TODO: add this error check after implementing the option to add vehicles.
                      else {
                        //context.read(authRepositoryProvider).registerNewUser(emailTextEditingController.text, passwordTextEditingController.text);
                        // final user = context.read(authRepositoryProvider).getCurrentUser();
                        // UserProfile userProfile = UserProfile(name: GivenNameTextEditingController.text, phone:  phoneTextEditingController.text);
                        // context.read(userProfileRepositoryProvider).createUserProfile(userId: user!.uid, user: userProfile);
                        context.read(userProfileControllerProvider).addUserProfile(name: GivenNameTextEditingController.text, phone: phoneTextEditingController.text);
                        Fluttertoast.showToast(msg:"Profile created!");
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

}
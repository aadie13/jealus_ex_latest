import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//*******************************//
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/controllers/user_profile_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/auth_repository.dart';
import 'package:jealus_ex/general_providers.dart';

import '../custom_exception.dart';

class CreateUserProfile extends HookWidget {
  TextEditingController givenNameTextEditingController =
  TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          'Create your profile',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 20.0,
            ),
            // Image(
            //   image: AssetImage("images/logo.png"),
            //   width: 390.0,
            //   height: 250.0,
            //   alignment: Alignment.center,
            // ),
            // SizedBox(
            //   height: 1.0,
            // ), TODO: add this image or something else here
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: givenNameTextEditingController,
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
                    onPressed: () async {
                      if (givenNameTextEditingController.text.length < 3) {
                        Fluttertoast.showToast(
                            msg: "name must be at least 3 characters");
                      } else if (phoneTextEditingController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter Phone number");
                      } else {
                        var user = context.read(authControllerProvider.state);
                        if (user != null){
                          await context
                              .read(userControllerProvider)
                              .addUserProfile(
                              name: givenNameTextEditingController.text,
                              phone: phoneTextEditingController.text,);
                          Fluttertoast.showToast(msg: "Profile created!");
                          print("User File created");


                          Navigator.of(context).pushReplacementNamed('/addVehiclesToProfile');
                        }else {
                          Fluttertoast.showToast(msg:
                          "User profile not created because use account hasn't been created");
                          print("User profile not created because use account hasn't been created");
                          Navigator.of(context).pushReplacementNamed('/register');
                        }

                        // Vehicle myVehicle = new Vehicle(
                        //     vehicleMake: vehicleMake.text.trim(),
                        //     vehicleModel: vehicleModel.text.trim(),
                        //     vehicleYear: vehicleYear.text.trim(),
                        //     engineSize: engineSize.text.trim(),
                        //     tireSpec: tireSpec.text.trim());
                        // vehicles.add(myVehicle);
                        //context.read(authRepositoryProvider).registerNewUser(emailTextEditingController.text, passwordTextEditingController.text);
                        // final user = context.read(authRepositoryProvider).getCurrentUser();
                        // UserProfile userProfile = UserProfile(name: GivenNameTextEditingController.text, phone:  phoneTextEditingController.text);
                        // context.read(userProfileRepositoryProvider).createUserProfile(userId: user!.uid, user: userProfile);
                        // context
                        //     .read(userControllerProvider)
                        //     .addUserProfile(
                        //     name: givenNameTextEditingController.text,
                        //     phone: phoneTextEditingController.text,
                        //     residenceType: residenceType.text,
                        //     address: address.text)
                        //     .then((value) {
                        //   var user = context.read(authControllerProvider.state);
                        //   if (user != null) {
                        //     print(user);
                        //     print(user.uid);
                        //     Fluttertoast.showToast(msg: "Profile created!");
                        //     Navigator.of(context).pushReplacementNamed('/home');
                        //   }
                        // }).catchError((error) {
                        //   print(error.toString());
                        //   print("Profile not created");
                        // });

                        //Fluttertoast.showToast(msg: "Profile created!");
                        //Navigator.of(context).pushReplacementNamed('/home');
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
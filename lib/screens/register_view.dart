import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
//****************************************************//
import 'package:jealus_ex/repositories/auth_repository.dart';
import 'package:jealus_ex/controllers/user_profile_controller.dart';

class RegistrationView extends StatelessWidget{

  TextEditingController GivenNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  //TextEditingController residenceTypeTextEditingController = TextEditingController();
  //TextEditingController vehicleMake = TextEditingController();
  //TextEditingController vehicleModel = TextEditingController();
  //TextEditingController vehicleYear = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
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
              Text(
                "SignUp as Rider",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    // TextField(
                    //   controller: GivenNameTextEditingController,
                    //   keyboardType: TextInputType.name,
                    //   decoration: InputDecoration(
                    //     labelText: "Enter Your Name",
                    //     labelStyle: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 10.0,
                    //     ),
                    //   ),
                    //   style: TextStyle(fontSize: 14.0),
                    // ),
                    // SizedBox(
                    //   height: 1.0,
                    // ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
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
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    // SizedBox(
                    //   height: 1.0,
                    // ),
                    // TextField(
                    //   controller: phoneTextEditingController,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     labelText: "Enter Your Phone Number",
                    //     labelStyle: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 10.0,
                    //     ),
                    //   ),
                    //   style: TextStyle(fontSize: 14.0),
                    // ),
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
                            "Create Account",
                            style: TextStyle(
                                fontSize: 28.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text
                            .contains("@")) {
                          Fluttertoast.showToast(msg:"Invalid email");
                        } else if (passwordTextEditingController.text.length < 6) {
                          Fluttertoast.showToast(msg:
                          "Password must be atleast 7 characters long");
                        }
                        // } else if (GivenNameTextEditingController.text.length < 3) {
                        //   Fluttertoast.showToast(msg:
                        //   "Name but be atleast 3 characters long");
                        // } else if (phoneTextEditingController.text.length < 10) {
                        //   Fluttertoast.showToast(msg:
                        //   "Enter a Valid phone number");
                        // }
                        // else if (context.read(vehicleControllerProvider).retrieveVehicles() == null) {
                        //   Fluttertoast.showToast(msg:
                        //   "Add at least one Vehicle to your profile");
                        // } TODO: add this error check after implementing the option to add vehicles.
                        else {
                          context.read(authRepositoryProvider).registerNewUser(emailTextEditingController.text, passwordTextEditingController.text);
                          //context.read(userProfileControllerProvider).addUserProfile(name: GivenNameTextEditingController.text.trim(), phone: phoneTextEditingController.text.trim());
                          Fluttertoast.showToast(msg:"Account created!");
                          Navigator.of(context).pushReplacementNamed('/createUserProfile');
                        }
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/logIn');
                },
                child: Text("Already have an Account? LogIn Here."),
              ),
            ]),
          ),
        ));
  }
}


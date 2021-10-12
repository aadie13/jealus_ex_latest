import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//****************************************************//
import 'package:jealus_ex/repositories/auth_repository.dart';

class LogInView extends StatelessWidget{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right:25.0, left: 25.0),
              child: Image(
                image: AssetImage("images/SmapleLogo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Text(
              "Login as Customer",
              style: TextStyle(fontSize: 32.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
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
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 28.0),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: () {
                      if (!emailTextEditingController.text.contains("@")) {
                        Fluttertoast.showToast(msg: "Invalid email");
                      } else if (emailTextEditingController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Password must be provided");
                      } else {
                        //TODO: loginAndAuthenticateUser(context);
                        context.read(authRepositoryProvider).signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text);
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    },
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
                //TODO: Navigator.pushNamedAndRemoveUntil(
                //context, RegistrationScreen.idScreen, (route) => false);
              },
              child: Text("Do not have an Account? Register Here."),
            ),
          ]),
        ),
      ),
    );
  }
}
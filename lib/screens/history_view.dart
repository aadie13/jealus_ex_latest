import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/screens/show_completed_bookings.dart';

import '../custom_exception.dart';


class HistoryView extends HookWidget{
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider.state);
    return Scaffold(
      // appBar: AppBar(
      //   title: Column(
      //       children: [
      //         Text("Select A Service", style: TextStyle(fontSize: 25.0),),
      //         GestureDetector(
      //           child: Text("User's Selected car make, model and year", style: TextStyle(fontSize: 12.0),),
      //           onTap: (){
      //             print("tapped subtitle");
      //             //TODO: add address of HOME, if user pressed address allow to change at his discretion
      //             //TODO: if tapped on car, user can select from the list of its vehicles of add a new vehicle.
      //           },
      //         )
      //       ]),
      //
      //   //TODO : Add a row showing the Car information and address
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 500,
                child: CompletedBookingsList()),
          ],
        ),
      ),
    );
  }
}
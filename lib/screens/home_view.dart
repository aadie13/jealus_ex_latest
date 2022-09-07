import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/screens - booking service/book_oil_change.dart';
import 'package:jealus_ex/screens - booking service/book_tire_change.dart';
import 'package:jealus_ex/screens - booking service/book_detailing.dart';
import 'package:jealus_ex/screens - booking service/book_car_inspection.dart';
import 'package:jealus_ex/screens - booking service/book_battery_change.dart';
import 'package:jealus_ex/screens/show_upcoming_bookings.dart';

import '../controllers/allBookingsDatabase_controller.dart';
import '../Archive/Show_accepted_bookings_archive.dart';

class HomeView extends HookWidget{
  //final List<String> services4customer = ["Oil Change","Tire Swap","Detailing","Cleaning","Inspection Only"];
  List<Widget> pageServiceList = [BookOilChange(),BookTireChange(),BookDetailing(),BookInspection(),BookBatteryChange()];
  //TODO: implement battery change and inspection fully
  int _currentServiceIndex = 0;
  //TODO: create a vehicle and pass it to all the New_Services pages
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider.state);
    final pendingBookingsList = useProvider(upcomingBookingsFromDatabaseListProvider).length;
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

            SizedBox(
              width: double.infinity,
              height: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1), ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: servicesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Service newService = servicesList[index];
                              //Booking newBoking = new Booking(newService, null, null, null,null, null);
                              _currentServiceIndex = index;
                              return Card(
                                child: ListTile(
                                  title: Text(newService.serviceName, style: TextStyle(fontSize: 25.0),),
                                  // subtitle: Padding(
                                  //   padding: const EdgeInsets.only(top: 12.0, bottom: 9),
                                  //   child: Text("\$${newService.serviceCost}",style: TextStyle(fontSize: 18.0),),
                                  // ),
                                  //TODO Add leading and trailing here to follow the video on youtube leading: Image.network(Service.imageURL()
                                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => pageServiceList[index]));
                                  },
                                ),
                              );
                              //buildServiceCard(context, index);
                            },

                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: -10,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 0,top: 5, left: 10, right: 10),
                            color: Colors.white,
                            child: Text(
                              'Select a service',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1), ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: AcceptedBookingsList(),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: -10,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 0,top: 5, left: 10, right: 10),
                        color: Colors.white,
                        child: Text(
                          'Upcoming Bookings $pendingBookingsList',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
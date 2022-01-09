import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/controllers/user_bookings_service_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/controllers/main_service_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';

class ConfirmBooking extends HookWidget {
  final int serviceIndex;
  final String? typeSpecific;
  final String? detailingPackage;
  final int? numberOfTires2Swap;
  final int? numberofTires2Store;
  final DateTime selectedDate;
  final TimeOfDay startTime;
  //final int? durationMins; //This is final booking duration which will change from service duration depending on how any vehicles are chosen
  const ConfirmBooking(
      {Key? key,
      required this.serviceIndex,
      this.typeSpecific,
      this.detailingPackage,
      this.numberOfTires2Swap,
      this.numberofTires2Store,
      required this.selectedDate,
      required this.startTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    final List<Vehicle> _vehiclesForBooking = [];
    final bookedVehiclesList = useProvider(selectedVehicleListProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirm the details of your booking'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => SelectVehicleDialog.show(context),
      //   child: const Icon(Icons.directions_car_sharp),
      // ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(servicesList[this.serviceIndex].serviceName),
            Text(this.serviceIndex.toString()),
            Text(
              this.typeSpecific ?? '',
            ),
            Text(
              this.detailingPackage ?? '',
            ),
            Text(
              this.numberOfTires2Swap.toString() ?? "0",
            ),
            Text(
              this.numberofTires2Store.toString() ?? "0",
            ),
            Text(
              'Number of Selected vehicles = ${context.read(selectedVehicleListProvider).length.toString()}',
            ),
            Text(
              context.read(authControllerProvider).state!.uid.toString(),
            ),
            // ElevatedButton(onPressed: () => SelectVehicleDialog.show(context),
            //     child: Text.rich(
            //       TextSpan(style: TextStyle(
            //         fontSize: 17,
            //       ),
            //         children: [
            //           TextSpan(text: '+'),
            //           WidgetSpan(child: const Icon(Icons.directions_car_sharp),)
            //         ],
            //     ),),),
            // ElevatedButton(child: const Icon(Icons.directions_car_sharp),
            //     style: ElevatedButton.styleFrom(
            //       primary: context.read(selectedVehicleListProvider).length > 0 ? Colors.green : Colors.red,
            //     ),
            //     onPressed: () => SelectVehicleDialog.show(context),),
            SizedBox(
              height: 12.0,
            ),
            RaisedButton(
                child: Text("Confirm Booking"),
                onPressed: () async {
                  //TODO: each booking needs to have a list of vehicles
                  //TODO: during the process of booking a service the user will select the vehicles to be included in this service
                  //TODO: Once the user selects vehicles to be serviced out of his own veicles, the "isBooked" become true. after the booking is complete change this to false.
                  //TODO: make sure to add a method in vehiclesController.dart that adds a list of "isBooked==true" vehicles to the current booking vehicle
                  //TODO
                  //TODO: add a page before this to select a service provider and pass to this page
                  //Vehicle tempVeh = Vehicle(vehicleMake: 'Honda', vehicleModel: 'Civic', vehicleYear: "2010", engineSize: "1.8L", tireSpec: "195/65R15");
                  //List<Vehicle> tempVehicleListForBooking = context.read(vehicleControllerProvider).retrieveBookedVehicles();
                  //List<Vehicle> tempVehicleListForServiceProvider = [tempVeh];
                  //List<Vehicle> vehicleListForThisBooking;
                  //await addBookedVehiclesToBooking(vehicleListForThisBooking);
                  //var bookedVehiclesReference = context.read(vehicleControllerProvider).retrieveBookedVehicles();
                  //bookedVehiclesList.forEach((element) { _vehiclesForBooking.add(element);});
                  //UserProfile tempServiceProvider = UserProfile(name: "Adil", phone: "647777", residenceType: "Condo", address: "123 St",id: '00001');// vehicles: tempVehicleListForServiceProvider);
                  //TODO: implement being able to select a service provider filtered by distance or ratings
                  // Service service = Service(serviceName: servicesList[this.serviceIndex].serviceName, serviceCost: null,
                  //     serviceDurationMins: servicesList[this.serviceIndex].serviceDurationMins, typeSpecific: this.typeSpecific,
                  //     detailingPackage: this.detailingPackage, numberofTires2Store: this.numberofTires2Store, numberOfTires2Swap: this.numberOfTires2Swap);
                  var user = context.read(authControllerProvider.state);
                  if (user != null) {
                    if (context.read(selectedVehicleListProvider).length > 0 &&
                        context.read(selectedAddressListProvider).length == 1) {
                      //TODO: change the above. All the fields of a service cannot be populated for oil change and so on....
                      await context.read(bookingsControllerProvider).addBooking(
                            startDate: selectedDate,
                            startTimeHrs: startTime.hour,
                            startTimeMins: startTime.minute,
                            serviceIndex: this.serviceIndex,
                            typseSpecific: this.typeSpecific,
                            numberOfTires2Swap: this.numberOfTires2Swap,
                            numberofTires2Store: this.numberofTires2Store,
                            detailingPackage: this.detailingPackage,
                          );
                      //vehicles: tempVehicleListForServiceProvider).then((value) => null);
                      //await db.collection("Bookings").add(widget.booking.toJason());
                      //MaterialPageRoute(builder: (context) => ConfirmBooking(typeSpecific: widget.typeSpecific, serviceIndex: widget.serviceIndex, selectedDate: selectedDate, startTime: selectedTime, detailingPackage: widget.detailingPackage, numberOfTires2Swap: widget.numberOfTires2Swap, numberofTires2Store: widget.numberofTires2Store));
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Address and/or Vehicles selection error");
                    }
                  } else {
                    Fluttertoast.showToast(msg: "User ID not found");
                  }
                }),
          ],
        ),
      ),
      //TODO: add a cost and duration parameter to the boooking model. This is because if multiple vehicles are selected the cost and duration must increase
      //TODO: create a page before this page that the customer can select a service provider from
    );
  }
}

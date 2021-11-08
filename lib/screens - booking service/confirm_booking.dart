import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/models/vehicle_model.dart';

class ConfirmBooking extends StatefulWidget {

  final int serviceIndex;
  final String? typeSpecific;
  final String? detailingPackage;
  final int? numberOfTires2Swap;
  final int? numberofTires2Store;
  final DateTime selectedDate;
  final TimeOfDay startTime;
  //final int? durationMins; //This is final booking duration which will change from service duration depending on how any vehicles are chosen


  ConfirmBooking({Key? key, required this.serviceIndex, this.typeSpecific, this.detailingPackage, this.numberOfTires2Swap, this.numberofTires2Store, required this.selectedDate, required this.startTime}) : super(key: key);
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirm the details of your booking'),
      ),
      body: Container(
        child: Column(
          children: <Widget> [
            Text(
                servicesList[widget.serviceIndex].serviceName
            ),
            Text(
                widget.serviceIndex.toString()
            ),
            Text(
              widget.typeSpecific ?? '',
            ),
            Text(
              widget.detailingPackage ?? '',
            ),
            Text(
              widget.numberOfTires2Swap.toString() ?? "0",
            ),
            Text(
              widget.numberofTires2Store.toString() ?? "0",
            ),
            RaisedButton(
                child: Text("Confirm Booking"),
                onPressed: () async{
                  //create a temp service provider //TODO: add a page before this to select a service provider and pass to this page
                  Vehicle tempVeh = Vehicle(vehicleMake: 'Honda', vehicleModel: 'Civic', vehicleYear: "2010", engineSize: "1.8L", tireSpec: "195/65R15");
                  List<Vehicle> tempVehicleListForServiceProvider = [tempVeh];
                  List<Vehicle> vehicleListForThisBooking;
                  await addBookedVehiclesToBooking(vehicleListForThisBooking);
                  UserProfile tempServiceProvider = UserProfile(name: "Adil", phone: "647777", residenceType: "Condo", address: "123 St",);// vehicles: tempVehicleListForServiceProvider);
                  Service service = Service(serviceName: servicesList[widget.serviceIndex].serviceName, serviceCost: servicesList[widget.serviceIndex].serviceCost,
                      serviceDurationMins: servicesList[widget.serviceIndex].serviceDurationMins, typeSpecific: widget.typeSpecific,
                      detailingPackage: widget.detailingPackage, numberofTires2Store: widget.numberofTires2Store, numberOfTires2Swap: widget.numberOfTires2Swap);
                  //TODO: change the above. All the fields of a service cannot be populated for oil change and so on....
                  await context.read(bookingsControllerProvider).addBooking(serviceProvider: tempServiceProvider,
                      startDate: widget.selectedDate,
                      startTimeHrs: widget.startTime.hour,
                      startTimeMins: widget.startTime.minute,
                      service: service,
                      vehicles: tempVehicleListForServiceProvider);
                  //await db.collection("Bookings").add(widget.booking.toJason());
                  //MaterialPageRoute(builder: (context) => ConfirmBooking(typeSpecific: widget.typeSpecific, serviceIndex: widget.serviceIndex, selectedDate: selectedDate, startTime: selectedTime, detailingPackage: widget.detailingPackage, numberOfTires2Swap: widget.numberOfTires2Swap, numberofTires2Store: widget.numberofTires2Store));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }),
          ],
        ),
      ),
      //TODO: add a cost and duration parameter to the boooking model. This is because if multiple vehicles are selected the cost and duration must increase
      //TODO: create a page before this page that the customer can select a service provider from

    );
  }

  addBookedVehiclesToBooking(List<Vehicle> vehicleListForThisBooking) {



  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/Dialogs/add_address.dart';
import 'package:jealus_ex/Dialogs/add_vehicle.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/models/address.dart';
import 'package:jealus_ex/screens/address_list_to_select.dart';
import 'package:jealus_ex/screens/vehicle_list_to_select.dart';
import 'package:jealus_ex/models/vehicle_model.dart';

import 'date_time_picker.dart';


class VehiclesAndAddressToBook extends HookWidget {

  final int serviceIndex;
  final String? typeSpecific;
  final String? detailingPackage;
  final int? numberOfTires2Swap;
  final int? numberofTires2Store;

  const VehiclesAndAddressToBook(
      {Key? key,
        required this.serviceIndex,
        this.typeSpecific,
        this.detailingPackage,
        this.numberOfTires2Swap,
        this.numberofTires2Store})
      : super(key: key);
  bool get isAtLeastOneVehicleSelected =>
      useProvider(selectedVehicleListProvider).length > 0;
  bool get isOnlyOneAddressSelected =>
      useProvider(selectedAddressListProvider).length == 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 0.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1), ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: const VehicleListToSelect(),
                        ),
                      ),

                      Positioned(
                        left: 30,
                        top: -10,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 0,top: 5, left: 10, right: 10),
                          color: Colors.white,
                          child: Text(
                            'Select All Vehicles to Service',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),

                      // Positioned(
                      //   right: 100.0,
                      //   bottom: 0.0,
                      //   child: ElevatedButton(onPressed: () => AddVehicleDialog.show(context, Vehicle.empty()),
                      //   child:
                      //   Text.rich(
                      //     TextSpan(
                      //       style: TextStyle(
                      //         fontSize: 17,
                      //       ),
                      //       children: [
                      //         TextSpan(text: '+'),
                      //         WidgetSpan(
                      //           child: const Icon(Icons.directions_car_sharp),
                      //
                      //         ),
                      //       ],
                      //     ),
                      //   ),),)
                    ],
                  ),
                ),),
            ),
            SizedBox(
              height: 50,
              child: new Row(
                children: [
                  Spacer(),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(text: '+'),
                        WidgetSpan(
                          child: const Icon(Icons.directions_car_sharp),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: SizedBox(
                width: double.infinity,
                height: 225,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1), ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: const AddressListToSelect(),
                        ),
                      ),

                      Positioned(
                        left: 30,
                        top: -10,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 0,top: 5, left: 10, right: 10),
                          color: Colors.white,
                          child: Text(
                            'Select a Location for this Booking',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),

                      // Positioned(
                      //   right: 0.0,
                      //   bottom: 45.0,
                      //   child: ElevatedButton(onPressed: () => AddAddressDialog.show(context, Adddress.empty()),
                      //     child: Text.rich(
                      //       TextSpan(
                      //         style: TextStyle(
                      //           fontSize: 17,
                      //         ),
                      //         children: [
                      //           TextSpan(text: '+'),
                      //           WidgetSpan(
                      //             child: const Icon(Icons.location_on_rounded),
                      //
                      //           ),
                      //         ],
                      //       ),
                      //     ),),)
                    ],
                  ),
                ),),
            ),
            SizedBox(
              height: 50,
              child: new Row(
                children: [
                  Spacer(),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(text: '+'),
                        WidgetSpan(
                          child: const Icon(Icons.location_on_rounded),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: isAtLeastOneVehicleSelected && isOnlyOneAddressSelected
                        ? Theme.of(context).primaryColor
                        : Colors.green,
                  ),
                  onPressed: () {
                    context.read(selectedVehicleListProvider).length > 0 && context.read(selectedAddressListProvider).length == 1
                        ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DateTimePicker(
                            typeSpecific: typeSpecific,
                            serviceIndex: serviceIndex,
                            detailingPackage: detailingPackage,
                            numberOfTires2Swap: numberOfTires2Swap,
                            numberofTires2Store: numberofTires2Store,
                          )),
                    )
                        : Fluttertoast.showToast(msg: "Select ONLY 1 location and At least 1 vehicle");
                  },
                  child:
                  Text(isAtLeastOneVehicleSelected && isOnlyOneAddressSelected ? 'Proceed' : 'Select Items'),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }


}
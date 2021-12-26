import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/Dialogs/add_vehicle.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/screens/show_vehicles.dart';
import 'package:jealus_ex/models/vehicle_model.dart';

import 'date_time_picker.dart';

class SelectVehiclesToBook extends HookWidget {
  final int serviceIndex;
  final String? typeSpecific;
  final String? detailingPackage;
  final int? numberOfTires2Swap;
  final int? numberofTires2Store;

  const SelectVehiclesToBook(
      {Key? key,
      required this.serviceIndex,
      this.typeSpecific,
      this.detailingPackage,
      this.numberOfTires2Swap,
      this.numberofTires2Store})
      : super(key: key);
  bool get isAtLeastOneSelected =>
      useProvider(selectedVehicleListProvider).length > 0;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select All Vehicles For This Service'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            const VehicleList(),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton(onPressed: () => AddVehicleDialog.show(context, Vehicle.empty()),
              child: Text.rich(
                TextSpan(style: TextStyle(
                  fontSize: 17,
                ),
                  children: [
                    TextSpan(text: '+'),
                    WidgetSpan(child: const Icon(Icons.directions_car_sharp),)
                  ],
                ),),),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isAtLeastOneSelected
                      ? Theme.of(context).primaryColor
                      : Colors.green,
                ),
                onPressed: () {
                  context.read(selectedVehicleListProvider).length > 0
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DateTimePicker(
                                  typeSpecific: typeSpecific,
                                  serviceIndex: serviceIndex)),
                        )
                      : null;
                },
                child:
                    Text(isAtLeastOneSelected ? 'Proceed' : 'Select Vehicle'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

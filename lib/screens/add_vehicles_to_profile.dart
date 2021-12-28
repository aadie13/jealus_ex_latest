import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/Dialogs/add_vehicle.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/repositories/vehicle_repository.dart';
import 'package:jealus_ex/screens/vehicle_list.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/screens/vehicle_list_main.dart';

import 'home_view.dart';

class ShowVehiclesMain extends HookWidget {

  const ShowVehiclesMain ({Key? key}):super(key: key);
  bool get isAtLeastOneVehicle =>
      useProvider(vehicleListProvider).length > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Vehicles To Profile'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            const VehicleListMain(),
            Text(isAtLeastOneVehicle.toString()),
            Text(context.read(vehicleListProvider).length.toString()),
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
                  primary: isAtLeastOneVehicle
                      ? Colors.green
                      : Colors.red,
                ),
                onPressed: () {
                  context.read(vehicleListProvider).length > 0
                      ? Navigator.of(context).popAndPushNamed(
                    '/home')
                      : AddVehicleDialog.show(context, Vehicle.empty());
                },
                child:
                Text(isAtLeastOneVehicle ? 'Proceed' : 'Add Vehicle'),
              ),
            ),
          ],
        ),
      ),
    );
  }



}
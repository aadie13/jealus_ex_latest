import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddVehicleDialog extends HookWidget {

  static void show(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (context) => AddVehicleDialog(vehicle: vehicle),
    );
  }

  final Vehicle vehicle;

  const AddVehicleDialog({Key? key, required this.vehicle}): super(key: key);

  bool get isUpdating => vehicle.id != null;
  @override
  Widget build(BuildContext context) {
    final vehicleNickName = useTextEditingController(text: vehicle.nickName);
    final vehicleMake = useTextEditingController(text: vehicle.vehicleMake);
    final vehicleModel = useTextEditingController(text: vehicle.vehicleModel);
    final vehicleYear = useTextEditingController(text: vehicle.vehicleYear);
    final engineSize = useTextEditingController(text: vehicle.engineSize);
    final tireSpec = useTextEditingController(text: vehicle.tireSpec);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: vehicleNickName,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Vehicle Nickname'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: vehicleMake,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Enter Vehicle Make'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: vehicleModel,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Enter Vehicle Model'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: vehicleYear,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Enter Vehicle Year'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: engineSize,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'What is the engine size?'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: tireSpec,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'What is the tire spec?'),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isUpdating
                      ? Colors.orange
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Vehicle vehicle = Vehicle(nickName: vehicleNickName.text.trim(), vehicleMake: vehicleMake.text.trim(), vehicleModel: vehicleModel.text.trim(), vehicleYear: vehicleYear.text.trim(), engineSize: engineSize.text.trim(), tireSpec: tireSpec.text.trim());
                  isUpdating
                      ? context.read(vehicleControllerProvider).updateVehicle(
                    updatedVehicle: vehicle.copyWith(
                      nickName: vehicleNickName.text.trim(),
                        vehicleMake: vehicleMake.text.trim(),
                        vehicleModel: vehicleModel.text.trim(),
                      vehicleYear: vehicleYear.text.trim(),
                      engineSize: engineSize.text.trim(),
                      tireSpec: tireSpec.text.trim(),
                      isBooked: vehicle.isBooked,
                    ),
                  ).then((value) => {
                  Fluttertoast.showToast(msg: "Vehicle Added!"),
                      print("Vehicle Added!"),
                  })

                      :
                  context
                      .read(vehicleControllerProvider)
                      .addVehicle(vehicle: vehicle);
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(msg: "Vehicle Added!");
                  print("Vehicle Added!");
                },
                child: Text(isUpdating ? 'Update' : 'Add'),
              ),
            ),
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel'),))
          ],
        ),
      ),
    );
  }


  }
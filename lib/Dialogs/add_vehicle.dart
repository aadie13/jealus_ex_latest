import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    TextEditingController vehicleNickName = TextEditingController();
    TextEditingController vehicleMake = TextEditingController();
    TextEditingController vehicleModel = TextEditingController();
    TextEditingController vehicleYear = TextEditingController();
    TextEditingController engineSize = TextEditingController();
    TextEditingController tireSpec = TextEditingController();
    return Dialog(
      child: Padding(
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
                  )
                      : context
                      .read(vehicleControllerProvider)
                      .addVehicle(                    vehicleMake: vehicleMake.text.trim(),
                    vehicleModel: vehicleModel.text.trim(),
                    vehicleYear: vehicleYear.text.trim(),
                    engineSize: engineSize.text.trim(),
                    tireSpec: tireSpec.text.trim(),
                    nickName: vehicleNickName.text.trim(),);
                  Navigator.of(context).pop();
                },
                child: Text(isUpdating ? 'Update' : 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  }


import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/screens/vehicle_list.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';

class SelectVehicleDialog extends HookWidget {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SelectVehicleDialog(),
    );
  }

  //late final Vehicle vehicle;
  //final int numVehiclesSelected = 0;
  const SelectVehicleDialog({Key? key}) : super(key: key);//, required this.item}) : super(key: key);
  bool get isAtLeastOneSelected => useProvider(selectedVehicleListProvider).length > 0;

  @override
  Widget build(BuildContext context) {
    //final textController = useTextEditingController(text: item.name);
    context.read(authControllerProvider.state)!.reload();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const VehicleList(),
            SizedBox(height: 5.0,),
            Text(useProvider(selectedVehicleListProvider).length.toString()),
            SizedBox(height: 5.0,),
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
                      ? Navigator.of(context).pop()
                      : null;
                },
                child: Text(isAtLeastOneSelected ? 'Book' : 'Empty'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


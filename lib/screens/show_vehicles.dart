import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/vehicles_controller.dart';
import 'package:jealus_ex/Dialogs/add_vehicle.dart';
import 'package:jealus_ex/models/vehicle_model.dart';

import '../custom_exception.dart';

final currentVehicle =
    ScopedProvider<Vehicle>((_) => throw UnimplementedError());

class VehicleList extends HookWidget {
  const VehicleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleListState = useProvider(vehicleControllerProvider.state);
    return vehicleListState.when(
      data: (vehicles) => vehicles.isEmpty
          ? const Center(
              child: Text(
                'Tap + to add an item',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: vehicles.length,
              itemBuilder: (BuildContext context, int index) {
                final vehicle = vehicles[index];
                return ProviderScope(
                  overrides: [currentVehicle.overrideWithValue(vehicle)],
                  child: const VehicleTileToSelectForBooking(),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => VehicleListError(
        message:
            error is CustomException ? error.message! : 'Something went wrong!',
      ),
    );
  }
}

class VehicleTileToSelectForBooking extends HookWidget {
  const VehicleTileToSelectForBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final vehicle = useProvider(currentVehicle);
    return ListTile(
      key: ValueKey(vehicle.id),
      title: Text(vehicle.nickName),
      trailing: Checkbox(
        value: vehicle.isBooked,
        onChanged: (val) => context
            .read(vehicleControllerProvider)
            .updateVehicle(
                updatedVehicle: vehicle.copyWith(isBooked: !vehicle.isBooked)),
      ),
      //onTap: () => AddVehicleDialog.show(context, vehicle),
      onTap: () => AddVehicleDialog.show(context, vehicle),
    );
  }
}

class VehicleListError extends StatelessWidget {
  final String message;
  const VehicleListError({
    Key? key,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => context
                .read(vehicleControllerProvider)
                .retrieveVehicles(isRefreshing: true),
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}

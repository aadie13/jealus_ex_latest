import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/user_profile_repository.dart';
import 'package:jealus_ex/repositories/vehicle_repository.dart';

import '../general_providers.dart';

enum VehicleListFilter {
  all,
  selected,
}

final vehicleListFilterProvider =
StateProvider<VehicleListFilter>((_) => VehicleListFilter.all);

final selectedVehicleListProvider = Provider<List<Vehicle>>((ref) {
  final vehicleListFilterState = ref.watch(vehicleListFilterProvider).state;
  final vehicleListState = ref.watch(vehicleControllerProvider.state);
  return vehicleListState.maybeWhen(
      data: (vehicles) {
        return vehicles.where((vehicle) => vehicle.isBooked).toList();
        // switch (vehicleListFilterState) {
        //   case VehicleListFilter.selected:
        //     return vehicles.where((vehicle) => vehicle.isBooked).toList();
        //   default:
        //     return vehicles;
        // }
      },
      orElse: () => []);
});

final vehicleListProvider = Provider<List<Vehicle>>((ref) {
  final vehicleListFilterState = ref.watch(vehicleListFilterProvider).state;
  final vehicleListState = ref.watch(vehicleControllerProvider.state);
  return vehicleListState.maybeWhen(
      data: (vehicles) {
        return vehicles.toList();
        // switch (vehicleListFilterState) {
        //   case VehicleListFilter.selected:
        //     return vehicles.where((vehicle) => vehicle.isBooked).toList();
        //   default:
        //     return vehicles;
        // }
      },
      orElse: () => []);
});
final vehicleExceptionProvider = StateProvider<CustomException?>((_) => null);

final vehicleControllerProvider = StateNotifierProvider<VehicleController>(
      (ref) {
    final user = ref.watch(authControllerProvider.state);
    return VehicleController(ref.read, user?.uid);
  },
);

class VehicleController extends StateNotifier<AsyncValue<List<Vehicle>>> {

  final Reader _read;
  final String? _userId;

  VehicleController(this._read,this._userId):super(AsyncValue.loading()){
    if (_userId !=null){
      retrieveVehicles();
    }
  }

  Future<void> retrieveVehicles({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final vehicle = await _read(vehicleRepositoryProvider).retrieveUsersVehicles(userID: _userId!);
      if (mounted){
        state = AsyncValue.data(vehicle);
      }
    } on CustomException catch(e, st){
      state = AsyncValue.error(e, st);
    }
  }


  Future<void> addVehicle({required Vehicle vehicle}) async{
    try {
      //final vehicle = Vehicle(vehicleMake: vehicleMake, vehicleModel: vehicleModel, vehicleYear: vehicleYear, engineSize: engineSize, tireSpec: tireSpec, nickName: nickName, isBooked: isBooked);
      final vehicleID = await _read(vehicleRepositoryProvider).createUsersVehicle(userID: _userId!, vehicle: vehicle);
      state.whenData((vehicles) =>
      state = AsyncValue.data(vehicles..add(vehicle.copyWith(id: vehicleID)))
      );
    } on CustomException catch(e, st){
      _read(vehicleExceptionProvider).state = e;
    }
  }

  // Future<void> addVehicleToABookingInAllBookingsDatabase({required Vehicle vehicle,  required String bookingID}) async{
  //   try {
  //     //final vehicle = Vehicle(vehicleMake: vehicleMake, vehicleModel: vehicleModel, vehicleYear: vehicleYear, engineSize: engineSize, tireSpec: tireSpec, nickName: nickName, isBooked: isBooked);
  //     //final vehicleID = await _read(vehicleRepositoryProvider).addVehicleToABookingInUsersBookingsCollection(bookingID: bookingID, vehicle: vehicle, userId: _userId!);
  //     final vehicleID = await _read(vehicleRepositoryProvider).addVehicleToABookingInAllBookingsDatabase(bookingId: bookingID, vehicle: vehicle);
  //     state.whenData((vehicles) =>
  //     state = AsyncValue.data(vehicles..add(vehicle.copyWith(id: vehicleID)))
  //     );
  //   } on CustomException catch(e, st){
  //     _read(vehicleExceptionProvider).state = e;
  //   }
  // }
  //
  //
  // Future<void> addVehicleToABookingInUsersBookingsCollection({required Vehicle vehicle,  required String bookingID}) async{
  //   try {
  //     //final vehicle = Vehicle(vehicleMake: vehicleMake, vehicleModel: vehicleModel, vehicleYear: vehicleYear, engineSize: engineSize, tireSpec: tireSpec, nickName: nickName, isBooked: isBooked);
  //     final vehicleID = await _read(vehicleRepositoryProvider).addVehicleToABookingInUsersBookingsCollection(bookingID: bookingID, vehicle: vehicle, userId: _userId!);
  //     //final vehicleID = await _read(vehicleRepositoryProvider).addVehicleToABookingInAllBookingsDatabase(bookingId: bookingID, vehicle: vehicle);
  //     state.whenData((vehicles) =>
  //     state = AsyncValue.data(vehicles..add(vehicle.copyWith(id: vehicleID)))
  //     );
  //   } on CustomException catch(e, st){
  //     _read(vehicleExceptionProvider).state = e;
  //   }
  // }

  Future<void> updateVehicle({required Vehicle updatedVehicle}) async {
    try {
      await _read(vehicleRepositoryProvider).updateVehicle(userID: _userId!, vehicle: updatedVehicle);
      state.whenData((vehicles) {
        state = AsyncValue.data([
          for (final vehicle in vehicles)
            if (vehicle.id == updatedVehicle.id) updatedVehicle else vehicle
        ]);
      });
    } on CustomException catch (e){
      _read(vehicleExceptionProvider).state = e;
    }
  }

  Future<void> deleteVehicle({required String vehicleId}) async {
    try {
      await _read(vehicleRepositoryProvider).deleteVehicle(userID: _userId!, vehicleID: vehicleId);
      state.whenData((vehicles) =>
      state = AsyncValue.data(vehicles..removeWhere((element) => element.id == vehicleId))
      );
    } on CustomException catch (e){
      _read(vehicleExceptionProvider).state = e;
    }
  }
}
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/user_profile_repository.dart';
import 'package:jealus_ex/repositories/vehicle_repository.dart';

enum VehicleList_User_Filter {
  all,
  selected,
}

final vehicleListProvider_User = Provider<List<Vehicle>>((ref) {
  final vehicleListState = ref.watch(vehicleControllerProvider_User.state);
  return vehicleListState.maybeWhen(
      data: (vehicles) {
        return vehicles.toList();
      },
      orElse: () => []);
});

final selectedVehicleListProvider_User = Provider<List<Vehicle>>((ref) {
  final vehicleListState = ref.watch(vehicleControllerProvider_User.state);
  return vehicleListState.maybeWhen(
      data: (vehicles) {
        return vehicles.where((vehicle) => vehicle.isBooked).toList();
      },
      orElse: () => []);
});


final vehicleListFilter_User_Provider =
StateProvider<VehicleList_User_Filter>((_) => VehicleList_User_Filter.all);

final vehicleExceptionProvider = StateProvider<CustomException?>((_) => null);

final vehicleControllerProvider_User = StateNotifierProvider<VehicleController_User>(
      (ref) {
    final user = ref.watch(authControllerProvider.state);
    return VehicleController_User(ref.read, user?.uid);
  },
);

class VehicleController_User extends StateNotifier<AsyncValue<List<Vehicle>>> {
  final Reader _read;
  final String? _userID;

  VehicleController_User(this._read,this._userID):super(AsyncValue.loading()){
    if (_userID !=null){
      retrieveVehiclesFromUsersProfile();
    }
  }

  Future<void> retrieveVehiclesFromUsersProfile({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final vehicle = await _read(vehicleRepositoryProvider).retrieveUsersVehicles(userID: _userID!);
      if (mounted){
        state = AsyncValue.data(vehicle);
      }
    } on CustomException catch(e, st){
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addVehicleToUsersProfile({required Vehicle vehicle}) async{
    try {
      //final vehicle = Vehicle(vehicleMake: vehicleMake, vehicleModel: vehicleModel, vehicleYear: vehicleYear, engineSize: engineSize, tireSpec: tireSpec, nickName: nickName, isBooked: isBooked);
      final vehicleID = await _read(vehicleRepositoryProvider).createUsersVehicle(userID: _userID!, vehicle: vehicle);
      state.whenData((vehicles) =>
      state = AsyncValue.data(vehicles..add(vehicle.copyWith(id: vehicleID)))
      );
    } on CustomException catch(e, st){
      _read(vehicleExceptionProvider).state = e;
    }
  }

  Future<void> updateVehicleInUsersProfile({required Vehicle updatedVehicle}) async {
    try {
      await _read(vehicleRepositoryProvider).updateVehicle(userID: _userID!, vehicle: updatedVehicle);
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

  Future<void> deleteVehicleFromUsersProfile({required String vehicleID}) async {
    try {
      await _read(vehicleRepositoryProvider).deleteVehicle(userID: _userID!, vehicleID: vehicleID);
      state.whenData((vehicles) =>
      state = AsyncValue.data(vehicles..removeWhere((element) => element.id == vehicleID))
      );
    } on CustomException catch (e){
      _read(vehicleExceptionProvider).state = e;
    }
  }

}
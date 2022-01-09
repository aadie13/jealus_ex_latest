import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/main_service_repository.dart';
import 'package:jealus_ex/repositories/user_bookings_service_repository.dart';

import 'auth_controller.dart';

enum UsersBookingServiceListFilter {
  all,
  selected,
}

final usersBookingServiceListFilterProvider =
StateProvider<UsersBookingServiceListFilter>((_) => UsersBookingServiceListFilter.all);

final selectedUsersBookingServiceListProvider = Provider<List<Service>>((ref) {
  // final addressListFilterState = ref.watch(vehicleListFilterProvider).state;
  final usersBookingServiceListState = ref.watch(usersBookingServiceControllerProvider.state);
  return usersBookingServiceListState.maybeWhen(
      data: (services) {
        return services.where((service) => service.isSelected).toList();
      },
      orElse: () => []);
});

final usersBookingServiceListProvider = Provider<List<Service>>((ref) {
  //final addressListFilterState = ref.watch(addressListFilterProvider).state;
  final usersBookingServiceListState = ref.watch(usersBookingServiceControllerProvider.state);
  return usersBookingServiceListState.maybeWhen(
      data: (services) {
        return services.toList();
      },
      orElse: () => []);
});

final usersBookingServiceExceptionProvider = StateProvider<CustomException?>((_) => null);

final usersBookingServiceControllerProvider = StateNotifierProvider<UsersBookingServiceController>(
      (ref) {
        final user = ref.watch(authControllerProvider.state);
    return UsersBookingServiceController(ref.read, user?.uid);
  },
);

class UsersBookingServiceController extends StateNotifier<AsyncValue<List<Service>>> {

  final Reader _read;
  final String? _userId;

  UsersBookingServiceController(this._read, this._userId):super(AsyncValue.loading());

  Future<void> retrieveServices({bool isRefreshing = false, required String bookingID}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final service = await _read(usersBookingServiceRepositoryProvider).retrieveServices(userID: _userId!, bookingID: bookingID);
      if (mounted){
        state = AsyncValue.data(service);
      }
    } on CustomException catch(e, st){
      state = AsyncValue.error(e, st);
    }
  }

  // Future<void> addService({required String serviceName,
  //   String? typeSpecific, double? serviceCost,
  //   required double serviceDurationMins,int? numberOfTires2Swap,
  //   int? numberofTires2Store,
  //   String? detailingPackage, bool isCurrent = false, required String bookingID}) async{
    Future<void> addService({required Service service, required String bookingID}) async{
    try {
      // final service = Service(serviceName: serviceName, serviceCost: serviceCost,
      //     serviceDurationMins: serviceDurationMins, typeSpecific: typeSpecific,
      //     numberOfTires2Swap: numberOfTires2Swap,
      //     numberofTires2Store: numberofTires2Store, isCurrent: isCurrent);
      final serviceID = await _read(usersBookingServiceRepositoryProvider).createService(userID: _userId!, bookingID: bookingID, service: service);
      state.whenData((services) =>
      state = AsyncValue.data(services..add(service.copyWith(id: serviceID)))
      );
    } on CustomException catch(e, st){
      _read(usersBookingServiceExceptionProvider).state = e;
    }
  }

  Future<void> updateService({required Service updatedService, required String bookingID}) async {
    try {
      await _read(usersBookingServiceRepositoryProvider).updateService(userID: _userId!, bookingID: bookingID, service: updatedService);
      state.whenData((services) {
        state = AsyncValue.data([
          for (final service in services)
            if (service.id == updatedService.id) updatedService else service
        ]);
      });
    } on CustomException catch (e){
      _read(usersBookingServiceExceptionProvider).state = e;
    }
  }

  Future<void> deleteService({required String serviceID,required String bookingID}) async {
    try {
      await _read(usersBookingServiceRepositoryProvider).deleteService(userID: _userId!, bookingID: bookingID, serviceID: serviceID);
      state.whenData((services) =>
      state = AsyncValue.data(services..removeWhere((element) => element.id == serviceID))
      );
    } on CustomException catch (e){
      _read(usersBookingServiceExceptionProvider).state = e;
    }
  }
}
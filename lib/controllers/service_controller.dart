import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/service_repository.dart';

final serviceExceptionProvider = StateProvider<CustomException?>((_) => null);

final serviceControllerProvider = StateNotifierProvider<ServiceController>(
      (ref) {
    return ServiceController(ref.read);
  },
);

class ServiceController extends StateNotifier<AsyncValue<List<Service>>> {

  final Reader _read;


  ServiceController(this._read):super(AsyncValue.loading()){
    retrieveServices();
  }

  Future<void> retrieveServices({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final service = await _read(serviceRepositoryProvider).retrieveServices();
      if (mounted){
        state = AsyncValue.data(service);
      }
    } on CustomException catch(e, st){
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addService({required String serviceName,
  String? typeSpecific, required double serviceCost,
    required double serviceDurationMins,int? numberOfTires2Swap,
    int? numberofTires2Store,
    String? detailingPackage, bool isCurrent = false}) async{
    try {
      final service = Service(serviceName: serviceName, serviceCost: serviceCost,
        serviceDurationMins: serviceDurationMins, typeSpecific: typeSpecific,
        numberOfTires2Swap: numberOfTires2Swap,
          numberofTires2Store: numberofTires2Store, isCurrent: isCurrent);
      final serviceID = await _read(serviceRepositoryProvider).createService(service: service);
      state.whenData((services) =>
      state = AsyncValue.data(services..add(service.copyWith(id: serviceID)))
      );
    } on CustomException catch(e, st){
      _read(serviceExceptionProvider).state = e;
    }
  }

  Future<void> updateService({required Service updatedService}) async {
    try {
      await _read(serviceRepositoryProvider).updateService(service: updatedService);
      state.whenData((services) {
        state = AsyncValue.data([
          for (final service in services)
            if (service.id == updatedService.id) updatedService else service
        ]);
      });
    } on CustomException catch (e){
      _read(serviceExceptionProvider).state = e;
    }
  }

  Future<void> deleteService({required String serviceID}) async {
    try {
      await _read(serviceRepositoryProvider).deleteService(serviceID: serviceID);
      state.whenData((services) =>
      state = AsyncValue.data(services..removeWhere((element) => element.id == serviceID))
      );
    } on CustomException catch (e){
      _read(serviceExceptionProvider).state = e;
    }
  }
}
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/address.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/repositories/address_repository.dart';

import '../general_providers.dart';

enum AddressListFilter {
  all,
  selected,
}

final addressListFilterProvider =
    StateProvider<AddressListFilter>((_) => AddressListFilter.all);

final selectedAddressListProvider = Provider<List<Adddress>>((ref) {
  // final addressListFilterState = ref.watch(vehicleListFilterProvider).state;
  final addressListState = ref.watch(addressControllerProvider.state);
  return addressListState.maybeWhen(
      data: (addresses) {
        return addresses.where((address) => address.isServiceLocation).toList();
        // switch (vehicleListFilterState) {
        //   case VehicleListFilter.selected:
        //     return vehicles.where((vehicle) => vehicle.isBooked).toList();
        //   default:
        //     return vehicles;
        // }
      },
      orElse: () => []);
});

final addressListProvider = Provider<List<Adddress>>((ref) {
  //final addressListFilterState = ref.watch(addressListFilterProvider).state;
  final addressListState = ref.watch(addressControllerProvider.state);
  return addressListState.maybeWhen(
      data: (addresses) {
        return addresses.toList();
      },
      orElse: () => []);
});
final addressExceptionProvider = StateProvider<CustomException?>((_) => null);

final addressControllerProvider = StateNotifierProvider<AddressController>(
  (ref) {
    final user = ref.watch(authControllerProvider.state);
    return AddressController(ref.read, user?.uid);
  },
);

class AddressController extends StateNotifier<AsyncValue<List<Adddress>>> {
  final Reader _read;
  final String? _userId;

  AddressController(this._read, this._userId) : super(AsyncValue.loading()) {
    if (_userId != null) {
      retrieveAllAddresses();
    }
  }

  Future<void> retrieveAllAddresses({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final address = await _read(addressRepositoryProvider)
          .retrieveAllAddresses(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(address);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addAddress(
      {required String placeFormattedAddress,
      required String placeName,
      required double latitude,
      required double longitude,
      required String addressType,
      bool isServiceLocation = false}) async {
    try {
      final address = Adddress(
          placeFormattedAddress: placeFormattedAddress,
          placeName: placeName,
          latitude: latitude,
          longitude: longitude,
          isServiceLocation: isServiceLocation,
          addressType: addressType);
      final addressID = await _read(addressRepositoryProvider)
          .createAddress(userId: _userId!, address: address);
      state.whenData((addresses) => state =
          AsyncValue.data(addresses..add(address.copyWith(id: addressID))));
    } on CustomException catch (e, st) {
      _read(addressExceptionProvider).state = e;
    }
  }

  Future<void> updateAddress({required Adddress updatedAddress}) async {
    try {
      await _read(addressRepositoryProvider)
          .updateAddress(userId: _userId!, address: updatedAddress);
      state.whenData((addresses) {
        state = AsyncValue.data([
          for (final address in addresses)
            if (address.id == updatedAddress.id) updatedAddress else address
        ]);
      });
    } on CustomException catch (e) {
      _read(addressExceptionProvider).state = e;
    }
  }

  Future<void> deleteAddress({required String addressId}) async {
    try {
      await _read(addressRepositoryProvider)
          .deleteAddress(userId: _userId!, addressId: addressId);
      state.whenData((addresses) => state = AsyncValue.data(
          addresses..removeWhere((element) => element.id == addressId)));
    } on CustomException catch (e) {
      _read(addressExceptionProvider).state = e;
    }
  }
}

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/Dialogs/add_address.dart';
import 'package:jealus_ex/models/address.dart';

import '../custom_exception.dart';

//this is the main page where the use is able to add vehicles to the profile. There needs to be atleast one vehicle in each users profile.

final currentAddress =
    ScopedProvider<Adddress>((_) => throw UnimplementedError());

class AddressListToSelect extends HookWidget {
  const AddressListToSelect({Key? key}) : super(key: key);
  //AsyncValue<List<Adddress>> addressListState = useProvider(addressControllerProvider.state);
  @override
  Widget build(BuildContext context) {
    final addressListState = useProvider(addressControllerProvider.state);
    return addressListState.when(
      data: (addresses) => addresses.isEmpty
          ? const Center(
              child: Text(
                'Tap + to add a Address',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              //TODO: make this list such that only one item is selectable in the list of addresses to select from got the booking.
              shrinkWrap: true,
              itemCount: addresses.length,
              itemBuilder: (BuildContext context, int index) {
                final address = addresses[index];
                return ProviderScope(
                  overrides: [currentAddress.overrideWithValue(address)],
                  child: const AddressTileToSelectForBooking(),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => AddressListError(
        message:
            error is CustomException ? error.message! : 'Something went wrong!',
      ),
    );
  }
}

class AddressTileToSelectForBooking extends HookWidget {
  const AddressTileToSelectForBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final address = useProvider(currentAddress);
    return ListTile(
      key: ValueKey(address.id),
      title: Text(address.placeName),
      subtitle: new Row(
        children: [
          Text(address.placeFormattedAddress),
        ],
      ),
      trailing: Checkbox(
        value: address.isServiceLocation,
        onChanged: (val) => context
            .read(addressControllerProvider)
            .updateAddress(
                updatedAddress: address.copyWith(
                    isServiceLocation: !address.isServiceLocation)),
      ),
      //onTap: () => AddVehicleDialog.show(context, vehicle),
      onTap: () => AddAddressDialog.show(context, address),
    );
  }
}

class AddressListError extends StatelessWidget {
  final String message;
  const AddressListError({
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
                .read(addressControllerProvider)
                .retrieveAllAddresses(isRefreshing: true),
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}

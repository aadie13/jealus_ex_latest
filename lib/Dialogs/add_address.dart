import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/models/address.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geocoding/geocoding.dart';

class AddAddressDialog extends HookWidget {

  static void show(BuildContext context, Adddress address) {
    showDialog(
      context: context,
      builder: (context) => AddAddressDialog(address: address),
    );
  }

  final Adddress address;

  const AddAddressDialog({Key? key, required this.address}): super(key: key);

  bool get isUpdating => address.id != null;
  @override
  Widget build(BuildContext context) {
    final fullAddress = useTextEditingController(text: address.placeFormattedAddress);
    final placeName = useTextEditingController(text: address.placeName);
    final latitude = useTextEditingController();
    final longitude = useTextEditingController();
    final addressType = useTextEditingController(text: address.addressType);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: placeName,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Enter Name: for ex Home'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: fullAddress,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Full Address: ex 81 Bay St, Toronto, ON M5J 1J5'),
            ),
            const SizedBox(height: 6.0),
            TextField(
              controller: addressType,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Is this Condo, House or parking Lot?'),
            ),
            const SizedBox(height: 6.0),

            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isUpdating
                      ? Colors.orange
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () async{
                  List<Location> locations = await locationFromAddress(fullAddress.text);
                  // var addresses = await Geocoder.local.findAddressesFromQuery(fullAddress.text.trim());
                  // var first = addresses.first;
                  print(locations.first);
                  var firstLocation = locations.first;
                  isUpdating
                      ? context.read(addressControllerProvider)
                      .updateAddress(
                    updatedAddress: address.copyWith(
                      placeName: placeName.text.trim(),
                      placeFormattedAddress: fullAddress.text.trim(),
                      addressType: addressType.text.trim(),
                      latitude: firstLocation.latitude,
                      longitude: firstLocation.longitude,
                    ),
                  ).then((value) => {
                    Fluttertoast.showToast(msg: "Address Updated!"),
                    print("Address Updated!"),
                  })

                      : context
                      .read(addressControllerProvider)
                      .addAddress(placeFormattedAddress: fullAddress.text.trim(),
                      placeName: placeName.text.trim(), latitude: firstLocation.latitude,
                      longitude: firstLocation.longitude,
                      addressType: addressType.text.trim());
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(msg: " New Address Added!");
                  print("New +Address Added!");
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
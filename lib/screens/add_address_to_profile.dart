import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/Dialogs/add_address.dart';
import 'package:jealus_ex/controllers/address_controller.dart';
import 'package:jealus_ex/models/address.dart';
import 'package:jealus_ex/screens/address_list_main.dart';

import 'home_view.dart';

class ShowAddressesMain extends HookWidget {
  const ShowAddressesMain({Key? key}) : super(key: key);
  bool get isAtLeastOneAddress => useProvider(addressListProvider).length > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Address To Your Profile'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            const AddressListMain(),
            Text(isAtLeastOneAddress.toString()),
            Text(context.read(addressListProvider).length.toString()),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              onPressed: () => AddAddressDialog.show(context, Adddress.empty()),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  children: [
                    TextSpan(text: '+'),
                    WidgetSpan(
                      child: const Icon(Icons.location_on_rounded),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isAtLeastOneAddress ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  context.read(addressListProvider).length > 0
                      ? Navigator.of(context).popAndPushNamed('/home')
                      : AddAddressDialog.show(context, Adddress.empty());
                },
                child: Text(isAtLeastOneAddress ? 'Finish' : 'Add Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

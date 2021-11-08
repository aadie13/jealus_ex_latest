import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';

class MessagesView extends HookWidget{
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: new Text('Messages View TBD',style: TextStyle(fontSize: 25.0),),
        leading: authControllerState != null
            ? IconButton(icon: const Icon(Icons.logout), onPressed: () => context.read(authControllerProvider).signOut(),)
            : null,
      ),
      body: Column(
        children: [
          Text(authControllerState != null ? "signedIn":"Loggedout"),
        ],
      ),
    );
  }
}
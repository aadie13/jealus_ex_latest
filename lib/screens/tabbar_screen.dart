import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
//************************************************************//
import 'history_view.dart';
import 'messages_view.dart';
import 'profle_view.dart';
import 'home_view.dart';

class TabBarScreen extends HookWidget {
  List<Widget> pageList = [HomeView(), HistoryView(), MessagesView(), ProfileView()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: new Text('Mobile Mechanic',style: TextStyle(fontSize: 25.0),),
        // leading: IconButton(icon: const Icon(Icons.logout),
        //   onPressed: () {
        //     context.read(authControllerProvider).signOut();
        //   },),
        leading: authControllerState != null ? IconButton(icon: const Icon(Icons.logout),
          onPressed: () {
            context.read(authControllerProvider).signOut();
            //var user = context.read(authControllerS)
            Navigator.of(context).pushReplacementNamed('/logIn');

          },):null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text(
                'Home'
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.history),
            title: new Text(
                'History'
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.message),
            title: new Text(
                'Messages'
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text(
                'Profile'
            ),
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index){
      _currentIndex = index;
  }

}

// class TabBarScreen extends StatefulWidget {
//   @override
//   _TabBarScreenState createState() => _TabBarScreenState();
// }
//
// class _TabBarScreenState extends State<TabBarScreen> {
//   List<Widget> pageList = [];
//   int _currentIndex = 0;
//   @override
//   void initState(){
//     pageList.add(HomeView());
//     pageList.add(HistoryView());
//     pageList.add(MessagesView());
//     pageList.add(ProfileView());
//     mustCallSuper;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final authControllerState = useProvider(authControllerProvider.state);
//     return Scaffold(
//       appBar: AppBar(
//         title: new Text('Mobile Mechanic',style: TextStyle(fontSize: 25.0),),
//         // leading: IconButton(icon: const Icon(Icons.logout),
//         //   onPressed: () {
//         //     context.read(authControllerProvider).signOut();
//         //   },),
//         leading: authControllerState != null ? IconButton(icon: const Icon(Icons.logout),
//           onPressed: () {
//             context.read(authControllerProvider).signOut();
//             //var user = context.read(authControllerS)
//             if (authControllerState == null){
//               Navigator.of(context).pushReplacementNamed('/logIn');
//             }
//
//           },):null,
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: pageList,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.home),
//             title: new Text(
//                 'Home'
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.history),
//             title: new Text(
//                 'History'
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.message),
//             title: new Text(
//                 'Messages'
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.account_circle),
//             title: new Text(
//                 'Profile'
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   void onTabTapped(int index){
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:jealus_ex/controllers/booking_controller.dart';
// import 'package:jealus_ex/models/booking_model.dart';
// import 'package:date_format/date_format.dart';
//
// import '../controllers/allBookingsDatabase_controller.dart';
// import '../custom_exception.dart';
//
// final currentBooking =
// ScopedProvider<Booking>((_) => throw UnimplementedError());
//
// class CompletedBookingsList extends HookWidget {
//   const CompletedBookingsList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _completedBookingsList = useState([]);
//     final _completedBookingsListLoaded = useState(false);
//     final _completedBookingsListHasData = useState(false);
//
//     Future collectData() async {
//       final completedBookingsList =
//       await useProvider(completedBookingsFromDatabaseListProvider);
//       print(pendingBookingsList.length);
//       if (pendingBookingsList.isNotEmpty) {
//         _upcomingBookingsList.value = pendingBookingsList;
//         if (!(_upcomingBookingsList.value.length == 0)) {
//           _upcomingBookingsListHasData.value = true;
//         }
//         _upcomingBookingsListLoaded.value = true;
//       }
//     }
//
//     return FutureBuilder(
//         future: collectData(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (_upcomingBookingsListHasData.value) {
//             return _upcomingBookingsListLoaded.value
//                 ? ListView.builder(
//                 itemCount: _upcomingBookingsList.value.length,
//                 itemBuilder: (BuildContext ctx, int index) {
//                   Booking booking = _upcomingBookingsList.value[index];
//                   return ProviderScope(
//                     overrides: [currentBooking.overrideWithValue(booking)],
//                     child: const BookingTile(),
//                   );
//                 })
//                 : Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return const Center(
//               child: Text(
//                 'No Bookings Created',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             );
//           }
//         });
//   }
// }
//
// class BookingTile extends HookWidget {
//   const BookingTile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final item = useProvider(currentBooking);
//     return Dismissible(
//       key: UniqueKey(), //Key(item.id!),
//       onDismissed: (direction) {
//         context
//             .read(allBookingsDatabaseControllerProvider)
//             .deleteBooking(bookingId: item.id.toString());
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('$item deleted')));
//       },
//       background: Container(
//         color: Colors.red,
//       ),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.lime, width: 5),
//           borderRadius: BorderRadius.circular(2),
//         ),
//         child: ListTile(
//           key: ValueKey(item.id),
//           title: new Row(
//             children: [
//               Text(
//                 'Date (yyyy-mm-dd): ',
//                 style: TextStyle(fontSize: 18),
//               ),
//               Spacer(),
//               Text(
//                 item.startDate.year.toString() +
//                     '-' +
//                     item.startDate.month.toString() +
//                     '-' +
//                     item.startDate.day.toString(),
//                 style: TextStyle(fontSize: 18),
//               ),
//             ],
//           ),
//           subtitle: Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: new Row(
//               children: [
//                 Text(
//                   'Time (hrs:min)  ',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Spacer(),
//                 Text(
//                   item.startTimeHrs.toString() +
//                       ':' +
//                       item.startTimeMins.toString(),
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ],
//             ),
//           ),
//           //onTap: () => AddItemDialog.show(context, item),//TODO:on Tap edit the pendingbooking
//           onLongPress: () => context //TODO:
//               .read(allBookingsDatabaseControllerProvider)
//               .updateBooking(
//               updatedBooking:
//               item.copyWith(isCompleted: !item.isCompleted)),
//         ),
//       ),
//     );
//   }
// }
//
// class BookingsListError extends StatelessWidget {
//   final String message;
//   const BookingsListError({
//     Key? key,
//     required this.message,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(message, style: const TextStyle(fontSize: 20.0)),
//           const SizedBox(height: 20.0),
//           ElevatedButton(
//             onPressed: () => context
//                 .read(bookingsControllerProvider)
//                 .retrieveBookings(isRefreshing: true),
//             child: const Text('Retry'),
//           )
//         ],
//       ),
//     );
//   }
// }

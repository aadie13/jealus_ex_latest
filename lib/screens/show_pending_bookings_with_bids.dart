import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:date_format/date_format.dart';

import '../controllers/allBookingsDatabase_controller.dart';
import '../custom_exception.dart';

final currentBooking =
ScopedProvider<Booking>((_) => throw UnimplementedError());

class AcceptedBookingsList extends HookWidget {
  const AcceptedBookingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pendingBookingsList = useState([]);
    final _pendingBookingsListLoaded = useState(false);
    final _pendingBookingsListHasData = useState(false);
    final _bookingIDtoFetchTheBIDS = useState('');

    Future collectData() async {
      final pendingBookingsList =
      await useProvider(pendingBookingsFromDatabaseListProvider);
      print(pendingBookingsList.length);
      if (pendingBookingsList.isNotEmpty) {
        _pendingBookingsList.value = pendingBookingsList;
        if (!(_pendingBookingsList.value.length == 0)) {
          _pendingBookingsListHasData.value = true;
        }
        _pendingBookingsListLoaded.value = true;
      }
    }

    return FutureBuilder(
        future: collectData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (_pendingBookingsListHasData.value) {
            return _pendingBookingsListLoaded.value
                ? ListView.builder(
                itemCount: _pendingBookingsList.value.length,
                itemBuilder: (BuildContext ctx, int index) {
                  Booking booking = _pendingBookingsList.value[index];
                  return Dismissible(key: UniqueKey(), //Key(item.id!),// ,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.lime, width: 5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ListTile(
                        key: ValueKey(booking.id),
                        title: new Row(
                          children: [
                            Text(
                              'Date (yyyy-mm-dd): ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            Text(
                              booking.startDate.year.toString() +
                                  '-' +
                                  booking.startDate.month.toString() +
                                  '-' +
                                  booking.startDate.day.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new Row(
                            children: [
                              Text(
                                'Time (hrs:min)  ',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                booking.startTimeHrs.toString() +
                                    ':' +
                                    booking.startTimeMins.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => _bookingIDtoFetchTheBIDS.value = booking.id!,//AddItemDialog.show(context, item),//TODO:on Tap edit the pendingbooking
                        onLongPress: () => context //TODO:
                            .read(allBookingsDatabaseControllerProvider)
                            .updateBooking(
                            updatedBooking:
                            booking.copyWith(isCompleted: !booking.isCompleted)),
                      ),
                    ),
                    onDismissed: (direction) {
                      context
                          .read(allBookingsDatabaseControllerProvider)
                          .deleteBooking(bookingId: booking.id.toString());
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('$booking deleted')));
                    },
                    background: Container(
                      color: Colors.red,
                    ),

                  );
                  // ProviderScope(
                  //   overrides: [currentBooking.overrideWithValue(booking)],
                  //   child: const BookingTile(),
                  // );
                })
                : Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(
                'No Bookings Created',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }
        });
  }
}

class BookingTile extends HookWidget {
  const BookingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = useProvider(currentBooking);
    return Dismissible(
      key: UniqueKey(), //Key(item.id!),
      onDismissed: (direction) {
        context
            .read(allBookingsDatabaseControllerProvider)
            .deleteBooking(bookingId: item.id.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$item deleted')));
      },
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.lime, width: 5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: ListTile(
          key: ValueKey(item.id),
          title: new Row(
            children: [
              Text(
                'Date (yyyy-mm-dd): ',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                item.startDate.year.toString() +
                    '-' +
                    item.startDate.month.toString() +
                    '-' +
                    item.startDate.day.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Row(
              children: [
                Text(
                  'Time (hrs:min)  ',
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  item.startTimeHrs.toString() +
                      ':' +
                      item.startTimeMins.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          //onTap: () => AddItemDialog.show(context, item),//TODO:on Tap edit the pendingbooking
          onLongPress: () => context //TODO:
              .read(allBookingsDatabaseControllerProvider)
              .updateBooking(
              updatedBooking:
              item.copyWith(isCompleted: !item.isCompleted)),
        ),
      ),
    );
  }
}

class BookingsListError extends StatelessWidget {
  final String message;
  const BookingsListError({
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
                .read(bookingsControllerProvider)
                .retrieveBookings(isRefreshing: true),
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}

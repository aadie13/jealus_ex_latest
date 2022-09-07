import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/booking_model.dart';

import '../controllers/allBookingsDatabase_controller.dart';
import '../custom_exception.dart';

final currentBooking =
ScopedProvider<Booking>((_) => throw UnimplementedError());

class CompletedBookingsListArchive extends HookWidget {
  const CompletedBookingsListArchive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedBookingsList = useProvider(completedBookingsFromDatabaseListProvider);
    final bookingsListState = useProvider(allBookingsDatabaseControllerProvider.state);
    return bookingsListState.when(
      data: (bookings) => bookings.isEmpty
          ? const Center(
        child: Text(
          'Wait till your first Booking is completed!',
          style: TextStyle(fontSize: 20.0),
        ),
      )
          : ListView.builder(
          itemCount: completedBookingsList.length,
          itemBuilder: (BuildContext context, int index) {
            final booking = completedBookingsList[index];
            return ProviderScope(
              overrides: [currentBooking.overrideWithValue(booking)],
              child: const BookingTile(),
            );
          }),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => BookingsListError(
        message:
        error is CustomException ? error.message! : 'Something went wrong!',
      ),
    );
  }
}

class BookingTile extends HookWidget {
  const BookingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = useProvider(currentBooking);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green, width: 5),
        borderRadius: BorderRadius.circular(2),
      ),
      child: ListTile(
        key: ValueKey(item.id),
        title:
        new Row(
          children: [
            Text(
              'Date (yyyy-mm-dd): ',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            Text(
              item.startDate.year.toString() + '-' +  item.startDate.month.toString() + '-' + item.startDate.day.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Row(
            children: [
              Text(
                'Time (hrs:min)  ' ,
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                item.startTimeHrs.toString() + ':' +  item.startTimeMins.toString() ,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        //TODO: on tap view the booking
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

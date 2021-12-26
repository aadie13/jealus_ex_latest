import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:date_format/date_format.dart';

import '../custom_exception.dart';

final currentBooking =
    ScopedProvider<Booking>((_) => throw UnimplementedError());

class IncompleteBookingsList extends HookWidget {
  const IncompleteBookingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pendingBookingsList = useProvider(pendingBookingsListProvider);
    final bookingsListState = useProvider(bookingsControllerProvider.state);
    return bookingsListState.when(
      data: (bookings) => bookings.isEmpty
          ? const Center(
              child: Text(
                'No Bookings Created',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              itemCount: pendingBookingsList.length,
              itemBuilder: (BuildContext context, int index) {
                final booking = pendingBookingsList[index];
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
    return Dismissible(
      key: Key(item.id!),
      onDismissed: (direction) {
        context
            .read(bookingsControllerProvider)
            .deleteBooking(bookingId: item.id.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$item deleted')));
      },
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        child: ListTile(
          key: ValueKey(item.id),
          title: Text(
            item.startDate.toString() + item.startTimeHrs.toString(),
            style: TextStyle(fontSize: 18),
          ),

          // trailing: Checkbox(
          //   value: item.obtained,
          //   onChanged: (val) => context
          //       .read(itemListControllerProvider)
          //       .updateItem(
          //       updatedItem:
          //       item.copyWith(obtained: !item.obtained)),
          // ),
          //onTap: () => AddItemDialog.show(context, item),//TODO:on Tap edit the pendingbooking
          onLongPress: () => context
              .read(bookingsControllerProvider)
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

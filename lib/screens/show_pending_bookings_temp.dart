import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/booking_controller.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:date_format/date_format.dart';

import '../controllers/allBookingsDatabase_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/bids_controller.dart';
import '../custom_exception.dart';
import '../models/bid_model.dart';
import '../repositories/bids_repository.dart';

final currentBooking =
ScopedProvider<Booking>((_) => throw UnimplementedError());

class PendingBookingsList extends HookWidget {
  const PendingBookingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pendingBookingsList = useState([]);
    final _pendingBookingsListLoaded = useState(false);
    final _pendingBookingsListHasData = useState(false);
    final _bookingIDtoFetchTheBIDS = useState('');

    final _bidsListForBooking = useState([]);
    final _bidsListForBookingLoaded = useState(false);
    final _bidsListForBookingHasData = useState(false);

    final authControllerState = useProvider(authControllerProvider.state);
    String? _uid = authControllerState?.uid ?? null;
    final _bookingSelectedToShowBids = useState(false);
    final _selectedTileIndex = useState(0);
    // if(_selectedTileIndex.value == 0){
    //
    // }


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

        if(!(_bookingIDtoFetchTheBIDS == '')){
          final bidsListOnBooking = await useProvider(bidsRepositoryProvider).retrieveAllBidsOnABooking(bookingID: _bookingIDtoFetchTheBIDS.value);
          if(bidsListOnBooking.isNotEmpty){
            _bidsListForBooking.value = bidsListOnBooking;
            if (!(_bidsListForBooking.value.length == 0)) {
              _bidsListForBookingHasData.value = true;
            }
            _bidsListForBookingLoaded.value = true;
          }
        }
      }
    }

    return FutureBuilder(
        future: collectData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(

            body: SafeArea(
              child: Column(
                children: [
                  //Start creating and displaying list of bookings that this mechanic has not placed a bid on
                  //essentially all elements of the list _bookingsWithinRadiusAndMechanicIDNotEqualToUserID
                  SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
                      child: Stack(
                        children: <Widget>[
                          _pendingBookingsListHasData.value ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 1),
                            ),
                            child: _pendingBookingsListLoaded.value ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                //shrinkWrap: true,
                                itemCount:
                                _pendingBookingsList
                                    .value.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  Booking booking =
                                  _pendingBookingsList
                                      .value[index];
                                  return Dismissible(key: UniqueKey(), //Key(item.id!),// ,
                                    child: Card(
                                      //color: _bookingSelectedToShowBids.value ? Colors.white54 : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.lime, width: 5),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: ListTile(
                                        selected: index == _selectedTileIndex.value,
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
                                        //selectedTileColor: Colors.grey,//_bookingSelectedToShowBids.value ? Colors.grey : Colors.white,
                                        onTap: () {
                                          _bookingIDtoFetchTheBIDS.value = booking.id!;
                                          _bookingSelectedToShowBids.value = true;
                                          _selectedTileIndex.value = index;
                                        } ,//AddItemDialog.show(context, item),//TODO:on Tap edit the pendingbooking
                                        // onLongPress: () => context //TODO:
                                        //     .read(allBookingsDatabaseControllerProvider)
                                        //     .updateBooking(
                                        //     updatedBooking:
                                        //     booking.copyWith(isCompleted: !booking.isCompleted)),
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      context
                                          .read(allBookingsDatabaseControllerProvider)
                                          .deleteBooking(bookingId: booking.id.toString());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('$booking deleted')));
                                    },

                                  );
                                }): CircularProgressIndicator(),
                          ) : Center(
                            child: Text('Create a Booking'),
                          ),
                          Positioned(
                            left: 30,
                            top: -10,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 0,top: 5, left: 10, right: 10),
                              color: Colors.white,
                              child: const Text(
                                'Pending Bookings',
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //Start creating and displaying list of bookings that this mechanic has placed a bid on
                  //essentially all elements of the list _bookingsWithinRadiusAndMechanicIDEqualToUserID
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
                      child: Stack(
                        children: <Widget>[
                          _bidsListForBookingHasData.value ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 1),
                            ),
                            child: _bidsListForBookingLoaded.value ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                //shrinkWrap: true,
                                itemCount:
                                _bidsListForBooking
                                    .value.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  Bid bid =
                                  _bidsListForBooking
                                      .value[index];
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ListTile(
                                          title: Text(bid.bidAmount.toString()),
                                          //Text(_bookingsWithinRadiusList.value[index].data["userID"]),
                                          subtitle: Row(
                                            children: [
                                              Text(bid.mechanicID
                                                  .toString()), //Text(_bookingsWithinRadiusList.value[index].data["latitude"]),
                                              Spacer(),
                                              Text(bid.bookingID
                                                  .toString()), //_bookingsWithinRadiusList.value[index].data["longitude"]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }):CircularProgressIndicator(),
                          ): Center(
                            child: _bookingSelectedToShowBids.value ? Text('No bids yet placed on this booking.') : Text('Select a Booking to show bids.'),
                          ),
                          Positioned(
                            left: 30,
                            top: -10,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 0,top: 5, left: 10, right: 10),
                              color: Colors.white,
                              child: const Text(
                                'Bids',
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
          );
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

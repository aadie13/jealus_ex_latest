import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/controllers/user_bookings_service_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/repositories/allBookingsDatabase_repository.dart';
import 'package:jealus_ex/repositories/booking_repository.dart';

enum allBookingsDatabaseListFilter {
  all,
  pending,
  completed,
}

final allBookingsDatabaseListFilterProvider =
    StateProvider<allBookingsDatabaseListFilter>(
        (_) => allBookingsDatabaseListFilter.all);

final completedBookingsFromDatabaseListProvider =
    Provider<List<Booking>>((ref) {
  final bookingsListFilterState =
      ref.watch(allBookingsDatabaseListFilterProvider).state;
  final bookingsListFromDatabaseState =
      ref.watch(allBookingsDatabaseControllerProvider.state);
  return bookingsListFromDatabaseState.maybeWhen(
      data: (bookings) {
        return bookings.where((booking) => booking.isCompleted).toList();
        // switch (vehicleListFilterState) {
        //   case VehicleListFilter.selected:
        //     return vehicles.where((vehicle) => vehicle.isBooked).toList();
        //   default:
        //     return vehicles;
        // }
      },
      orElse: () => []);
});

final pendingBookingsFromDatabaseListProvider = Provider<List<Booking>>((ref) {
  final bookingsFromDatabaseListFilterState =
      ref.watch(allBookingsDatabaseListFilterProvider).state;
  final bookingsFromDatabaseListState =
      ref.watch(allBookingsDatabaseControllerProvider.state);
  return bookingsFromDatabaseListState.maybeWhen(
      data: (bookings) {
        return bookings.where((booking) => !booking.isCompleted).toList();
        // switch (vehicleListFilterState) {
        //   case VehicleListFilter.selected:
        //     return vehicles.where((vehicle) => vehicle.isBooked).toList();
        //   default:
        //     return vehicles;
        // }
      },
      orElse: () => []);
});

final allBookingsDatabaseExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final allBookingsDatabaseControllerProvider =
    StateNotifierProvider<AllBookingsDatabaseController>(
  (ref) {
    final user = ref.watch(authControllerProvider.state);
    return AllBookingsDatabaseController(ref.read, user?.uid);
  },
);

class AllBookingsDatabaseController
    extends StateNotifier<AsyncValue<List<Booking>>> {
  final Reader _read;
  final String? _userId;

  AllBookingsDatabaseController(this._read, this._userId)
      : super(AsyncValue.loading()) {
    retrieveBookings();
  }

  Future<void> retrieveBookings({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final bookings =
          await _read(allBookingsDatabaseRepositoryProvider).retrieveBookings();
      if (mounted) {
        state = AsyncValue.data(bookings);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addBooking({
    //should be the mechanic user
    required Booking booking,
    required String bookingID,
  }) async {
    //required List<Vehicle> vehicles,}) async{
    try {
      // vehicles: vehicles, );
      await _read(allBookingsDatabaseRepositoryProvider)
          .createBooking(booking: booking, bookingID: bookingID);
      state.whenData((bookings) => state =
          AsyncValue.data(bookings..add(booking.copyWith(id: bookingID))));
    } on CustomException catch (e, st) {
      _read(allBookingsDatabaseExceptionProvider).state = e;
    }
  }

  Future<void> updateBooking({required Booking updatedBooking}) async {
    try {
      await _read(allBookingsDatabaseRepositoryProvider)
          .updateBooking(booking: updatedBooking);
      state.whenData((bookings) {
        state = AsyncValue.data([
          for (final booking in bookings)
            if (booking.id == updatedBooking.id) updatedBooking else booking
        ]);
      });
    } on CustomException catch (e) {
      _read(allBookingsDatabaseExceptionProvider).state = e;
    }
  }

  Future<void> deleteBooking({required String bookingId}) async {
    try {
      await _read(allBookingsDatabaseRepositoryProvider)
          .deleteBooking(bookingId: bookingId);
      state.whenData((bookings) => state = AsyncValue.data(
          bookings..removeWhere((element) => element.id == bookingId)));
    } on CustomException catch (e) {
      _read(allBookingsDatabaseExceptionProvider).state = e;
    }
  }
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/controllers/user_bookings_service_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/repositories/booking_repository.dart';
import 'package:jealus_ex/controllers/allBookingsDatabase_controller.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

enum BookingsListFilter {
  all,
  pending,
  completed,
}

final bookingsListFilterProvider =
    StateProvider<BookingsListFilter>((_) => BookingsListFilter.all);

final completedBookingsListProvider = Provider<List<Booking>>((ref) {
  final bookingsListFilterState = ref.watch(bookingsListFilterProvider).state;
  final bookingsListState = ref.watch(bookingsControllerProvider.state);
  return bookingsListState.maybeWhen(
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

final pendingBookingsListProvider = Provider<List<Booking>>((ref) {
  final bookingsListFilterState = ref.watch(bookingsListFilterProvider).state;
  final bookingsListState = ref.watch(bookingsControllerProvider.state);
  return bookingsListState.maybeWhen(
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

final bookingsExceptionProvider = StateProvider<CustomException?>((_) => null);

final bookingsControllerProvider = StateNotifierProvider<BookingsController>(
  (ref) {
    final user = ref.watch(authControllerProvider.state);
    return BookingsController(ref.read, user?.uid);
  },
);

class BookingsController extends StateNotifier<AsyncValue<List<Booking>>> {
  final Reader _read;
  final String? _userId;

  BookingsController(this._read, this._userId) : super(AsyncValue.loading()) {
    retrieveBookings();
  }

  Future<void> retrieveBookings({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final bookings = await _read(bookingsRepositoryProvider)
          .retrieveBookings(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(bookings);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addBooking({
    //should be the mechanic user
    required DateTime startDate,
    required int startTimeHrs,
    required int startTimeMins,
    required int serviceIndex,
    required double latitude,
    required double longitude,
    String? typseSpecific,
    int? numberOfTires2Swap,
    int? numberofTires2Store,
    String? detailingPackage,
    required Service service
  }) async {
    //required List<Vehicle> vehicles,}) async{
    try {
      final geo = Geoflutterfire();
      GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);
      final booking = Booking(
          startDate: startDate,
          startTimeHrs: startTimeHrs,
          startTimeMins: startTimeMins,
          mechanicID: '',
          bidID: '',
          userID: _userId!, center: center);//, center: center); // vehicles: vehicles, );

      final usersBookingsService =
          await _read(usersBookingServiceControllerProvider);
      final allBookingsDatabase =
      await _read(allBookingsDatabaseControllerProvider);
      print("before the foor loop");
      Service service = Service(serviceName: servicesList[serviceIndex].serviceName,
          serviceDurationMins: servicesList[serviceIndex].serviceDurationMins,
      serviceCost: servicesList[serviceIndex].serviceCost,
      numberOfTires2Swap: numberOfTires2Swap,
        numberofTires2Store: numberofTires2Store,typeSpecific: typseSpecific, detailingPackage: detailingPackage );
      final bookingID = await _read(bookingsRepositoryProvider)
          .createBooking(userId: _userId!, booking: booking, service: service);
      usersBookingsService.addService(service: service, bookingID: bookingID);
      //allBookingsDatabase.addBooking(booking: booking, bookingID: bookingID);
      state.whenData((bookings) => state =
          AsyncValue.data(bookings..add(booking.copyWith(id: bookingID))));
    } on CustomException catch (e, st) {
      _read(bookingsExceptionProvider).state = e;
    }
  }

  Future<void> updateBooking({required Booking updatedBooking}) async {
    try {
      await _read(bookingsRepositoryProvider)
          .updateBooking(userId: _userId!, booking: updatedBooking);
      state.whenData((bookings) {
        state = AsyncValue.data([
          for (final booking in bookings)
            if (booking.id == updatedBooking.id) updatedBooking else booking
        ]);
      });
    } on CustomException catch (e) {
      _read(bookingsExceptionProvider).state = e;
    }
  }

  Future<void> deleteBooking({required String bookingId}) async {
    try {
      await _read(bookingsRepositoryProvider)
          .deleteBooking(userId: _userId!, bookingId: bookingId);
      state.whenData((bookings) => state = AsyncValue.data(
          bookings..removeWhere((element) => element.id == bookingId)));
    } on CustomException catch (e) {
      _read(bookingsExceptionProvider).state = e;
    }
  }
}

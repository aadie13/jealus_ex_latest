import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/service_model.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/models/booking_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/models/vehicle_model.dart';
import 'package:jealus_ex/repositories/user_profile_repository.dart';
import 'package:jealus_ex/repositories/booking_repository.dart';

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

  BookingsController(this._read,this._userId):super(AsyncValue.loading()){
    retrieveBookings();

  }

  Future<void> retrieveBookings({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final bookings = await _read(bookingsRepositoryProvider).retrieveBookings(userId: _userId!);
      if (mounted){
        state = AsyncValue.data(bookings);
      }
    } on CustomException catch(e, st){
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addBooking({required UserProfile serviceProvider, //should be the mechanic user
    required DateTime startDate,
    required int startTimeHrs,
    required int startTimeMins,
    required Service service,
    required List<Vehicle> vehicles,}) async{
    try {
      final booking = Booking(serviceProvider: serviceProvider, startDate: startDate, startTimeHrs: startTimeHrs, startTimeMins: startTimeMins, service: service, vehicles: vehicles, );
      final bookingID = await _read(bookingsRepositoryProvider).createBooking(userId: _userId!, booking: booking);
      state.whenData((bookings) =>
      state = AsyncValue.data(bookings..add(booking.copyWith(id: bookingID)))
      );
    } on CustomException catch(e, st){
      _read(bookingsExceptionProvider).state = e;
    }
  }

  Future<void> updateBooking({required Booking updatedBooking}) async {
    try {
      await _read(bookingsRepositoryProvider).updateBooking(userId: _userId!, booking: updatedBooking);
      state.whenData((bookings) {
        state = AsyncValue.data([
          for (final booking in bookings)
            if (booking.id == updatedBooking.id) updatedBooking else booking
        ]);
      });
    } on CustomException catch (e){
      _read(bookingsExceptionProvider).state = e;
    }
  }

  Future<void> deleteBooking({required String bookingId}) async {
    try {
      await _read(bookingsRepositoryProvider).deleteBooking(userId: _userId!, bookingId: bookingId);
      state.whenData((bookings) =>
      state = AsyncValue.data(bookings..removeWhere((element) => element.id == bookingId))
      );
    } on CustomException catch (e){
      _read(bookingsExceptionProvider).state = e;
    }
  }
}
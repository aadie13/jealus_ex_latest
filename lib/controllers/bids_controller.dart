import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/bid_model.dart';
import 'package:jealus_ex/repositories/bids_repository.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../general_providers.dart';

enum BidsListFilter {
  all,
  selected,
}

final bidsListFilterProvider =
StateProvider<BidsListFilter>((_) => BidsListFilter.all);

final pendingBidsProviderOfMechanic = Provider<List<Bid>>((ref) {
  // final addressListFilterState = ref.watch(vehicleListFilterProvider).state;
  final bidsListState = ref.watch(bidsControllerProvider.state);
  return bidsListState.maybeWhen(
      data: (bids) {
        return bids.where((bid) => !bid.isAccepted).toList();
      },
      orElse: () => []);
});



final bidsExceptionProvider = StateProvider<CustomException?>((_) => null);

final bidsControllerProvider = StateNotifierProvider<BidsController>(
      (ref) {
    final user = ref.watch(authControllerProvider.state);
    return BidsController(ref.read, user?.uid);
  },
);

class BidsController extends StateNotifier<AsyncValue<List<Bid>>> {
  final Reader _read;
  final String? _userId;

  BidsController(this._read, this._userId) : super(AsyncValue.loading()) {
    // if (_userId != null) {
    //   retrieveAllBidsMadeByThisMechanic();
    // }
  }

  Future<void> retrieveAllBidsMadeByThisMechanic({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final bid = await _read(bidsRepositoryProvider).retrieveAllBidsMadeByThisMechanic(mechanicID: _userId!);
      if (mounted) {
        state = AsyncValue.data(bid);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> retrieveAllBidsOnABooking({bool isRefreshing = false, required String bookingID}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final bid = await _read(bidsRepositoryProvider).retrieveAllBidsOnABooking(bookingID: bookingID);
      if (mounted) {
        state = AsyncValue.data(bid);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }


  Future<void> addBid(
      {required String bookingID,
        required String mechanicID,
        required double bidAmount}) async {
    try {
      final bid = Bid(bookingID: bookingID, mechanicID: mechanicID, bidAmount: bidAmount);
      final bidID = await _read(bidsRepositoryProvider).createBid(bid: bid);
      state.whenData((bids) => state =
          AsyncValue.data(bids..add(bid.copyWith(id: bidID))));
    } on CustomException catch (e, st) {
      _read(bidsExceptionProvider).state = e;
    }
  }

  Future<void> updateBid({required Bid updatedBid}) async {
    try {
      await _read(bidsRepositoryProvider).updateBid(bid: updatedBid);
      state.whenData((bids) {
        state = AsyncValue.data([
          for (final bid in bids)
            if (bid.id == updatedBid.id) updatedBid else bid
        ]);
      });
    } on CustomException catch (e) {
      _read(bidsExceptionProvider).state = e;
    }
  }

  Future<void> deleteBid({required String bidID, required String bookingID}) async {
    try {
      await _read(bidsRepositoryProvider).deleteBid(bidID: bidID, bookingID: bookingID);
      state.whenData((bids) => state = AsyncValue.data(
          bids..removeWhere((bid) => bid.id == bidID)));
    } on CustomException catch (e) {
      _read(bidsExceptionProvider).state = e;
    }
  }
}

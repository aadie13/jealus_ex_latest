import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/models/bid_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/extensions/firebase_firestore_extension.dart';
import '../general_providers.dart';



abstract class BaseBidsRepository {

  Future<String> createBid({required Bid bid});//Create a Bid and add to the "Bids" Collection of that booking as well as to AllBidsDatabase
  Future<void> updateBid({required Bid bid});//required String bidID, required Bid bid});//update the big in AllBidsDatabase and in the bookings "Bids" collection -> need bidID and updated Bid
  Future<List<Bid>> retrieveAllBidsOnABooking({required String bookingID}); // add all the bids to a booking as a new collectoin
  Future<List<Bid>> retrieveAllBidsMadeByThisMechanic({required String mechanicID}); // retrieve all the bids made by this mechanic from allBidsDatabase
  Future<void> deleteBid({required String bidID, required String bookingID});//Delete in AllBidsDatabase and from the "bids" list of that booking

}

final bidsRepositoryProvider =
Provider<BidsRepository>((ref) => BidsRepository(ref.read));

class BidsRepository implements BaseBidsRepository{
  final Reader _read;
  const BidsRepository(this._read);

  @override
  Future<String> createBid({required Bid bid}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .bidsForThisBooking(bid.bookingID).add(bid.toDocument()).then((value) async {
        await _read(firebaseFirestoreProvider).collection("AllBids").doc(value.id).set(bid.toDocument());//TODO: Test if value.id is actually docRef.id?
      });
      //final docRef2 = await _read(firebaseFirestoreProvider).collection("AllBids").doc(docRef).set(bid.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateBid({ required Bid bid}) async{
    // update the bid in AllBidsDatabase and in the bookings "Bids" collection -> need bidID and updated Bid
    try {
      //update the bid in the "Bids" Collection of the booking
      await _read(firebaseFirestoreProvider)
          .bidsForThisBooking(bid.bookingID)
          .doc(bid.id)
          .update(bid.toDocument()).then((value) async{ //then update the bid in the AllBids database
        await _read(firebaseFirestoreProvider).collection("AllBids").doc(bid.id).update(bid.toDocument());
      });

    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
  @override
  Future<void> deleteBid({required String bidID, required String bookingID}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .bidsForThisBooking(bookingID)
          .doc(bidID)
          .delete().then((value) async{
        await _read(firebaseFirestoreProvider).collection("AllBids").doc(bidID).delete();
      });
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Bid>> retrieveAllBidsOnABooking({required String bookingID}) async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .bidsForThisBooking(bookingID)
          .get();
      return snap.docs.map((doc) => Bid.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Bid>> retrieveAllBidsMadeByThisMechanic({required String mechanicID}) async{
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection("AllBids").where("mechanicID", isEqualTo: mechanicID)
          .get();
      return snap.docs.map((doc) => Bid.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

}





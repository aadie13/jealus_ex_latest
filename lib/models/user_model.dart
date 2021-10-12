import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
//************************************************************//
part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
abstract class UserProfile implements _$UserProfile {
  const UserProfile._(); //private constructor put in to change with to implements.

  const factory UserProfile({
    String? id,
    required String name,
    required String phone,
    //required String residenceType,
    //TODO: implement address to be able to track location
    //required List<Booking> booking,
    @Default(false) bool isBeautician,
  }) = _UserProfile;

  // factory UserProfile.empty() => UserProfile(name: '', phone: '',
  //     residenceType: '', vehicleMake: '', vehicleModel: '',
  //     vehicleYear: '', null);

  factory UserProfile.fromJson(Map<String, dynamic> data) =>
      _$UserProfileFromJson(data);

  factory UserProfile.fromDocument(DocumentSnapshot doc){
    final data = doc.data()!;
    return UserProfile.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
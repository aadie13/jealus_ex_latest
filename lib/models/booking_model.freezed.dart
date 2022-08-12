// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
class _$BookingTearOff {
  const _$BookingTearOff();

  _Booking call(
      {String? id,
      required String userID,
      String? mechanicID,
      String? bidID,
      required DateTime startDate,
      double? latitude,
      double? longitude,
      required int startTimeHrs,
      required int startTimeMins,
      required GeoFirePoint center,
      bool isCompleted = false,
      bool isAccepted = false}) {
    return _Booking(
      id: id,
      userID: userID,
      mechanicID: mechanicID,
      bidID: bidID,
      startDate: startDate,
      latitude: latitude,
      longitude: longitude,
      startTimeHrs: startTimeHrs,
      startTimeMins: startTimeMins,
      center: center,
      isCompleted: isCompleted,
      isAccepted: isAccepted,
    );
  }

  Booking fromJson(Map<String, Object> json) {
    return Booking.fromJson(json);
  }
}

/// @nodoc
const $Booking = _$BookingTearOff();

/// @nodoc
mixin _$Booking {
  String? get id =>
      throw _privateConstructorUsedError; //should be the user id of the customer
//required UserProfile serviceProvider, //should be the mechanic user
//TODO: add service provider to the booking
  String get userID => throw _privateConstructorUsedError;
  String? get mechanicID => throw _privateConstructorUsedError;
  String? get bidID => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  int get startTimeHrs => throw _privateConstructorUsedError;
  int get startTimeMins => throw _privateConstructorUsedError;
  GeoFirePoint get center =>
      throw _privateConstructorUsedError; //required Service service,//TODO: NOTE - this app allows one service per booking
//TODO: add service to the booking
//required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
  bool get isCompleted =>
      throw _privateConstructorUsedError; //is the job done? If so what are the reviews? TODO: add review setup in the app
  bool get isAccepted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String userID,
      String? mechanicID,
      String? bidID,
      DateTime startDate,
      double? latitude,
      double? longitude,
      int startTimeHrs,
      int startTimeMins,
      GeoFirePoint center,
      bool isCompleted,
      bool isAccepted});
}

/// @nodoc
class _$BookingCopyWithImpl<$Res> implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  final Booking _value;
  // ignore: unused_field
  final $Res Function(Booking) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userID = freezed,
    Object? mechanicID = freezed,
    Object? bidID = freezed,
    Object? startDate = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? startTimeHrs = freezed,
    Object? startTimeMins = freezed,
    Object? center = freezed,
    Object? isCompleted = freezed,
    Object? isAccepted = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userID: userID == freezed
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      mechanicID: mechanicID == freezed
          ? _value.mechanicID
          : mechanicID // ignore: cast_nullable_to_non_nullable
              as String?,
      bidID: bidID == freezed
          ? _value.bidID
          : bidID // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      startTimeHrs: startTimeHrs == freezed
          ? _value.startTimeHrs
          : startTimeHrs // ignore: cast_nullable_to_non_nullable
              as int,
      startTimeMins: startTimeMins == freezed
          ? _value.startTimeMins
          : startTimeMins // ignore: cast_nullable_to_non_nullable
              as int,
      center: center == freezed
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as GeoFirePoint,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isAccepted: isAccepted == freezed
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) then) =
      __$BookingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String userID,
      String? mechanicID,
      String? bidID,
      DateTime startDate,
      double? latitude,
      double? longitude,
      int startTimeHrs,
      int startTimeMins,
      GeoFirePoint center,
      bool isCompleted,
      bool isAccepted});
}

/// @nodoc
class __$BookingCopyWithImpl<$Res> extends _$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(_Booking _value, $Res Function(_Booking) _then)
      : super(_value, (v) => _then(v as _Booking));

  @override
  _Booking get _value => super._value as _Booking;

  @override
  $Res call({
    Object? id = freezed,
    Object? userID = freezed,
    Object? mechanicID = freezed,
    Object? bidID = freezed,
    Object? startDate = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? startTimeHrs = freezed,
    Object? startTimeMins = freezed,
    Object? center = freezed,
    Object? isCompleted = freezed,
    Object? isAccepted = freezed,
  }) {
    return _then(_Booking(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userID: userID == freezed
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      mechanicID: mechanicID == freezed
          ? _value.mechanicID
          : mechanicID // ignore: cast_nullable_to_non_nullable
              as String?,
      bidID: bidID == freezed
          ? _value.bidID
          : bidID // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      startTimeHrs: startTimeHrs == freezed
          ? _value.startTimeHrs
          : startTimeHrs // ignore: cast_nullable_to_non_nullable
              as int,
      startTimeMins: startTimeMins == freezed
          ? _value.startTimeMins
          : startTimeMins // ignore: cast_nullable_to_non_nullable
              as int,
      center: center == freezed
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as GeoFirePoint,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isAccepted: isAccepted == freezed
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Booking extends _Booking {
  const _$_Booking(
      {this.id,
      required this.userID,
      this.mechanicID,
      this.bidID,
      required this.startDate,
      this.latitude,
      this.longitude,
      required this.startTimeHrs,
      required this.startTimeMins,
      required this.center,
      this.isCompleted = false,
      this.isAccepted = false})
      : super._();

  factory _$_Booking.fromJson(Map<String, dynamic> json) =>
      _$$_BookingFromJson(json);

  @override
  final String? id;
  @override //should be the user id of the customer
//required UserProfile serviceProvider, //should be the mechanic user
//TODO: add service provider to the booking
  final String userID;
  @override
  final String? mechanicID;
  @override
  final String? bidID;
  @override
  final DateTime startDate;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final int startTimeHrs;
  @override
  final int startTimeMins;
  @override
  final GeoFirePoint center;
  @JsonKey(defaultValue: false)
  @override //required Service service,//TODO: NOTE - this app allows one service per booking
//TODO: add service to the booking
//required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
  final bool isCompleted;
  @JsonKey(defaultValue: false)
  @override //is the job done? If so what are the reviews? TODO: add review setup in the app
  final bool isAccepted;

  @override
  String toString() {
    return 'Booking(id: $id, userID: $userID, mechanicID: $mechanicID, bidID: $bidID, startDate: $startDate, latitude: $latitude, longitude: $longitude, startTimeHrs: $startTimeHrs, startTimeMins: $startTimeMins, center: $center, isCompleted: $isCompleted, isAccepted: $isAccepted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Booking &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userID, userID) ||
                const DeepCollectionEquality().equals(other.userID, userID)) &&
            (identical(other.mechanicID, mechanicID) ||
                const DeepCollectionEquality()
                    .equals(other.mechanicID, mechanicID)) &&
            (identical(other.bidID, bidID) ||
                const DeepCollectionEquality().equals(other.bidID, bidID)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)) &&
            (identical(other.startTimeHrs, startTimeHrs) ||
                const DeepCollectionEquality()
                    .equals(other.startTimeHrs, startTimeHrs)) &&
            (identical(other.startTimeMins, startTimeMins) ||
                const DeepCollectionEquality()
                    .equals(other.startTimeMins, startTimeMins)) &&
            (identical(other.center, center) ||
                const DeepCollectionEquality().equals(other.center, center)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)) &&
            (identical(other.isAccepted, isAccepted) ||
                const DeepCollectionEquality()
                    .equals(other.isAccepted, isAccepted)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userID) ^
      const DeepCollectionEquality().hash(mechanicID) ^
      const DeepCollectionEquality().hash(bidID) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude) ^
      const DeepCollectionEquality().hash(startTimeHrs) ^
      const DeepCollectionEquality().hash(startTimeMins) ^
      const DeepCollectionEquality().hash(center) ^
      const DeepCollectionEquality().hash(isCompleted) ^
      const DeepCollectionEquality().hash(isAccepted);

  @JsonKey(ignore: true)
  @override
  _$BookingCopyWith<_Booking> get copyWith =>
      __$BookingCopyWithImpl<_Booking>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookingToJson(this);
  }
}

abstract class _Booking extends Booking {
  const factory _Booking(
      {String? id,
      required String userID,
      String? mechanicID,
      String? bidID,
      required DateTime startDate,
      double? latitude,
      double? longitude,
      required int startTimeHrs,
      required int startTimeMins,
      required GeoFirePoint center,
      bool isCompleted,
      bool isAccepted}) = _$_Booking;
  const _Booking._() : super._();

  factory _Booking.fromJson(Map<String, dynamic> json) = _$_Booking.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override //should be the user id of the customer
//required UserProfile serviceProvider, //should be the mechanic user
//TODO: add service provider to the booking
  String get userID => throw _privateConstructorUsedError;
  @override
  String? get mechanicID => throw _privateConstructorUsedError;
  @override
  String? get bidID => throw _privateConstructorUsedError;
  @override
  DateTime get startDate => throw _privateConstructorUsedError;
  @override
  double? get latitude => throw _privateConstructorUsedError;
  @override
  double? get longitude => throw _privateConstructorUsedError;
  @override
  int get startTimeHrs => throw _privateConstructorUsedError;
  @override
  int get startTimeMins => throw _privateConstructorUsedError;
  @override
  GeoFirePoint get center => throw _privateConstructorUsedError;
  @override //required Service service,//TODO: NOTE - this app allows one service per booking
//TODO: add service to the booking
//required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
  bool get isCompleted => throw _privateConstructorUsedError;
  @override //is the job done? If so what are the reviews? TODO: add review setup in the app
  bool get isAccepted => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BookingCopyWith<_Booking> get copyWith =>
      throw _privateConstructorUsedError;
}

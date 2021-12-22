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
      required DateTime startDate,
      required int startTimeHrs,
      required int startTimeMins,
      bool isCompleted = false}) {
    return _Booking(
      id: id,
      startDate: startDate,
      startTimeHrs: startTimeHrs,
      startTimeMins: startTimeMins,
      isCompleted: isCompleted,
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
  DateTime get startDate => throw _privateConstructorUsedError;
  int get startTimeHrs => throw _privateConstructorUsedError;
  int get startTimeMins =>
      throw _privateConstructorUsedError; //required Service service,//TODO: NOTE - this app allows one service per booking
//TODO: add service to the booking
//required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
  bool get isCompleted => throw _privateConstructorUsedError;

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
      DateTime startDate,
      int startTimeHrs,
      int startTimeMins,
      bool isCompleted});
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
    Object? startDate = freezed,
    Object? startTimeHrs = freezed,
    Object? startTimeMins = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTimeHrs: startTimeHrs == freezed
          ? _value.startTimeHrs
          : startTimeHrs // ignore: cast_nullable_to_non_nullable
              as int,
      startTimeMins: startTimeMins == freezed
          ? _value.startTimeMins
          : startTimeMins // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
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
      DateTime startDate,
      int startTimeHrs,
      int startTimeMins,
      bool isCompleted});
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
    Object? startDate = freezed,
    Object? startTimeHrs = freezed,
    Object? startTimeMins = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_Booking(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTimeHrs: startTimeHrs == freezed
          ? _value.startTimeHrs
          : startTimeHrs // ignore: cast_nullable_to_non_nullable
              as int,
      startTimeMins: startTimeMins == freezed
          ? _value.startTimeMins
          : startTimeMins // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Booking extends _Booking {
  const _$_Booking(
      {this.id,
      required this.startDate,
      required this.startTimeHrs,
      required this.startTimeMins,
      this.isCompleted = false})
      : super._();

  factory _$_Booking.fromJson(Map<String, dynamic> json) =>
      _$_$_BookingFromJson(json);

  @override
  final String? id;
  @override //should be the user id of the customer
//required UserProfile serviceProvider, //should be the mechanic user
//TODO: add service provider to the booking
  final DateTime startDate;
  @override
  final int startTimeHrs;
  @override
  final int startTimeMins;
  @JsonKey(defaultValue: false)
  @override //required Service service,//TODO: NOTE - this app allows one service per booking
//TODO: add service to the booking
//required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
  final bool isCompleted;

  @override
  String toString() {
    return 'Booking(id: $id, startDate: $startDate, startTimeHrs: $startTimeHrs, startTimeMins: $startTimeMins, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Booking &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.startTimeHrs, startTimeHrs) ||
                const DeepCollectionEquality()
                    .equals(other.startTimeHrs, startTimeHrs)) &&
            (identical(other.startTimeMins, startTimeMins) ||
                const DeepCollectionEquality()
                    .equals(other.startTimeMins, startTimeMins)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(startTimeHrs) ^
      const DeepCollectionEquality().hash(startTimeMins) ^
      const DeepCollectionEquality().hash(isCompleted);

  @JsonKey(ignore: true)
  @override
  _$BookingCopyWith<_Booking> get copyWith =>
      __$BookingCopyWithImpl<_Booking>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BookingToJson(this);
  }
}

abstract class _Booking extends Booking {
  const factory _Booking(
      {String? id,
      required DateTime startDate,
      required int startTimeHrs,
      required int startTimeMins,
      bool isCompleted}) = _$_Booking;
  const _Booking._() : super._();

  factory _Booking.fromJson(Map<String, dynamic> json) = _$_Booking.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override //should be the user id of the customer
//required UserProfile serviceProvider, //should be the mechanic user
//TODO: add service provider to the booking
  DateTime get startDate => throw _privateConstructorUsedError;
  @override
  int get startTimeHrs => throw _privateConstructorUsedError;
  @override
  int get startTimeMins => throw _privateConstructorUsedError;
  @override //required Service service,//TODO: NOTE - this app allows one service per booking
//TODO: add service to the booking
//required List<Vehicle> vehicles,//TODO: NOTE- this app allows multiple vehicles per booking
  bool get isCompleted => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BookingCopyWith<_Booking> get copyWith =>
      throw _privateConstructorUsedError;
}

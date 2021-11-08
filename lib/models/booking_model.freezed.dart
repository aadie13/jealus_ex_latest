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
      required UserProfile serviceProvider,
      required DateTime startDate,
      required int startTimeHrs,
      required int startTimeMins,
      required Service service,
      required List<Vehicle> vehicles,
      bool isCompleted = false}) {
    return _Booking(
      id: id,
      serviceProvider: serviceProvider,
      startDate: startDate,
      startTimeHrs: startTimeHrs,
      startTimeMins: startTimeMins,
      service: service,
      vehicles: vehicles,
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
  UserProfile get serviceProvider =>
      throw _privateConstructorUsedError; //should be the mechanic user
  DateTime get startDate => throw _privateConstructorUsedError;
  int get startTimeHrs => throw _privateConstructorUsedError;
  int get startTimeMins => throw _privateConstructorUsedError;
  Service get service =>
      throw _privateConstructorUsedError; //TODO: NOTE - this app allows one service per booking
  List<Vehicle> get vehicles =>
      throw _privateConstructorUsedError; //TODO: NOTE- this app allows multiple vehicles per booking
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
      UserProfile serviceProvider,
      DateTime startDate,
      int startTimeHrs,
      int startTimeMins,
      Service service,
      List<Vehicle> vehicles,
      bool isCompleted});

  $UserProfileCopyWith<$Res> get serviceProvider;
  $ServiceCopyWith<$Res> get service;
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
    Object? serviceProvider = freezed,
    Object? startDate = freezed,
    Object? startTimeHrs = freezed,
    Object? startTimeMins = freezed,
    Object? service = freezed,
    Object? vehicles = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceProvider: serviceProvider == freezed
          ? _value.serviceProvider
          : serviceProvider // ignore: cast_nullable_to_non_nullable
              as UserProfile,
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
      service: service == freezed
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as Service,
      vehicles: vehicles == freezed
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $UserProfileCopyWith<$Res> get serviceProvider {
    return $UserProfileCopyWith<$Res>(_value.serviceProvider, (value) {
      return _then(_value.copyWith(serviceProvider: value));
    });
  }

  @override
  $ServiceCopyWith<$Res> get service {
    return $ServiceCopyWith<$Res>(_value.service, (value) {
      return _then(_value.copyWith(service: value));
    });
  }
}

/// @nodoc
abstract class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) then) =
      __$BookingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      UserProfile serviceProvider,
      DateTime startDate,
      int startTimeHrs,
      int startTimeMins,
      Service service,
      List<Vehicle> vehicles,
      bool isCompleted});

  @override
  $UserProfileCopyWith<$Res> get serviceProvider;
  @override
  $ServiceCopyWith<$Res> get service;
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
    Object? serviceProvider = freezed,
    Object? startDate = freezed,
    Object? startTimeHrs = freezed,
    Object? startTimeMins = freezed,
    Object? service = freezed,
    Object? vehicles = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_Booking(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceProvider: serviceProvider == freezed
          ? _value.serviceProvider
          : serviceProvider // ignore: cast_nullable_to_non_nullable
              as UserProfile,
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
      service: service == freezed
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as Service,
      vehicles: vehicles == freezed
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
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
      required this.serviceProvider,
      required this.startDate,
      required this.startTimeHrs,
      required this.startTimeMins,
      required this.service,
      required this.vehicles,
      this.isCompleted = false})
      : super._();

  factory _$_Booking.fromJson(Map<String, dynamic> json) =>
      _$_$_BookingFromJson(json);

  @override
  final String? id;
  @override //should be the user id of the customer
  final UserProfile serviceProvider;
  @override //should be the mechanic user
  final DateTime startDate;
  @override
  final int startTimeHrs;
  @override
  final int startTimeMins;
  @override
  final Service service;
  @override //TODO: NOTE - this app allows one service per booking
  final List<Vehicle> vehicles;
  @JsonKey(defaultValue: false)
  @override //TODO: NOTE- this app allows multiple vehicles per booking
  final bool isCompleted;

  @override
  String toString() {
    return 'Booking(id: $id, serviceProvider: $serviceProvider, startDate: $startDate, startTimeHrs: $startTimeHrs, startTimeMins: $startTimeMins, service: $service, vehicles: $vehicles, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Booking &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.serviceProvider, serviceProvider) ||
                const DeepCollectionEquality()
                    .equals(other.serviceProvider, serviceProvider)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.startTimeHrs, startTimeHrs) ||
                const DeepCollectionEquality()
                    .equals(other.startTimeHrs, startTimeHrs)) &&
            (identical(other.startTimeMins, startTimeMins) ||
                const DeepCollectionEquality()
                    .equals(other.startTimeMins, startTimeMins)) &&
            (identical(other.service, service) ||
                const DeepCollectionEquality()
                    .equals(other.service, service)) &&
            (identical(other.vehicles, vehicles) ||
                const DeepCollectionEquality()
                    .equals(other.vehicles, vehicles)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(serviceProvider) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(startTimeHrs) ^
      const DeepCollectionEquality().hash(startTimeMins) ^
      const DeepCollectionEquality().hash(service) ^
      const DeepCollectionEquality().hash(vehicles) ^
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
      required UserProfile serviceProvider,
      required DateTime startDate,
      required int startTimeHrs,
      required int startTimeMins,
      required Service service,
      required List<Vehicle> vehicles,
      bool isCompleted}) = _$_Booking;
  const _Booking._() : super._();

  factory _Booking.fromJson(Map<String, dynamic> json) = _$_Booking.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override //should be the user id of the customer
  UserProfile get serviceProvider => throw _privateConstructorUsedError;
  @override //should be the mechanic user
  DateTime get startDate => throw _privateConstructorUsedError;
  @override
  int get startTimeHrs => throw _privateConstructorUsedError;
  @override
  int get startTimeMins => throw _privateConstructorUsedError;
  @override
  Service get service => throw _privateConstructorUsedError;
  @override //TODO: NOTE - this app allows one service per booking
  List<Vehicle> get vehicles => throw _privateConstructorUsedError;
  @override //TODO: NOTE- this app allows multiple vehicles per booking
  bool get isCompleted => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BookingCopyWith<_Booking> get copyWith =>
      throw _privateConstructorUsedError;
}

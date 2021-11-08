// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'vehicle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return _Vehicle.fromJson(json);
}

/// @nodoc
class _$VehicleTearOff {
  const _$VehicleTearOff();

  _Vehicle call(
      {String? id,
      required String vehicleMake,
      required String vehicleModel,
      required String vehicleYear,
      required String engineSize,
      required String tireSpec,
      bool isBooked = false}) {
    return _Vehicle(
      id: id,
      vehicleMake: vehicleMake,
      vehicleModel: vehicleModel,
      vehicleYear: vehicleYear,
      engineSize: engineSize,
      tireSpec: tireSpec,
      isBooked: isBooked,
    );
  }

  Vehicle fromJson(Map<String, Object> json) {
    return Vehicle.fromJson(json);
  }
}

/// @nodoc
const $Vehicle = _$VehicleTearOff();

/// @nodoc
mixin _$Vehicle {
  String? get id => throw _privateConstructorUsedError;
  String get vehicleMake => throw _privateConstructorUsedError;
  String get vehicleModel => throw _privateConstructorUsedError;
  String get vehicleYear => throw _privateConstructorUsedError;
  String get engineSize => throw _privateConstructorUsedError;
  String get tireSpec => throw _privateConstructorUsedError;
  bool get isBooked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String vehicleMake,
      String vehicleModel,
      String vehicleYear,
      String engineSize,
      String tireSpec,
      bool isBooked});
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res> implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  final Vehicle _value;
  // ignore: unused_field
  final $Res Function(Vehicle) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? vehicleMake = freezed,
    Object? vehicleModel = freezed,
    Object? vehicleYear = freezed,
    Object? engineSize = freezed,
    Object? tireSpec = freezed,
    Object? isBooked = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleMake: vehicleMake == freezed
          ? _value.vehicleMake
          : vehicleMake // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleModel: vehicleModel == freezed
          ? _value.vehicleModel
          : vehicleModel // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleYear: vehicleYear == freezed
          ? _value.vehicleYear
          : vehicleYear // ignore: cast_nullable_to_non_nullable
              as String,
      engineSize: engineSize == freezed
          ? _value.engineSize
          : engineSize // ignore: cast_nullable_to_non_nullable
              as String,
      tireSpec: tireSpec == freezed
          ? _value.tireSpec
          : tireSpec // ignore: cast_nullable_to_non_nullable
              as String,
      isBooked: isBooked == freezed
          ? _value.isBooked
          : isBooked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$VehicleCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$VehicleCopyWith(_Vehicle value, $Res Function(_Vehicle) then) =
      __$VehicleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String vehicleMake,
      String vehicleModel,
      String vehicleYear,
      String engineSize,
      String tireSpec,
      bool isBooked});
}

/// @nodoc
class __$VehicleCopyWithImpl<$Res> extends _$VehicleCopyWithImpl<$Res>
    implements _$VehicleCopyWith<$Res> {
  __$VehicleCopyWithImpl(_Vehicle _value, $Res Function(_Vehicle) _then)
      : super(_value, (v) => _then(v as _Vehicle));

  @override
  _Vehicle get _value => super._value as _Vehicle;

  @override
  $Res call({
    Object? id = freezed,
    Object? vehicleMake = freezed,
    Object? vehicleModel = freezed,
    Object? vehicleYear = freezed,
    Object? engineSize = freezed,
    Object? tireSpec = freezed,
    Object? isBooked = freezed,
  }) {
    return _then(_Vehicle(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleMake: vehicleMake == freezed
          ? _value.vehicleMake
          : vehicleMake // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleModel: vehicleModel == freezed
          ? _value.vehicleModel
          : vehicleModel // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleYear: vehicleYear == freezed
          ? _value.vehicleYear
          : vehicleYear // ignore: cast_nullable_to_non_nullable
              as String,
      engineSize: engineSize == freezed
          ? _value.engineSize
          : engineSize // ignore: cast_nullable_to_non_nullable
              as String,
      tireSpec: tireSpec == freezed
          ? _value.tireSpec
          : tireSpec // ignore: cast_nullable_to_non_nullable
              as String,
      isBooked: isBooked == freezed
          ? _value.isBooked
          : isBooked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Vehicle extends _Vehicle {
  const _$_Vehicle(
      {this.id,
      required this.vehicleMake,
      required this.vehicleModel,
      required this.vehicleYear,
      required this.engineSize,
      required this.tireSpec,
      this.isBooked = false})
      : super._();

  factory _$_Vehicle.fromJson(Map<String, dynamic> json) =>
      _$_$_VehicleFromJson(json);

  @override
  final String? id;
  @override
  final String vehicleMake;
  @override
  final String vehicleModel;
  @override
  final String vehicleYear;
  @override
  final String engineSize;
  @override
  final String tireSpec;
  @JsonKey(defaultValue: false)
  @override
  final bool isBooked;

  @override
  String toString() {
    return 'Vehicle(id: $id, vehicleMake: $vehicleMake, vehicleModel: $vehicleModel, vehicleYear: $vehicleYear, engineSize: $engineSize, tireSpec: $tireSpec, isBooked: $isBooked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Vehicle &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.vehicleMake, vehicleMake) ||
                const DeepCollectionEquality()
                    .equals(other.vehicleMake, vehicleMake)) &&
            (identical(other.vehicleModel, vehicleModel) ||
                const DeepCollectionEquality()
                    .equals(other.vehicleModel, vehicleModel)) &&
            (identical(other.vehicleYear, vehicleYear) ||
                const DeepCollectionEquality()
                    .equals(other.vehicleYear, vehicleYear)) &&
            (identical(other.engineSize, engineSize) ||
                const DeepCollectionEquality()
                    .equals(other.engineSize, engineSize)) &&
            (identical(other.tireSpec, tireSpec) ||
                const DeepCollectionEquality()
                    .equals(other.tireSpec, tireSpec)) &&
            (identical(other.isBooked, isBooked) ||
                const DeepCollectionEquality()
                    .equals(other.isBooked, isBooked)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(vehicleMake) ^
      const DeepCollectionEquality().hash(vehicleModel) ^
      const DeepCollectionEquality().hash(vehicleYear) ^
      const DeepCollectionEquality().hash(engineSize) ^
      const DeepCollectionEquality().hash(tireSpec) ^
      const DeepCollectionEquality().hash(isBooked);

  @JsonKey(ignore: true)
  @override
  _$VehicleCopyWith<_Vehicle> get copyWith =>
      __$VehicleCopyWithImpl<_Vehicle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_VehicleToJson(this);
  }
}

abstract class _Vehicle extends Vehicle {
  const factory _Vehicle(
      {String? id,
      required String vehicleMake,
      required String vehicleModel,
      required String vehicleYear,
      required String engineSize,
      required String tireSpec,
      bool isBooked}) = _$_Vehicle;
  const _Vehicle._() : super._();

  factory _Vehicle.fromJson(Map<String, dynamic> json) = _$_Vehicle.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get vehicleMake => throw _privateConstructorUsedError;
  @override
  String get vehicleModel => throw _privateConstructorUsedError;
  @override
  String get vehicleYear => throw _privateConstructorUsedError;
  @override
  String get engineSize => throw _privateConstructorUsedError;
  @override
  String get tireSpec => throw _privateConstructorUsedError;
  @override
  bool get isBooked => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$VehicleCopyWith<_Vehicle> get copyWith =>
      throw _privateConstructorUsedError;
}

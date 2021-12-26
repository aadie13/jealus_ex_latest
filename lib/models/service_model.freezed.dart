// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return _Service.fromJson(json);
}

/// @nodoc
class _$ServiceTearOff {
  const _$ServiceTearOff();

  _Service call(
      {String? id,
      required String serviceName,
      String? typeSpecific,
      required double serviceCost,
      required double serviceDurationMins,
      int? numberOfTires2Swap,
      int? numberofTires2Store,
      String? detailingPackage,
      bool isCurrent = false}) {
    return _Service(
      id: id,
      serviceName: serviceName,
      typeSpecific: typeSpecific,
      serviceCost: serviceCost,
      serviceDurationMins: serviceDurationMins,
      numberOfTires2Swap: numberOfTires2Swap,
      numberofTires2Store: numberofTires2Store,
      detailingPackage: detailingPackage,
      isCurrent: isCurrent,
    );
  }

  Service fromJson(Map<String, Object> json) {
    return Service.fromJson(json);
  }
}

/// @nodoc
const $Service = _$ServiceTearOff();

/// @nodoc
mixin _$Service {
  String? get id => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String? get typeSpecific =>
      throw _privateConstructorUsedError; //TODO: this is specifically made for oil change {Synthetic, Regular or BYOO. Change it such that it is a ist with the string values which itself will have cost, properties etc
  double get serviceCost => throw _privateConstructorUsedError;
  double get serviceDurationMins =>
      throw _privateConstructorUsedError; //To be used for Tire swapping
// TODO bad practise below. Create Oil CHANGE, TireSwap, etc as separate class so each class can have a particular field like shown below.
  int? get numberOfTires2Swap => throw _privateConstructorUsedError;
  int? get numberofTires2Store => throw _privateConstructorUsedError;
  String? get detailingPackage => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceCopyWith<Service> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCopyWith<$Res> {
  factory $ServiceCopyWith(Service value, $Res Function(Service) then) =
      _$ServiceCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String serviceName,
      String? typeSpecific,
      double serviceCost,
      double serviceDurationMins,
      int? numberOfTires2Swap,
      int? numberofTires2Store,
      String? detailingPackage,
      bool isCurrent});
}

/// @nodoc
class _$ServiceCopyWithImpl<$Res> implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._value, this._then);

  final Service _value;
  // ignore: unused_field
  final $Res Function(Service) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? serviceName = freezed,
    Object? typeSpecific = freezed,
    Object? serviceCost = freezed,
    Object? serviceDurationMins = freezed,
    Object? numberOfTires2Swap = freezed,
    Object? numberofTires2Store = freezed,
    Object? detailingPackage = freezed,
    Object? isCurrent = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: serviceName == freezed
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      typeSpecific: typeSpecific == freezed
          ? _value.typeSpecific
          : typeSpecific // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCost: serviceCost == freezed
          ? _value.serviceCost
          : serviceCost // ignore: cast_nullable_to_non_nullable
              as double,
      serviceDurationMins: serviceDurationMins == freezed
          ? _value.serviceDurationMins
          : serviceDurationMins // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfTires2Swap: numberOfTires2Swap == freezed
          ? _value.numberOfTires2Swap
          : numberOfTires2Swap // ignore: cast_nullable_to_non_nullable
              as int?,
      numberofTires2Store: numberofTires2Store == freezed
          ? _value.numberofTires2Store
          : numberofTires2Store // ignore: cast_nullable_to_non_nullable
              as int?,
      detailingPackage: detailingPackage == freezed
          ? _value.detailingPackage
          : detailingPackage // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: isCurrent == freezed
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ServiceCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$ServiceCopyWith(_Service value, $Res Function(_Service) then) =
      __$ServiceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String serviceName,
      String? typeSpecific,
      double serviceCost,
      double serviceDurationMins,
      int? numberOfTires2Swap,
      int? numberofTires2Store,
      String? detailingPackage,
      bool isCurrent});
}

/// @nodoc
class __$ServiceCopyWithImpl<$Res> extends _$ServiceCopyWithImpl<$Res>
    implements _$ServiceCopyWith<$Res> {
  __$ServiceCopyWithImpl(_Service _value, $Res Function(_Service) _then)
      : super(_value, (v) => _then(v as _Service));

  @override
  _Service get _value => super._value as _Service;

  @override
  $Res call({
    Object? id = freezed,
    Object? serviceName = freezed,
    Object? typeSpecific = freezed,
    Object? serviceCost = freezed,
    Object? serviceDurationMins = freezed,
    Object? numberOfTires2Swap = freezed,
    Object? numberofTires2Store = freezed,
    Object? detailingPackage = freezed,
    Object? isCurrent = freezed,
  }) {
    return _then(_Service(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: serviceName == freezed
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      typeSpecific: typeSpecific == freezed
          ? _value.typeSpecific
          : typeSpecific // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCost: serviceCost == freezed
          ? _value.serviceCost
          : serviceCost // ignore: cast_nullable_to_non_nullable
              as double,
      serviceDurationMins: serviceDurationMins == freezed
          ? _value.serviceDurationMins
          : serviceDurationMins // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfTires2Swap: numberOfTires2Swap == freezed
          ? _value.numberOfTires2Swap
          : numberOfTires2Swap // ignore: cast_nullable_to_non_nullable
              as int?,
      numberofTires2Store: numberofTires2Store == freezed
          ? _value.numberofTires2Store
          : numberofTires2Store // ignore: cast_nullable_to_non_nullable
              as int?,
      detailingPackage: detailingPackage == freezed
          ? _value.detailingPackage
          : detailingPackage // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: isCurrent == freezed
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Service extends _Service {
  const _$_Service(
      {this.id,
      required this.serviceName,
      this.typeSpecific,
      required this.serviceCost,
      required this.serviceDurationMins,
      this.numberOfTires2Swap,
      this.numberofTires2Store,
      this.detailingPackage,
      this.isCurrent = false})
      : super._();

  factory _$_Service.fromJson(Map<String, dynamic> json) =>
      _$_$_ServiceFromJson(json);

  @override
  final String? id;
  @override
  final String serviceName;
  @override
  final String? typeSpecific;
  @override //TODO: this is specifically made for oil change {Synthetic, Regular or BYOO. Change it such that it is a ist with the string values which itself will have cost, properties etc
  final double serviceCost;
  @override
  final double serviceDurationMins;
  @override //To be used for Tire swapping
// TODO bad practise below. Create Oil CHANGE, TireSwap, etc as separate class so each class can have a particular field like shown below.
  final int? numberOfTires2Swap;
  @override
  final int? numberofTires2Store;
  @override
  final String? detailingPackage;
  @JsonKey(defaultValue: false)
  @override
  final bool isCurrent;

  @override
  String toString() {
    return 'Service(id: $id, serviceName: $serviceName, typeSpecific: $typeSpecific, serviceCost: $serviceCost, serviceDurationMins: $serviceDurationMins, numberOfTires2Swap: $numberOfTires2Swap, numberofTires2Store: $numberofTires2Store, detailingPackage: $detailingPackage, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Service &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.serviceName, serviceName) ||
                const DeepCollectionEquality()
                    .equals(other.serviceName, serviceName)) &&
            (identical(other.typeSpecific, typeSpecific) ||
                const DeepCollectionEquality()
                    .equals(other.typeSpecific, typeSpecific)) &&
            (identical(other.serviceCost, serviceCost) ||
                const DeepCollectionEquality()
                    .equals(other.serviceCost, serviceCost)) &&
            (identical(other.serviceDurationMins, serviceDurationMins) ||
                const DeepCollectionEquality()
                    .equals(other.serviceDurationMins, serviceDurationMins)) &&
            (identical(other.numberOfTires2Swap, numberOfTires2Swap) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfTires2Swap, numberOfTires2Swap)) &&
            (identical(other.numberofTires2Store, numberofTires2Store) ||
                const DeepCollectionEquality()
                    .equals(other.numberofTires2Store, numberofTires2Store)) &&
            (identical(other.detailingPackage, detailingPackage) ||
                const DeepCollectionEquality()
                    .equals(other.detailingPackage, detailingPackage)) &&
            (identical(other.isCurrent, isCurrent) ||
                const DeepCollectionEquality()
                    .equals(other.isCurrent, isCurrent)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(serviceName) ^
      const DeepCollectionEquality().hash(typeSpecific) ^
      const DeepCollectionEquality().hash(serviceCost) ^
      const DeepCollectionEquality().hash(serviceDurationMins) ^
      const DeepCollectionEquality().hash(numberOfTires2Swap) ^
      const DeepCollectionEquality().hash(numberofTires2Store) ^
      const DeepCollectionEquality().hash(detailingPackage) ^
      const DeepCollectionEquality().hash(isCurrent);

  @JsonKey(ignore: true)
  @override
  _$ServiceCopyWith<_Service> get copyWith =>
      __$ServiceCopyWithImpl<_Service>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ServiceToJson(this);
  }
}

abstract class _Service extends Service {
  const factory _Service(
      {String? id,
      required String serviceName,
      String? typeSpecific,
      required double serviceCost,
      required double serviceDurationMins,
      int? numberOfTires2Swap,
      int? numberofTires2Store,
      String? detailingPackage,
      bool isCurrent}) = _$_Service;
  const _Service._() : super._();

  factory _Service.fromJson(Map<String, dynamic> json) = _$_Service.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get serviceName => throw _privateConstructorUsedError;
  @override
  String? get typeSpecific => throw _privateConstructorUsedError;
  @override //TODO: this is specifically made for oil change {Synthetic, Regular or BYOO. Change it such that it is a ist with the string values which itself will have cost, properties etc
  double get serviceCost => throw _privateConstructorUsedError;
  @override
  double get serviceDurationMins => throw _privateConstructorUsedError;
  @override //To be used for Tire swapping
// TODO bad practise below. Create Oil CHANGE, TireSwap, etc as separate class so each class can have a particular field like shown below.
  int? get numberOfTires2Swap => throw _privateConstructorUsedError;
  @override
  int? get numberofTires2Store => throw _privateConstructorUsedError;
  @override
  String? get detailingPackage => throw _privateConstructorUsedError;
  @override
  bool get isCurrent => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ServiceCopyWith<_Service> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bid _$BidFromJson(Map<String, dynamic> json) {
  return _Bid.fromJson(json);
}

/// @nodoc
class _$BidTearOff {
  const _$BidTearOff();

  _Bid call(
      {String? id,
      required String bookingID,
      required String mechanicID,
      required double bidAmount,
      bool isAccepted = false}) {
    return _Bid(
      id: id,
      bookingID: bookingID,
      mechanicID: mechanicID,
      bidAmount: bidAmount,
      isAccepted: isAccepted,
    );
  }

  Bid fromJson(Map<String, Object> json) {
    return Bid.fromJson(json);
  }
}

/// @nodoc
const $Bid = _$BidTearOff();

/// @nodoc
mixin _$Bid {
  String? get id => throw _privateConstructorUsedError;
  String get bookingID => throw _privateConstructorUsedError;
  String get mechanicID => throw _privateConstructorUsedError;
  double get bidAmount => throw _privateConstructorUsedError;
  bool get isAccepted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BidCopyWith<Bid> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidCopyWith<$Res> {
  factory $BidCopyWith(Bid value, $Res Function(Bid) then) =
      _$BidCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String bookingID,
      String mechanicID,
      double bidAmount,
      bool isAccepted});
}

/// @nodoc
class _$BidCopyWithImpl<$Res> implements $BidCopyWith<$Res> {
  _$BidCopyWithImpl(this._value, this._then);

  final Bid _value;
  // ignore: unused_field
  final $Res Function(Bid) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? bookingID = freezed,
    Object? mechanicID = freezed,
    Object? bidAmount = freezed,
    Object? isAccepted = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingID: bookingID == freezed
          ? _value.bookingID
          : bookingID // ignore: cast_nullable_to_non_nullable
              as String,
      mechanicID: mechanicID == freezed
          ? _value.mechanicID
          : mechanicID // ignore: cast_nullable_to_non_nullable
              as String,
      bidAmount: bidAmount == freezed
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isAccepted: isAccepted == freezed
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$BidCopyWith<$Res> implements $BidCopyWith<$Res> {
  factory _$BidCopyWith(_Bid value, $Res Function(_Bid) then) =
      __$BidCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String bookingID,
      String mechanicID,
      double bidAmount,
      bool isAccepted});
}

/// @nodoc
class __$BidCopyWithImpl<$Res> extends _$BidCopyWithImpl<$Res>
    implements _$BidCopyWith<$Res> {
  __$BidCopyWithImpl(_Bid _value, $Res Function(_Bid) _then)
      : super(_value, (v) => _then(v as _Bid));

  @override
  _Bid get _value => super._value as _Bid;

  @override
  $Res call({
    Object? id = freezed,
    Object? bookingID = freezed,
    Object? mechanicID = freezed,
    Object? bidAmount = freezed,
    Object? isAccepted = freezed,
  }) {
    return _then(_Bid(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingID: bookingID == freezed
          ? _value.bookingID
          : bookingID // ignore: cast_nullable_to_non_nullable
              as String,
      mechanicID: mechanicID == freezed
          ? _value.mechanicID
          : mechanicID // ignore: cast_nullable_to_non_nullable
              as String,
      bidAmount: bidAmount == freezed
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isAccepted: isAccepted == freezed
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bid extends _Bid {
  const _$_Bid(
      {this.id,
      required this.bookingID,
      required this.mechanicID,
      required this.bidAmount,
      this.isAccepted = false})
      : super._();

  factory _$_Bid.fromJson(Map<String, dynamic> json) => _$_$_BidFromJson(json);

  @override
  final String? id;
  @override
  final String bookingID;
  @override
  final String mechanicID;
  @override
  final double bidAmount;
  @JsonKey(defaultValue: false)
  @override
  final bool isAccepted;

  @override
  String toString() {
    return 'Bid(id: $id, bookingID: $bookingID, mechanicID: $mechanicID, bidAmount: $bidAmount, isAccepted: $isAccepted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Bid &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bookingID, bookingID) ||
                const DeepCollectionEquality()
                    .equals(other.bookingID, bookingID)) &&
            (identical(other.mechanicID, mechanicID) ||
                const DeepCollectionEquality()
                    .equals(other.mechanicID, mechanicID)) &&
            (identical(other.bidAmount, bidAmount) ||
                const DeepCollectionEquality()
                    .equals(other.bidAmount, bidAmount)) &&
            (identical(other.isAccepted, isAccepted) ||
                const DeepCollectionEquality()
                    .equals(other.isAccepted, isAccepted)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bookingID) ^
      const DeepCollectionEquality().hash(mechanicID) ^
      const DeepCollectionEquality().hash(bidAmount) ^
      const DeepCollectionEquality().hash(isAccepted);

  @JsonKey(ignore: true)
  @override
  _$BidCopyWith<_Bid> get copyWith =>
      __$BidCopyWithImpl<_Bid>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BidToJson(this);
  }
}

abstract class _Bid extends Bid {
  const factory _Bid(
      {String? id,
      required String bookingID,
      required String mechanicID,
      required double bidAmount,
      bool isAccepted}) = _$_Bid;
  const _Bid._() : super._();

  factory _Bid.fromJson(Map<String, dynamic> json) = _$_Bid.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get bookingID => throw _privateConstructorUsedError;
  @override
  String get mechanicID => throw _privateConstructorUsedError;
  @override
  double get bidAmount => throw _privateConstructorUsedError;
  @override
  bool get isAccepted => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BidCopyWith<_Bid> get copyWith => throw _privateConstructorUsedError;
}

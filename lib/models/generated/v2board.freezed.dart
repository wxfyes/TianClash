// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../v2board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Plan {

 int get id; String get name; String get content;@JsonKey(name: 'capacity_limit') int? get capacityLimit;@JsonKey(name: 'month_price') int? get monthPrice;@JsonKey(name: 'quarter_price') int? get quarterPrice;@JsonKey(name: 'half_year_price') int? get halfYearPrice;@JsonKey(name: 'year_price') int? get yearPrice;@JsonKey(name: 'two_year_price') int? get twoYearPrice;@JsonKey(name: 'three_year_price') int? get threeYearPrice;@JsonKey(name: 'onetime_price') int? get onetimePrice;@JsonKey(name: 'reset_price') int? get resetPrice;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.content, content) || other.content == content)&&(identical(other.capacityLimit, capacityLimit) || other.capacityLimit == capacityLimit)&&(identical(other.monthPrice, monthPrice) || other.monthPrice == monthPrice)&&(identical(other.quarterPrice, quarterPrice) || other.quarterPrice == quarterPrice)&&(identical(other.halfYearPrice, halfYearPrice) || other.halfYearPrice == halfYearPrice)&&(identical(other.yearPrice, yearPrice) || other.yearPrice == yearPrice)&&(identical(other.twoYearPrice, twoYearPrice) || other.twoYearPrice == twoYearPrice)&&(identical(other.threeYearPrice, threeYearPrice) || other.threeYearPrice == threeYearPrice)&&(identical(other.onetimePrice, onetimePrice) || other.onetimePrice == onetimePrice)&&(identical(other.resetPrice, resetPrice) || other.resetPrice == resetPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,content,capacityLimit,monthPrice,quarterPrice,halfYearPrice,yearPrice,twoYearPrice,threeYearPrice,onetimePrice,resetPrice);

@override
String toString() {
  return 'Plan(id: $id, name: $name, content: $content, capacityLimit: $capacityLimit, monthPrice: $monthPrice, quarterPrice: $quarterPrice, halfYearPrice: $halfYearPrice, yearPrice: $yearPrice, twoYearPrice: $twoYearPrice, threeYearPrice: $threeYearPrice, onetimePrice: $onetimePrice, resetPrice: $resetPrice)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 int id, String name, String content,@JsonKey(name: 'capacity_limit') int? capacityLimit,@JsonKey(name: 'month_price') int? monthPrice,@JsonKey(name: 'quarter_price') int? quarterPrice,@JsonKey(name: 'half_year_price') int? halfYearPrice,@JsonKey(name: 'year_price') int? yearPrice,@JsonKey(name: 'two_year_price') int? twoYearPrice,@JsonKey(name: 'three_year_price') int? threeYearPrice,@JsonKey(name: 'onetime_price') int? onetimePrice,@JsonKey(name: 'reset_price') int? resetPrice
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? content = null,Object? capacityLimit = freezed,Object? monthPrice = freezed,Object? quarterPrice = freezed,Object? halfYearPrice = freezed,Object? yearPrice = freezed,Object? twoYearPrice = freezed,Object? threeYearPrice = freezed,Object? onetimePrice = freezed,Object? resetPrice = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,capacityLimit: freezed == capacityLimit ? _self.capacityLimit : capacityLimit // ignore: cast_nullable_to_non_nullable
as int?,monthPrice: freezed == monthPrice ? _self.monthPrice : monthPrice // ignore: cast_nullable_to_non_nullable
as int?,quarterPrice: freezed == quarterPrice ? _self.quarterPrice : quarterPrice // ignore: cast_nullable_to_non_nullable
as int?,halfYearPrice: freezed == halfYearPrice ? _self.halfYearPrice : halfYearPrice // ignore: cast_nullable_to_non_nullable
as int?,yearPrice: freezed == yearPrice ? _self.yearPrice : yearPrice // ignore: cast_nullable_to_non_nullable
as int?,twoYearPrice: freezed == twoYearPrice ? _self.twoYearPrice : twoYearPrice // ignore: cast_nullable_to_non_nullable
as int?,threeYearPrice: freezed == threeYearPrice ? _self.threeYearPrice : threeYearPrice // ignore: cast_nullable_to_non_nullable
as int?,onetimePrice: freezed == onetimePrice ? _self.onetimePrice : onetimePrice // ignore: cast_nullable_to_non_nullable
as int?,resetPrice: freezed == resetPrice ? _self.resetPrice : resetPrice // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String content, @JsonKey(name: 'capacity_limit')  int? capacityLimit, @JsonKey(name: 'month_price')  int? monthPrice, @JsonKey(name: 'quarter_price')  int? quarterPrice, @JsonKey(name: 'half_year_price')  int? halfYearPrice, @JsonKey(name: 'year_price')  int? yearPrice, @JsonKey(name: 'two_year_price')  int? twoYearPrice, @JsonKey(name: 'three_year_price')  int? threeYearPrice, @JsonKey(name: 'onetime_price')  int? onetimePrice, @JsonKey(name: 'reset_price')  int? resetPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.content,_that.capacityLimit,_that.monthPrice,_that.quarterPrice,_that.halfYearPrice,_that.yearPrice,_that.twoYearPrice,_that.threeYearPrice,_that.onetimePrice,_that.resetPrice);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String content, @JsonKey(name: 'capacity_limit')  int? capacityLimit, @JsonKey(name: 'month_price')  int? monthPrice, @JsonKey(name: 'quarter_price')  int? quarterPrice, @JsonKey(name: 'half_year_price')  int? halfYearPrice, @JsonKey(name: 'year_price')  int? yearPrice, @JsonKey(name: 'two_year_price')  int? twoYearPrice, @JsonKey(name: 'three_year_price')  int? threeYearPrice, @JsonKey(name: 'onetime_price')  int? onetimePrice, @JsonKey(name: 'reset_price')  int? resetPrice)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.id,_that.name,_that.content,_that.capacityLimit,_that.monthPrice,_that.quarterPrice,_that.halfYearPrice,_that.yearPrice,_that.twoYearPrice,_that.threeYearPrice,_that.onetimePrice,_that.resetPrice);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String content, @JsonKey(name: 'capacity_limit')  int? capacityLimit, @JsonKey(name: 'month_price')  int? monthPrice, @JsonKey(name: 'quarter_price')  int? quarterPrice, @JsonKey(name: 'half_year_price')  int? halfYearPrice, @JsonKey(name: 'year_price')  int? yearPrice, @JsonKey(name: 'two_year_price')  int? twoYearPrice, @JsonKey(name: 'three_year_price')  int? threeYearPrice, @JsonKey(name: 'onetime_price')  int? onetimePrice, @JsonKey(name: 'reset_price')  int? resetPrice)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.content,_that.capacityLimit,_that.monthPrice,_that.quarterPrice,_that.halfYearPrice,_that.yearPrice,_that.twoYearPrice,_that.threeYearPrice,_that.onetimePrice,_that.resetPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plan implements Plan {
  const _Plan({required this.id, required this.name, required this.content, @JsonKey(name: 'capacity_limit') this.capacityLimit, @JsonKey(name: 'month_price') this.monthPrice, @JsonKey(name: 'quarter_price') this.quarterPrice, @JsonKey(name: 'half_year_price') this.halfYearPrice, @JsonKey(name: 'year_price') this.yearPrice, @JsonKey(name: 'two_year_price') this.twoYearPrice, @JsonKey(name: 'three_year_price') this.threeYearPrice, @JsonKey(name: 'onetime_price') this.onetimePrice, @JsonKey(name: 'reset_price') this.resetPrice});
  factory _Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

@override final  int id;
@override final  String name;
@override final  String content;
@override@JsonKey(name: 'capacity_limit') final  int? capacityLimit;
@override@JsonKey(name: 'month_price') final  int? monthPrice;
@override@JsonKey(name: 'quarter_price') final  int? quarterPrice;
@override@JsonKey(name: 'half_year_price') final  int? halfYearPrice;
@override@JsonKey(name: 'year_price') final  int? yearPrice;
@override@JsonKey(name: 'two_year_price') final  int? twoYearPrice;
@override@JsonKey(name: 'three_year_price') final  int? threeYearPrice;
@override@JsonKey(name: 'onetime_price') final  int? onetimePrice;
@override@JsonKey(name: 'reset_price') final  int? resetPrice;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.content, content) || other.content == content)&&(identical(other.capacityLimit, capacityLimit) || other.capacityLimit == capacityLimit)&&(identical(other.monthPrice, monthPrice) || other.monthPrice == monthPrice)&&(identical(other.quarterPrice, quarterPrice) || other.quarterPrice == quarterPrice)&&(identical(other.halfYearPrice, halfYearPrice) || other.halfYearPrice == halfYearPrice)&&(identical(other.yearPrice, yearPrice) || other.yearPrice == yearPrice)&&(identical(other.twoYearPrice, twoYearPrice) || other.twoYearPrice == twoYearPrice)&&(identical(other.threeYearPrice, threeYearPrice) || other.threeYearPrice == threeYearPrice)&&(identical(other.onetimePrice, onetimePrice) || other.onetimePrice == onetimePrice)&&(identical(other.resetPrice, resetPrice) || other.resetPrice == resetPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,content,capacityLimit,monthPrice,quarterPrice,halfYearPrice,yearPrice,twoYearPrice,threeYearPrice,onetimePrice,resetPrice);

@override
String toString() {
  return 'Plan(id: $id, name: $name, content: $content, capacityLimit: $capacityLimit, monthPrice: $monthPrice, quarterPrice: $quarterPrice, halfYearPrice: $halfYearPrice, yearPrice: $yearPrice, twoYearPrice: $twoYearPrice, threeYearPrice: $threeYearPrice, onetimePrice: $onetimePrice, resetPrice: $resetPrice)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String content,@JsonKey(name: 'capacity_limit') int? capacityLimit,@JsonKey(name: 'month_price') int? monthPrice,@JsonKey(name: 'quarter_price') int? quarterPrice,@JsonKey(name: 'half_year_price') int? halfYearPrice,@JsonKey(name: 'year_price') int? yearPrice,@JsonKey(name: 'two_year_price') int? twoYearPrice,@JsonKey(name: 'three_year_price') int? threeYearPrice,@JsonKey(name: 'onetime_price') int? onetimePrice,@JsonKey(name: 'reset_price') int? resetPrice
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? content = null,Object? capacityLimit = freezed,Object? monthPrice = freezed,Object? quarterPrice = freezed,Object? halfYearPrice = freezed,Object? yearPrice = freezed,Object? twoYearPrice = freezed,Object? threeYearPrice = freezed,Object? onetimePrice = freezed,Object? resetPrice = freezed,}) {
  return _then(_Plan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,capacityLimit: freezed == capacityLimit ? _self.capacityLimit : capacityLimit // ignore: cast_nullable_to_non_nullable
as int?,monthPrice: freezed == monthPrice ? _self.monthPrice : monthPrice // ignore: cast_nullable_to_non_nullable
as int?,quarterPrice: freezed == quarterPrice ? _self.quarterPrice : quarterPrice // ignore: cast_nullable_to_non_nullable
as int?,halfYearPrice: freezed == halfYearPrice ? _self.halfYearPrice : halfYearPrice // ignore: cast_nullable_to_non_nullable
as int?,yearPrice: freezed == yearPrice ? _self.yearPrice : yearPrice // ignore: cast_nullable_to_non_nullable
as int?,twoYearPrice: freezed == twoYearPrice ? _self.twoYearPrice : twoYearPrice // ignore: cast_nullable_to_non_nullable
as int?,threeYearPrice: freezed == threeYearPrice ? _self.threeYearPrice : threeYearPrice // ignore: cast_nullable_to_non_nullable
as int?,onetimePrice: freezed == onetimePrice ? _self.onetimePrice : onetimePrice // ignore: cast_nullable_to_non_nullable
as int?,resetPrice: freezed == resetPrice ? _self.resetPrice : resetPrice // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Order {

 int get id;@JsonKey(name: 'trade_no') String get tradeNo;@JsonKey(name: 'plan_id') int get planId;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'total_amount') int get totalAmount; int get status;@JsonKey(name: 'created_at') int get createdAt;@JsonKey(name: 'expired_at') int? get expiredAt;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, id) || other.id == id)&&(identical(other.tradeNo, tradeNo) || other.tradeNo == tradeNo)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tradeNo,planId,userId,totalAmount,status,createdAt,expiredAt);

@override
String toString() {
  return 'Order(id: $id, tradeNo: $tradeNo, planId: $planId, userId: $userId, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'trade_no') String tradeNo,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'total_amount') int totalAmount, int status,@JsonKey(name: 'created_at') int createdAt,@JsonKey(name: 'expired_at') int? expiredAt
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tradeNo = null,Object? planId = null,Object? userId = null,Object? totalAmount = null,Object? status = null,Object? createdAt = null,Object? expiredAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tradeNo: null == tradeNo ? _self.tradeNo : tradeNo // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'trade_no')  String tradeNo, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'total_amount')  int totalAmount,  int status, @JsonKey(name: 'created_at')  int createdAt, @JsonKey(name: 'expired_at')  int? expiredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.tradeNo,_that.planId,_that.userId,_that.totalAmount,_that.status,_that.createdAt,_that.expiredAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'trade_no')  String tradeNo, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'total_amount')  int totalAmount,  int status, @JsonKey(name: 'created_at')  int createdAt, @JsonKey(name: 'expired_at')  int? expiredAt)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.tradeNo,_that.planId,_that.userId,_that.totalAmount,_that.status,_that.createdAt,_that.expiredAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'trade_no')  String tradeNo, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'total_amount')  int totalAmount,  int status, @JsonKey(name: 'created_at')  int createdAt, @JsonKey(name: 'expired_at')  int? expiredAt)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.tradeNo,_that.planId,_that.userId,_that.totalAmount,_that.status,_that.createdAt,_that.expiredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Order implements Order {
  const _Order({this.id = 0, @JsonKey(name: 'trade_no') required this.tradeNo, @JsonKey(name: 'plan_id') this.planId = 0, @JsonKey(name: 'user_id') this.userId = 0, @JsonKey(name: 'total_amount') this.totalAmount = 0, this.status = 0, @JsonKey(name: 'created_at') this.createdAt = 0, @JsonKey(name: 'expired_at') this.expiredAt});
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'trade_no') final  String tradeNo;
@override@JsonKey(name: 'plan_id') final  int planId;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'total_amount') final  int totalAmount;
@override@JsonKey() final  int status;
@override@JsonKey(name: 'created_at') final  int createdAt;
@override@JsonKey(name: 'expired_at') final  int? expiredAt;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.tradeNo, tradeNo) || other.tradeNo == tradeNo)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tradeNo,planId,userId,totalAmount,status,createdAt,expiredAt);

@override
String toString() {
  return 'Order(id: $id, tradeNo: $tradeNo, planId: $planId, userId: $userId, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'trade_no') String tradeNo,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'total_amount') int totalAmount, int status,@JsonKey(name: 'created_at') int createdAt,@JsonKey(name: 'expired_at') int? expiredAt
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tradeNo = null,Object? planId = null,Object? userId = null,Object? totalAmount = null,Object? status = null,Object? createdAt = null,Object? expiredAt = freezed,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tradeNo: null == tradeNo ? _self.tradeNo : tradeNo // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PaymentMethod {

 int get id; String get name; String get payment; String? get icon;
/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<PaymentMethod> get copyWith => _$PaymentMethodCopyWithImpl<PaymentMethod>(this as PaymentMethod, _$identity);

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,payment,icon);

@override
String toString() {
  return 'PaymentMethod(id: $id, name: $name, payment: $payment, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodCopyWith<$Res>  {
  factory $PaymentMethodCopyWith(PaymentMethod value, $Res Function(PaymentMethod) _then) = _$PaymentMethodCopyWithImpl;
@useResult
$Res call({
 int id, String name, String payment, String? icon
});




}
/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._self, this._then);

  final PaymentMethod _self;
  final $Res Function(PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? payment = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethod].
extension PaymentMethodPatterns on PaymentMethod {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethod value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethod value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String payment,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.id,_that.name,_that.payment,_that.icon);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String payment,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod():
return $default(_that.id,_that.name,_that.payment,_that.icon);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String payment,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.id,_that.name,_that.payment,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethod implements PaymentMethod {
  const _PaymentMethod({required this.id, required this.name, required this.payment, this.icon});
  factory _PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

@override final  int id;
@override final  String name;
@override final  String payment;
@override final  String? icon;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodCopyWith<_PaymentMethod> get copyWith => __$PaymentMethodCopyWithImpl<_PaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,payment,icon);

@override
String toString() {
  return 'PaymentMethod(id: $id, name: $name, payment: $payment, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory _$PaymentMethodCopyWith(_PaymentMethod value, $Res Function(_PaymentMethod) _then) = __$PaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String payment, String? icon
});




}
/// @nodoc
class __$PaymentMethodCopyWithImpl<$Res>
    implements _$PaymentMethodCopyWith<$Res> {
  __$PaymentMethodCopyWithImpl(this._self, this._then);

  final _PaymentMethod _self;
  final $Res Function(_PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? payment = null,Object? icon = freezed,}) {
  return _then(_PaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Coupon {

 int get id; String get code; String get name; int get type; int get value;
/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponCopyWith<Coupon> get copyWith => _$CouponCopyWithImpl<Coupon>(this as Coupon, _$identity);

  /// Serializes this Coupon to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coupon&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,type,value);

@override
String toString() {
  return 'Coupon(id: $id, code: $code, name: $name, type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $CouponCopyWith<$Res>  {
  factory $CouponCopyWith(Coupon value, $Res Function(Coupon) _then) = _$CouponCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name, int type, int value
});




}
/// @nodoc
class _$CouponCopyWithImpl<$Res>
    implements $CouponCopyWith<$Res> {
  _$CouponCopyWithImpl(this._self, this._then);

  final Coupon _self;
  final $Res Function(Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? type = null,Object? value = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Coupon].
extension CouponPatterns on Coupon {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coupon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coupon value)  $default,){
final _that = this;
switch (_that) {
case _Coupon():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coupon value)?  $default,){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name,  int type,  int value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.type,_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name,  int type,  int value)  $default,) {final _that = this;
switch (_that) {
case _Coupon():
return $default(_that.id,_that.code,_that.name,_that.type,_that.value);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name,  int type,  int value)?  $default,) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.type,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Coupon implements Coupon {
  const _Coupon({required this.id, required this.code, required this.name, required this.type, required this.value});
  factory _Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override final  int type;
@override final  int value;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponCopyWith<_Coupon> get copyWith => __$CouponCopyWithImpl<_Coupon>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coupon&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,type,value);

@override
String toString() {
  return 'Coupon(id: $id, code: $code, name: $name, type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class _$CouponCopyWith<$Res> implements $CouponCopyWith<$Res> {
  factory _$CouponCopyWith(_Coupon value, $Res Function(_Coupon) _then) = __$CouponCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name, int type, int value
});




}
/// @nodoc
class __$CouponCopyWithImpl<$Res>
    implements _$CouponCopyWith<$Res> {
  __$CouponCopyWithImpl(this._self, this._then);

  final _Coupon _self;
  final $Res Function(_Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? type = null,Object? value = null,}) {
  return _then(_Coupon(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UserInfo {

 String get email;@JsonKey(name: 'balance') int get balance;@JsonKey(name: 'commission_balance') int get commissionBalance;@JsonKey(name: 'transfer_enable') int get transferEnable;@JsonKey(name: 'transfer_used') int get transferUsed;@JsonKey(name: 'expired_at') int? get expiredAt;@JsonKey(name: 'plan_id') int? get planId;@JsonKey(name: 'remind_expire') int? get remindExpire;@JsonKey(name: 'remind_traffic') int? get remindTraffic;@JsonKey(name: 'uuid') String? get uuid;@JsonKey(name: 'token') String? get token;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'telegram_id') int? get telegramId;
/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoCopyWith<UserInfo> get copyWith => _$UserInfoCopyWithImpl<UserInfo>(this as UserInfo, _$identity);

  /// Serializes this UserInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfo&&(identical(other.email, email) || other.email == email)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.commissionBalance, commissionBalance) || other.commissionBalance == commissionBalance)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.transferUsed, transferUsed) || other.transferUsed == transferUsed)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.remindExpire, remindExpire) || other.remindExpire == remindExpire)&&(identical(other.remindTraffic, remindTraffic) || other.remindTraffic == remindTraffic)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.token, token) || other.token == token)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,balance,commissionBalance,transferEnable,transferUsed,expiredAt,planId,remindExpire,remindTraffic,uuid,token,avatarUrl,telegramId);

@override
String toString() {
  return 'UserInfo(email: $email, balance: $balance, commissionBalance: $commissionBalance, transferEnable: $transferEnable, transferUsed: $transferUsed, expiredAt: $expiredAt, planId: $planId, remindExpire: $remindExpire, remindTraffic: $remindTraffic, uuid: $uuid, token: $token, avatarUrl: $avatarUrl, telegramId: $telegramId)';
}


}

/// @nodoc
abstract mixin class $UserInfoCopyWith<$Res>  {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) _then) = _$UserInfoCopyWithImpl;
@useResult
$Res call({
 String email,@JsonKey(name: 'balance') int balance,@JsonKey(name: 'commission_balance') int commissionBalance,@JsonKey(name: 'transfer_enable') int transferEnable,@JsonKey(name: 'transfer_used') int transferUsed,@JsonKey(name: 'expired_at') int? expiredAt,@JsonKey(name: 'plan_id') int? planId,@JsonKey(name: 'remind_expire') int? remindExpire,@JsonKey(name: 'remind_traffic') int? remindTraffic,@JsonKey(name: 'uuid') String? uuid,@JsonKey(name: 'token') String? token,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'telegram_id') int? telegramId
});




}
/// @nodoc
class _$UserInfoCopyWithImpl<$Res>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._self, this._then);

  final UserInfo _self;
  final $Res Function(UserInfo) _then;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? balance = null,Object? commissionBalance = null,Object? transferEnable = null,Object? transferUsed = null,Object? expiredAt = freezed,Object? planId = freezed,Object? remindExpire = freezed,Object? remindTraffic = freezed,Object? uuid = freezed,Object? token = freezed,Object? avatarUrl = freezed,Object? telegramId = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,commissionBalance: null == commissionBalance ? _self.commissionBalance : commissionBalance // ignore: cast_nullable_to_non_nullable
as int,transferEnable: null == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int,transferUsed: null == transferUsed ? _self.transferUsed : transferUsed // ignore: cast_nullable_to_non_nullable
as int,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,remindExpire: freezed == remindExpire ? _self.remindExpire : remindExpire // ignore: cast_nullable_to_non_nullable
as int?,remindTraffic: freezed == remindTraffic ? _self.remindTraffic : remindTraffic // ignore: cast_nullable_to_non_nullable
as int?,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,telegramId: freezed == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfo].
extension UserInfoPatterns on UserInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInfo value)  $default,){
final _that = this;
switch (_that) {
case _UserInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInfo value)?  $default,){
final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email, @JsonKey(name: 'balance')  int balance, @JsonKey(name: 'commission_balance')  int commissionBalance, @JsonKey(name: 'transfer_enable')  int transferEnable, @JsonKey(name: 'transfer_used')  int transferUsed, @JsonKey(name: 'expired_at')  int? expiredAt, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'remind_expire')  int? remindExpire, @JsonKey(name: 'remind_traffic')  int? remindTraffic, @JsonKey(name: 'uuid')  String? uuid, @JsonKey(name: 'token')  String? token, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'telegram_id')  int? telegramId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that.email,_that.balance,_that.commissionBalance,_that.transferEnable,_that.transferUsed,_that.expiredAt,_that.planId,_that.remindExpire,_that.remindTraffic,_that.uuid,_that.token,_that.avatarUrl,_that.telegramId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email, @JsonKey(name: 'balance')  int balance, @JsonKey(name: 'commission_balance')  int commissionBalance, @JsonKey(name: 'transfer_enable')  int transferEnable, @JsonKey(name: 'transfer_used')  int transferUsed, @JsonKey(name: 'expired_at')  int? expiredAt, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'remind_expire')  int? remindExpire, @JsonKey(name: 'remind_traffic')  int? remindTraffic, @JsonKey(name: 'uuid')  String? uuid, @JsonKey(name: 'token')  String? token, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'telegram_id')  int? telegramId)  $default,) {final _that = this;
switch (_that) {
case _UserInfo():
return $default(_that.email,_that.balance,_that.commissionBalance,_that.transferEnable,_that.transferUsed,_that.expiredAt,_that.planId,_that.remindExpire,_that.remindTraffic,_that.uuid,_that.token,_that.avatarUrl,_that.telegramId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email, @JsonKey(name: 'balance')  int balance, @JsonKey(name: 'commission_balance')  int commissionBalance, @JsonKey(name: 'transfer_enable')  int transferEnable, @JsonKey(name: 'transfer_used')  int transferUsed, @JsonKey(name: 'expired_at')  int? expiredAt, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'remind_expire')  int? remindExpire, @JsonKey(name: 'remind_traffic')  int? remindTraffic, @JsonKey(name: 'uuid')  String? uuid, @JsonKey(name: 'token')  String? token, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'telegram_id')  int? telegramId)?  $default,) {final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that.email,_that.balance,_that.commissionBalance,_that.transferEnable,_that.transferUsed,_that.expiredAt,_that.planId,_that.remindExpire,_that.remindTraffic,_that.uuid,_that.token,_that.avatarUrl,_that.telegramId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInfo implements UserInfo {
  const _UserInfo({required this.email, @JsonKey(name: 'balance') this.balance = 0, @JsonKey(name: 'commission_balance') this.commissionBalance = 0, @JsonKey(name: 'transfer_enable') this.transferEnable = 0, @JsonKey(name: 'transfer_used') this.transferUsed = 0, @JsonKey(name: 'expired_at') this.expiredAt, @JsonKey(name: 'plan_id') this.planId, @JsonKey(name: 'remind_expire') this.remindExpire, @JsonKey(name: 'remind_traffic') this.remindTraffic, @JsonKey(name: 'uuid') this.uuid, @JsonKey(name: 'token') this.token, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'telegram_id') this.telegramId});
  factory _UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

@override final  String email;
@override@JsonKey(name: 'balance') final  int balance;
@override@JsonKey(name: 'commission_balance') final  int commissionBalance;
@override@JsonKey(name: 'transfer_enable') final  int transferEnable;
@override@JsonKey(name: 'transfer_used') final  int transferUsed;
@override@JsonKey(name: 'expired_at') final  int? expiredAt;
@override@JsonKey(name: 'plan_id') final  int? planId;
@override@JsonKey(name: 'remind_expire') final  int? remindExpire;
@override@JsonKey(name: 'remind_traffic') final  int? remindTraffic;
@override@JsonKey(name: 'uuid') final  String? uuid;
@override@JsonKey(name: 'token') final  String? token;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'telegram_id') final  int? telegramId;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInfoCopyWith<_UserInfo> get copyWith => __$UserInfoCopyWithImpl<_UserInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInfo&&(identical(other.email, email) || other.email == email)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.commissionBalance, commissionBalance) || other.commissionBalance == commissionBalance)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.transferUsed, transferUsed) || other.transferUsed == transferUsed)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.remindExpire, remindExpire) || other.remindExpire == remindExpire)&&(identical(other.remindTraffic, remindTraffic) || other.remindTraffic == remindTraffic)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.token, token) || other.token == token)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.telegramId, telegramId) || other.telegramId == telegramId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,balance,commissionBalance,transferEnable,transferUsed,expiredAt,planId,remindExpire,remindTraffic,uuid,token,avatarUrl,telegramId);

@override
String toString() {
  return 'UserInfo(email: $email, balance: $balance, commissionBalance: $commissionBalance, transferEnable: $transferEnable, transferUsed: $transferUsed, expiredAt: $expiredAt, planId: $planId, remindExpire: $remindExpire, remindTraffic: $remindTraffic, uuid: $uuid, token: $token, avatarUrl: $avatarUrl, telegramId: $telegramId)';
}


}

/// @nodoc
abstract mixin class _$UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$UserInfoCopyWith(_UserInfo value, $Res Function(_UserInfo) _then) = __$UserInfoCopyWithImpl;
@override @useResult
$Res call({
 String email,@JsonKey(name: 'balance') int balance,@JsonKey(name: 'commission_balance') int commissionBalance,@JsonKey(name: 'transfer_enable') int transferEnable,@JsonKey(name: 'transfer_used') int transferUsed,@JsonKey(name: 'expired_at') int? expiredAt,@JsonKey(name: 'plan_id') int? planId,@JsonKey(name: 'remind_expire') int? remindExpire,@JsonKey(name: 'remind_traffic') int? remindTraffic,@JsonKey(name: 'uuid') String? uuid,@JsonKey(name: 'token') String? token,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'telegram_id') int? telegramId
});




}
/// @nodoc
class __$UserInfoCopyWithImpl<$Res>
    implements _$UserInfoCopyWith<$Res> {
  __$UserInfoCopyWithImpl(this._self, this._then);

  final _UserInfo _self;
  final $Res Function(_UserInfo) _then;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? balance = null,Object? commissionBalance = null,Object? transferEnable = null,Object? transferUsed = null,Object? expiredAt = freezed,Object? planId = freezed,Object? remindExpire = freezed,Object? remindTraffic = freezed,Object? uuid = freezed,Object? token = freezed,Object? avatarUrl = freezed,Object? telegramId = freezed,}) {
  return _then(_UserInfo(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,commissionBalance: null == commissionBalance ? _self.commissionBalance : commissionBalance // ignore: cast_nullable_to_non_nullable
as int,transferEnable: null == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int,transferUsed: null == transferUsed ? _self.transferUsed : transferUsed // ignore: cast_nullable_to_non_nullable
as int,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,remindExpire: freezed == remindExpire ? _self.remindExpire : remindExpire // ignore: cast_nullable_to_non_nullable
as int?,remindTraffic: freezed == remindTraffic ? _self.remindTraffic : remindTraffic // ignore: cast_nullable_to_non_nullable
as int?,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,telegramId: freezed == telegramId ? _self.telegramId : telegramId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

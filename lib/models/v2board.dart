import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/v2board.freezed.dart';
part 'generated/v2board.g.dart';

@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    required int id,
    required String name,
    required String content,
    @JsonKey(name: 'capacity_limit') int? capacityLimit,
    @JsonKey(name: 'month_price') int? monthPrice,
    @JsonKey(name: 'quarter_price') int? quarterPrice,
    @JsonKey(name: 'half_year_price') int? halfYearPrice,
    @JsonKey(name: 'year_price') int? yearPrice,
    @JsonKey(name: 'two_year_price') int? twoYearPrice,
    @JsonKey(name: 'three_year_price') int? threeYearPrice,
    @JsonKey(name: 'onetime_price') int? onetimePrice,
    @JsonKey(name: 'reset_price') int? resetPrice,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}

@freezed
abstract class Order with _$Order {
  const factory Order({
    @Default(0) int id,
    @JsonKey(name: 'trade_no') required String tradeNo,
    @JsonKey(name: 'plan_id') @Default(0) int planId,
    @JsonKey(name: 'user_id') @Default(0) int userId,
    @JsonKey(name: 'total_amount') @Default(0) int totalAmount,
    @Default(0) int status,
    @JsonKey(name: 'created_at') @Default(0) int createdAt,
    @JsonKey(name: 'expired_at') int? expiredAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
abstract class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required int id,
    required String name,
    required String payment,
    String? icon,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
}

@freezed
abstract class Coupon with _$Coupon {
  const factory Coupon({
    required int id,
    required String code,
    required String name,
    required int type,
    required int value,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}

@freezed
abstract class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String email,
    @JsonKey(name: 'balance') @Default(0) int balance,
    @JsonKey(name: 'commission_balance') @Default(0) int commissionBalance,
    @JsonKey(name: 'transfer_enable') @Default(0) int transferEnable,
    @JsonKey(name: 'transfer_used') @Default(0) int transferUsed,
    @JsonKey(name: 'expired_at') int? expiredAt,
    @JsonKey(name: 'plan_id') int? planId,
    @JsonKey(name: 'remind_expire') int? remindExpire,
    @JsonKey(name: 'remind_traffic') int? remindTraffic,
    @JsonKey(name: 'uuid') String? uuid,
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'telegram_id') int? telegramId,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}

@freezed
abstract class Notice with _$Notice {
  const factory Notice({
    required int id,
    required String title,
    required String content,
    @JsonKey(name: 'show') @Default(1) int show,
    @JsonKey(name: 'tags') List<String>? tags,
    @JsonKey(name: 'created_at') @Default(0) int createdAt,
    @JsonKey(name: 'updated_at') @Default(0) int updatedAt,
  }) = _Notice;

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}

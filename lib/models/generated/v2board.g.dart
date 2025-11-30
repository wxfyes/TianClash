// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../v2board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Plan _$PlanFromJson(Map<String, dynamic> json) => _Plan(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  content: json['content'] as String,
  capacityLimit: (json['capacity_limit'] as num?)?.toInt(),
  monthPrice: (json['month_price'] as num?)?.toInt(),
  quarterPrice: (json['quarter_price'] as num?)?.toInt(),
  halfYearPrice: (json['half_year_price'] as num?)?.toInt(),
  yearPrice: (json['year_price'] as num?)?.toInt(),
  twoYearPrice: (json['two_year_price'] as num?)?.toInt(),
  threeYearPrice: (json['three_year_price'] as num?)?.toInt(),
  onetimePrice: (json['onetime_price'] as num?)?.toInt(),
  resetPrice: (json['reset_price'] as num?)?.toInt(),
);

Map<String, dynamic> _$PlanToJson(_Plan instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'content': instance.content,
  'capacity_limit': instance.capacityLimit,
  'month_price': instance.monthPrice,
  'quarter_price': instance.quarterPrice,
  'half_year_price': instance.halfYearPrice,
  'year_price': instance.yearPrice,
  'two_year_price': instance.twoYearPrice,
  'three_year_price': instance.threeYearPrice,
  'onetime_price': instance.onetimePrice,
  'reset_price': instance.resetPrice,
};

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
  id: (json['id'] as num?)?.toInt() ?? 0,
  tradeNo: json['trade_no'] as String,
  planId: (json['plan_id'] as num?)?.toInt() ?? 0,
  userId: (json['user_id'] as num?)?.toInt() ?? 0,
  totalAmount: (json['total_amount'] as num?)?.toInt() ?? 0,
  status: (json['status'] as num?)?.toInt() ?? 0,
  createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
  expiredAt: (json['expired_at'] as num?)?.toInt(),
);

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
  'id': instance.id,
  'trade_no': instance.tradeNo,
  'plan_id': instance.planId,
  'user_id': instance.userId,
  'total_amount': instance.totalAmount,
  'status': instance.status,
  'created_at': instance.createdAt,
  'expired_at': instance.expiredAt,
};

_PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    _PaymentMethod(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      payment: json['payment'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$PaymentMethodToJson(_PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'payment': instance.payment,
      'icon': instance.icon,
    };

_Coupon _$CouponFromJson(Map<String, dynamic> json) => _Coupon(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  name: json['name'] as String,
  type: (json['type'] as num).toInt(),
  value: (json['value'] as num).toInt(),
);

Map<String, dynamic> _$CouponToJson(_Coupon instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'type': instance.type,
  'value': instance.value,
};

_UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => _UserInfo(
  email: json['email'] as String,
  balance: (json['balance'] as num?)?.toInt() ?? 0,
  commissionBalance: (json['commission_balance'] as num?)?.toInt() ?? 0,
  transferEnable: (json['transfer_enable'] as num?)?.toInt() ?? 0,
  transferUsed: (json['transfer_used'] as num?)?.toInt() ?? 0,
  expiredAt: (json['expired_at'] as num?)?.toInt(),
  planId: (json['plan_id'] as num?)?.toInt(),
  remindExpire: (json['remind_expire'] as num?)?.toInt(),
  remindTraffic: (json['remind_traffic'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  token: json['token'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  telegramId: (json['telegram_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserInfoToJson(_UserInfo instance) => <String, dynamic>{
  'email': instance.email,
  'balance': instance.balance,
  'commission_balance': instance.commissionBalance,
  'transfer_enable': instance.transferEnable,
  'transfer_used': instance.transferUsed,
  'expired_at': instance.expiredAt,
  'plan_id': instance.planId,
  'remind_expire': instance.remindExpire,
  'remind_traffic': instance.remindTraffic,
  'uuid': instance.uuid,
  'token': instance.token,
  'avatar_url': instance.avatarUrl,
  'telegram_id': instance.telegramId,
};

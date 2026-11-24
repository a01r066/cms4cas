// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AmlProfileModel _$AmlProfileModelFromJson(Map<String, dynamic> json) =>
    _AmlProfileModel(
      regime: json['regime'] as String? ?? 'reg6a',
      ctrThreshold: (json['ctrThreshold'] as num?)?.toDouble() ?? 10000,
      mtlThreshold: (json['mtlThreshold'] as num?)?.toDouble() ?? 3000,
      cashForCashLimit: (json['cashForCashLimit'] as num?)?.toDouble() ?? 3000,
      casinoCheckForCashLimit:
          (json['casinoCheckForCashLimit'] as num?)?.toDouble() ?? 3000,
      sarThreshold: (json['sarThreshold'] as num?)?.toDouble() ?? 5000,
      sarFileDays: (json['sarFileDays'] as num?)?.toInt() ?? 30,
      sarExtensionDays: (json['sarExtensionDays'] as num?)?.toInt() ?? 30,
      gamingDayStartHour: (json['gamingDayStartHour'] as num?)?.toInt() ?? 6,
      nearThresholdPct: (json['nearThresholdPct'] as num?)?.toDouble() ?? 0.8,
    );

Map<String, dynamic> _$AmlProfileModelToJson(_AmlProfileModel instance) =>
    <String, dynamic>{
      'regime': instance.regime,
      'ctrThreshold': instance.ctrThreshold,
      'mtlThreshold': instance.mtlThreshold,
      'cashForCashLimit': instance.cashForCashLimit,
      'casinoCheckForCashLimit': instance.casinoCheckForCashLimit,
      'sarThreshold': instance.sarThreshold,
      'sarFileDays': instance.sarFileDays,
      'sarExtensionDays': instance.sarExtensionDays,
      'gamingDayStartHour': instance.gamingDayStartHour,
      'nearThresholdPct': instance.nearThresholdPct,
    };

_CompPolicyModel _$CompPolicyModelFromJson(Map<String, dynamic> json) =>
    _CompPolicyModel(
      pctOfTheo: (json['pctOfTheo'] as num?)?.toDouble() ?? 0.45,
      quickLossPctOfActual:
          (json['quickLossPctOfActual'] as num?)?.toDouble() ?? 0.15,
      quickLossEnabled: json['quickLossEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$CompPolicyModelToJson(_CompPolicyModel instance) =>
    <String, dynamic>{
      'pctOfTheo': instance.pctOfTheo,
      'quickLossPctOfActual': instance.quickLossPctOfActual,
      'quickLossEnabled': instance.quickLossEnabled,
    };

_SettingsModel _$SettingsModelFromJson(
  Map<String, dynamic> json,
) => _SettingsModel(
  casinoName: json['casinoName'] as String? ?? 'My Casino',
  jurisdictionLabel:
      json['jurisdictionLabel'] as String? ?? 'Book reference (Nevada, 2003)',
  aml: json['aml'] == null
      ? const AmlProfileModel()
      : AmlProfileModel.fromJson(json['aml'] as Map<String, dynamic>),
  comps: json['comps'] == null
      ? const CompPolicyModel()
      : CompPolicyModel.fromJson(json['comps'] as Map<String, dynamic>),
  gamingTaxRate: (json['gamingTaxRate'] as num?)?.toDouble() ?? 0.0625,
  holdTolerance: (json['holdTolerance'] as num?)?.toDouble() ?? 0.03,
  houseAdvantage:
      (json['houseAdvantage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  multipliers:
      (json['multipliers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, (e as num?)?.toDouble()),
          ),
        ),
      ) ??
      const <String, Map<String, double?>>{},
  ratingHitThreshold: (json['ratingHitThreshold'] as num?)?.toDouble() ?? 10000,
);

Map<String, dynamic> _$SettingsModelToJson(_SettingsModel instance) =>
    <String, dynamic>{
      'casinoName': instance.casinoName,
      'jurisdictionLabel': instance.jurisdictionLabel,
      'aml': instance.aml.toJson(),
      'comps': instance.comps.toJson(),
      'gamingTaxRate': instance.gamingTaxRate,
      'holdTolerance': instance.holdTolerance,
      'houseAdvantage': instance.houseAdvantage,
      'multipliers': instance.multipliers,
      'ratingHitThreshold': instance.ratingHitThreshold,
    };

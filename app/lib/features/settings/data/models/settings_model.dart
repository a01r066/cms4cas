import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_settings.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
abstract class AmlProfileModel with _$AmlProfileModel {
  const AmlProfileModel._();

  const factory AmlProfileModel({
    @Default('reg6a') String regime,
    @Default(10000) double ctrThreshold,
    @Default(3000) double mtlThreshold,
    @Default(3000) double cashForCashLimit,
    @Default(3000) double casinoCheckForCashLimit,
    @Default(5000) double sarThreshold,
    @Default(30) int sarFileDays,
    @Default(30) int sarExtensionDays,
    @Default(6) int gamingDayStartHour,
    @Default(0.8) double nearThresholdPct,
  }) = _AmlProfileModel;

  factory AmlProfileModel.fromJson(Map<String, dynamic> json) => _$AmlProfileModelFromJson(json);

  factory AmlProfileModel.fromEntity(AmlProfile a) => AmlProfileModel(
        regime: a.regime.wire,
        ctrThreshold: a.ctrThreshold,
        mtlThreshold: a.mtlThreshold,
        cashForCashLimit: a.cashForCashLimit,
        casinoCheckForCashLimit: a.casinoCheckForCashLimit,
        sarThreshold: a.sarThreshold,
        sarFileDays: a.sarFileDays,
        sarExtensionDays: a.sarExtensionDays,
        gamingDayStartHour: a.gamingDayStartHour,
        nearThresholdPct: a.nearThresholdPct,
      );

  AmlProfile toEntity() => AmlProfile(
        regime: AggregationRegime.fromWire(regime),
        ctrThreshold: ctrThreshold,
        mtlThreshold: mtlThreshold,
        cashForCashLimit: cashForCashLimit,
        casinoCheckForCashLimit: casinoCheckForCashLimit,
        sarThreshold: sarThreshold,
        sarFileDays: sarFileDays,
        sarExtensionDays: sarExtensionDays,
        gamingDayStartHour: gamingDayStartHour,
        nearThresholdPct: nearThresholdPct,
      );
}

@freezed
abstract class CompPolicyModel with _$CompPolicyModel {
  const CompPolicyModel._();

  const factory CompPolicyModel({
    @Default(0.45) double pctOfTheo,
    @Default(0.15) double quickLossPctOfActual,
    @Default(true) bool quickLossEnabled,
  }) = _CompPolicyModel;

  factory CompPolicyModel.fromJson(Map<String, dynamic> json) => _$CompPolicyModelFromJson(json);

  factory CompPolicyModel.fromEntity(CompPolicy c) =>
      CompPolicyModel(pctOfTheo: c.pctOfTheo, quickLossPctOfActual: c.quickLossPctOfActual, quickLossEnabled: c.quickLossEnabled);

  CompPolicy toEntity() =>
      CompPolicy(pctOfTheo: pctOfTheo, quickLossPctOfActual: quickLossPctOfActual, quickLossEnabled: quickLossEnabled);
}

/// casinos/{casinoId}/settings/main
@freezed
abstract class SettingsModel with _$SettingsModel {
  const SettingsModel._();

  const factory SettingsModel({
    @Default('My Casino') String casinoName,
    @Default('Book reference (Nevada, 2003)') String jurisdictionLabel,
    @Default(AmlProfileModel()) AmlProfileModel aml,
    @Default(CompPolicyModel()) CompPolicyModel comps,
    @Default(0.0625) double gamingTaxRate,
    @Default(0.03) double holdTolerance,
    @Default(<String, double>{}) Map<String, double> houseAdvantage,
    @Default(<String, Map<String, double?>>{}) Map<String, Map<String, double?>> multipliers,
    @Default(10000) double ratingHitThreshold,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

  factory SettingsModel.fromEntity(AppSettings s) => SettingsModel(
        casinoName: s.casinoName,
        jurisdictionLabel: s.jurisdictionLabel,
        aml: AmlProfileModel.fromEntity(s.aml),
        comps: CompPolicyModel.fromEntity(s.comps),
        gamingTaxRate: s.gamingTaxRate,
        holdTolerance: s.holdTolerance,
        houseAdvantage: s.houseAdvantage,
        multipliers: s.multipliers,
        ratingHitThreshold: s.ratingHitThreshold,
      );

  AppSettings toEntity() => AppSettings(
        casinoName: casinoName,
        jurisdictionLabel: jurisdictionLabel,
        aml: aml.toEntity(),
        comps: comps.toEntity(),
        gamingTaxRate: gamingTaxRate,
        holdTolerance: holdTolerance,
        houseAdvantage: houseAdvantage,
        multipliers: multipliers,
        ratingHitThreshold: ratingHitThreshold,
      );
}

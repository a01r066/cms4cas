import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signature.freezed.dart';

/// A credit signature, stamped by the server with the signer's role at the time.
@freezed
abstract class Signature with _$Signature {
  const factory Signature({
    required String userId,
    required String userName,
    required CreditRole role,
    required DateTime at,
  }) = _Signature;
}

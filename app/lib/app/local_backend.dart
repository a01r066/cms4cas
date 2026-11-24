import '../core/backend/functions_gateway.dart';
import '../features/auth/data/datasources/auth_local_actions.dart';
import '../features/compliance/data/datasources/compliance_local_actions.dart';
import '../features/credit/data/datasources/credit_local_actions.dart';

/// Every privileged action, implemented in Dart for the local backend.
/// Same names and checks as firebase/functions/src/index.js.
Map<String, LocalFunction> localFunctionHandlers() => {
      ...authLocalActions(),
      ...creditLocalActions(),
      ...complianceLocalActions(),
    };

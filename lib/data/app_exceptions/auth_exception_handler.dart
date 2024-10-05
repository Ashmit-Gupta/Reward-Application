
import 'auth_result_status.dart';

class AuthExceptionHandler {
  static AuthResultStatus handleException(e) {
    AuthResultStatus status;
    switch (e.code) {
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "id-token-expired":
        status = AuthResultStatus.idTokenExpired;
        break;
      case "invalid-id-token":
        status = AuthResultStatus.invalidIdToken;
        break;
      case "insufficient-permission":
        status = AuthResultStatus.insufficientPermission;
        break;
      case "internal-error":
        status = AuthResultStatus.internalError;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }
}

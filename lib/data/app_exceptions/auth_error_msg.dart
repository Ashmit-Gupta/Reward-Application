import 'auth_result_status.dart';

class AuthErrorMessage {
  static String generateMessage(AuthResultStatus status) {
    switch (status) {
      case AuthResultStatus.emailAlreadyExists:
        return "The email address is already registered. Try using a different email.";
      case AuthResultStatus.wrongPassword:
        return "The password is incorrect. Please check your password.";
      case AuthResultStatus.invalidEmail:
        return "The email address is badly formatted.";
      case AuthResultStatus.userNotFound:
        return "No user found for this email. Please sign up first.";
      case AuthResultStatus.userDisabled:
        return "This user has been disabled. Contact support for more information.";
      case AuthResultStatus.operationNotAllowed:
        return "This operation is not allowed. Please enable it in the Firebase console.";
      case AuthResultStatus.tooManyRequests:
        return "Too many requests. Please try again later.";
      case AuthResultStatus.idTokenExpired:
        return "The provided ID token is expired.";
      case AuthResultStatus.invalidIdToken:
        return "The provided ID token is invalid.";
      case AuthResultStatus.insufficientPermission:
        return "Insufficient permissions. Please check your Firebase project setup.";
      case AuthResultStatus.internalError:
        return "An internal error occurred. Please try again later.";
      case AuthResultStatus.successful:
        return "Operation successful.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }
}

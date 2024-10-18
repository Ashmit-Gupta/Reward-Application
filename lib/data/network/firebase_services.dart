// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:reward_app/data/app_exceptions/auth_exception_handler.dart';
// import 'package:reward_app/data/app_exceptions/auth_result_status.dart';
// import 'package:reward_app/data/network/base_firebase_services.dart';
// import 'package:reward_app/data/response/response.dart';
//
// import '../app_exceptions/auth_error_msg.dart';
//
// class FirebaseServices extends BaseFirebaseServices {
//   final _auth = FirebaseAuth.instance;
//   @override
//   Future<Resource<User?>> logIn(String email, String pwd) async {
//     try {
//       UserCredential userCredential =
//           await _auth.signInWithEmailAndPassword(email: email, password: pwd);
//       if (userCredential.user != null) {
//         return Resource.completed(userCredential.user);
//       } else {
//         String error =
//             AuthErrorMessage.generateMessage(AuthResultStatus.userNotFound);
//         return Resource.error(error);
//       }
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     }
//   }
//
//   @override
//   Future<Resource<void>> logOut() async {
//     try {
//       await _auth.signOut();
//       return Resource.completed(null);
//     } catch (e) {
//       return Resource.error("Error during SignOut : $e");
//     }
//   }
//
//   @override
//   Future<Resource<User?>> signUp(String email, String pwd) async {
//     try {
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: pwd);
//       if (userCredential.user != null) {
//         return Resource.completed(userCredential.user);
//       } else {
//         return Resource.error("User creation failed");
//       }
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     }
//   }
//
//   Resource<User?> _handleAuthException(FirebaseAuthException e) {
//     AuthResultStatus status = AuthExceptionHandler.handleException(e);
//     String errorMsg = AuthErrorMessage.generateMessage(status);
//     return Resource.error(errorMsg);
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:reward_app/data/app_exceptions/auth_exception_handler.dart';

import '../app_exceptions/auth_error_msg.dart';
import '../app_exceptions/auth_result_status.dart';
import '../response/response.dart';
import 'base_firebase_services.dart';

@injectable
class FirebaseServices extends BaseFirebaseServices {
  final FirebaseAuth _auth; // Injected FirebaseAuth instance

  FirebaseServices(this._auth);

  @override
  Future<Resource<User?>> logIn(String email, String pwd) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      if (userCredential.user != null) {
        return Resource.completed(userCredential.user);
      } else {
        String error =
            AuthErrorMessage.generateMessage(AuthResultStatus.userNotFound);
        return Resource.error(error);
      }
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    } catch (e) {
      return Resource.error("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<Resource<User?>> signUp(String email, String pwd, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pwd);
      if (userCredential.user != null) {
        userCredential.user?.updateDisplayName(name);
        return Resource.completed(userCredential.user);
      } else {
        String error =
            AuthErrorMessage.generateMessage(AuthResultStatus.undefined);
        return Resource.error(error);
      }
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    } catch (e) {
      return Resource.error("Unexpected error: ${e.toString()}");
    }
  }

  // Log Out functionality
  @override
  Future<Resource<void>> logOut() async {
    try {
      await _auth.signOut();
      return Resource.completed(null);
    } catch (e) {
      print("error while log out $e");
      return Resource.error(e.toString());
    }
  }

  Resource<User?> _handleAuthException(FirebaseAuthException e) {
    AuthResultStatus status = AuthExceptionHandler.handleException(e);
    String errorMessage = AuthErrorMessage.generateMessage(status);
    return Resource.error(errorMessage);
  }
}

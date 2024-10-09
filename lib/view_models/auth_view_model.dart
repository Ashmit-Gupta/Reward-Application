import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';
import 'package:reward_app/data/response/status.dart';
import '../data/response/response.dart';
import '../repository/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) {
    _checkCurrentUser(); // Check current user on initialization
  }

  User? _user;
  User? get user => _user;

  Resource<User?> _authResource = Resource(status: Status.IDLE);
  Resource<User?> get authResource => _authResource;

  void _checkCurrentUser() {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _authResource = Resource.completed(_user); // User is logged in
    } else {
      _authResource = Resource.error("User is not logged in");
    }
    notifyListeners(); // Notify UI about the user state
  }

  Future<void> login(String email, String pwd) async {
    _setAuthResource(Resource.loading());
    try {
      Resource<User?> result = await _authRepository.login(email, pwd);
      _setAuthResource(result);
      if (result.status == Status.COMPLETED) _user = result.data;
    } catch (e) {
      _setAuthResource(Resource.error(e.toString()));
    }
  }

  Future<void> signUp(String email, String pwd) async {
    _setAuthResource(Resource.loading());
    try {
      Resource<User?> result = await _authRepository.signUp(email, pwd);
      _setAuthResource(result);
      if (result.status == Status.COMPLETED) _user = result.data;
    } catch (e) {
      _setAuthResource(Resource.error(e.toString()));
    }
  }

  Future<void> logOut() async {
    _setAuthResource(Resource.loading());
    try {
      Resource<void> result = await _authRepository.logOut();
      if (result.status == Status.COMPLETED) {
        _user = null; // Clear the user
        _setAuthResource(Resource.completed(
            null)); // Set authResource as completed with null user
      } else {
        _setAuthResource(
            Resource.error(result.message ?? "Error during logout"));
      }
    } catch (e) {
      _setAuthResource(Resource.error(e.toString()));
    }
  }

  // Private method to update the auth resource and notify UI changes in one call
  void _setAuthResource(Resource<User?> resource) {
    _authResource = resource;
    notifyListeners();
  }
}

//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../data/network/firebase_services.dart';
// import '../data/response/response.dart';
//
// class AuthViewModel extends ChangeNotifier {
//   final FirebaseServices _authRepository;
//   Resource<User?> _authResource = Resource.idle();
//
//   AuthViewModel(this._authRepository);
//
//   Resource<User?> get authResource => _authResource;
//
//   void _setAuthResource(Resource<User?> resource) {
//     _authResource = resource;
//     notifyListeners(); // Notify listeners when state changes
//   }
//
//   void _setLoadingState() {
//     _setAuthResource(Resource.loading());
//   }
//
//   Future<void> login(String email, String pwd) async {
//     _setLoadingState(); // Reused for setting loading state
//     try {
//       Resource<User?> result = await _authRepository.logIn(email, pwd);
//       _setAuthResource(result);
//     } catch (e) {
//       _setAuthResource(Resource.error(e.toString()));
//     }
//   }
//
//   Future<void> signUp(String email, String pwd) async {
//     _setLoadingState(); // Reused for setting loading state
//     try {
//       Resource<User?> result = await _authRepository.signUp(email, pwd);
//       _setAuthResource(result);
//     } catch (e) {
//       _setAuthResource(Resource.error(e.toString()));
//     }
//   }
//
//   // New logout method
//   Future<void> logOut() async {
//     try {
//       await _authRepository.logOut();
//       _setAuthResource(Resource.idle); // Set to idle state after logout
//     } catch (e) {
//       _setAuthResource(Resource.error(e.toString()));
//     }
//   }
// }

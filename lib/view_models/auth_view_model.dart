import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'package:injectable/injectable.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/view_models/user_view_model.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';
import '../data/response/response.dart';
import '../repository/auth_repo.dart';
import 'home_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  Resource<User?> _authResource = Resource(status: Status.IDLE);

  Resource<User?> get authResource => _authResource;
  //
  // @override
  // void dispose() {
  //   resetAuthResource();
  //   super.dispose();
  // }

  Future<void> login(String email, String pwd, BuildContext context) async {
    _setAuthResource(Resource.loading());
    try {
      print("auth view model : $email , $pwd");
      Resource<User?> result = await _authRepository.login(email, pwd);
      _setAuthResource(result);
      Provider.of<UserViewModel>(context, listen: false).fetchUserData();
    } catch (e) {
      _setAuthResource(Resource.error(e.toString()));
    }
  }

  Future<void> signUp(String email, String pwd) async {
    _setAuthResource(Resource.loading());
    try {
      Resource<User?> result = await _authRepository.signUp(email, pwd);
      _setAuthResource(result);
    } catch (e) {
      _setAuthResource(Resource.error(e.toString()));
    }
  }

  Future<void> logOut(BuildContext context) async {
    _setAuthResource(Resource.loading());
    try {
      await _authRepository.logOut();
      _setAuthResource(Resource.completed(null));
      resetAuthResource();
      Provider.of<HomeViewModel>(context, listen: false).clearHomeData();
      Provider.of<UserViewModel>(context, listen: false).clearUserData();
      Provider.of<WalletViewModel>(context, listen: false).clearWalletData();
    } catch (e) {
      print("The user logout has been failed !!");
      _setAuthResource(Resource.error(e.toString()));
    }
  }

  // Private method to update the auth resource and notify UI changes in one call
  void _setAuthResource(Resource<User?> resource) {
    _authResource = resource;
    notifyListeners();
  }

  void resetAuthResource() {
    _authResource = Resource(status: Status.IDLE);
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

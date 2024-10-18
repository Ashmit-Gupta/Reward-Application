import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reward_app/data/response/response.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/auth_repo.dart';
import 'package:reward_app/view_models/home_view_model.dart';
import 'package:reward_app/view_models/user_view_model.dart';

import '../data/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserViewModel _userViewModel;
  // final HomeViewModel _homeView
  LoginViewModel(this._authRepository, this._userViewModel);

  Resource<User?> _loginResource = Resource(status: Status.IDLE);
  Resource<User?> get loginResource => _loginResource;

  Future<void> login(String email, String pwd) async {
    _loginResource = Resource.loading();
    notifyListeners();
    try {
      Resource<User?> result = await _authRepository.login(email, pwd);
      if (result.status == Status.COMPLETED) {
        var res = await _userViewModel.fetchAndSaveUserData();
        print(
            "log (loginViewModel) able to save user data true or false: $res ");

        //testing
        if (res) {
          UserData user = await _userViewModel.getUser();
          print(
              "log the user data is after login vm is : ${user.id} , ${user.email}  ");
        } else {
          print("log Unable to fetch and save user data : loginViewModel");
        }

        // result.data.displayName; add data to saveData like this?
        if (res) {
          _loginResource = result;
          notifyListeners();
        } else {
          _loginResource = Resource.error("unable to save the user !!");
          notifyListeners();
        }
      }
    } catch (e) {
      _loginResource = Resource.error("Unable to Login $e");
      notifyListeners();
    }
  }

  void clearState() {
    _loginResource = Resource(status: Status.IDLE);
    notifyListeners();
  }
}

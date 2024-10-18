import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:reward_app/data/response/response.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/auth_repo.dart';
import 'package:reward_app/view_models/home_view_model.dart';
import 'package:reward_app/view_models/user_view_model.dart';

class LogOutViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserViewModel _userViewModel;
  final HomeViewModel _homeViewModel;
  LogOutViewModel(
      this._authRepository, this._userViewModel, this._homeViewModel);
  Resource<User?> _logout = Resource(status: Status.IDLE);
  Resource<User?> get logoutResource => _logout;

  Future<void> logout() async {
    try {
      Resource<void> result = await _authRepository.logOut();
      if (result.status == Status.COMPLETED) {
        var res = await _userViewModel.removeUser();
        if (res) {
          _logout = Resource.completed(null);
          _homeViewModel.clearHomeData();
          notifyListeners();
        } else {
          _logout = Resource.error("Failed to deleted user data !! ");
          notifyListeners();
        }
      }
      // _logout = Resource.completed(null);
      // notifyListeners();
    } catch (e) {
      _logout = Resource.error("Error while loggin out the user : , $e");
      notifyListeners();
      print("Error while logging out please retry again later $e");
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:reward_app/data/response/response.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/auth_repo.dart';

class SignUpViewModel extends ChangeNotifier {
  AuthRepository _authRepository;

  SignUpViewModel(this._authRepository);
//use dependency injection instead of depending on the build context
  Resource<User?> _signUpResource = Resource(status: Status.IDLE);
  Resource<User?> get signUpResource => _signUpResource;

  Future<void> signUp(String email, String pwd, String name) async {
    _signUpResource = Resource.loading();
    notifyListeners();

    try {
      Resource<User?> result = await _authRepository.signUp(email, pwd, name);
      if (result.status == Status.COMPLETED) {
        _signUpResource = result;
      }
    } catch (e) {
      _signUpResource = Resource.error(
          "error while Signing In ${_signUpResource.message} ,$e ");
      notifyListeners();
    }
  }

  void resetSignUpViewModel() {
    _signUpResource = Resource(status: Status.IDLE);
    notifyListeners();
  }
}

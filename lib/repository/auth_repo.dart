import 'package:firebase_auth/firebase_auth.dart';
import 'package:reward_app/data/network/firebase_services.dart';
import 'package:reward_app/data/response/response.dart';

class AuthRepository {
  final FirebaseServices _firebaseServices;

  AuthRepository(this._firebaseServices);

  Future<Resource<User?>> login(String email, String pwd) async {
    return await _firebaseServices.logIn(email, pwd);
  }

  Future<Resource<User?>> signUp(String email, String pwd) async {
    return await _firebaseServices.signUp(email, pwd);
  }

  Future<Resource<void>> logOut() async {
    return await _firebaseServices.logOut();
  }
}

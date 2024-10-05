import 'package:firebase_auth/firebase_auth.dart';
import 'package:reward_app/data/response/response.dart';

abstract class BaseFirebaseServices {
  Future<Resource<User?>> signUp(String email, String pwd);
  Future<Resource<User?>> logIn(String email, String pwd);
  Future<void> logOut();
}

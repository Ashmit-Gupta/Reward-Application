import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  static Future<SharedPreferences> sharedPref() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp;
  }

  Future<bool> saveUser(UserData user) async {
    final SharedPreferences sp = await sharedPref();
    if (user.id.isNotEmpty) {
      await sp.setString('id', user.id.toString());
      await sp.setString('name', user.displayName.toString());
      await sp.setString('email', user.email.toString());
      await sp.setString('imageUrl', user.photoURL.toString());
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fetchAndSaveUserData() async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        UserData userData = UserData(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "guestUser@gmail.com",
            displayName: firebaseUser.displayName ?? 'Guest User',
            photoURL: firebaseUser.photoURL ?? '');

        bool success = await saveUser(userData);
        if (success) {
          print('user data saved to sharedPreference');
        } else {
          print('failed to save user data to sharedPreference');
        }
        _setIsLoggedIn(true);
        return success;
      } else {
        print('no user is signed in');
        _setIsLoggedIn(false);
        return false;
      }
    } catch (e) {
      _setIsLoggedIn(false);
      print("Error fetching user data from Firebase: $e");
      return false;
    }
  }

  Future<UserData> getUser() async {
    final SharedPreferences sp = await sharedPref();
    // final SharedPreferences sp = await SharedPreferences.getInstance();
    final String id = sp.getString('id') ?? '';
    final String name = sp.getString('name') ?? '';
    final String email = sp.getString('email') ?? '';
    final String imageUrl = sp.getString('imageUrl') ?? '';

    if (id.isEmpty) {
      return UserData(id: '', email: '', displayName: '', photoURL: '');
    } else {
      return UserData(
          id: id, email: email, photoURL: imageUrl, displayName: name);
    }
  }

  Future<bool> removeUser() async {
    // final SharedPreferences sp = await SharedPreferences.getInstance();
    final SharedPreferences sp = await sharedPref();
    // Remove the token
    bool isCleared = await sp.clear();
    if (isCleared) {
      await _auth.signOut();
      _setIsLoggedIn(false);
      print("User signed out and data cleared successfully.");
      return true;
    } else {
      print("Failed to remove user data.");
      return false;
    }
  }

  void _setIsLoggedIn(bool state) {
    _isLoggedIn = state;
    notifyListeners();
  }
}
//todo add hold to share the qr

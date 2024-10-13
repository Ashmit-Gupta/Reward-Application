import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  User? _currentUser;
  String? _uId;
  String? _email;
  String? _name;
  String? _contactNo;
  String? _imageUrl;

  String? get uId => _uId;

  String? get email => _email;

  String? get name => _name;
  String? get contactNo => _contactNo;
  String? get imageUrl => _imageUrl;

  void fetchUserData() {
    try {
      _currentUser = FirebaseAuth.instance.currentUser;
      if (_currentUser != null) {
        _uId = _currentUser!.uid;
        _email = _currentUser!.email;
        _name = _currentUser!.displayName;
        _imageUrl = _currentUser!.photoURL;
      }
      notifyListeners();
    } catch (e) {
      print("error while fetching the user data!! $e");
    }
  }

  void clearUserData() {
    _currentUser = null;
    _uId = null;
    _email = null;
    _name = null;
    notifyListeners();
  }
}
//todo add hold to share the qr

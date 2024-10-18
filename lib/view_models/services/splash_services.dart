import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/view_models/user_view_model.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_view_model.dart';

class SplashServices {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<void> checkAuthentication(BuildContext context) async {
  //   Future.delayed(Duration(seconds: 3), () async {
  //     User? user = _auth.currentUser;
  //     if (user == null) {
  //       Navigator.pushReplacementNamed(context, RoutesName.login);
  //     } else {
  //       await fetchRewards(context, user.uid);
  //       Provider.of<UserViewModel>(context, listen: false).fetchUserData();
  //       Navigator.pushReplacementNamed(context, RoutesName.home);
  //     }
  //   });
  // }

  Future<void> checkAuthentication(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), () async {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String userId = sp.getString('id') ?? '';

      Provider.of<WalletViewModel>(context, listen: false).fetchAllRewards();
      if (userId.isEmpty) {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        context.read<HomeViewModel>().fetchUserRewards();
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    });
  }
}
//todo fetching anything from the viewmodel try to use provider ,
//todo add user update name and photo etc

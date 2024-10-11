import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';

import '../home_view_model.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> checkAuthentication(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), () async {
      User? user = _auth.currentUser;
      if (user == null) {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await fetchRewards(context, user.uid);
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    });
  }

  Future<void> fetchRewards(BuildContext context, String userId) async {
    try {
      Provider.of<HomeViewModel>(context, listen: false)
          .fetchUserRewards(userId);
      print("fetching all the rewards for wallet ");
      Provider.of<WalletViewModel>(context, listen: false).fetchAllRewards();
    } catch (e) {
      print("error while loading the data from firestore $e");
    }
  }
}

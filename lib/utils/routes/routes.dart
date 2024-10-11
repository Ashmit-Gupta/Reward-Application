import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/data/model/payment_model.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/views/login_view.dart';
import 'package:reward_app/views/payment_view.dart';

import '../../data/model/user_reward_model.dart';
import '../../views/home_view.dart';
import '../../views/qr_generation_view.dart';
import '../../views/signup_view.dart';
import '../../views/splash_screen.dart';
import '../../views/wallet_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.wallet:
        return MaterialPageRoute(
            builder: (BuildContext context) => WalletScreen());

      case RoutesName.payment:
        return MaterialPageRoute(
            builder: (BuildContext context) => PaymentPage());

      case RoutesName.rewardQR:
        return MaterialPageRoute(
            builder: (BuildContext context) => QrGenerationView());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}

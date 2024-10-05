// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/view_models/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    _splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Center(
    //           child: Container(
    //             decoration: BoxDecoration(
    //                 border: Border.all(color: Colors.black, width: 6),
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Lottie.asset(
    //               'assets/animation/splash_animation.json', // Replace with the path to your Lottie JSON file
    //               fit: BoxFit.cover,
    //               // width: MediaQuery.of(context).size.width *
    //               //     0.6, // Adjust the width and height as needed
    //               // height: MediaQuery.of(context).size.height * 0.6,
    //               width: 300,
    //               height: 300,
    //               repeat: false,
    //               // Set to true if you want the animation to loop
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         const Center(
    //           child: Text(
    //             "Splash Screen",
    //             style: TextStyle(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.blueAccent),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}

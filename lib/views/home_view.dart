import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/res/components/custom_app_bar.dart';
import 'package:reward_app/res/components/custom_drawer.dart';
import 'package:reward_app/view_models/auth_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      drawer: SideBar(),
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
            " name of the user is : and the ${authViewModel.user?.email ?? "mai nhi bata rha"} email is this "),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';

import '../res/components/rounded_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();

  @override
  void dispose() {
    _obsecurePassword.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    emailFocusNode.dispose();
    pwdFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            focusNode: emailFocusNode,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, emailFocusNode, pwdFocusNode);
            },
            decoration: InputDecoration(
                hintText: "Email",
                labelText: "Email",
                prefixIcon: Icon(Icons.alternate_email)),
          ),
          ValueListenableBuilder(
            valueListenable: _obsecurePassword,
            builder: (BuildContext context, value, Widget? child) {
              return TextFormField(
                controller: _pwdController,
                focusNode: pwdFocusNode,
                obscureText: _obsecurePassword.value,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  hintText: "password",
                  labelText: "password",
                  prefixIcon: Icon(Icons.lock_open_outlined),
                  suffixIcon: InkWell(
                    onTap: () {
                      _obsecurePassword.value = !_obsecurePassword.value;
                    },
                    child: Icon(
                      _obsecurePassword.value
                          ? (Icons.visibility_off_outlined)
                          : (Icons.visibility_outlined),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: height * .1,
          ),
          RoundedButton(
            title: "Login",
            loading: authViewModel.authResource.status == Status.LOADING,
            onPress: () async {
              if (_emailController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please Enter Email", context);
              } else if (_pwdController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please Enter Password", context);
              } else if (_pwdController.text.length < 6) {
                Utils.flushBarErrorMessage(
                    "The Password must be greater than 6 digits or words!",
                    context);
              } else {
                await authViewModel.login(
                    _emailController.text, _pwdController.text);
                if (authViewModel.authResource.status == Status.COMPLETED) {
                  Navigator.pushReplacementNamed(context, RoutesName.home);
                } else if (authViewModel.authResource.status == Status.ERROR) {
                  Utils.flushBarErrorMessage(
                      "Login Failed ${authViewModel.authResource.message} ",
                      context);
                }
              }
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.signUp);
            },
            child: Text("Dont have an Account Sign Up?"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import '../res/components/rounded_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_models/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/signup_bg.jpg'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or Title
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Input
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.alternate_email,
                          color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (BuildContext context, value, Widget? child) {
                      return TextFormField(
                        controller: _pwdController,
                        focusNode: pwdFocusNode,
                        obscureText: _obsecurePassword.value,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_open_outlined,
                              color: Colors.white),
                          suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(
                              _obsecurePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          hintStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  const SizedBox(height: 40),

                  // Sign Up Button
                  RoundedButton(
                    title: "Sign Up",
                    loading:
                        authViewModel.authResource.status == Status.LOADING,
                    onPress: () async {
                      if (_emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Please Enter Email", context);
                      } else if (_pwdController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Please Enter Password", context);
                      } else if (_pwdController.text.length < 6) {
                        Utils.flushBarErrorMessage(
                            "The Password must be greater than 6 characters!",
                            context);
                      } else {
                        await authViewModel.signUp(
                            _emailController.text, _pwdController.text);
                        if (authViewModel.authResource.status ==
                            Status.COMPLETED) {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.login);
                        } else if (authViewModel.authResource.status ==
                            Status.ERROR) {
                          Utils.flushBarErrorMessage(
                              "SignUp Failed ${authViewModel.authResource.message}",
                              context);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Navigate to login screen
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: const Center(
                      child: Text(
                        "Already have an account? Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

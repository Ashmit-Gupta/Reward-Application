import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/view_models/login_view_model.dart';
import 'package:reward_app/view_models/services/validate_email_pwd.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/home_view_model.dart';
import 'components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.clear();
    _pwdController.clear();
    _obsecurePassword.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _emailFocusNode.dispose();
    _pwdFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, loginViewModel, Widget? child) {
        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login_bg.jpg'),
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
                      // Logo
                      const Text(
                        "Welcome Back!",
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
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(
                              context, _emailFocusNode, _pwdFocusNode);
                        },
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
                            focusNode: _pwdFocusNode,
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
                      // Login Button
                      RoundedButton(
                        title: "Login",
                        loading: loginViewModel.loginResource.status ==
                            Status.LOADING,
                        onPress: () async {
                          String? emailError = ValidationService.validateEmail(
                              _emailController.text);
                          String? pwdError = ValidationService.validatePassword(
                              _pwdController.text);
                          if (emailError != null) {
                            Utils.flushBarErrorMessage(emailError, context);
                          } else if (pwdError != null) {
                            Utils.flushBarErrorMessage(pwdError, context);
                          } else {
                            await loginViewModel.login(
                                _emailController.text, _pwdController.text);
                            switch (loginViewModel.loginResource.status) {
                              case Status.COMPLETED:
                                // Utils.flushBarSuccessfullMessage(
                                //     "Login Successful", context); // not working
                                loginViewModel.clearState();
                                context
                                    .read<HomeViewModel>()
                                    .fetchUserRewards();

                                Navigator.pushReplacementNamed(
                                    context, RoutesName.home);
                                break;
                              case Status.ERROR:
                                Utils.flushBarErrorMessage(
                                    "login failed : ${loginViewModel.loginResource.message}",
                                    context);
                                break;
                              default:
                                break;
                            }
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      // Sign-Up Option
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.signUp);
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //or use a consumer widget/*Use a Consumer<SignUpViewModel> to rebuild the widget when the state changes (like setting status to LOADING).
              // The CircularProgressIndicator is now inside the Consumer, so it's always rebuilt when status changes.
              // UI updates (like showing progress) are always in sync with the current ViewModel state.*/
              if (loginViewModel.loginResource.status == Status.LOADING)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

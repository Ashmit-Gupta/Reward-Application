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
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();

  @override
  void dispose() {
    _obscurePassword.dispose();
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
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Email input field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            focusNode: emailFocusNode,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, emailFocusNode, pwdFocusNode);
            },
            decoration: const InputDecoration(
                hintText: "Email",
                labelText: "Email",
                prefixIcon: Icon(Icons.alternate_email)),
          ),

          const SizedBox(height: 20),

          // Password input field
          Center(
            child: ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (BuildContext context, bool value, Widget? child) {
                return TextFormField(
                  controller: _pwdController,
                  focusNode: pwdFocusNode,
                  obscureText: _obscurePassword.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_open_outlined),
                    suffixIcon: InkWell(
                      onTap: () {
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                      child: Icon(
                        _obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 40),

          // Signup button
          RoundedButton(
            title: "Sign Up",
            loading: authViewModel.authResource.status == Status.LOADING,
            onPress: () async {
              if (_emailController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please Enter Email", context);
              } else if (_pwdController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please Enter Password", context);
              } else if (_pwdController.text.length < 6) {
                Utils.flushBarErrorMessage(
                    "The Password must be greater than 6 characters!", context);
              } else {
                // Set loading state only after validation passes
                await authViewModel.signUp(
                    _emailController.text, _pwdController.text);

                // Handle sign-up result
                if (authViewModel.authResource.status == Status.COMPLETED) {
                  // Redirect to login after successful sign-up
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                } else if (authViewModel.authResource.status == Status.ERROR) {
                  // Show error message
                  Utils.flushBarErrorMessage(
                      " SignUp Failed ${authViewModel.authResource.message}",
                      context);
                  print(authViewModel.authResource.message);
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
              child: Text("Already have an Account? Login"),
            ),
          ),
        ],
      ),
    );
  }
}

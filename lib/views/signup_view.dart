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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();

  @override
  void dispose() {
    _obscurePassword.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _pwdController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // App Logo or Image
              Center(
                child: Image.asset(
                  'assets/images/signup.jpeg', // Add your image here
                  height: 150,
                ),
              ),

              const SizedBox(height: 20),

              // Name input field
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                focusNode: nameFocusNode,
                decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person)),
              ),

              const SizedBox(height: 20),

              // Email input field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email)),
              ),

              const SizedBox(height: 20),

              // Mobile number input field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                focusNode: phoneFocusNode,
                decoration: InputDecoration(
                    hintText: "Mobile Number",
                    labelText: "Mobile Number",
                    prefixIcon: const Icon(Icons.phone)),
              ),

              const SizedBox(height: 20),

              // Password input field
              ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (BuildContext context, value, Widget? child) {
                  return TextFormField(
                    controller: _pwdController,
                    focusNode: pwdFocusNode,
                    obscureText: _obscurePassword.value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
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

              const SizedBox(height: 40),

              // Sign-up button
              RoundedButton(
                title: "Sign Up",
                loading: authViewModel.authResource.status == Status.LOADING,
                onPress: () async {
                  if (_nameController.text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Email", context);
                  } else if (_pwdController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please Enter Password", context);
                  } else if (_pwdController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        "Password should be at least 6 characters", context);
                  } else {
                    await authViewModel.signUp(
                      _nameController.text,
                      _emailController.text,
                      _phoneController.text,
                      _pwdController.text,
                    );
                    if (authViewModel.authResource.status == Status.COMPLETED) {
                      Navigator.pushReplacementNamed(context, RoutesName.home);
                    } else if (authViewModel.authResource.status ==
                        Status.ERROR) {
                      Utils.flushBarErrorMessage(
                          "Sign Up Failed: ${authViewModel.authResource.message}",
                          context);
                    }
                  }
                },
              ),

              const SizedBox(height: 20),

              // Navigate to login
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text(
                  "Already have an account? Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

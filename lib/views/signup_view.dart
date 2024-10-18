import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/view_models/signup_view_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_models/services/validate_email_pwd.dart';
import 'components/rounded_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _pwdController.clear();
    _obsecurePassword.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return Consumer<SignUpViewModel>(
        builder: (context, signUpViewModel, Widget? child) {
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
              color: Colors.black.withOpacity(0.3),
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
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _nameFocusNode,
                      onFieldSubmitted: (value) {
                        Utils.fieldFocusChange(
                            context, _nameFocusNode, _emailFocusNode);
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "name",
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.white),
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
                          onFieldSubmitted: (_) {
                            _pwdFocusNode.unfocus();
                          },
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
                            fillColor: Colors.white.withOpacity(0.5),
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
                      loading: signUpViewModel.signUpResource.status ==
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
                          await signUpViewModel.signUp(_emailController.text,
                              _pwdController.text, _nameController.text);
                          switch (signUpViewModel.signUpResource.status) {
                            case Status.ERROR:
                              Utils.flushBarErrorMessage(
                                  "login failed : ${signUpViewModel.signUpResource.message}",
                                  context);
                              break;
                            case Status.COMPLETED:
                              // Utils.flushBarSuccessfullMessage(
                              //     "SignUp Successful please Login!", context);
                              signUpViewModel.resetSignUpViewModel();
                              Navigator.pushReplacementNamed(
                                  context, RoutesName.login);
                              break;
                            default:
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
            //or use a consumer widget/*Use a Consumer<SignUpViewModel> to rebuild the widget when the state changes (like setting status to LOADING).
            // The CircularProgressIndicator is now inside the Consumer, so it's always rebuilt when status changes.
            // UI updates (like showing progress) are always in sync with the current ViewModel state.*/
            if (signUpViewModel.signUpResource.status == Status.LOADING)
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
    });
  }
}
//todo remove the redundant code from auth and check ohter views for logic in the views
//todo jaab user signin kaar toh uska jo user data h usko fhiala do pure app mai using provider
//todo user signin karne ke baad agar app band kare to again kholne ke badd vo bina login ke ghus jata h
//todo in login and signup when click on right it doesnt move to next field

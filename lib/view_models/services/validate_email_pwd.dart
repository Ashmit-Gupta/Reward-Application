class ValidationService {
  static String? validateEmail(String email) {
    if (email.isEmpty) return "Please Enter Email";
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return "Invalid email format";
    }
    return null; // No error
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return "Please Enter Password";
    if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null; // No error
  }
}

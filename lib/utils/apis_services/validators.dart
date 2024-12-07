class Validators {
  static String? validateName(String name) {
    if (name.isEmpty) return "Name is required.";
    return null;
  }

  static String? validateUsername(String username) {
    if (username.isEmpty) return "Username is required.";
    return null;
  }

  static String? validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return "Phone number is required.";
    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(phoneNumber)) {
      return "Enter a valid phone number.";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return "Password is required.";
    if (password.length < 6) return "Password must be at least 6 characters.";
    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return "Confirm password is required.";
    if (password != confirmPassword) return "Passwords do not match.";
    return null;
  }
}

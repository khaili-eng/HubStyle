class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    if (value.length < 10) {
      return "Password must be at least 10 characters";
    }

    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Full name is required";
    }

    if (value.trim().split(" ").length < 2) {
      return "Enter first and last name";
    }

    return null;
  }

  static String? code(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Verification code required";
    }

    if (value.length != 4) {
      return "Code must be 4 digits";
    }

    return null;
  }
}

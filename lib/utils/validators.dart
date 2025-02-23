class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number.';
    }
    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required.';
    }
    if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // Password validation Log in
  static String? validatePasswordLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  // Validator for First Name & Last Name (Alphabetic, 3-10 chars)
  static String? validateName(String? value) {
    RegExp nameRegex = RegExp(r"^[A-Za-z]{3,10}$");
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!nameRegex.hasMatch(value)) {
      return "Must be alphabetic (3-10 characters)";
    }
    return null;
  }

  // Validator for Sri Lankan Phone Number (07X-XXXXXXX or +947X-XXXXXXX)
  static String? validatePhoneNumber(String? value) {
    RegExp phoneRegex = RegExp(r"^(?:\+94|0)[7][01245678]\d{7}$");
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    } else if (!phoneRegex.hasMatch(value)) {
      return "Invalid phone number (e.g., 0712345678)";
    }
    return null;
  }

  // Validator for Address (6-50 chars)
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Address is required";
    } else if (value.length < 6 || value.length > 50) {
      return "Must be between 6-50 characters";
    }
    return null;
  }
}

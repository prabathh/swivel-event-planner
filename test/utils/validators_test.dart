import 'package:flutter_test/flutter_test.dart';
import 'package:event_planner_app/utils/validators.dart';

void main() {
  
  group('Email Validation', () {
    test('should return error when email is empty', () {
      expect(Validators.validateEmail(''), 'Email is required.');
    });

    test('should return error when email is invalid', () {
      expect(
        Validators.validateEmail('invalidEmail'),
        'Please enter a valid email address.',
      );
    });

    test('should return null when email is valid', () {
      expect(Validators.validateEmail('test@example.com'), isNull);
    });
  });

  group('Password Validation', () {
    test('should return error when password is empty', () {
      expect(Validators.validatePassword(''), 'Password is required.');
    });

    test('should return error when password is less than 6 characters', () {
      expect(
        Validators.validatePassword('Abc1'),
        'Password must be at least 6 characters long.',
      );
    });

    test('should return error when password lacks an uppercase letter', () {
      expect(
        Validators.validatePassword('abcdef1'),
        'Password must contain at least one uppercase letter.',
      );
    });

    test('should return error when password lacks a lowercase letter', () {
      expect(
        Validators.validatePassword('ABCDEF1'),
        'Password must contain at least one lowercase letter.',
      );
    });

    test('should return error when password lacks a number', () {
      expect(
        Validators.validatePassword('Abcdef'),
        'Password must contain at least one number.',
      );
    });

    test('should return null when password is valid', () {
      expect(Validators.validatePassword('Abcdef1'), isNull);
    });
  });

  group('Confirm Password Validation', () {
    test('should return error when confirm password is empty', () {
      expect(
        Validators.validateConfirmPassword('', 'password123'),
        'Confirm password is required.',
      );
    });

    test('should return error when passwords do not match', () {
      expect(
        Validators.validateConfirmPassword('password456', 'password123'),
        'Passwords do not match.',
      );
    });

    test('should return null when passwords match', () {
      expect(
        Validators.validateConfirmPassword('password123', 'password123'),
        isNull,
      );
    });
  });

  group('Password Login Validation', () {
    test('should return error when password is empty', () {
      expect(Validators.validatePasswordLogin(''), 'Password is required.');
    });

    test('should return null when password is provided', () {
      expect(Validators.validatePasswordLogin('password123'), isNull);
    });
  });

  group('Name Validation', () {
    test('should return error when name is empty', () {
      expect(Validators.validateName(''), 'This field is required');
    });

    test('should return error when name is too short', () {
      expect(
        Validators.validateName('Jo'),
        'Must be alphabetic (3-10 characters)',
      );
    });

    test(
      'should return error when name contains non-alphabetic characters',
      () {
        expect(
          Validators.validateName('John123'),
          'Must be alphabetic (3-10 characters)',
        );
      },
    );

    test('should return null when name is valid', () {
      expect(Validators.validateName('John'), isNull);
    });
  });

  group('Phone Number Validation', () {
    test('should return error when phone number is empty', () {
      expect(Validators.validatePhoneNumber(''), 'Phone number is required');
    });

    test('should return error when phone number format is invalid', () {
      expect(
        Validators.validatePhoneNumber('12345678'),
        'Invalid phone number (e.g., 0712345678)',
      );
    });

    test('should return null when phone number is valid', () {
      expect(Validators.validatePhoneNumber('0712345678'), isNull);
      expect(Validators.validatePhoneNumber('+94712345678'), isNull);
    });
  });

  group('Address Validation', () {
    test('should return error when address is empty', () {
      expect(Validators.validateAddress(''), 'Address is required');
    });

    test('should return error when address is too short', () {
      expect(
        Validators.validateAddress('123'),
        'Must be between 6-50 characters',
      );
    });

    test('should return error when address is too long', () {
      expect(
        Validators.validateAddress('a' * 51),
        'Must be between 6-50 characters',
      );
    });

    test('should return null when address is valid', () {
      expect(Validators.validateAddress('123 Main Street'), isNull);
    });
  });
}

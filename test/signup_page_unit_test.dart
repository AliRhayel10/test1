import 'package:flutter_test/flutter_test.dart';
import 'package:test1/Model/User.dart';

/// Simulates the logic of signing up a user.
String signupUser({
  required String username,
  required String email,
  required String password,
  required String confirmPassword,
  required bool agreeTerms,
  required List<User> usersList,
}) {
  if (username.isEmpty || email.isEmpty || password.isEmpty) {
    return 'All fields are required';
  }

  if (password.length < 6) {
    return 'Password must be at least 6 characters';
  }

  if (password != confirmPassword) {
    return 'Passwords do not match';
  }

  if (!agreeTerms) {
    return 'You must agree to terms & conditions.';
  }

  usersList.add(User(username: username, email: email, password: password));
  return 'Sign up successful!';
}

void main() {
  group('Signup logic tests', () {
    late List<User> users;

    setUp(() {
      users = [];
    });

    test('Successful signup adds user to the list', () {
      final message = signupUser(
        username: 'Ali',
        email: 'ali@example.com',
        password: '123456',
        confirmPassword: '123456',
        agreeTerms: true,
        usersList: users,
      );

      expect(message, 'Sign up successful!');
      expect(users.length, 1);
      expect(users.first.email, 'ali@example.com');
    });

    test('Rejects if password is too short', () {
      final message = signupUser(
        username: 'Ali',
        email: 'ali@example.com',
        password: '123',
        confirmPassword: '123',
        agreeTerms: true,
        usersList: users,
      );

      expect(message, 'Password must be at least 6 characters');
      expect(users.isEmpty, true);
    });

    test('Rejects if passwords do not match', () {
      final message = signupUser(
        username: 'Ali',
        email: 'ali@example.com',
        password: '123456',
        confirmPassword: '654321',
        agreeTerms: true,
        usersList: users,
      );

      expect(message, 'Passwords do not match');
      expect(users.isEmpty, true);
    });

    test('Rejects if terms are not agreed', () {
      final message = signupUser(
        username: 'Ali',
        email: 'ali@example.com',
        password: '123456',
        confirmPassword: '123456',
        agreeTerms: false,
        usersList: users,
      );

      expect(message, 'You must agree to terms & conditions.');
      expect(users.isEmpty, true);
    });

    test('Rejects if fields are missing', () {
      final message = signupUser(
        username: '',
        email: '',
        password: '',
        confirmPassword: '',
        agreeTerms: true,
        usersList: users,
      );

      expect(message, 'All fields are required');
    });
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:test1/Model/User.dart';

/// Simple logic function to validate user credentials
bool validateCredentials({
  required String email,
  required String password,
  required List<User> users,
}) {
  return users.any(
      (user) => user.email.trim() == email.trim() && user.password == password);
}

void main() {
  group('Login Credentials Validation', () {
    final mockUsers = [
      User(
        username: 'alirhayel',
        email: 'alirhayel10@icloud.com',
        password: '123123123',
      ),
      User(
        username: 'testUser',
        email: 'test@example.com',
        password: 'password123',
      ),
    ];

    test('Valid credentials return true', () {
      final result = validateCredentials(
        email: 'alirhayel10@icloud.com',
        password: '123123123',
        users: mockUsers,
      );
      expect(result, isTrue);
    });

    test('Incorrect password returns false', () {
      final result = validateCredentials(
        email: 'alirhayel10@icloud.com',
        password: 'wrongpass',
        users: mockUsers,
      );
      expect(result, isFalse);
    });

    test('Non-existent email returns false', () {
      final result = validateCredentials(
        email: 'not@found.com',
        password: '123123123',
        users: mockUsers,
      );
      expect(result, isFalse);
    });

    test('Email with leading/trailing spaces still passes', () {
      final result = validateCredentials(
        email: '  alirhayel10@icloud.com  ',
        password: '123123123',
        users: mockUsers,
      );
      expect(result, isTrue);
    });
  });
}

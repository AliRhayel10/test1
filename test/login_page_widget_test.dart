import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test1/Model/User.dart';
import 'package:test1/Screens/login_page.dart';

void main() {
  final List<User> testUsers = [
    User(
      username: 'alirhayel',
      email: 'alirhayel10@icloud.com',
      password: '123123123',
    ),
  ];

  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(registeredUsers: testUsers),
      ),
    );

    // Find widgets by key
    final signInButton = find.byKey(const Key('signInButton'));
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));

    // Verify UI elements
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    // Tap Sign In with empty fields (scroll into view first)
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);

    // Enter short password to trigger length validation
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, '123');

    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);

    // Enter invalid credentials
    // Invalid login
    await tester.enterText(emailField, 'wrong@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.text('Invalid email or password'), findsOneWidget);

// Wait for SnackBar to disappear
    await tester.pumpAndSettle(const Duration(seconds: 3));

// Valid login
    await tester.enterText(emailField, 'alirhayel10@icloud.com');
    await tester.enterText(passwordField, '123123123');
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.text('Login successful!'), findsOneWidget);

    expect(find.byType(SnackBar), findsOneWidget);
  });
}

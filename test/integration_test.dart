import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:test1/Model/User.dart';
import 'package:test1/Screens/login_page.dart';
import 'package:test1/Screens/signup_page.dart';
import 'package:test1/Widgets/custom_name_field.dart';
import 'package:test1/Widgets/custom_password_text_field.dart';
import 'package:test1/Widgets/custom_text_field.dart';

void main() {
  testWidgets('Signup and then login flow', (WidgetTester tester) async {
        final List<User> registeredUsers = [];


    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(registeredUsers: registeredUsers),
          '/signup': (context) => const SignupPage(registeredUsers: [],),
        },
      ),
    );

    // On login page initially - tap 'Sign Up' button to go to SignupPage
    final signUpNavButton = find.widgetWithText(TextButton, 'Sign Up');
    expect(signUpNavButton, findsOneWidget);

    await tester.ensureVisible(signUpNavButton);
    await tester.tap(signUpNavButton);
    await tester.pumpAndSettle();

    // Find Signup form fields & button
    final usernameField = find.byType(CustomUsernameField);
    final emailField = find.byType(CustomTextField);
    final passwordField =
        find.widgetWithText(PasswordField, 'Enter your password');
    final confirmPasswordField =
        find.widgetWithText(PasswordField, 'Confirm your password');
    final termsCheckbox = find.widgetWithText(
        CheckboxListTile, "I agree to terms & conditions and privacy policy");
    final signUpButton = find.byKey(const Key('signUpButton'));

    // Fill signup form

    await tester.ensureVisible(usernameField);
    await tester.enterText(usernameField, 'TestUser');

    await tester.ensureVisible(emailField);
    await tester.enterText(emailField, 'test@example.com');

    await tester.ensureVisible(passwordField);
    await tester.enterText(passwordField, '123456');

    await tester.ensureVisible(confirmPasswordField);
    await tester.enterText(confirmPasswordField, '123456');

    // Agree to terms
    await tester.ensureVisible(termsCheckbox);
    await tester.tap(termsCheckbox);
    await tester.pumpAndSettle();

    // Tap Sign Up
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // Expect success SnackBar
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Sign up successful!'), findsOneWidget);

    // Wait for navigation to login page (SignupPage delays 3 seconds before nav)
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // On login page, find login fields and button
    final loginEmailField = find.byKey(const Key('emailField'));
    final loginPasswordField = find.byKey(const Key('passwordField'));
    final signInButton = find.byKey(const Key('signInButton'));

    expect(loginEmailField, findsOneWidget);
    expect(loginPasswordField, findsOneWidget);
    expect(signInButton, findsOneWidget);

    // Enter login credentials
    await tester.ensureVisible(loginEmailField);
    await tester.enterText(loginEmailField, 'test@example.com');
    await tester.ensureVisible(loginPasswordField);
    await tester.enterText(loginPasswordField, '123456');

    // Tap Sign In
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    // Expect login success SnackBar
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Login successful!'), findsOneWidget);
  });
}

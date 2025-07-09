import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test1/Model/User.dart';
import 'package:test1/Screens/login_page.dart';
import 'package:test1/Screens/signup_page.dart';
import 'package:test1/Widgets/custom_name_field.dart';
import 'package:test1/Widgets/custom_password_text_field.dart';
import 'package:test1/Widgets/custom_text_field.dart';

void main() {
  testWidgets('SignupPage widget test', (WidgetTester tester) async {
    final List<User> registeredUsers = [];

    await tester.pumpWidget(
      MaterialApp(
        home: const SignupPage(
          registeredUsers: [],
        ),
        routes: {
          '/login': (_) => LoginPage(registeredUsers: []),
        },
      ),
    );

    // Find widgets by type or key
    final usernameField = find.byType(CustomUsernameField);
    final emailField = find.byType(CustomTextField);
    final passwordField =
        find.widgetWithText(PasswordField, 'Enter your password');
    final confirmPasswordField =
        find.widgetWithText(PasswordField, 'Confirm your password');
    final signUpButton = find.byKey(const Key('signUpButton'));
    final termsCheckbox = find.widgetWithText(
        CheckboxListTile, "I agree to terms & conditions and privacy policy");

    // UI presence
    expect(find.text('Sign Up'), findsNWidgets(2)); // title + button
    expect(usernameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(confirmPasswordField, findsOneWidget);
    expect(signUpButton, findsOneWidget);
    expect(termsCheckbox, findsOneWidget);

    // Tap Sign Up with empty fields
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.text('Password is required'), findsOneWidget);

    // Enter password and mismatched confirm password
    await tester.enterText(passwordField, '123456');
    await tester.enterText(confirmPasswordField, '654321');
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match'), findsOneWidget);

    // Fill all fields with valid data but don't agree to terms
    await tester.enterText(usernameField, 'TestUser');
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, '123456');
    await tester.enterText(confirmPasswordField, '123456');

    // Confirm terms checkbox initially false
    expect(tester.widget<CheckboxListTile>(termsCheckbox).value, false);

    // Tap Sign Up again (without checking checkbox)
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.text('You must agree to terms & conditions.'), findsOneWidget);

    // Check the terms checkbox
    await tester.tap(termsCheckbox);
    await tester.pumpAndSettle();

    // Ensure checkbox is now true
    expect(tester.widget<CheckboxListTile>(termsCheckbox).value, true);

    // Tap Sign Up with everything correct
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle(const Duration(seconds: 3)); // settle animation

    // Expect success SnackBar
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Sign up successful!'), findsOneWidget);

    // Verify user was added
    expect(
      registeredUsers.any((user) => user.email == 'test@example.com'),
      isTrue,
    );
  });
}

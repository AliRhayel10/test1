import 'package:flutter/material.dart';
import 'package:test1/Model/User.dart';
import 'package:test1/Screens/login_page.dart';
import 'package:test1/Widgets/custom_name_field.dart';
import 'package:test1/Widgets/custom_password_text_field.dart';
import 'package:test1/Widgets/custom_text_field.dart';
import 'package:test1/Widgets/mainbutton.dart';

class SignupPage extends StatefulWidget {
  final List<User> registeredUsers;
  const SignupPage({super.key, required this.registeredUsers});

  @override
  State<SignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Checkboxes state
  bool _wantCatalogue = false;
  bool _dataConsent = false;
  bool _receiveNewsletters = false;
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            const Center(
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Enter your name, email and password for sign up. Already have an account?",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),

            // White container
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        const Text("Username", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),

                        // Name Field
                        CustomUsernameField(
                          controller: _usernameController,
                          hintText: 'Enter your name',
                        ),

                        const SizedBox(height: 20),

                        const Text("Email", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),

                        // Email field
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Enter your email',
                        ),

                        const SizedBox(height: 20),

                        const Text("Password", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),

                        // Password field
                        PasswordField(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        const Text("Confirm Password",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),

                        // Confirm Password field
                        PasswordField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm your password',
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Checkbox 1
                        CheckboxListTile(
                          value: _wantCatalogue,
                          onChanged: (value) {
                            setState(() {
                              _wantCatalogue = value ?? false;
                            });
                          },
                          title: const Text(
                              "Would you like to have your own catalogue?"),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),

                        // Checkbox 2
                        CheckboxListTile(
                          value: _dataConsent,
                          onChanged: (value) {
                            setState(() {
                              _dataConsent = value ?? false;
                            });
                          },
                          title: const Text("Data usage consent"),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),

                        // Checkbox 3
                        CheckboxListTile(
                          value: _receiveNewsletters,
                          onChanged: (value) {
                            setState(() {
                              _receiveNewsletters = value ?? false;
                            });
                          },
                          title: const Text("Receive newsletters"),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),

                        // Checkbox 4
                        CheckboxListTile(
                          value: _agreeTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeTerms = value ?? false;
                            });
                          },
                          title: const Text(
                            "I agree to terms & conditions and privacy policy",
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),

                        const SizedBox(height: 10),

                        // Sign Up Button
                        Button(
                          key: const Key('signUpButton'),
                          text: 'Sign Up',
                          textColor: Colors.black,
                          buttonColor: Colors.deepOrange,
                          width: double.maxFinite,
                          height: 48,
                          borderColor: Colors.deepOrange,
                          fontSize: 16,
                          func: () {
                            if (_formKey.currentState!.validate()) {
                              if (!_agreeTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'You must agree to terms & conditions.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              widget.registeredUsers.add(User(
                                username: _usernameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign up successful!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Future.delayed(const Duration(seconds: 3), () {
                                  if (mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(
                                            registeredUsers:
                                                widget.registeredUsers),
                                      ),
                                    );
                                  }
                                });
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

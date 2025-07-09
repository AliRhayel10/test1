import 'package:flutter/material.dart';
import 'package:test1/Model/User.dart';
import 'package:test1/Screens/signup_page.dart';
import 'package:test1/Widgets/custom_password_text_field.dart';
import 'package:test1/Widgets/custom_text_field.dart';
import 'package:test1/Widgets/mainbutton.dart';

class LoginPage extends StatefulWidget {
  final List<User> registeredUsers;

  const LoginPage({super.key, required this.registeredUsers});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo[900],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Enter your email address to sign in. Enjoy your food.",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // White container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),

                      const Text("Email", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),

                      // Email field Widget with Key
                      CustomTextField(
                        key: const Key('emailField'),
                        controller: _emailController,
                        hintText: 'Email address',
                      ),

                      const SizedBox(height: 20),

                      const Text("Password", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),

                      // Password field Widget with Key
                      PasswordField(
                        key: const Key('passwordField'),
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

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Forgot Password!',
                            style: TextStyle(
                              color: Colors.deepOrange[200],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Sign In Button with Key
                      Button(
                        key: const Key('signInButton'),
                        text: 'Sign In',
                        textColor: Colors.black,
                        buttonColor: Colors.deepOrange,
                        width: double.maxFinite,
                        height: 48,
                        borderColor: Colors.deepOrange,
                        fontSize: 16,
                        func: () {
                          if (_formKey.currentState!.validate()) {
                            final inputEmail = _emailController.text.trim();
                            final inputPassword = _passwordController.text;

                            bool userFound = false;

                            for (var user in widget.registeredUsers) {
                              if (user.email == inputEmail &&
                                  user.password == inputPassword) {
                                userFound = true;
                                break;
                              }
                            }

                            if (userFound) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login successful!'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                if (mounted) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/products',
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid email or password'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(
                                      registeredUsers: widget.registeredUsers),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.deepOrange[200],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

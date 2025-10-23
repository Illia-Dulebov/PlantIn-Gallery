import 'package:flutter/material.dart';
import 'package:gallery/features/authentication/widgets/login_button.dart';
import 'package:gallery/features/authentication/widgets/login_error_message.dart';
import 'package:gallery/features/gallery/screens/pictures_gallery_screen.dart';
import 'package:provider/provider.dart';
import 'package:gallery/features/authentication/state/authentication_notifier.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Log In',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              LoginErrorMessage(message: errorMessage),
              LoginButton(onPressed: _onLoginPressed),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onLoginPressed() async {
    setState(() {
      errorMessage = null;
    });

    context
        .read<AuthenticationNotifier>()
        .logIn(emailController.text.trim(), passwordController.text.trim())
        .then((value) {
          if (value && mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PicturesGalleryScreen()),
              (route) => false,
            );
          } else {
            setState(() => errorMessage = 'Login failed. Try again.');
          }
        });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        errorMessage = null;
      });
    });
  }
}

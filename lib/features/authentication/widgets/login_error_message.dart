import 'package:flutter/material.dart';

class LoginErrorMessage extends StatelessWidget {
  final String? message;

  const LoginErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message != null ?
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          message!,
          style: const TextStyle(color: Colors.red),
        ),
      ) : const SizedBox.shrink();
  }
}

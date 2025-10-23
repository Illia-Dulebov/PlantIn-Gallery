import 'package:flutter/material.dart';
import 'package:gallery/features/authentication/models/auth_status.dart';
import 'package:gallery/features/authentication/state/authentication_notifier.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Selector<AuthenticationNotifier, AuthStatus>(
      selector: (context, notifier) => notifier.authStatus,
      shouldRebuild: (prev, next) => true,
      builder: (context, status, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: status == AuthStatus.loggingIn  ? null : onPressed,
                child:
                status == AuthStatus.loggingIn
                        ? SizedBox(
                          height: 20,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                        : const Text('Continue'),
              ),
            ),
          ],
        );
      },
    );
  }
}

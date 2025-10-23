import 'package:flutter/material.dart';
import 'package:gallery/core/di/dependencies.dart';
import 'package:gallery/core/di/providers.dart';
import 'package:gallery/features/authentication/models/auth_status.dart';
import 'package:gallery/features/authentication/screens/login_screen.dart';
import 'package:gallery/features/gallery/screens/pictures_gallery_screen.dart';
import 'package:provider/provider.dart';
import 'package:gallery/features/authentication/state/authentication_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await AppDiService.init();
  runApp(GalleryApp(dependencies: dependencies));
}

class GalleryApp extends StatelessWidget {
  final AppDependencies dependencies;

  const GalleryApp({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      dependencies: dependencies,
      child: MaterialApp(
        title: 'Gallery App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Selector<AuthenticationNotifier, AuthStatus>(
          selector: (_, auth) => auth.authStatus,
          builder: (context, state, _) {
            if (state == AuthStatus.unknown || state == AuthStatus.checking) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return state == AuthStatus.authenticated
                ? const PicturesGalleryScreen()
                : const LoginScreen();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gallery/core/di/dependencies.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final AppDependencies dependencies;
  final Widget child;

  const AppProviders({super.key, required this.dependencies, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: dependencies.prefs),
        Provider.value(value: dependencies.dio),
        Provider.value(value: dependencies.authRepository),
        Provider.value(value: dependencies.picturesRepository),
        ChangeNotifierProvider.value(value: dependencies.authNotifier),
        ChangeNotifierProvider.value(value: dependencies.picturesNotifier),
      ],
      child: child,
    );
  }
}

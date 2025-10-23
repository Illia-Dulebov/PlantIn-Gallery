import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/pictures_notifier.dart';

class PicturesLazyLoader extends StatelessWidget {
  const PicturesLazyLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<PicturesNotifier, bool>(
      selector: (context, notifier) => notifier.isLoading,
      builder: (context, isLoading, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isLoading ? 1.0 : 0.0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

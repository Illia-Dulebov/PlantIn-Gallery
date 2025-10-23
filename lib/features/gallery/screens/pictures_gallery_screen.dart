import 'package:flutter/material.dart';
import 'package:gallery/features/authentication/screens/login_screen.dart';
import 'package:gallery/features/authentication/state/authentication_notifier.dart';
import 'package:gallery/features/gallery/models/picture.dart';
import 'package:gallery/features/gallery/state/pictures_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/pictures_grid.dart';
import '../widgets/pictures_lazy_loader.dart';

class PicturesGalleryScreen extends StatefulWidget {
  const PicturesGalleryScreen({super.key});

  @override
  State<PicturesGalleryScreen> createState() => _PicturesGalleryScreenState();
}

class _PicturesGalleryScreenState extends State<PicturesGalleryScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PicturesNotifier>().fetchPictures();
    });
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<PicturesNotifier>().fetchPictures();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationNotifier>().logOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Selector<PicturesNotifier, List<Picture>>(
              selector:
                  (context, notifier) => List.unmodifiable(notifier.pictures),
              builder: (context, pictures, child) {
                if (pictures.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Stack(
                  children: [
                    PicturesGrid(
                      pictures: pictures,
                      scrollController: scrollController,
                    ),
                    PicturesLazyLoader(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<PicturesNotifier>().pickImage,
        child: const Icon(Icons.add),
      ),
    );
  }
}

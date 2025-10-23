import 'package:flutter/material.dart';
import 'package:gallery/features/gallery/widgets/picture_item.dart';

class PicturesGrid extends StatelessWidget {
  final ScrollController scrollController;
  final List pictures;

  const PicturesGrid({
    super.key,
    required this.scrollController,
    required this.pictures,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.2,
      children: List.generate(pictures.length, (index) {
        return PictureItem(picture: pictures[index]);
      }),
    );
  }
}

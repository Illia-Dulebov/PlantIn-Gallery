import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery/features/gallery/models/picture.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/picture_screen.dart';

class PictureItem extends StatelessWidget {
  final Picture picture;
  final BoxFit fit;
  final bool onTapDisabled;

  const PictureItem({
    super.key,
    required this.picture,
    this.fit = BoxFit.cover,
    this.onTapDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return Hero(
      tag: picture.id ?? picture.downloadUrl ?? "",
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildCachedImage(picture),
            if (!onTapDisabled)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: borderRadius,
                  onTap: () => _onTap(context, picture),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCachedImage(Picture picture) {
    final shimmer = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(color: Colors.grey.shade300),
    );

    if (picture.imageData != null) {
      return CachedNetworkImage(
        imageUrl:
            "https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=687",
        imageBuilder:
            (context, _) => Image.memory(picture.imageData!, fit: fit),
        placeholder: (_, __) => shimmer,
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      );
    }

    return CachedNetworkImage(
      imageUrl: picture.downloadUrl ?? "",
      fit: fit,
      placeholder: (_, __) => shimmer,
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }

  void _onTap(BuildContext context, Picture picture) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PictureScreen(picture: picture),
      ),
    );
  }
}

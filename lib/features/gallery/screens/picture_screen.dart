import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/download_status.dart';
import '../models/picture.dart';
import '../state/pictures_notifier.dart';
import '../widgets/picture_item.dart';
import '../widgets/picture_metadata.dart';

class PictureScreen extends StatefulWidget {
  final Picture picture;

  const PictureScreen({super.key, required this.picture});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late final PicturesNotifier _notifier;


  @override
  void initState() {
    super.initState();

    _notifier = context.read<PicturesNotifier>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _listenToDownloadStatus(),
    );
  }

  @override
  void dispose() {
    _notifier.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: BackButton(color: Colors.black)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: getAspectRatio(),
                child: PictureItem(
                  picture: widget.picture,
                  fit: BoxFit.contain,
                  onTapDisabled: true,
                ),
              ),
              const SizedBox(height: 8.0),
              PictureMetadata(picture: widget.picture),
            ],
          ),
        ),
    );
  }

  void _listenToDownloadStatus() {
    final notifier = context.read<PicturesNotifier>();

    notifier.addListener(() {
      final status = notifier.downloadStatus;
      if (status != DownloadStatus.idle) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(status.message)));
      }
    });
  }

  double getAspectRatio() {
    if (widget.picture.width != null && widget.picture.height != null) {
      return widget.picture.width! / widget.picture.height!;
    }
    return 16 / 9;
  }
}

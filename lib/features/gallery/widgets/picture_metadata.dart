import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/core/widgets/dialog_modal_window.dart';
import 'package:gallery/features/gallery/models/picture.dart';
import 'package:provider/provider.dart';

import '../state/pictures_notifier.dart';

class PictureMetadata extends StatelessWidget {
  final Picture picture;

  const PictureMetadata({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Meta info',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Author: ${picture.author}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 4.0),
        if (picture.downloadUrl != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Download link:',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  _onLinkTap(context, picture);
                },
                child: Text(
                  '${picture.downloadUrl}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _onLinkTap(BuildContext context, Picture picture) {
    showCupertinoDialog<void>(
      context: context,
      builder:
          (BuildContext context) => DialogModalWindow(
            content: 'Download picture?',
            onConfirm: () {
              _onDownloadTap(context, picture);
            },
          ),
    );
  }

  _onDownloadTap(BuildContext context, Picture picture) {
    context.read<PicturesNotifier>().downloadPicture(picture);
  }
}

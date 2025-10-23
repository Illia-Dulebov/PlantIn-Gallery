import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:gallery/core/models/download_status.dart';
import 'package:gallery/features/gallery/models/picture.dart';
import 'package:gallery/features/gallery/repositories/dio_pictures_repository.dart';
import 'package:image_picker/image_picker.dart';

class PicturesNotifier extends ChangeNotifier {
  final DioPicturesRepository _repository;
  final ImagePicker _imagePicker = ImagePicker();

  PicturesNotifier(this._repository);

  final List<Picture> _pictures = [];

  int page = 0;
  bool isLoading = false;

  DownloadStatus downloadStatus = DownloadStatus.idle;

  UnmodifiableListView<Picture> get pictures => UnmodifiableListView(_pictures);

  Future<void> fetchPictures() async {
    if (isLoading || page > 10) return;

    isLoading = true;
    notifyListeners();

    _pictures.addAll(await _repository.getPicturesList(page: page));
    page += 1;

    isLoading = false;
    notifyListeners();
  }

  Future<void> downloadPicture(Picture picture) async {
    downloadStatus = DownloadStatus.inProgress;
    _repository
        .downloadPicture(picture)
        .then((value) {
          downloadStatus = DownloadStatus.completed;
          notifyListeners();
        })
        .catchError((_) {
          downloadStatus = DownloadStatus.failed;
          notifyListeners();
        });
  }

  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    final pictureBytes = await pickedFile?.readAsBytes();
    if(pictureBytes != null) {
      final Picture picture = Picture.fromByteData(pictureBytes);
      _pictures.insert(0, picture);
      notifyListeners();
    }
  }
}

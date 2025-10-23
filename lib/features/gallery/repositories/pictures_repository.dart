import 'package:gallery/features/gallery/models/picture.dart';

abstract interface class PicturesRepository {
  Future<List<Picture>> getPicturesList();
  void downloadPicture(Picture picture);
}
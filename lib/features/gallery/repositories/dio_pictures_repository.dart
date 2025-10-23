import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/features/gallery/models/picture.dart';
import 'package:gallery/features/gallery/repositories/pictures_repository.dart';
import 'package:path_provider/path_provider.dart';

class DioPicturesRepository implements PicturesRepository {
  DioPicturesRepository(this.dio);

  final Dio dio;

  @override
  Future<List<Picture>> getPicturesList({int page = 0}) async {
    final result = await dio.get('/v2/list?page=$page&limit=20');

    return List.from(result.data).map((e) => Picture.fromJson(e)).toList();
  }

  @override
  Future<void> downloadPicture(Picture picture) async {
    if (picture.downloadUrl == null) return;
    dio
        .get(
          picture.downloadUrl!,
          options: Options(responseType: ResponseType.bytes),
        )
        .then((value) async {
          try {
            final dir = await getTemporaryDirectory();
            String filename =
                '${dir.path}/SaveImage${picture.id ?? DateTime.now().millisecondsSinceEpoch}.png';
            final file = File(filename);
            await file.writeAsBytes(value.data);
            debugPrint('Picture saved to $filename');
          } catch (e) {
            throw Exception('Error saving picture: $e');
          }
        });
  }
}

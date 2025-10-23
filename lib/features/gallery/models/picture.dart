import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Picture extends Equatable {
  final String? id;
  final String? author;
  final double? width;
  final double? height;
  final String? url;
  final String? downloadUrl;
  final Uint8List? imageData;

  const Picture({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
    this.imageData,
  });

  factory Picture.fromByteData(Uint8List data) {
    return Picture(
      id: Uuid().v4().toString(),
      author: 'You',
      imageData: data,
    );
  }

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      author: json['author'],
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      url: json['url'],
      downloadUrl: json['download_url'],
    );
  }

  @override
  List<Object?> get props => [id, author, width, height, url, downloadUrl, imageData];
}

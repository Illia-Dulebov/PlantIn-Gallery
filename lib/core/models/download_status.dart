enum DownloadStatus {
  idle('Idle'),
  inProgress('Downloading...'),
  completed('Download complete!'),
  failed('Download failed!');

  final String message;
  const DownloadStatus(this.message);
}
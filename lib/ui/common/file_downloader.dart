import 'file_downloader_stub.dart'
    if (dart.library.html) 'file_downloader_web.dart'
    if (dart.library.io) 'file_downloader_io.dart';

abstract class FileDownloader {
  static Future<bool> download({
    required String filename,
    required String content,
  }) {
    return downloadFile(filename: filename, content: content);
  }
}

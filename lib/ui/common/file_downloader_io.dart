import 'dart:io';
import 'package:flutter/foundation.dart';

Future<bool> downloadFile({
  required String filename,
  required String content,
}) async {
  try {
    final file = File(filename);
    await file.writeAsString(content);
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('FileDownloader IO error: $e');
    }
    return false;
  }
}

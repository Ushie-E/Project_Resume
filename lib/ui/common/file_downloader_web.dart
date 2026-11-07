import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

Future<bool> downloadFile({
  required String filename,
  required String content,
}) async {
  try {
    final bytes = utf8.encode(content);
    final blob = web.Blob(
      [bytes.toJS].toJS,
      web.BlobPropertyBag(type: 'text/plain;charset=utf-8'),
    );
    final url = web.URL.createObjectURL(blob);
    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..setAttribute('download', filename)
      ..style.display = 'none';
    web.document.body?.appendChild(anchor);
    anchor.click();
    anchor.remove();
    web.URL.revokeObjectURL(url);
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('FileDownloader Web error: $e');
    }
    return false;
  }
}

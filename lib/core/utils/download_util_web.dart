import 'dart:html' as html;
import 'package:flutter/foundation.dart';

Future<void> downloadFile(String url, {String? fileName}) async {
  try {
    final String decodedUrl = Uri.decodeFull(url);
    String assetPath = decodedUrl;

    if (assetPath.startsWith('assets/') && !assetPath.startsWith('assets/assets/')) {
      assetPath = 'assets/$assetPath';
    }

    final String encodedUrl = Uri.encodeFull(assetPath);
    final String finalUrl = Uri.base.resolve(encodedUrl).toString();

    final anchor = html.AnchorElement(href: finalUrl)
      ..target = '_blank'
      ..download = fileName ?? 'al_shahriar_mohammad_rafat_resume.pdf';
    
    html.document.body?.children.add(anchor);
    anchor.click();
    anchor.remove();
  } catch (e) {
    if (kDebugMode) print('downloadFile web error: $e');
  }
}

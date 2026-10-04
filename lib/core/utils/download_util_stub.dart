import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile(String url, {String? fileName}) async {
  try {
    final String cleanUrl = Uri.encodeFull(Uri.decodeFull(url));
    Uri uri = Uri.parse(cleanUrl);
    if (!uri.hasScheme) {
      uri = Uri.base.resolve(cleanUrl);
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(uri);
    }
  } catch (e) {
    if (kDebugMode) print('downloadFile stub error: $e');
  }
}

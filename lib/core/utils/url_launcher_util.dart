import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'download_util.dart';

// ─────────────────────────────────────────────────────────────────────────────
// URL LAUNCHER UTILITY
// ─────────────────────────────────────────────────────────────────────────────

class UrlLauncherUtil {
  UrlLauncherUtil._();

  static Future<void> launch(String url) async {
    if (url.isEmpty) return;

    if (url.toLowerCase().endsWith('.pdf') || (url.startsWith('assets/') && !url.contains('://'))) {
      await downloadFile(url, fileName: 'Al_Shahriar_Mohammad_Rafat_Resume.pdf');
      return;
    }

    try {
      final String cleanUrl = Uri.encodeFull(Uri.decodeFull(url));
      Uri uri = Uri.parse(cleanUrl);

      if (!uri.hasScheme) {
        String path = cleanUrl;
        if (kIsWeb && path.startsWith('assets/') && !path.startsWith('assets/assets/')) {
          path = 'assets/$path';
        }
        uri = Uri.base.resolve(path);
      }

      final can = await canLaunchUrl(uri);
      if (can) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (kDebugMode) print('UrlLauncherUtil: Failed to launch $url — $e');
      try {
        final fallbackUri = Uri.base.resolve(url);
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } catch (_) {}
    }
  }

  static Future<void> launchEmail(String email, {String? subject, String? body}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null && subject.isNotEmpty) 'subject': subject,
        if (body != null && body.isNotEmpty) 'body': body,
      },
    );
    await launch(uri.toString());
  }

  static Future<void> launchGitHub(String url) => launch(url);
  static Future<void> launchLinkedIn(String url) => launch(url);
  static Future<void> launchDiscord(String url) => launch(url);
}

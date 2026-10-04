import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────────────────────────────────────
// URL LAUNCHER UTILITY
// ─────────────────────────────────────────────────────────────────────────────

class UrlLauncherUtil {
  UrlLauncherUtil._();

  static Future<void> launch(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      final can = await canLaunchUrl(uri);
      if (can) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (kDebugMode) print('UrlLauncherUtil: Failed to launch $url — $e');
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

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
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) print('UrlLauncherUtil: Failed to launch $url — $e');
    }
  }

  static Future<void> launchEmail(String email, {String? subject}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: subject != null ? {'subject': subject} : null,
    );
    await launch(uri.toString());
  }

  static Future<void> launchGitHub(String url) => launch(url);
  static Future<void> launchLinkedIn(String url) => launch(url);
}

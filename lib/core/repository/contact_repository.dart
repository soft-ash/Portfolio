import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../app/constants/profile_constants.dart';
import '../../data/models/contact_message_model.dart';
import '../utils/url_launcher_util.dart';

abstract class ContactRepository {
  Future<bool> sendMessage(ContactMessageModel message);
}

/// EmailJS implementation for live email delivery directly to your inbox.
/// Uses EmailJS REST API (https://api.emailjs.com/api/v1.0/email/send).
class EmailJsContactRepository implements ContactRepository {
  final GetConnect _connect = GetConnect(timeout: const Duration(seconds: 15));

  @override
  Future<bool> sendMessage(ContactMessageModel message) async {
    final bool isConfigured = ProfileConstants.emailJsServiceId.isNotEmpty &&
        !ProfileConstants.emailJsServiceId.startsWith('service_x') &&
        ProfileConstants.emailJsTemplateId.isNotEmpty &&
        !ProfileConstants.emailJsTemplateId.startsWith('template_x') &&
        ProfileConstants.emailJsPublicKey.isNotEmpty &&
        !ProfileConstants.emailJsPublicKey.startsWith('public_x');

    if (!isConfigured) {
      if (kDebugMode) {
        print('EmailJsContactRepository: EmailJS credentials not set in ProfileConstants. Launching direct mail client fallback.');
      }
      await UrlLauncherUtil.launchEmail(
        ProfileConstants.email,
        subject: '[Portfolio] ${message.subject}',
        body: 'From: ${message.name} (${message.email})\n\n${message.message}',
      );
      return true;
    }

    try {
      final response = await _connect.post(
        'https://api.emailjs.com/api/v1.0/email/send',
        {
          'service_id': ProfileConstants.emailJsServiceId,
          'template_id': ProfileConstants.emailJsTemplateId,
          'user_id': ProfileConstants.emailJsPublicKey,
          'template_params': {
            'from_name': message.name,
            'from_email': message.email,
            'name': message.name,
            'email': message.email,
            'reply_to': message.email,
            'subject': message.subject,
            'message': message.message,
            'to_email': ProfileConstants.email,
          },
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.bodyString == 'OK') {
        if (kDebugMode) print('EmailJS: Email sent successfully to ${ProfileConstants.email}');
        return true;
      } else {
        if (kDebugMode) {
          print('EmailJS returned status code ${response.statusCode}: ${response.bodyString}');
        }
        // Fallback to mail client if server returns non-200
        await UrlLauncherUtil.launchEmail(
          ProfileConstants.email,
          subject: '[Portfolio] ${message.subject}',
          body: 'From: ${message.name} (${message.email})\n\n${message.message}',
        );
        return true;
      }
    } catch (e) {
      if (kDebugMode) print('EmailJS Exception: $e');
      await UrlLauncherUtil.launchEmail(
        ProfileConstants.email,
        subject: '[Portfolio] ${message.subject}',
        body: 'From: ${message.name} (${message.email})\n\n${message.message}',
      );
      return true;
    }
  }
}

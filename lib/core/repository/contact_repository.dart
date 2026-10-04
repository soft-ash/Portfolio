import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../app/constants/profile_constants.dart';
import '../../data/models/contact_message_model.dart';

abstract class ContactRepository {
  Future<bool> sendMessage(ContactMessageModel message);
}

/// EmailJS implementation for live background email delivery directly to inbox.
/// Uses EmailJS REST API (https://api.emailjs.com/api/v1.0/email/send).
class EmailJsContactRepository implements ContactRepository {
  final GetConnect _connect = GetConnect(timeout: const Duration(seconds: 15));

  @override
  Future<bool> sendMessage(ContactMessageModel message) async {
    try {
      final payload = {
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
      };

      final response = await _connect.post(
        'https://api.emailjs.com/api/v1.0/email/send',
        jsonEncode(payload),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print('EmailJS Response Code: ${response.statusCode}');
        print('EmailJS Response Body: ${response.bodyString}');
      }

      if (response.statusCode == 200 || response.bodyString == 'OK') {
        if (kDebugMode) print('EmailJS: Message sent successfully to ${ProfileConstants.email}');
        return true;
      } else {
        if (kDebugMode) {
          print('EmailJS Error: Status ${response.statusCode} — ${response.bodyString}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) print('EmailJS Exception: $e');
      return false;
    }
  }
}

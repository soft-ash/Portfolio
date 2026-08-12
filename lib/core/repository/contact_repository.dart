import 'package:flutter/foundation.dart';
import '../../data/models/contact_message_model.dart';

abstract class ContactRepository {
  Future<bool> sendMessage(ContactMessageModel message);
}

/// For now, simulates sending a message.
/// Replace with HTTP POST to your backend API when ready.
class LocalContactRepository implements ContactRepository {
  @override
  Future<bool> sendMessage(ContactMessageModel message) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    if (kDebugMode) {
      print('ContactRepository: Message received:');
      print('  From: ${message.name} <${message.email}>');
      print('  Subject: ${message.subject}');
      print('  Message: ${message.message}');
    }

    // TODO: Replace with actual API call:
    // final response = await http.post(
    //   Uri.parse('https://your-api.com/contact'),
    //   body: message.toJson(),
    // );
    // return response.statusCode == 200;

    return true; // Simulate success
  }
}

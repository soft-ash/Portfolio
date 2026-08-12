import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/contact_message_model.dart';
import '../../../core/repository/contact_repository.dart';

enum ContactStatus { idle, loading, success, error }

class ContactController extends GetxController {
  final ContactRepository _repository = Get.find<ContactRepository>();

  final Rx<ContactStatus> status = ContactStatus.idle.obs;
  final Rxn<String> errorMessage = Rxn();

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> sendMessage() async {
    if (!formKey.currentState!.validate()) return;

    status.value = ContactStatus.loading;
    errorMessage.value = null;

    try {
      final message = ContactMessageModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        subject: subjectController.text.trim(),
        message: messageController.text.trim(),
        sentAt: DateTime.now(),
      );

      final success = await _repository.sendMessage(message);

      if (success) {
        status.value = ContactStatus.success;
        _clearForm();
      } else {
        status.value = ContactStatus.error;
        errorMessage.value = 'Failed to send message. Please try again.';
      }
    } catch (e) {
      status.value = ContactStatus.error;
      errorMessage.value = 'Something went wrong. Please try again.';
    }
  }

  void resetStatus() => status.value = ContactStatus.idle;

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value.trim())) return 'Enter a valid email address';
    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) return 'Subject is required';
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) return 'Message is required';
    if (value.trim().length < 20) return 'Message must be at least 20 characters';
    return null;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — CONTACT MESSAGE
// ─────────────────────────────────────────────────────────────────────────────

class ContactMessageModel {
  const ContactMessageModel({
    this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    this.sentAt,
  });

  final String? id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime? sentAt;

  factory ContactMessageModel.fromJson(Map<String, dynamic> json) =>
      ContactMessageModel(
        id: json['id'] as String?,
        name: json['name'] as String,
        email: json['email'] as String,
        subject: json['subject'] as String,
        message: json['message'] as String,
        sentAt: json['sentAt'] != null
            ? DateTime.tryParse(json['sentAt'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'sentAt': sentAt?.toIso8601String(),
      };
}

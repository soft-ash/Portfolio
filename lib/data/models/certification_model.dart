// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — CERTIFICATION
// ─────────────────────────────────────────────────────────────────────────────

class CertificationModel {
  const CertificationModel({
    required this.id,
    required this.title,
    required this.organization,
    required this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.credentialUrl,
    this.imageAsset,
    this.imageUrl,
    this.description,
  });

  final String id;
  final String title;
  final String organization;
  final String issueDate;
  final String? expiryDate;
  final String? credentialId;
  final String? credentialUrl;
  final String? imageAsset;
  final String? imageUrl;
  final String? description;

  factory CertificationModel.fromJson(Map<String, dynamic> json) =>
      CertificationModel(
        id: json['id'] as String,
        title: json['title'] as String,
        organization: json['organization'] as String,
        issueDate: json['issueDate'] as String,
        expiryDate: json['expiryDate'] as String?,
        credentialId: json['credentialId'] as String?,
        credentialUrl: json['credentialUrl'] as String?,
        imageAsset: json['imageAsset'] as String?,
        imageUrl: json['imageUrl'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'organization': organization,
        'issueDate': issueDate,
        'expiryDate': expiryDate,
        'credentialId': credentialId,
        'credentialUrl': credentialUrl,
        'imageAsset': imageAsset,
        'imageUrl': imageUrl,
        'description': description,
      };
}

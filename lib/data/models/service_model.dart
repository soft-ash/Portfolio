// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — SERVICE
// ─────────────────────────────────────────────────────────────────────────────

class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    this.emojiIcon,
    this.features = const [],
    this.accentColorHex,
  });

  final String id;
  final String title;
  final String description;
  final String? emojiIcon;
  final List<String> features;
  final String? accentColorHex;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        emojiIcon: json['emojiIcon'] as String?,
        features: List<String>.from(json['features'] ?? []),
        accentColorHex: json['accentColorHex'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'emojiIcon': emojiIcon,
        'features': features,
        'accentColorHex': accentColorHex,
      };
}

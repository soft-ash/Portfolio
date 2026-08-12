// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — EXPERIENCE
// ─────────────────────────────────────────────────────────────────────────────

class ExperienceModel {
  const ExperienceModel({
    required this.id,
    required this.company,
    required this.position,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    required this.location,
    required this.description,
    this.responsibilities = const [],
    this.technologies = const [],
    this.achievements = const [],
    this.companyUrl,
    this.logoAsset,
  });

  final String id;
  final String company;
  final String position;
  final String startDate;
  final String? endDate;
  final bool isCurrent;
  final String location;
  final String description;
  final List<String> responsibilities;
  final List<String> technologies;
  final List<String> achievements;
  final String? companyUrl;
  final String? logoAsset;

  String get dateRange => isCurrent ? '$startDate — Present' : '$startDate — ${endDate ?? ""}';

  factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
        id: json['id'] as String,
        company: json['company'] as String,
        position: json['position'] as String,
        startDate: json['startDate'] as String,
        endDate: json['endDate'] as String?,
        isCurrent: json['isCurrent'] as bool? ?? false,
        location: json['location'] as String,
        description: json['description'] as String,
        responsibilities: List<String>.from(json['responsibilities'] ?? []),
        technologies: List<String>.from(json['technologies'] ?? []),
        achievements: List<String>.from(json['achievements'] ?? []),
        companyUrl: json['companyUrl'] as String?,
        logoAsset: json['logoAsset'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company': company,
        'position': position,
        'startDate': startDate,
        'endDate': endDate,
        'isCurrent': isCurrent,
        'location': location,
        'description': description,
        'responsibilities': responsibilities,
        'technologies': technologies,
        'achievements': achievements,
        'companyUrl': companyUrl,
        'logoAsset': logoAsset,
      };
}

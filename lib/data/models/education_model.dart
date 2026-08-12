// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — EDUCATION
// ─────────────────────────────────────────────────────────────────────────────

class EducationModel {
  const EducationModel({
    required this.id,
    required this.institution,
    required this.degree,
    required this.major,
    required this.startYear,
    this.endYear,
    this.isCurrent = false,
    this.cgpa,
    this.description,
    this.logoAsset,
    this.institutionUrl,
  });

  final String id;
  final String institution;
  final String degree;
  final String major;
  final int startYear;
  final int? endYear;
  final bool isCurrent;
  final String? cgpa;
  final String? description;
  final String? logoAsset;
  final String? institutionUrl;

  String get yearRange => isCurrent ? '$startYear — Present' : '$startYear — ${endYear ?? ""}';

  factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
        id: json['id'] as String,
        institution: json['institution'] as String,
        degree: json['degree'] as String,
        major: json['major'] as String,
        startYear: json['startYear'] as int,
        endYear: json['endYear'] as int?,
        isCurrent: json['isCurrent'] as bool? ?? false,
        cgpa: json['cgpa'] as String?,
        description: json['description'] as String?,
        logoAsset: json['logoAsset'] as String?,
        institutionUrl: json['institutionUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'institution': institution,
        'degree': degree,
        'major': major,
        'startYear': startYear,
        'endYear': endYear,
        'isCurrent': isCurrent,
        'cgpa': cgpa,
        'description': description,
        'logoAsset': logoAsset,
        'institutionUrl': institutionUrl,
      };
}

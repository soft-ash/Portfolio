// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — SKILL
// ─────────────────────────────────────────────────────────────────────────────

enum SkillCategory {
  mobile,
  stateManagement,
  backend,
  programming,
  aiMl,
  tools,
  design,
}

extension SkillCategoryExtension on SkillCategory {
  String get label => switch (this) {
        SkillCategory.mobile => 'Mobile',
        SkillCategory.stateManagement => 'State Management',
        SkillCategory.backend => 'Backend & APIs',
        SkillCategory.programming => 'Programming',
        SkillCategory.aiMl => 'AI / ML',
        SkillCategory.tools => 'Tools & DevOps',
        SkillCategory.design => 'Design',
      };
}

class SkillModel {
  const SkillModel({
    required this.id,
    required this.name,
    required this.category,
    this.iconPath,
    this.iconCodePoint,
    this.proficiency = 5,
    this.description,
  });

  final String id;
  final String name;
  final SkillCategory category;
  final String? iconPath;
  final int? iconCodePoint;
  final int proficiency; // 1-5
  final String? description;

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        id: json['id'] as String,
        name: json['name'] as String,
        category: SkillCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => SkillCategory.tools,
        ),
        iconPath: json['iconPath'] as String?,
        iconCodePoint: json['iconCodePoint'] as int?,
        proficiency: json['proficiency'] as int? ?? 5,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category.name,
        'iconPath': iconPath,
        'iconCodePoint': iconCodePoint,
        'proficiency': proficiency,
        'description': description,
      };
}

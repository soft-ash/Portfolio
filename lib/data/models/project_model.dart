// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — PROJECT
// ─────────────────────────────────────────────────────────────────────────────

class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.category,
    required this.technologies,
    this.thumbnailAsset,
    this.thumbnailUrl,
    this.screenshots = const [],
    this.videoUrl,
    this.githubUrl,
    this.liveUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.featured = false,
    required this.year,
    this.problem,
    this.solution,
    this.features = const [],
    this.architecture,
    this.challenges,
    this.results,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String description;
  final String category;
  final List<String> technologies;
  final String? thumbnailAsset;
  final String? thumbnailUrl;
  final List<String> screenshots;
  final String? videoUrl;
  final String? githubUrl;
  final String? liveUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final bool featured;
  final int year;
  final String? problem;
  final String? solution;
  final List<String> features;
  final String? architecture;
  final String? challenges;
  final String? results;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'] as String,
        title: json['title'] as String,
        shortDescription: json['shortDescription'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        technologies: List<String>.from(json['technologies'] ?? []),
        thumbnailAsset: json['thumbnailAsset'] as String?,
        thumbnailUrl: json['thumbnailUrl'] as String?,
        screenshots: List<String>.from(json['screenshots'] ?? []),
        videoUrl: json['videoUrl'] as String?,
        githubUrl: json['githubUrl'] as String?,
        liveUrl: json['liveUrl'] as String?,
        appStoreUrl: json['appStoreUrl'] as String?,
        playStoreUrl: json['playStoreUrl'] as String?,
        featured: json['featured'] as bool? ?? false,
        year: json['year'] as int,
        problem: json['problem'] as String?,
        solution: json['solution'] as String?,
        features: List<String>.from(json['features'] ?? []),
        architecture: json['architecture'] as String?,
        challenges: json['challenges'] as String?,
        results: json['results'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'shortDescription': shortDescription,
        'description': description,
        'category': category,
        'technologies': technologies,
        'thumbnailAsset': thumbnailAsset,
        'thumbnailUrl': thumbnailUrl,
        'screenshots': screenshots,
        'videoUrl': videoUrl,
        'githubUrl': githubUrl,
        'liveUrl': liveUrl,
        'appStoreUrl': appStoreUrl,
        'playStoreUrl': playStoreUrl,
        'featured': featured,
        'year': year,
        'problem': problem,
        'solution': solution,
        'features': features,
        'architecture': architecture,
        'challenges': challenges,
        'results': results,
      };
}

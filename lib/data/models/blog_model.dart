// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS — BLOG ARTICLE
// ─────────────────────────────────────────────────────────────────────────────

class BlogModel {
  const BlogModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.excerpt,
    this.content,
    this.coverImageAsset,
    this.coverImageUrl,
    required this.publishedDate,
    this.tags = const [],
    this.readingTime = 5,
    this.authorName,
    this.externalUrl,
  });

  final String id;
  final String title;
  final String slug;
  final String excerpt;
  final String? content;
  final String? coverImageAsset;
  final String? coverImageUrl;
  final String publishedDate;
  final List<String> tags;
  final int readingTime;
  final String? authorName;
  final String? externalUrl; // Link to Medium, Dev.to etc.

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        id: json['id'] as String,
        title: json['title'] as String,
        slug: json['slug'] as String,
        excerpt: json['excerpt'] as String,
        content: json['content'] as String?,
        coverImageAsset: json['coverImageAsset'] as String?,
        coverImageUrl: json['coverImageUrl'] as String?,
        publishedDate: json['publishedDate'] as String,
        tags: List<String>.from(json['tags'] ?? []),
        readingTime: json['readingTime'] as int? ?? 5,
        authorName: json['authorName'] as String?,
        externalUrl: json['externalUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
        'excerpt': excerpt,
        'content': content,
        'coverImageAsset': coverImageAsset,
        'coverImageUrl': coverImageUrl,
        'publishedDate': publishedDate,
        'tags': tags,
        'readingTime': readingTime,
        'authorName': authorName,
        'externalUrl': externalUrl,
      };
}

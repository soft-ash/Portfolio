// ─────────────────────────────────────────────────────────────────────────────
// ROUTE NAMES
// ─────────────────────────────────────────────────────────────────────────────

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String about = '/about';
  static const String experience = '/experience';
  static const String skills = '/skills';
  static const String projects = '/projects';
  static const String projectDetail = '/projects/:id';
  static const String education = '/education';
  static const String certifications = '/certifications';
  static const String services = '/services';
  static const String blog = '/blog';
  static const String blogDetail = '/blog/:slug';
  static const String contact = '/contact';

  static String projectDetailPath(String id) => '/projects/$id';
  static String blogDetailPath(String slug) => '/blog/$slug';
}

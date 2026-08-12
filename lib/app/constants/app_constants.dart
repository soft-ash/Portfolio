// ─────────────────────────────────────────────────────────────────────────────
// APP-WIDE CONSTANTS
// ─────────────────────────────────────────────────────────────────────────────

class AppConstants {
  AppConstants._();

  // ── Animation Durations ───────────────────────────────────────────────────
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 400);
  static const Duration durationSlow = Duration(milliseconds: 700);
  static const Duration durationVerySlow = Duration(milliseconds: 1200);

  // ── Breakpoints ───────────────────────────────────────────────────────────
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // ── Layout ────────────────────────────────────────────────────────────────
  static const double maxContentWidth = 1200.0;
  static const double navBarHeight = 72.0;
  static const double sectionPaddingVertical = 100.0;
  static const double sectionPaddingVerticalMobile = 64.0;

  // ── Sections ──────────────────────────────────────────────────────────────
  static const int sectionHome = 0;
  static const int sectionAbout = 1;
  static const int sectionExperience = 2;
  static const int sectionSkills = 3;
  static const int sectionProjects = 4;
  static const int sectionEducation = 5;
  static const int sectionCertifications = 6;
  static const int sectionServices = 7;
  static const int sectionBlog = 8;
  static const int sectionContact = 9;

  static const List<String> sectionLabels = [
    'Home',
    'About',
    'Experience',
    'Skills',
    'Projects',
    'Education',
    'Certifications',
    'Services',
    'Blog',
    'Contact',
  ];

  // ── Navigation ────────────────────────────────────────────────────────────
  // Main nav items (subset shown in navbar)
  static const List<Map<String, dynamic>> navItems = [
    {'label': 'About', 'section': 1},
    {'label': 'Experience', 'section': 2},
    {'label': 'Skills', 'section': 3},
    {'label': 'Projects', 'section': 4},
    {'label': 'Blog', 'section': 8},
    {'label': 'Contact', 'section': 9},
  ];

  // ── Storage Keys ──────────────────────────────────────────────────────────
  static const String themeKey = 'portfolio_theme_dark';
}
